import torch
import torchvision
import torchvision.transforms as transforms
import torch.nn as nn
import torch.nn.functional as F
import torchvision.models.vgg as models

import matplotlib.pyplot as plt
import numpy as np

# functions to show an image


def imshow(img):
    img = img / 2 + 0.5  # unnormalize
    npimg = img.numpy()
    plt.imshow(np.transpose(npimg, (1, 2, 0)))
    plt.show()


class Net(nn.Module):

    def __init__(self):
        super().__init__()
        self.conv1 = nn.Conv2d(3, 6, 5)
        self.pool = nn.MaxPool2d(2, 2)
        self.conv2 = nn.Conv2d(6, 16, 5)
        self.fc1 = nn.Linear(16 * 5 * 5, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        conv1_out = self.conv1(x)
        x = self.pool(F.relu(conv1_out))
        conv2_out = self.conv2(x)
        x = self.pool(F.relu(conv2_out))
        x = torch.flatten(x, 1)  # flatten all dimensions except batch
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x, conv1_out.detach(), conv2_out.detach()


def display_channel(images, layer_out, batch_index, num_channels):
    for channel in range(num_channels):
        feature_map = layer_out[batch_index, channel, :, :]
        feature_image = feature_map.numpy()
        img = images[batch_index]
        img = img / 2 + 0.5  # unnormalize
        np_img = img.numpy()
        plt.figure(f"Feature map channel {channel}")
        plt.imshow(feature_image)
        plt.figure(f"Input image number {batch_index}")
        plt.imshow(np.transpose(np_img, (1, 2, 0)))
    plt.show()


def run():

    transform = transforms.Compose([
        transforms.ToTensor(),
        transforms.Normalize((0.5, 0.5, 0.5), (0.5, 0.5, 0.5))
    ])

    batch_size = 4

    testset = torchvision.datasets.CIFAR10(root='./data',
                                           train=False,
                                           download=True,
                                           transform=transform)
    testloader = torch.utils.data.DataLoader(testset,
                                             batch_size=batch_size,
                                             shuffle=True,
                                             num_workers=2)

    classes = ('plane', 'car', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse',
               'ship', 'truck')

    dataiter = iter(testloader)
    images, labels = next(dataiter)

    # print images
    imshow(torchvision.utils.make_grid(images))
    print('GroundTruth: ',
          ' '.join(f'{classes[labels[j]]:5s}' for j in range(4)))

    net = Net()

    outputs, conv1_out, conv2_out = net(images)

    for i in range(images.shape[0]):
        display_channel(images, conv1_out, i, 2)

    _, predicted = torch.max(outputs, 1)

    print('Predicted: ',
          ' '.join(f'{classes[predicted[j]]:5s}' for j in range(4)))

    pretrained = models.vgg16(pretrained=True)
    print(pretrained)

    for i in range(images.shape[0]):
        out_vgg = pretrained.features[:2](images).detach()
        display_channel(images, out_vgg, i, 2)


if __name__ == '__main__':
    run()
