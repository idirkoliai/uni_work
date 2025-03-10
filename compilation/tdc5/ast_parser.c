#include "ast_parser.h"

#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define GET_VAR_TYPE(str) (!strcmp((str), "char") ? CHAR_TYPE : INT_TYPE)

#define FIRSTCHILD(node) node->firstChild
#define SECONDCHILD(node) node->firstChild->nextSibling
#define SIBLING(node) node->nextSibling
#define GRANDCHILD(node) node->firstChild->firstChild

static int is_redeclared(const char *name, int num_tables, ...)
{
  va_list args;
  va_start(args, num_tables);

  for (int i = 0; i < num_tables; i++)
  {
    SymbolTable *table = va_arg(args, SymbolTable *);
    if (lookup_symbol(table, name))
    {
      va_end(args);
      return 0;
    }
  }
  va_end(args);
  return 1;
}

static SymbolTable fill_global_variable_table(Node *global_node)
{
  SymbolTable global_table;

  init_symbol_table(&global_table);
  for (Node *decl_node = FIRSTCHILD(global_node); decl_node;
       decl_node = SIBLING(decl_node))
  {
    SymbolType var_type = GET_VAR_TYPE(decl_node->string);

    for (Node *variable_node = FIRSTCHILD(decl_node); variable_node;
         variable_node = SIBLING(variable_node))
    {
      if (lookup_symbol(&global_table, variable_node->string))
      {
        fprintf(stderr, "Error: Redeclaration of the global variable : %s\n",
                variable_node->string);
        exit(EXIT_FAILURE);
      }
      insert_symbol(&global_table, variable_node->string, var_type);
    }
  }
  return global_table;
}

static void process_variables(Node *decl_node, SymbolTable *insert_table,
                              SymbolTable *other_table,
                              SymbolTable *param_table)
{
  SymbolType var_type = GET_VAR_TYPE(decl_node->string);

  for (Node *variable_node = FIRSTCHILD(decl_node); variable_node;
       variable_node = SIBLING(variable_node))
  {
    if (!is_redeclared(variable_node->string, 3, insert_table, param_table,
                       other_table))
    {
      fprintf(stderr, "Error: Redeclaration of the variable: %s\n",
              variable_node->string);
      exit(EXIT_FAILURE);
    }
    insert_symbol(insert_table, variable_node->string, var_type);
  }
}

static void fill_local_variable_table(Node *local_node,
                                      SymbolTable *param_table,
                                      SymbolTable *local_table,
                                      SymbolTable *static_table)
{
  for (Node *decl_node = FIRSTCHILD(local_node); decl_node;
       decl_node = SIBLING(decl_node))
  {
    if (decl_node->label == _static)
      process_variables(FIRSTCHILD(decl_node), static_table, local_table,
                        param_table);
    else
      process_variables(decl_node, local_table, static_table, param_table);
  }
}

