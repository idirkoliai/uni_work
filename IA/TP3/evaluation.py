import torch
import torch.nn as nn
import torch.nn.functional as F
from torchvision import datasets
from torchvision.transforms import ToTensor
import matplotlib.pyplot as plt
import tqdm
import numpy as np


class Net(nn.Module):
    def __init__(self):
        super().__init__()
        # First conv layer with 8 filters of kernel size 3
        self.conv1 = nn.Conv2d(1, 8, 3, padding='same')
        # Maxpool (can be reused)
        self.pool = nn.MaxPool2d(2, 2)
        # Second conv layer with 16 filters of kernel size 3
        self.conv2 = nn.Conv2d(8, 16, 3, padding='same')
        # Fuly connected layers.
        self.fc1 = nn.Linear(16 * 7 * 7, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        # Input resolution Nx1x28x28
        # x shape Nx8x14x14
        x = self.pool(F.relu(self.conv1(x)))
        # x shape Nx16x7x7
        x = self.pool(F.relu(self.conv2(x)))
        # x shape Nx120
        x = torch.flatten(x, 1) # flatten all dimensions except batch
        x = F.relu(self.fc1(x))
        # x shape Nx80
        x = F.relu(self.fc2(x))
        # x shape Nx10
        x = self.fc3(x)
        return x

epoch = 0
save_path = f'./checkpoint_{epoch}.pth'

# Download the FashionMNIST test dataset
test_data = datasets.FashionMNIST(
    root="data",
    train=False,
    download=True,
    transform=ToTensor()
)

# Map between class index and human readable name.
labels_map = {
    0: "T-Shirt",
    1: "Trouser",
    2: "Pullover",
    3: "Dress",
    4: "Coat",
    5: "Sandal",
    6: "Shirt",
    7: "Sneaker",
    8: "Bag",
    9: "Ankle Boot",
}

def run():

    net = Net()
    net.load_state_dict(torch.load(save_path))
    net.eval()

    batch_size = 32
    test_loader = torch.utils.data.DataLoader(test_data, batch_size=batch_size,
                                            shuffle=True, num_workers=4)

    # Visualize data sample
    # Get some random training images
    dataiter = iter(test_loader)
    images, labels = next(dataiter)
    figure = plt.figure()
    # figure = plt.figure(figsize=(8, 15))
    cols, rows = 8, 4
    
    outputs = net(images)
    _, predicted = torch.max(outputs.data, 1)

    for i in range(1, cols * rows + 1):
        figure.add_subplot(rows, cols, i)
        current_label = labels[i - 1].item()
        current_pred = predicted[i - 1].item()
        plt.title(f'GT {labels_map[current_label]} \n Pred {labels_map[current_pred]}')
        plt.axis("off")
        plt.imshow(images[i - 1].numpy().squeeze(), cmap="gray")
    plt.show()

if __name__ == '__main__':
    run()