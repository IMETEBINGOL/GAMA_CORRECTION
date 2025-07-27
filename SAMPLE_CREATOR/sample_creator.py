## Import necessary modules
import numpy as np
import cv2 as cv2
## Import custom modules
from GAMA_EFFECT_ADDER.gama_effect_adder import gamaEffectAdder
from NOISE_SPRINKLER.noise_sprinkler import noiseSprinkler
from SIGNAL_ADDER.signal_adder import signalAdder
from PLOTTER.plotter import plotter



class SampleCreator:
    def __init__(self):
        self.OWNER          = "IBRAHIM METE BINGOL"
        self.VERSION        = "1.0.0"
        self.DESCRIPTION    = "This class provides methods to create and manipulate samples."
        self.CREATION_DATE  = "2025-07-27"
        self.LAST_MODIFIED  = "2025-07-27"
        self.GEA            = gamaEffectAdder()
        self.NS             = noiseSprinkler()
        self.SA             = signalAdder()
        self.P              = plotter()
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
    def createRandomImageSignal1D(self, length: int, signalLevel: float):
        """
        Creates a 1D random signal.
        """
        return self.SA.CreateRandomImageSignal1D(length, signalLevel)
    def createRandomImageSignal1DWithGaussianNoise(self, shape: tuple, signalLevel: float, noiseLevel: float):
        """
        Creates a 1D random signal with Gaussian noise.
        """
        return self.NS.addNoiseGaussian1D(self.SA.CreateRandomImageSignal1D(shape, signalLevel), noiseLevel)
    def createRandomImageSignal1DWithUniformNoise(self, shape: tuple, signalLevel: float, noiseLevel: float):
        """
        Creates a 1D random signal with uniform noise.
        """
        return self.NS.addNoiseUniform1D(self.SA.CreateRandomImageSignal1D(shape, signalLevel), noiseLevel)
    def createRandomImageSignal2D(self, shape: tuple, signalLevel: float):
        """
        Creates a 2D random signal.
        """
        return self.SA.CreateRandomImageSignal2D(shape, signalLevel)
    def createRandomImageSignal2DWithGaussianNoise(self, shape: tuple, signalLevel: float, noiseLevel: float):
        """
        Creates a 2D random signal with Gaussian noise.
        """
        return self.NS.addNoiseGaussian2D(self.SA.CreateRandomImageSignal2D(shape, signalLevel), noiseLevel)
    def createRandomImageSignal2DWithUniformNoise(self, shape: tuple, signalLevel: float, noiseLevel: float):
        """
        Creates a 2D random signal with uniform noise.
        """
        return self.NS.addNoiseUniform2D(self.SA.CreateRandomImageSignal2D(shape, signalLevel), noiseLevel)
    def imageToImageSignal1D(self, filePath: str):
        """
        Converts a PNG image to a 1D signal.

        Parameters:
        filePath (str): The path to the PNG file.
        
        Returns:
        np.array: The 1D signal represented by the image.
        """
        return self.SA.imageToImageSignal1D(filePath)
    def imageToImageSignal1DWithUniformNoise(self, filePath: str):
        """
        Converts a PNG image to a 1D signal with uniform noise.

        Parameters:
        filePath (str): The path to the PNG file.
        
        Returns:
        np.array: The 1D signal represented by the image.
        """
        return self.NS.addNoiseUniform1D(self.SA.imageToImageSignal1D(filePath))
    def imageToImageSignal1DWithGaussianNoise(self, filePath: str, noiseLevel: float = 0.1):
        """
        Converts a PNG image to a 1D signal with Gaussian noise.

        Parameters:
        filePath (str): The path to the PNG file.

        Returns:
        np.array: The 1D signal represented by the image.
        """
        return self.NS.addNoiseGaussian1D(self.SA.imageToImageSignal1D(filePath), noiseLevel)
    def imageToImageSignal2D(self, filePath: str):
        """
        Converts a PNG image to a 2D signal.

        Parameters:
        filePath (str): The path to the PNG file.

        Returns:
        np.array: The 2D signal represented by the image.
        """
        return self.SA.imageToImageSignal2D(filePath)
    def imageToImageSignal2DWithUniformNoise(self, filePath: str, noiseLevel: float = 0.1):
        """
        Converts a PNG image to a 2D signal with uniform noise.

        Parameters:
        filePath (str): The path to the PNG file.

        Returns:
        np.array: The 2D signal represented by the image.
        """
        return self.NS.addNoiseUniform2D(self.SA.imageToImageSignal2D(filePath), noiseLevel)
    def imageToImageSignal2DWithGaussianNoise(self, filePath: str, noiseLevel: float = 0.1):
        """
        Converts a PNG image to a 2D signal with Gaussian noise.

        Parameters:
        filePath (str): The path to the PNG file.

        Returns:
        np.array: The 2D signal represented by the image.
        """
        return self.NS.addNoiseGaussian2D(self.SA.imageToImageSignal2D(filePath), noiseLevel)
    def applyGamaEffect1D(self, signal: np.array, gama: float, scaler: float = 1.0):
        """
        Applies Gama effect to a 1D signal.

        Parameters:
        signal (np.array): The input signal.
        gama (float): The gama value for the effect.

        Returns:
        np.array: The signal with Gama effect applied.
        """
        return self.GEA.addGamaEffect1DImageSignal(signal, gama, scaler)
    def applyGamaEffect2D(self, signal: np.array, gama: float, scaler: float = 1.0):
        """
        Applies Gama effect to a 2D signal.

        Parameters:
        signal (np.array): The input signal.
        gama (float): The gama value for the effect.

        Returns:
        np.array: The signal with Gama effect applied.
        """
        return self.GEA.addGamaEffect2DImageSignal(signal, gama, scaler)
    def findMinValue1DArray(self, arr: np.array):
        """
        Finds the minimum value in a 1D array.

        Parameters:
        arr (np.array): The input 1D array.

        Returns:
        float: The minimum value in the array.
        """
        return np.min(arr)
    def findMinValue2DArray(self, arr: np.array):
        """
        Finds the minimum value in a 2D array.

        Parameters:
        arr (np.array): The input 2D array.

        Returns:
        float: The minimum value in the array.
        """
        return np.min(arr)
    def findMaxValue1DArray(self, arr: np.array):
        """
        Finds the maximum value in a 1D array.

        Parameters:
        arr (np.array): The input 1D array.

        Returns:
        float: The maximum value in the array.
        """
        return np.max(arr)
    def findMaxValue2DArray(self, arr: np.array):
        """
        Finds the maximum value in a 2D array.

        Parameters:
        arr (np.array): The input 2D array.

        Returns:
        float: The maximum value in the array.
        """
        return np.max(arr)
    def floatArrayToUInt32Array(self, arr: np.array):
        """
        Converts a float array to an 32-bit unsigned integer array.

        Parameters:
        arr (np.array): The input float array.

        Returns:
        np.array: The converted integer array.
        """
        return arr.astype(np.uint32)
    def uint32ArrayToFloatArray(self, arr: np.array):
        """
        Converts a 32-bit unsigned integer array to a float array.

        Parameters:
        arr (np.array): The input 32-bit unsigned integer array.

        Returns:
        np.array: The converted float array.
        """
        return arr.astype(np.float32)
    def floatArrayToUint16Array(self, arr: np.array):
        """
        Converts a float array to a 16-bit unsigned integer array.

        Parameters:
        arr (np.array): The input float array.

        Returns:
        np.array: The converted 16-bit unsigned integer array.
        """
        return arr.astype(np.uint16)
    def uint16ArrayToFloatArray(self, arr: np.array):
        """
        Converts a 16-bit unsigned integer array to a float array.

        Parameters:
        arr (np.array): The input 16-bit unsigned integer array.

        Returns:
        np.array: The converted float array.
        """
        return arr.astype(np.float32) 
    def floatArrayToUint8Array(self, arr: np.array):
        """
        Converts a float array to an 8-bit unsigned integer array.

        Parameters:
        arr (np.array): The input float array.

        Returns:
        np.array: The converted 8-bit unsigned integer array.
        """
        return arr.astype(np.uint8)

    def uint8ArrayToFloatArray(self, arr: np.array):
        """
        Converts an 8-bit unsigned integer array to a float array.

        Parameters:
        arr (np.array): The input 8-bit unsigned integer array.

        Returns:
        np.array: The converted float array.
        """
        return arr.astype(np.float32)
    def plot2DSignal(self, signal: np.array, title: str = "2D Signal Plot", cmap: str = "gray", xlabel: str = "Sample Index", ylabel: str = "Time Index", min_value: float = None, max_value: float = None):
        """
        Plots a 2D signal.

        Parameters:
        signal (np.array): The 2D signal to be plotted.
        title (str): The title of the plot.
        cmap (str): The colormap to be used for the plot.
        xlabel (str): The label for the x-axis.
        ylabel (str): The label for the y-axis.
        min_value (float): Minimum value for color scaling.
        max_value (float): Maximum value for color scaling.
        """
        self.P.plot2DSignal(signal, title, cmap, xlabel, ylabel, min_value, max_value)
    def plot1DSignal(self, signal: np.array, title: str = "1D Signal Plot", xlabel: str = "Sample Index", ylabel: str = "Signal Value"):
        """
        Plots a 1D signal.

        Parameters:
        signal (np.array): The 1D signal to be plotted.
        title (str): The title of the plot.
        xlabel (str): The label for the x-axis.
        ylabel (str): The label for the y-axis.
        """
        self.P.plot1DSignal(signal, title, xlabel, ylabel)
    def showImage(self, image: np.array, title: str = "Image", cmap: str = "gray", min_value: float = None, max_value: float = None):
        """
        Displays an image.

        Parameters:
        image (np.array): The image to be displayed.
        title (str): The title of the image.
        cmap (str): The colormap to use for displaying the image.
        min_value (float): Minimum value for color scaling.
        max_value (float): Maximum value for color scaling.
        """
        self.P.showImage(image, title, cmap, min_value, max_value)
    def linearMap1DSignal(self, signal: np.array, newMin: float, newMax: float):
        """
        Linearly maps a 1D signal to a new range.

        Parameters:
        signal (np.array): The input 1D signal.
        newMin (float): The new minimum value.
        newMax (float): The new maximum value.

        Returns:
        np.array: The linearly mapped 1D signal.
        """
        return self.SA.linearMap1DSignal(signal, newMin, newMax)
    
    def linearMap2DSignal(self, signal: np.array, newMin: float, newMax: float):
        """
        Linearly maps a 2D signal to a new range.

        Parameters:
        signal (np.array): The input 2D signal.
        newMin (float): The new minimum value.
        newMax (float): The new maximum value.

        Returns:
        np.array: The linearly mapped 2D signal.
        """
        return self.SA.linearMap2DSignal(signal, newMin, newMax)

