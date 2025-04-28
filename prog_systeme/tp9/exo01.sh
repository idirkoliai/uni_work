awk '{ 
    if ($0 ~ /<div class="section-number">.*<\/div>/) { 
        gsub(/<div class="section-number">.*<\/div>/, "<div class=\"section-number\">" ++n "</div>");
    } 
    print
}' tp-09-ressources/ex-1-web-design/website.html > tst.html


awk '
{
  # Match lines that contain the "color:" property in a style attribute
  if ($0 ~ /style="[^"]*color:\s*#[0-9a-fA-F]{6}[^"]*"/) {
    # Extract the color value using a regular expression
    match($0, /color:\s*#([0-9a-fA-F]{6})/, arr);
    hex = arr[1];

    # Convert the RGB components from the hex string to decimal
    r = strtonum("0x" substr(hex, 1, 2));  # Red component
    g = strtonum("0x" substr(hex, 3, 2));  # Green component
    b = strtonum("0x" substr(hex, 5, 2));  # Blue component

    # Scale each RGB component by 0.6
    r = int(r * 0.5);
    g = int(g * 0.5);
    b = int(b * 0.5);

    # Ensure RGB values stay within valid range (0-255)
    r = (r < 0) ? 0 : (r > 255) ? 255 : r;
    g = (g < 0) ? 0 : (g > 255) ? 255 : g;
    b = (b < 0) ? 0 : (b > 255) ? 255 : b;

    # Format the new color values back to hex
    new_color = sprintf("#%02x%02x%02x", r, g, b);
    # Replace only the color property (leave background-color intact)
    sub(/; color:\s*#[0-9a-fA-F]{6}/, "; color: " new_color);
  }

  # Print the modified line
  print $0;
}
' tst.html > tst2.html

cat tst2.html > tp-09-ressources/ex-1-web-design/website.html
rm tst.html tst2.html


