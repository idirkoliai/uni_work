import torch
import torch.nn as nn
import torch.nn.functional as F
import numpy as np
import matplotlib.pyplot as plt

PATH = './loutres.png'

test_image = plt.imread(PATH)[:, :, :3]

conv = nn.Conv2d(3, 1, 3)

# TODO: change kernel values in here.
#single_channel_kernel = np.array([[0, 0, 0],[0, 1, 0],[0, 0, 0]],dtype=np.float32)
#conturing kernel
#single_channel_kernel = np.array([[0, 1, 0], [1, -4, 1], [0, 1, 0]],dtype=np.float32)
#top down  kernel
#single_channel_kernel = np.array([[1, 1, 1], [0, 0, 0], [-1, -1, -1]],dtype=np.float32),
#left right kernel
#single_channel_kernel = np.array([[1, 0, -1], [1, 0, -1], [1, 0, -1]],dtype=np.float32)
#clear kernel
single_channel_kernel = np.array([[0, -1, 0], [-1, 5, -1], [0, -1, 0]],dtype=np.float32)
#blur kernel
#single_channel_kernel = np.array([[1/9, 1/9, 1/9], [1/9, 1/9, 1/9], [1/9, 1/9, 1/9]],dtype=np.float32)
multi_channel_kernel = np.stack([single_channel_kernel for _ in range(3)],
                                axis=0)
multi_channel_kernel = np.expand_dims(multi_channel_kernel, axis=0)

conv.weight = torch.nn.Parameter(torch.from_numpy(multi_channel_kernel))

# Change to CxHxW convention for torch
input_image = torch.from_numpy(test_image).permute((2, 0, 1))
output = conv(input_image).detach()

test_image = plt.imread(PATH)[:, :, :3]
plt.figure("Image entrée")
plt.imshow(test_image)

channel = 0
plt.figure("Sortie")
plt.imshow(output[channel, :, :])
plt.show()