if __name__ == "__main__":
    # Example usage
    SC = SampleCreator()
    print(SC.getOwner())
    print(SC.getVersion())
    print(SC.getDescription())
    print(SC.getCreationDate())
    print(SC.getLastModified())

    # create samples 
    originalSignal1DwithGaussianNoise   = SC.imageToImageSignal1DWithGaussianNoise("SAMPLES/sample_image_dog.jpg", 0.2)
    originalSignal2DwithGaussianNoise   = SC.imageToImageSignal2DWithGaussianNoise("SAMPLES/sample_image_dog.jpg", 0.2)
    # Normalize the signals to have minimum value of 0
    normalizedSignal1D                  = SC.linearMap1DSignal(originalSignal1DwithGaussianNoise, 0.0, originalSignal1DwithGaussianNoise.max())
    normalizedSignal2D                  = SC.linearMap2DSignal(originalSignal2DwithGaussianNoise, 0.0, originalSignal2DwithGaussianNoise.max())
    # Plot the signals
    #SC.plot1DSignal(originalSignal1DwithGaussianNoise, title="Original 1D Signal with Gaussian Noise", xlabel="Sample Index", ylabel="Signal Value")
    #SC.plot2DSignal(SC.floatArrayToUint16Array(originalSignal2DwithGaussianNoise), title="Original 2D Signal with Gaussian Noise", cmap="gray", xlabel="Sample X Index", ylabel="Sample Y Index", min_value=originalSignal2DwithGaussianNoise.min(), max_value=originalSignal2DwithGaussianNoise.max())
    #SC.showImage(SC.floatArrayToUint16Array(originalSignal2DwithGaussianNoise), title="Original 2D Signal Image", cmap="gray", min_value=originalSignal2DwithGaussianNoise.min(), max_value=originalSignal2DwithGaussianNoise.max())
    ## Plot the normalized signals
    #SC.plot1DSignal(normalizedSignal1D, title="Normalized 1D Signal", xlabel="Sample Index", ylabel="Signal Value")
    #SC.plot2DSignal(SC.floatArrayToUint16Array(normalizedSignal2D), title="Normalized 2D Signal", cmap="gray", xlabel="Sample X Index", ylabel="Sample Y Index", min_value=normalizedSignal2D.min(), max_value=normalizedSignal2D.max())
    #SC.showImage(SC.floatArrayToUint16Array(normalizedSignal2D), title="Normalized 2D Signal Image", cmap="gray", min_value=normalizedSignal2D.min(), max_value=normalizedSignal2D.max())
    ## Apply Gama effect
    gamaEffect1D                        = SC.applyGamaEffect1D(normalizedSignal1D, 0.5, scaler=10.0)
    gamaEffect2D                        = SC.applyGamaEffect2D(normalizedSignal2D, 0.5, scaler=10.0)
    normalizedGamaEffect1D              = SC.linearMap1DSignal(gamaEffect1D, 0.0, gamaEffect1D.max())
    normalizedGamaEffect2D              = SC.linearMap2DSignal(gamaEffect2D, 0.0, gamaEffect2D.max())
    # Plot the Gama effect signals
    SC.plot1DSignal(normalizedGamaEffect1D, title="Gama Effect 1D Signal", xlabel="Sample Index", ylabel="Signal Value")
    SC.plot2DSignal(SC.floatArrayToUint16Array(normalizedGamaEffect2D), title="Gama Effect 2D Signal", cmap="gray", xlabel="Sample X Index", ylabel="Sample Y Index", min_value=0, max_value=255)
    SC.showImage(SC.floatArrayToUint16Array(normalizedGamaEffect2D), title="Gama Effect 2D Signal Image", cmap="gray", min_value=0, max_value=255)
