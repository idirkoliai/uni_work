import numpy as np
import matplotlib.pyplot as plt
import random


# Transformation en coordonnées polaires
def cartesian_to_polar(samples):
    x, y = samples[:, 0], samples[:, 1]
    r = np.sqrt(x**2 + y**2)  # Rayon
    theta = np.arctan2(y, x)  # Angle (non utilisé ici)
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
    def __init__(self):
        # Initialisation aléatoire du poids sur r et du biais
        self.weight_r = random.uniform(-1, 1)
        self.bias = random.uniform(-1, 1)

    def forward(self, r):
        """Classe en fonction du seuil sur r."""
        return 1 if (self.weight_r * r + self.bias) >= 0 else 0

    def update(self, error, r, learning_rate):
        """Mise à jour des poids avec la règle du perceptron"""
        self.weight_r -= learning_rate * error * r
        self.bias -= learning_rate * error


# Entraînement du perceptron
def train_perceptron_polar(sample_0, sample_1, all_samples, labels, learning_rate=0.1, epochs=100):
    neuron = Neuron()

    plt.ion()  # Mode interactif pour voir l'évolution en direct
    plt.figure("Apprentissage du Perceptron en polaire")

    for epoch in range(epochs):
        for i in range(all_samples.shape[0]):
            r = all_samples[i, 0]  # On prend uniquement r
            label = labels[i]
            prediction = neuron.forward(r)
            error = prediction - label  # Erreur du perceptron

            # Mise à jour des poids
            neuron.update(error, r, learning_rate)

        # Affichage de l'évolution de la ligne
        plt.clf()
        display_polar(neuron, sample_0, sample_1)
        plt.title(f"Epoch {epoch+1}/{epochs}")
        plt.pause(0.1)

    plt.ioff()  # Fin du mode interactif
    return neuron


# Affichage du résultat
def display_polar(neuron, sample_0, sample_1):
    plt.scatter(sample_0[:, 0], sample_0[:, 1], label="Classe 0", color="blue")
    plt.scatter(sample_1[:, 0], sample_1[:, 1], label="Classe 1", color="red")

    # Tracer la ligne verticale de séparation r = -bias / weight_r
    if neuron.weight_r != 0:  # Éviter la division par zéro
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
