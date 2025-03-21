import numpy as np
import matplotlib.pyplot as plt
import argparse
import random


def load_samples(sample_0_path, sample_1_path):
    """A method to load samples and generate labels

    Args:
        sample_0_path (str): Path to the samples belonging to class 0
        sample_1_path (str): Path to the samples belonging to class 1

    Returns:
        sample_0, sample_1, all_samples, labels: (N, 2) array of samples,
          (M, 2) array of samples,
          (N + M, 2) array of concatenated samples,
          (N + M, 1) array of corresponding labels
    """
    sample_0 = np.load(sample_0_path)
    sample_1 = np.load(sample_1_path)

    labels_0 = np.zeros(sample_0.shape[0], dtype=np.uint8)
    labels_1 = np.ones(sample_1.shape[0], dtype=np.uint8)

    all_samples = np.concatenate([sample_0, sample_1])
    labels = np.concatenate([labels_0, labels_1])

    return sample_0, sample_1, all_samples, labels


class Neuron:
    """A class for a Perceptron neuron
    """

    def __init__(self, weight_0, weight_1, bias):
        self.weight_0 = weight_0
        self.weight_1 = weight_1
        self.bias = bias

    def __str__(self):
        return f"w_0: {self.weight_0:2f} w_1: {self.weight_1:2f} bias {self.bias:2f}"

    def forward(self, x_0, x_1):
        return 1 if self.weight_0 * x_0 + self.weight_1 * x_1 + self.bias >= 0 else 0

    def update(self, delta_0, delta_1, delta_bias):
        self.weight_0 += delta_0
        self.weight_1 += delta_1
        self.bias += delta_bias


def display(neuron, sample_0, sample_1):
    """Generate a plot for a neuron and the data separation

    Args:
        neuron (Neuron): Neuron to display
        sample_0 (np.array): (N, 2) array of samples
        sample_1 (np.array): (M, 2) array of samples
    """
    x_a = -10
    y_a = - (neuron.bias + neuron.weight_0 * x_a) / neuron.weight_1
    x_b = 10
    y_b = - (neuron.bias + neuron.weight_0 * x_b) / neuron.weight_1
    plt.plot([x_a, x_b], [y_a, y_b])
    plt.plot(sample_0[:, 0], sample_0[:, 1], 'x')
    plt.plot(sample_1[:, 0], sample_1[:, 1], 'x')
    plt.xlim(-10, 10)
    plt.ylim(-10, 10)
    plt.title(f'{neuron}')


def exercise_1(sample_0, sample_1):
    # Create a neuron with fixed weights.
    # TODO: test with different weights

    neuron_example = Neuron(0.242951, 0.256975, -1.561680)

    # Test it on an example input.
    # TODO: test with different inputs and check prediction
    input_example = [7, 8]
    prediction_example = neuron_example.forward(
        input_example[0], input_example[1])

    # Visualize the neuron and its prediction.
    plt.figure('Neurone tout fait')
    display(neuron_example, sample_0, sample_1)
    plt.plot(input_example[0], input_example[1], marker='o')
    plt.legend(['Separation', 'Classe 0', 'Classe 1',
                f'Prediction : {prediction_example} '])
    plt.show()


def exercice_2(sample_0, sample_1, all_samples, labels):
    # This part is training a neuron on random initial weights.

    neuron = Neuron(1e-3 + 0.1*random.random(), 1e-3 + 0.1 *random.random(), 1e-3 + 0.1*random.random())
    learning_rate = 2**60

    plt.ion()
    plt.figure('Etat initial')
    display(neuron, sample_0, sample_1)
    plt.draw()
    plt.pause(0.1)

    plt.figure('Etat courant')
    for _ in range(10000):
        random_index = random.randrange(0, all_samples.shape[0] - 1)
        current_sample = all_samples[random_index]
        current_prediction = neuron.forward(
            current_sample[0], current_sample[1])
        # TODO: Compute dC / df
        dc_df = current_prediction - labels[random_index]
        # TODO: Compute df / dw0
        df_dw0 = current_sample[0]
        # TODO: Compute df / dw1
        df_dw1 = current_sample[1]
        # TODO: Compute df / db
        df_db = 1.0

        # TODO: Compute weights update
        delta_0 = -learning_rate * dc_df * df_dw0
        delta_1 = - learning_rate * dc_df * df_dw1
        delta_bias = - learning_rate * dc_df * df_db
        neuron.update(delta_0, delta_1, delta_bias)
        if dc_df != 0:
            plt.clf()
            display(neuron, sample_0, sample_1)
            plt.legend(['Separation', 'Classe 0', 'Classe 1'])
            plt.draw()
            plt.pause(0.1)

    plt.ioff()

    plt.figure('Etat final')
    display(neuron, sample_0, sample_1)
    plt.legend(['Separation', 'Classe 0', 'Classe 1'])
    plt.show()


if __name__ == "__main__":

    parser = argparse.ArgumentParser("TP numéro 1")
    parser.add_argument("--path_0", type=str, default="./sample_0.npy")
    parser.add_argument("--path_1", type=str, default="./sample_1.npy")
    parser.add_argument("--exo", type=int, default=1)

    args = parser.parse_args()

    # Load data
    sample_0, sample_1, all_samples, labels = load_samples(
        args.path_0, args.path_1)

    if args.exo == 1:
        exercise_1(sample_0, sample_1)
    else:
        exercice_2(sample_0, sample_1, all_samples, labels)
