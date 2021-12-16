enum ColorSpace: Equatable {
	/// Controls the intensity of achromatic light,
	/// on a scale from black to white.
	///
	/// A grayscale value is represented in the range 0 to 1,
	/// where 0 corresponds to black, 1 to white,
	/// and intermediate values to different gray levels.
	case deviceGray(Double)
	
	/// Controls the intensities of red, green, and blue light,
	/// the three additive primary colors used in displays.
	///
	/// Each component is specified by a number in the range 0 to 1,
	/// where 0 denotes the complete absence of a primary component
	/// and 1 denotes maximum intensity.
	case deviceRGB(Double, Double, Double)
	
	/// Controls the concentrations of cyan, magenta, yellow, and black inks,
	/// the four subtractive process colors used in printing.
	///
	/// Each component is a number in the range 0 to 1,
	/// where 0 denotes the complete absence of a process colourant
	/// and 1 shall denote maximum concentration
	/// (absorbs as much as possible of the additive primary).
	case deviceCMYK(Double, Double, Double, Double)
}
