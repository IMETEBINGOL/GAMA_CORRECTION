# -*- coding: utf-8 -*-
"""
This module provides a class for adding noise to signals.
"""
import numpy as np
import numpy.random as r


class noiseSprinkler:
    """
    This class represents a noise sprinkler that can be used to add noise to a signal.
    """
    
    def __init__(self):
        self.OWNER          = "IBRAHIM METE BINGOL"
        self.VERSION        = "1.0.0"
        self.DESCRIPTION    = "This class represents a noise sprinkler that can be used to add noise to a signal."
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

    def addNoiseGaussian1D(self, signal : np.array, noise_level, max_value = 255.0, min_value = 0.0):
        """
        Adds Gaussian noise to a 1D signal.

        Parameters:
        signal (np.array): The input signal.
        noise_level (float): The level of noise to be added.
        
        Returns:
        np.array: The signal with added noise.
        """
        noise = r.normal(0, noise_level, len(signal))
        noisy_signal = signal + noise
        return np.clip(noisy_signal, min_value, max_value)

    def addNoiseRandom1D(self, signal : np.array, noise_level, max_value = 255.0, min_value = 0.0):
        """
        Adds random noise to a 1D signal.

        Parameters:
        signal (np.array): The input signal.
        noise_level (float): The level of noise to be added.
        
        Returns:
        np.array: The signal with added noise.
        """
        noise = r.uniform(-noise_level, noise_level, len(signal))
        noisy_signal = signal + noise
        return np.clip(noisy_signal, min_value, max_value)

    def addNoiseGaussian2D(self, signal : np.array, noise_level, max_value = 255.0, min_value = 0.0):
        """
        Adds Gaussian noise to a 2D signal.

        Parameters:
        signal (np.array): The input signal.
        noise_level (float): The level of noise to be added.
        
        Returns:
        np.array: The signal with added noise.
        """
        noise = r.normal(0, noise_level, signal.shape)
        noisy_signal = signal + noise
        return np.clip(noisy_signal, min_value, max_value)

    def addNoiseRandom2D(self, signal : np.array, noise_level, max_value = 255.0, min_value = 0.0):
        """
        Adds random noise to a 2D signal.

        Parameters:
        signal (np.array): The input signal.
        noise_level (float): The level of noise to be added.

        Returns:
        np.array: The signal with added noise.
        """
        noise = r.uniform(-noise_level, noise_level, signal.shape)
        noisy_signal = signal + noise
        return np.clip(noisy_signal, min_value, max_value)



if __name__ == "__main__":
    # Example usage
    ns = noiseSprinkler()
    signal_1d = np.array([1, 2, 3, 4, 5])
    noisy_signal_1d = ns.addNoiseGaussian1D(signal_1d, 0.5)
    print("Noisy 1D Signal:", noisy_signal_1d)

    signal_2d = np.array([[1, 2], [3, 4], [5, 6]])
    noisy_signal_2d = ns.addNoiseRandom2D(signal_2d, 0.5)
    print("Noisy 2D Signal:\n", noisy_signal_2d)    


