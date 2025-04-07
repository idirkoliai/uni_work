import matplotlib.pyplot as plt
import numpy as np

PATH = './loutres.png'


class Convolution():

    def __init__(self, kernel_size, channels_in, channels_out) -> None:
        self.channels_out = channels_out  # Noted C_out
        self.channels_in = channels_in  # Noted C_in
        self.kernel_size = kernel_size  # Noted K
        # Initialize channels_out kernels of size (C_out, C_in, K, K)
        self.kernels = np.random.rand(channels_out, channels_in, kernel_size,
                                      kernel_size)

    def apply_kernel(self, kernel: np.ndarray, input: np.ndarray) -> float:
        """Apply convolution to a part of the input, with element-wise multiplication and summation.

        Args:
            kernel (np.ndarray): Kernel of size (KxK)
            input (np.ndarray): Sub-window of the image to apply kernel (KxK)

        Returns:
            float: Result of the result of the convolution
        """
        output = 0.0
        for i in range(self.kernel_size):
            for j in range(self.kernel_size):
                output += kernel[i, j] * input[i, j]
        return output


    def single_filter(self, kernels: np.ndarray, input: np.ndarray) -> float:
        """Apply convolution across multiple input channels by summing all results together

        Args:
            kernels (np.ndarray): All input channel kernels (C_in, K, K)
            input (np.ndarray): Sub-window of the image to apply convolution

        Returns:
            float: Resulting convolution across all channels
        """
        filter_output = 0.0
        for kernel in kernels:
            for c in range(self.channels_in):
                filter_output += self.apply_kernel(kernel, input[:, :, c])
        return filter_output

    def forward(self, input_data: np.ndarray) -> np.ndarray:
        rows = input_data.shape[0]
        cols = input_data.shape[1]
        # Initialize output volume of siwe (H, W, C_out)
        output = np.zeros((rows, cols, self.channels_out))
        # Compute padding to get same output dimension.
        padding = int((self.kernel_size - 1) / 2)
        # Copy input image to padded input.
        padded_image = np.zeros(
            (rows + 2 * padding, cols + 2 * padding, self.channels_in))
        padded_image[padding:-padding, padding:-padding] = input_data
        # Iterate over all rows and columns.
        for i in range(rows):
            for j in range(cols):
                sub_window = padded_image[i:i + self.kernel_size,
                                          j:j + self.kernel_size]
                # Iterate over all out channels.
                for c_out in range(self.channels_out):
                    output[i, j, c_out] = 0.0
                    kernels = self.kernels[c_out]
                    output[i, j, c_out] = self.single_filter(kernels,
                                                             sub_window)
        return output


test_image = plt.imread(PATH)[:, :, :3]
plt.figure("Image entrée")
plt.imshow(test_image)

conv = Convolution(3, 3, 1)
output = conv.forward(test_image)

channel = 0
plt.figure(f"Sortie canal {channel}")
plt.imshow(np.squeeze(output[:, :, channel:channel + 1]))

plt.show()
