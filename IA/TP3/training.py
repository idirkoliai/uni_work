import torch
import torch.nn as nn
import torch.nn.functional as F
import torch.optim as optim
from torchvision import datasets
from torchvision.transforms import ToTensor
import matplotlib.pyplot as plt
import tqdm
import numpy as np
from torch.utils.tensorboard import SummaryWriter
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


class Net(nn.Module):
    def __init__(self):
        super().__init__()
        # First conv layer with 8 filters of kernel size 3
        self.conv1 = nn.Conv2d(1, 8, 3, padding='same')
        # Maxpool (can be reused)
        self.pool = nn.MaxPool2d(2, 2)
        # Second conv layer with 16 filters of kernel size 3
        self.conv2 = nn.Conv2d(8, 16, 3, padding='same')
        # Fuly connected layers reducing to 120, 84, 10 channels.
        self.fc1 = nn.Linear(16 * 14 * 14, 120)
        self.fc2 = nn.Linear(120, 84)
        self.fc3 = nn.Linear(84, 10)

    def forward(self, x):
        x = F.relu(self.conv1(x))
        x = self.pool(x)
        x = F.relu(self.conv2(x))
        x = torch.flatten(x,1)
        x = F.relu(self.fc1(x))
        x = F.relu(self.fc2(x))
        x = self.fc3(x)
        return x


def run():
    writer = SummaryWriter()
    # Download the FashionMNIST train dataset
    # Data augmentation will be added here. See https://pytorch.org/tutorials/beginner/data_loading_tutorial.html
    training_data = datasets.FashionMNIST(
        root="data",
        train=True,
        download=False,
        transform=ToTensor()
    )
    # This is to perform an overfit by selecting only a few images.
    #training_data = torch.utils.data.Subset(training_data, np.arange(0, 100))
    training_size = len(training_data)
    # Download the FashionMNIST test dataset
    test_data = datasets.FashionMNIST(
        root="data",
        train=False,
        download=True,
        transform=ToTensor()
    )

    # Batch size can be changed here.
    batch_size = 8
    train_loader = torch.utils.data.DataLoader(training_data, batch_size=batch_size,
                                            shuffle=True, num_workers=4)
    test_loader = torch.utils.data.DataLoader(test_data, batch_size=batch_size,
                                            shuffle=False, num_workers=4)

    # Check if you can use GPU.
    use_gpu = torch.cuda.is_available()
    if use_gpu:
        device = torch.device('cuda')
        print('GPU device detected')
    else:
        device = torch.device('cpu')
        print('No GPU detected, using CPU')

     
    # Visualize data sample
    # Get some random training images
    dataiter = iter(train_loader)
    images, labels = next(dataiter)
    figure = plt.figure(figsize=(8, 8))
    cols, rows = 4, 2
    print(f'Getting batch of input size {images.shape} labels size {labels.shape}')
    for i in range(1, cols * rows + 1):
        figure.add_subplot(rows, cols, i)
        current_label = labels[i - 1].item()
        plt.title(labels_map[current_label])
        plt.axis("off")
        plt.imshow(images[i - 1].numpy().squeeze(), cmap="gray")
    plt.show()

    net = Net().to(device)
    print(net)

    learning_rate = 5 * 1e-3
    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(net.parameters(), lr=learning_rate)

    epoch_count = 2
    loss_batch_print = 1000
    for epoch in range(epoch_count):  # loop over the dataset multiple times

        running_loss = 0.0
        for i, data in tqdm.tqdm(enumerate(train_loader, 0)):
            # get the inputs; data is a list of [inputs, labels]
            inputs, labels = data[0].to(device), data[1].to(device)

            # zero the parameter gradients
            optimizer.zero_grad()

            # forward + backward + optimize
            outputs = net(inputs)
            loss = criterion(outputs, labels)
            writer.add_scalar('Loss/train', loss, epoch)
            loss.backward()
            optimizer.step()

            # print statistics
            running_loss += loss.item()
            if i > 0 and i % loss_batch_print == 0:    # print regularly
                print(f'[{epoch + 1}, {i + 1:5d}] loss: {running_loss / loss_batch_print:.3f}')
                running_loss = 0.0
        
        # Save at the end of the epoch.
        save_path = f'./checkpoint_{epoch}.pth'
        torch.save(net.state_dict(), save_path)
        # Evaluate on test at the end of the epoch
        correct = 0
        total = 0
        # since we're not training, we don't need to calculate the gradients for our outputs
        with torch.no_grad():
            for data in test_loader:
                inputs, labels = data[0].to(device), data[1].to(device)
                # calculate outputs by running images through the network
                outputs = net(inputs)
                # the class with the highest energy is what we choose as prediction
                _, predicted = torch.max(outputs.data, 1)
                correct += (predicted == labels).sum().item()
                total += batch_size
            print(f'Accuracy of the network on the {total} test images: {100 * correct // total} %')
    writer.flush()
    writer.close()
    print('Finished Training')
if __name__ == '__main__':
    run()