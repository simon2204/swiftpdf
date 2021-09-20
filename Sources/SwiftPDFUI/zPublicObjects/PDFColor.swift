/// Darstellung einer Farbe.
///
/// Farben können, zum Beispiel, auf ``PDFText`` und ``PDFPath`` angewendet werden.
///
/// ```swift
/// let gefieder = Color(red: 25, green: 22, blue: 17) // Braun- bis grauschwarzes Gefieder.
/// var text = Text("Der Mauersegler (Apus apus) ist eine Vogelart aus der Familie der Segler.")
/// text.color = gefieder
/// ```
///
/// Alle Farben, wie ``aliceBlue``, ``deepSkyBlue`` usw., wurden aus
/// [RapidTables](https://www.rapidtables.com/web/color/RGB_Color.html) entnommen.
public struct PDFColor {
	var value: Color
    
    /// Erstellt eine neue Farbe, zusammengesetzt aus Rot, Grün, Blau.
    ///
    /// Ein standardmäßiger sRGB-Farbraum.
    /// Jede Farbkomponente - Rot, Grün und Blau - ist auf einen Bereich von 0 bis 255 festgelegt.
    ///
    /// - Parameters:
    ///   - red: Roter Farbanteil.
    ///   - green: Grüner Farbanteil.
    ///   - blue: Blauer Farbanteil.
	public init(red: Int, green: Int, blue: Int) {
		self.init(
			red: Double(red) / 255.0,
			green: Double(green) / 255.0,
			blue: Double(blue) / 255.0
		)
    }
    
    /// Erstellt eine neue Farbe, zusammengesetzt aus Rot, Grün, Blau und einer Deckkraft.
    ///
    /// Ein standardmäßiger sRGB-Farbraum.
    /// Jede Farbkomponente - Rot, Grün und Blau - ist auf einen Bereich von 0 bis 1 festgelegt.
    ///
    /// - Parameters:
    ///   - red: Roter Farbanteil.
    ///   - green: Grüner Farbanteil.
    ///   - blue: Blauer Farbanteil.
	public init(red: Double, green: Double, blue: Double) {
		self.value = Color(
			colorSpace: .deviceRGB(red, green, blue),
			operation: Color.InkOperation.fill)
    }
	
	init(_ red: Int, _ green: Int, _ blue: Int) {
		self.init(red: red, green: green, blue: blue)
	}
}

public extension PDFColor {
    
    static let maroon = PDFColor(128, 0, 0)
    
    static let darkRed = PDFColor(139, 0, 0)
    
    static let brown = PDFColor(165, 42, 42)
    
    static let firebrick = PDFColor(178, 34, 34)
    
    static let crimson = PDFColor(220, 20, 60)
    
    static let red = PDFColor(255, 0, 0)
    
    static let tomato = PDFColor(255, 99, 71)
    
    static let coral = PDFColor(255, 127, 80)
    
    static let indianRed = PDFColor(205, 92, 92)
    
    static let lightCoral = PDFColor(240, 128, 128)
    
    static let darkSalmon = PDFColor(233, 150, 122)
    
    static let salmon = PDFColor(250, 128, 114)
    
    static let lightSalmon = PDFColor(255, 160, 122)
    
    static let orangeRed = PDFColor(255, 69, 0)
    
    static let darkOrange = PDFColor(255, 140, 0)
    
    static let orange = PDFColor(255, 165, 0)
    
    static let gold = PDFColor(255, 215, 0)
    
    static let darkGoldenRod = PDFColor(184, 134, 11)
    
    static let goldenRod = PDFColor(218, 165, 32)
    
    static let paleGoldenRod = PDFColor(238, 232, 170)
    
    static let darkKhaki = PDFColor(189, 183, 107)
    
    static let khaki = PDFColor(240, 230, 140)
    
    static let olive = PDFColor(128, 128, 0)
    
    static let yellow = PDFColor(255, 255, 0)
    
    static let yellowGreen = PDFColor(154, 205, 50)
    
    static let darkOliveGreen = PDFColor(85, 107, 47)
    
    static let oliveDrab = PDFColor(107, 142, 35)
    
    static let lawnGreen = PDFColor(124, 252, 0)
    
    static let charReuse = PDFColor(127, 255, 0)
    
    static let greenYellow = PDFColor(172, 255, 47)
    
    static let darkGreen = PDFColor(0, 100, 0)
    
    static let green = PDFColor(0, 128, 0)
    
    static let forestGreen = PDFColor(24, 139, 34)
    
    static let lime = PDFColor(0, 255, 0)
    
    static let limeGreen = PDFColor(50, 205, 50)
    
    static let lightGreen = PDFColor(144, 238, 144)
    
    static let paleGreen = PDFColor(152, 251, 152)
    
    static let darkSeaGreen = PDFColor(143, 188, 143)
    
    static let mediumSpringGreen = PDFColor(0, 250, 154)
    
    static let springGreen = PDFColor(0, 255, 127)
    
    static let seaGreen = PDFColor(46, 139, 87)
    
    static let mediumAquaMarine = PDFColor(102, 205, 170)
    
    static let mediumSeaGreen = PDFColor(60, 179, 113)
    
    static let lightSeaGreen = PDFColor(47, 79, 79)
    
    static let darkSlateGray = PDFColor(47, 79, 79)
    
    static let teal = PDFColor(0, 128, 128)
    
    static let darkCyan = PDFColor(0, 139, 139)
    
    static let aqua = PDFColor(0, 255, 255)
    
    static let cyan = PDFColor(0, 255, 255)
    
    static let lightCyan = PDFColor(224, 255, 255)
    
    static let darkTurquoise = PDFColor(0, 206, 209)
    
    static let turquoise = PDFColor(64, 224, 208)
    
