import SwiftPDF
import Foundation

struct DarkDocumentationBackgroundModifier: ViewModifier {
    
    let darkBackgroundColor = Color(red: 0.12, green: 0.12, blue: 0.12)
    
    func body(content: Content) -> some View {
        content.background {
            darkBackgroundColor
        }
    }
}

extension View {
    func darkDocumentationBackground() -> some View {
        self.modifier(DarkDocumentationBackgroundModifier())
    }
}

struct Star: Shape {
    /// Anzahl der Zacken.
    var points = 5

    func path(in rect: Rect) -> Path {

        // Länge bis zur Spitze einer Zacke,
        // beginnend von der Mitte des Sterns.
        let outerRadius = min(rect.width, rect.height) / 2

        // Länge bis zum Tal zwischen zweier Zacken,
        // beginnend von der Mitte des Sterns.
        let innerRadius = outerRadius / 2.25

        // Mitte des Sterns.
        let center = Point(x: rect.midX, y: rect.midY)

        // Winkel des Tals, senkrecht unter der Mitte.
        let startAngle = -Double.pi / 2 // -90°
        let endAngle = 3 * Double.pi / 2 // 270°

        // Winkel zwischen der Spitze und
        // dem Anfang einer Zacke eines Sterns.
        let halfCornerAngle = Double.pi / Double(points)

        // Winkel zwischen zwei Zacken eines Sterns.
        let cornerAngle = halfCornerAngle * 2

        // Winkel der Täler zwischen den Zacken.
        let innerAngles = stride(
            from: startAngle,
            through: endAngle,
            by: cornerAngle)

        // Alle Punkte der Täler und Spitzen.
        let points = innerAngles.lazy.flatMap { angle -> [Point] in
            let innerX = center.x + innerRadius * cos(angle)
            let innerY = center.y + innerRadius * sin(angle)
            let outerX = center.x + outerRadius * cos(angle + halfCornerAngle)
            let outerY = center.y + outerRadius * sin(angle + halfCornerAngle)
            return [Point(x: innerX, y: innerY), Point(x: outerX, y: outerY)]
        }

        // Pfad des Sterns.
        var path = Path()

        // Iterator über Punkte des Sterns.
        var pointIterator = points.makeIterator()

        // Zeichnet den Stern.
        if let firstPoint = pointIterator.next() {
            path.move(to: firstPoint)
            while let nextPoint = pointIterator.next() {
                path.addLine(to: nextPoint)
            }
        }

        path.closePath()

        return path
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            Star()
                .fill(.yellow)
            Star()
                .stroke(.orange)
        }
        .frame(width: 100, height: 100)
    }
}