static void fill_parameters_table(Node *param_node, SymbolTable *param_table)
{
  for (Node *param_decl_node = FIRSTCHILD(param_node);
       param_decl_node && param_decl_node->label != _void;
       param_decl_node = SIBLING(param_decl_node))
  {
    Node *identifier_node = FIRSTCHILD(param_decl_node);

    if (lookup_symbol(param_table, identifier_node->string))
    {
      printf("Error: Redeclaration of parameter %s param \n",
             identifier_node->string);
      exit(EXIT_FAILURE);
    }

    SymbolType param_type = GET_VAR_TYPE(param_decl_node->string);
    insert_symbol(param_table, identifier_node->string, param_type);
  }
}
static void translate_subtraction(Node *node, FILE *asm_file)
{
  if (node->label == _addsub)
  {
    Node *left = FIRSTCHILD(node);
    Node *right = SIBLING(left);

    fprintf(asm_file, "mov rax, %d\n", left->num);
    fprintf(asm_file, "push rax\n");
    fprintf(asm_file, "mov rax, %d\n", right->num);
    fprintf(asm_file, "pop rbx\n");
    fprintf(asm_file, "sub rax, rbx\n");
    fprintf(asm_file, "push rax\n");
  }
}
static void parse_instructions(Node *instructions_node, FunctionTable *function_table, FILE *asm_file)
{
  printf("Parsing instructions\n");
  for (Node *instruction_node = FIRSTCHILD(instructions_node); instruction_node;
       instruction_node = SIBLING(instruction_node))
  {
    switch (instruction_node->label)
    {
    case _assign:
      parse_instructions(instruction_node, function_table, asm_file);
      break;
    case _addsub:
      translate_subtraction(instruction_node, asm_file);
      break;
    default:
      break;
    }
  }
}
static FunctionTable fill_function_table(Node *function_list_node, FILE *asm_file)
{
  FunctionTable function_table;
  init_function_table(&function_table);

  for (Node *function_node = FIRSTCHILD(function_list_node); function_node;
       function_node = SIBLING(function_node))
  {

    Node *header_node = FIRSTCHILD(function_node);
    Node *return_type_node = FIRSTCHILD(header_node);
    Node *body_node = SIBLING(header_node);
    Node *name_node = SIBLING(return_type_node);
    Node *parameters_node = SIBLING(name_node);
    Node *local_variables_node = FIRSTCHILD(body_node);
    Node *instructions_node = SIBLING(local_variables_node);
    SymbolType return_type = GET_VAR_TYPE(return_type_node->string);

    if (lookup_function(&function_table, name_node->string))
    {
      printf("Error: Redeclaration of function : %s\n", name_node->string);
      exit(EXIT_FAILURE);
    }

    SymbolTable param_table, local_table, static_table;
    char function_name[MAX_IDENTIFIER_LENGTH];

    init_symbol_table(&param_table);
    init_symbol_table(&local_table);
    init_symbol_table(&static_table);

    fill_parameters_table(parameters_node, &param_table);
    fill_local_variable_table(local_variables_node, &param_table, &local_table,
                              &static_table);

    strcpy(function_name, name_node->string);
    insert_function(&function_table, function_name, return_type, param_table,
                    static_table, local_table);

    if (strcmp(function_name, "main") == 0)
    {
      fprintf(asm_file, "global _start\nsection .text\n_start:\n");
      parse_instructions(instructions_node, &function_table, asm_file);
      fprintf(asm_file, "mov rax, 60\nmov rdi, 0\nsyscall\n");
    }
  }
  return function_table;
}

SymbolManager ast_parser(Node *root)
{
  SymbolManager manager;

  FILE *asm_file = fopen("_anonymous.asm", "w");
  if (!asm_file)
  {
    perror("Error opening file");
    exit(EXIT_FAILURE);
  }

  for (Node *current_node = FIRSTCHILD(root); current_node;
       current_node = SIBLING(current_node))
  {
    switch (current_node->label)
    {
    case global_variables:
      manager.global_variables = fill_global_variable_table(current_node);
      break;
    case function_list:
      manager.functions = fill_function_table(current_node, asm_file);
      break;
    default:
      break;
    }
  }

  fclose(asm_file);

  return manager;
}

void print_all_tables(SymbolManager *manager)
{
  printf("Global Variables:\n\n");
  print_symbol_table(&manager->global_variables);
  printf("*****************************************************************\n");

  printf("Functions:\n\n");
  for (int i = 0; i < HASH_SIZE; i++)
  {
    for (Function *current_function = manager->functions.buckets[i];
         current_function; current_function = current_function->next)
    {
      printf("Function %s\n", current_function->name);
      printf("Return type: %s\n",
             (current_function->return_type == CHAR_TYPE) ? "char" : "int");
      printf("Parameters:\n");
      print_symbol_table(&current_function->parameters);
      printf("Static Variables:\n");
      print_symbol_table(&current_function->static_variables);
      printf("Local Variables:\n");
      print_symbol_table(&current_function->variables);
      printf("-------------------------------------------------------------\n");
    }
  }
}

