import numpy as np






class gamaEffectAdder:
    """
    Class to add GAMA effects to image signals.
    """
    def __init__(self):
        self.OWNER = "GAMA_CORRECTION"
        self.VERSION = "1.0.0"
        self.DESCRIPTION = "This class represents a GAMA effect adder that can be used to add GAMA effects to image signals."
        self.CREATION_DATE = "2025-07-27"
        self.LAST_MODIFIED = "2025-07-27"

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

    def addGamaEffect1DImageSignal(self, imageSignal: np.ndarray, gamma: float, scaler: float) -> np.ndarray:
        """
        Adds GAMA effect to the 1D image signal.

        Parameters:
        imageSignal (np.ndarray): The input 1D image signal.
        gamma (float): The gamma value to apply.

        Returns:
        np.ndarray: The image signal with GAMA effect applied.
        """
        # Apply GAMA effect
        return np.power(imageSignal, gamma) * scaler
    def addGamaEffect2DImageSignal(self, imageSignal: np.ndarray, gamma: float, scaler: float) -> np.ndarray:
        """
        Adds GAMA effect to the 2D image signal.

        Parameters:
        imageSignal (np.ndarray): The input 2D image signal.
        gamma (float): The gamma value to apply.

        Returns:
        np.ndarray: The image signal with GAMA effect applied.
        """
        # Apply GAMA effect
        return np.power(imageSignal, gamma) * scaler
    
if __name__ == "__main__":
    ## Example usage of gamaEffectAdder class
    gama_adder = gamaEffectAdder()
    print("Owner:", gama_adder.getOwner())
    print("Version:", gama_adder.getVersion())
    print("Description:", gama_adder.getDescription())
    print("Creation Date:", gama_adder.getCreationDate())
    print("Last Modified:", gama_adder.getLastModified())
    # Example 1D image signal
    image_signal_1d = np.array([0.1, 0.5, 0.9])
    gamma_value = 2.2
    scaler_value = 1.0
    # Adding GAMA effect to 1D image signal
    output_signal_1d = gama_adder.addGamaEffect1DImageSignal(image_signal_1d, gamma_value, scaler_value)
    print("Output 1D Signal:", output_signal_1d)
    
    # Example 2D image signal
    image_signal_2d = np.array([[0.1, 0.5],
                                 [0.9, 0.3]])
    # Adding GAMA effect to 2D image signal
    output_signal_2d = gama_adder.addGamaEffect2DImageSignal(image_signal_2d, gamma_value, scaler_value)
    print("Output 2D Signal:", output_signal_2d)
    # Note: The above example usage is for demonstration purposes and can be removed in production code.