import numpy as np
import matplotlib.pyplot as plt
import random


# Transformation en coordonnées polaires
def cartesian_to_polar(samples):
    x, y = samples[:, 0], samples[:, 1]
    r = np.sqrt(x**2 + y**2)
    theta = np.arctan2(y, x)  
    return np.column_stack((r, theta))  


# Chargement et transformation des données
def load_samples_polar(sample_0_path, sample_1_path):
    sample_0 = np.load(sample_0_path)
    sample_1 = np.load(sample_1_path)

    # Conversion en coordonnées polaires
    sample_0_polar = cartesian_to_polar(sample_0)
    sample_1_polar = cartesian_to_polar(sample_1)

    # Création des labels
    labels_0 = np.zeros(sample_0.shape[0], dtype=np.uint8)
    labels_1 = np.ones(sample_1.shape[0], dtype=np.uint8)

    all_samples = np.concatenate([sample_0_polar, sample_1_polar])
    labels = np.concatenate([labels_0, labels_1])

    return sample_0_polar, sample_1_polar, all_samples, labels


# Définition du Perceptron en polaire
class Neuron:
    def __init__(self, weight_r, bias):
        self.weight_r = weight_r
        self.bias = bias

    def forward(self, r):
        """Classe en fonction du seuil sur r."""
        return 1 if (self.weight_r * r + self.bias) >= 0 else 0

    def update(self, delta_r, delta_bias):
        self.weight_r += delta_r
        self.bias += delta_bias


# Entraînement du perceptron
def train_perceptron_polar(sample_0, sample_1, all_samples, labels):
    # Initialisation des poids aléatoires
    neuron = Neuron(1e-3 + 0.1*random.random(), 1e-3 + 0.1*random.random())
    learning_rate = 0.01

    plt.ion()
    plt.figure('Etat initial')
    display_polar(neuron, sample_0, sample_1)
    plt.draw()
    plt.pause(0.1)

    plt.figure('Etat courant')
    for _ in range(10000):
        random_index = random.randrange(0, all_samples.shape[0])
        current_sample = all_samples[random_index]
        current_label = labels[random_index]

        r = current_sample[0]  # Utilisation uniquement de r
        prediction = neuron.forward(r)

        # Calcul de l'erreur
        dc_df = prediction - current_label
        df_dwr = r
        df_db = 1.0

        # Mise à jour des poids
        delta_r = -learning_rate * dc_df * df_dwr
        delta_bias = -learning_rate * dc_df * df_db
        neuron.update(delta_r, delta_bias)

        if dc_df != 0:
            plt.clf()
            display_polar(neuron, sample_0, sample_1)
            plt.legend(['Separation', 'Classe 0', 'Classe 1'])
            plt.draw()
            plt.pause(0.1)

    plt.ioff()
    plt.figure('Etat final')
    display_polar(neuron, sample_0, sample_1)
    plt.legend(['Separation', 'Classe 0', 'Classe 1'])
    plt.show()
    
    return neuron


# Affichage du résultat
def display_polar(neuron, sample_0, sample_1):
    plt.figure("Séparation linéaire en coordonnées polaires")
    plt.scatter(sample_0[:, 0], sample_0[:, 1], label="Classe 0")
    plt.scatter(sample_1[:, 0], sample_1[:, 1], label="Classe 1")
    # Tracer la ligne verticale de séparation r = -bias / weight_r
    decision_boundary = -neuron.bias / neuron.weight_r
    plt.axvline(x=decision_boundary, color='r', linestyle='--', label="Frontière de décision")
    plt.legend()
    plt.xlabel("Rayon r")
    plt.ylabel("Angle θ")
    plt.title(f"Neuron: w_r = {neuron.weight_r:.2f}, bias = {neuron.bias:.2f}")
    plt.show()


# Exécution
if __name__ == "__main__":
    sample_0_path = "circle_0.npy"
    sample_1_path = "circle_1.npy"

    sample_0_polar, sample_1_polar, all_samples, labels = load_samples_polar(sample_0_path, sample_1_path)

    neuron = train_perceptron_polar(sample_0_polar, sample_1_polar, all_samples, labels)

    display_polar(neuron, sample_0_polar, sample_1_polar)
