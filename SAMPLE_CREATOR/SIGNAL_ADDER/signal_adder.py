import numpy as np
import numpy.random as r





class signalAdder:
    def __init__(self):
        self.OWNER          = "IBRAHIM METE BINGOL"
        self.VERSION        = "1.0.0"
        self.DESCRIPTION    = "This class represents a signal adder that can be used to add image signals."
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
    def CreateRandomImageSignal1D(self, length : int, signalLevel : float):
        """
        Creates a 1D random signal.
        """
        return r.uniform(0, signalLevel, length)
    def CreateRandomImageSignal2D(self, shape : tuple, signalLevel : float):
        """
        Creates a 2D random signal.
        """
        return r.uniform(0, signalLevel, shape)
    def imageToImageSignal1D(self, filePath : str):
        """
        Converts a PNG image to a 1D signal.

        Parameters:
        filePath (str): The path to the PNG file.
        
        Returns:
        np.array: The 1D signal represented by the image.
        """
        from PIL import Image
        img = Image.open(filePath)
        return np.array(img).flatten()
    def imageToImageSignal2D(self, filePath : str):
        """
        Converts a PNG image to a 2D signal.
        Parameters:
        filePath (str): The path to the PNG file.
        Returns:
        np.array: The 2D signal represented by the image.
        """
        from PIL import Image
        img = Image.open(filePath)
        return np.array(img)
    
    def linearMap1DSignal(self, signal : np.ndarray, minValue : float, maxValue : float):
        """
        Maps a 1D signal to a specified range.
        
        Parameters:
        signal (np.ndarray): The input 1D signal.
        minValue (float): The minimum value of the output range.
        maxValue (float): The maximum value of the output range.
        
        Returns:
        np.ndarray: The mapped 1D signal.
        """
        return np.interp(signal, (signal.min(), signal.max()), (minValue, maxValue))
    
    def linearMap2DSignal(self, signal : np.ndarray, minValue : float, maxValue : float):
        """
        Maps a 2D signal to a specified range.
        
        Parameters:
        signal (np.ndarray): The input 2D signal.
        minValue (float): The minimum value of the output range.
        maxValue (float): The maximum value of the output range.
        
        Returns:
        np.ndarray: The mapped 2D signal.
        """
        return np.interp(signal, (signal.min(), signal.max()), (minValue, maxValue))    
    
    
if __name__ == "__main__":
    imagePath = "SAMPLE/image0.jpg"
    signal_adder = signalAdder()
    print("Owner:", signal_adder.getOwner())
    print("Version:", signal_adder.getVersion())
    print("Description:", signal_adder.getDescription())
    print("Creation Date:", signal_adder.getCreationDate())
    print("Last Modified:", signal_adder.getLastModified())
    # EXAMPLE USAGE
    signal_1d = signal_adder.CreateRandomImageSignal1D(100, 10.0)
    print("1D Signal:", signal_1d)

    signal_2d = signal_adder.CreateRandomImageSignal2D((100, 100), 10.0)
    print("2D Signal:", signal_2d)

    pngSignal_1d = signal_adder.imageToImageSignal1D(imagePath)
    print("1D Signal from PNG:", pngSignal_1d)

    pngSignal_2d = signal_adder.imageToImageSignal2D(imagePath)
    print("2D Signal from PNG:", pngSignal_2d)
    
