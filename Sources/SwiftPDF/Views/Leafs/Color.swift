import SwiftPDFFoundation

/// Repräsentiert eine Farbe.
///
/// Farben können sowohl als Wert verwendet werden, der einem Parameter übergeben werden kann,
/// sowie auch als View, dargestellt als Reckteck mit der entsprechenden Farbe als Füllung.
///
/// Eine beliebige Farbe kann mit ``Color/init(red:green:blue:)`` erstellt werden.
///
/// ```swift
/// let olive = Color(red: 0.5, green: 0.5, blue: 0)
/// ```
/// ![Olivenfarbenes Rechteck.](Color.png)
///
/// Um verschiedene Helligkeitsstufen einer Farbe zu erreichen wird ``Color/brightness(_:)`` verwendet.
/// In diesem Beispiel wird ein Wertebereich von 0 bis 2, mit einer Schrittweite von 0,1 erstellt,
/// um die Farbe Blau in 20 verschiedenen Helligkeitsstufen abzubilden:
/// ```swift
/// struct ContentView: View {
///
///     let dark = 0.0
///
///     let bright = 3.0
///
///     let stepOfBrightness = 0.1
///
///     var colorRange: StrideThrough<Double> {
///         stride(from: dark, through: bright, by: stepOfBrightness)
///     }
///
///     var body: some View {
///         VStack(spacing: 1) {
///             ForEach(colorRange) { amount in
///                 HStack {
///                     Color(red: 1, green: 0, blue: 0).brightness(amount)
///                     Color(red: 0, green: 1, blue: 0).brightness(amount)
///                     Color(red: 0, green: 0, blue: 1).brightness(amount)
///                 }
///             }
///         }
///     }
/// }
/// ```
/// ![Blau mit unterschiedlichen Helligkeitsstufen.](ColorBrightness.png)
public struct Color: View {
    
    /// Rotanteil des RGB-Farbraumes.
    let red: Double
    
    /// Grünanteil des RGB-Farbraumes.
    let green: Double
    
    /// Blauanteil des RGB-Farbraumes.
    let blue: Double
    
    /// Repräsentation einer Fabe in einem PDF-Dokument.
    var pdfColor: PDFColor {
        PDFColor(red: red, green: green, blue: blue)
    }
    
    /// Erstellt eine neue Farbe mit den übergebenen Farbanteilen des RGB-Farbraumes.
    ///
    /// Jeder Farbanteil bekommt einen Wert zwischen 0 und 1 zugewiesen.
    /// 0 bedeutet ein Farbanteil von 0 Prozent und 1 bedeutet ein Farbanteil von 100 Prozent.
    ///
    /// - Parameters:
    ///   - red: Rotanteil des RGB-Farbraumes.
    ///   - green: Grünanteil des RGB-Farbraumes.
    ///   - blue: Blauanteil des RGB-Farbraumes.
	public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
	}
    
    /// Erstellt eine neue Farbe, durch Änderung der Helligkeit.
    ///
    /// Erhöht oder verringert die Helligkeit einer Farbe.
    /// Durch Übergabe eines Wertes größer 1 wird die Helligkeit erhöht,
    /// bei einem Wert kleiner 1 verringert sich die Helligkeit.
    ///
    /// - Parameter factor: Der Faktor, der der Farbe hinzugefügt oder abgezogen werden soll.
    /// - Returns: Liefert die gleiche Farbe, mit einem anderen Helligkeitsfactor.
    public func brightness(_ factor: Double) -> Color {
        redistribute(red: red * factor, green: green * factor, blue: blue * factor)
    }
    
    private func redistribute(red: Double, green: Double, blue: Double) -> Color {
        let upperColorBound = 1.0
        let maxSegmentColor = max(red, green, blue)
        
        if maxSegmentColor <= upperColorBound {
            return Color(red: red, green: green, blue: blue)
        }
        
        let totalColor = red + green + blue
        
        if totalColor >= 3 * upperColorBound {
            return Color(red: upperColorBound, green: upperColorBound, blue: upperColorBound)
        }
        
        // Ratio of (middle-lowest)/(highest-lowest)
        let x = (3 * upperColorBound - totalColor) / (3 * maxSegmentColor - totalColor)
        let gray = upperColorBound - x * maxSegmentColor
        
        return Color(red: gray + x * red, green: gray + x * green, blue: gray + x * blue)
    }
}

public extension Color {
	static let black = Color(red: 0, green: 0, blue: 0)
	static let blue = Color(red: 0.04, green: 0.52, blue: 1)
	static let brown = Color(red: 0.67, green: 0.56, blue: 0.41)
	static let cyan = Color(red: 0.35, green: 0.78, blue: 0.96)
	static let gray = Color(red: 0.6, green: 0.6, blue: 0.62)
	static let green = Color(red: 0.2, green: 0.84, blue: 0.29)
	static let indigo = Color(red: 0.37, green: 0.36, blue: 0.9)
	static let mint = Color(red: 0.39, green: 0.9, blue: 0.89)
	static let orange = Color(red: 1, green: 0.62, blue: 0.04)
	static let pink = Color(red: 1, green: 0.22, blue: 0.37)
	static let purple = Color(red: 0.75, green: 0.35, blue: 0.95)
	static let red = Color(red: 1, green: 0.27, blue: 0.23)
	static let teal = Color(red: 0.42, green: 0.77, blue: 0.86)
	static let white = Color(red: 1, green: 1, blue: 1)
	static let yellow = Color(red: 1, green: 0.84, blue: 0.2)
}

extension Color: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let drawable = ColorDrawable(color: pdfColor)
		parent.add(child: drawable)
	}
}
