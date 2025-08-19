import numpy as np
import matplotlib.pyplot as plt


class plotter:
    def __init__(self):
        self.OWNER          = "IBRAHIM METE BINGOL"
        self.VERSION        = "1.0.0"
        self.DESCRIPTION    = "This class provides methods to plot signals and images."
        self.CREATION_DATE  = "2025-07-27"
        self.LAST_MODIFIED  = "2025-07-27"
    def getOwner(self):
        """
        Returns the owner of the class.
        """
        return self.OWNER
    def getVersion(self):
        """
        Returns the version of the class.
        """
        return self.VERSION
    def getDescription(self):
        """
        Returns the description of the class.
        """
        return self.DESCRIPTION
    def getCreationDate(self):
        """
        Returns the creation date of the class.
        """
        return self.CREATION_DATE
    def getLastModified(self):
        """
        Returns the last modified date of the class.
        """
        return self.LAST_MODIFIED
    def plot1DSignal(self, signal : np.array, title: str = "1D Signal Plot", xlabel: str = "Sample Index", ylabel: str = "Signal Value"):
        """
        Plots a 1D signal.

        Parameters:
        signal (np.array): The 1D signal to be plotted.
        title (str): The title of the plot.
        xlabel (str): The label for the x-axis.
        ylabel (str): The label for the y-axis.
        """
        plt.figure(figsize=(10, 5))
        plt.plot(signal)
        plt.title(title)
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.grid()
        plt.show()
    def plot2DSignal(self, signal : np.array, title: str = "2D Signal Plot", cmap: str = "gray", xlabel: str = "Sample Index", ylabel: str = "Time Index", min_value: float = None, max_value: float = None):
        """
        Plots a 2D signal.
        """
        plt.figure(figsize=(10, 5))
        plt.imshow(signal, aspect='auto', cmap=cmap, vmin=min_value, vmax=max_value)
        plt.title(title)
        plt.colorbar(label='Signal Value')
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.grid()
        plt.show()
    def showImage(self, image: np.array, title: str = "Image", cmap: str = "gray", min_value: float = None, max_value: float = None):
        """
        Displays an image.

        Parameters:
        image (np.array): The image to be displayed.
        title (str): The title of the image.
        cmap (str): The colormap to use for displaying the image.
        """
        plt.figure(figsize=(10, 5))
        plt.imshow(image, cmap=cmap, vmin=min_value, vmax=max_value)    
        plt.title(title)
        plt.axis('off')
        plt.show()