    static let mediumTurquoise = PDFColor(72, 209, 204)
    
    static let paleTurquoise = PDFColor(175, 238, 238)
    
    static let aquaMarine = PDFColor(127, 255, 212)
    
    static let powderBlue = PDFColor(176, 224, 230)
    
    static let cadetBlue = PDFColor(95, 158, 160)
    
    static let steelBlue = PDFColor(70, 130, 180)
    
    static let cornFlowerBlue = PDFColor(100, 149, 237)
    
    static let deepSkyBlue = PDFColor(0, 191, 255)
    
    static let dodgerBlue = PDFColor(30, 144, 255)
    
    static let lightBlue = PDFColor(173, 216, 230)
    
    static let skyBlue = PDFColor(135, 206, 235)
    
    static let lightSkyBlue = PDFColor(135, 206, 250)
    
    static let midnightBlue = PDFColor(25, 25, 112)
    
    static let navy = PDFColor(0, 0, 128)
    
    static let darkBlue = PDFColor(0, 0, 139)
    
    static let mediumBlue = PDFColor(0, 0, 205)
    
    static let blue = PDFColor(0, 0, 255)
    
    static let royalBlue = PDFColor(65, 105, 225)
    
    static let blueViolet = PDFColor(138, 43, 226)
    
    static let indigo = PDFColor(75, 0, 130)
    
    static let darkSlateBlue = PDFColor(72, 61, 139)
    
    static let slateBlue = PDFColor(106, 90, 205)
    
    static let mediumSlateBlue = PDFColor(123, 104, 238)
    
    static let mediumPurple = PDFColor(147, 112, 219)
    
    static let darkMagenta = PDFColor(139, 0, 139)
    
    static let darkViolet = PDFColor(148, 0, 211)
    
    static let darkOrchid = PDFColor(153, 50, 204)
    
    static let mediumOrchid = PDFColor(186, 85, 211)
    
    static let purple = PDFColor(128, 0, 128)
    
    static let thistle = PDFColor(216, 191, 216)
    
    static let plum = PDFColor(221, 160, 221)
    
    static let violet = PDFColor(238, 130, 238)
    
    static let magenta = PDFColor(255, 0, 255)
    
    static let fuchsia = PDFColor(255, 0, 255)
    
    static let orchid = PDFColor(218, 112, 214)
    
    static let mediumVioletRed = PDFColor(199, 21, 133)
    
    static let paleVioletRed = PDFColor(219, 112, 147)
    
    static let deepPink = PDFColor(255, 20, 147)
    
    static let hotPink = PDFColor(255, 105, 180)
    
    static let lightPink = PDFColor(255, 182, 193)
    
    static let pink = PDFColor(255, 192, 203)
    
    static let antiqueWhite = PDFColor(250, 235, 215)
    
    static let beige = PDFColor(245, 245, 220)
    
    static let bisque = PDFColor(255, 228, 196)
    
    static let blanchedAlmond = PDFColor(255, 235, 205)
    
    static let wheat = PDFColor(245, 222, 179)
    
    static let cornSilk = PDFColor(255, 248, 220)
    
    static let lemonChiffon = PDFColor(255, 250, 205)
    
    static let lightGoldenRodYellow = PDFColor(250, 250, 210)
    
    static let lightYellow = PDFColor(255, 255, 224)
    
    static let saddleBrown = PDFColor(139, 69, 19)
    
    static let sienna = PDFColor(160, 82, 45)
    
    static let chocolate = PDFColor(210, 105, 30)
    
    static let peru = PDFColor(205, 133, 63)
    
    static let sandyBrown = PDFColor(244, 164, 96)
    
    static let burlyWood = PDFColor(222, 184, 135)
    
    static let tan = PDFColor(210, 180, 140)
    
    static let rosyBrown = PDFColor(188, 143, 143)
    
    static let moccasin = PDFColor(255, 228, 181)
    
    static let navajoWhite = PDFColor(255, 222, 173)
    
    static let peachPuff = PDFColor(255, 218, 185)
    
    static let mistyRose = PDFColor(255, 228, 225)
    
    static let lavenderBlush = PDFColor(255, 240, 245)
    
    static let linen = PDFColor(250, 240, 230)
    
    static let oldLace = PDFColor(253, 245, 230)
    
    static let papayaWhip = PDFColor(255, 239, 213)
    
    static let seaShell = PDFColor(255, 245, 238)
    
    static let mintCream = PDFColor(245, 255, 250)
    
    static let slateGray = PDFColor(112, 128, 144)
    
    static let lightSlateGray = PDFColor(119, 136, 153)
    
    static let lightSteelBlue = PDFColor(176, 196, 222)
    
    static let lavender = PDFColor(230, 230, 250)
    
    static let floralWhite = PDFColor(255, 250, 240)
    
    static let aliceBlue = PDFColor(240, 248, 255)
    
    static let ghostWhite = PDFColor(248, 248, 255)
    
    static let honeydew = PDFColor(240, 255, 240)
    
    static let ivory = PDFColor(255, 255, 240)
    
    static let azure = PDFColor(240, 255, 255)
    
    static let snow = PDFColor(255, 250, 250)
    
    static let black = PDFColor(0, 0, 0)
    
    static let dimGray = PDFColor(105, 105, 105)
    
    static let gray = PDFColor(128, 128, 128)
    
    static let darkGray = PDFColor(169, 169, 169)
    
    static let silver = PDFColor(192, 192, 192)
    
    static let gainsboro = PDFColor(220, 220, 220)
    
    static let whiteSmoke = PDFColor(245, 245, 245)
    
    static let white = PDFColor(255, 255, 255)
    
    static let clear = PDFColor(0, 0, 0)
}

extension PDFColor: Equatable {}
