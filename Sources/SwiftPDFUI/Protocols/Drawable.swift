protocol Drawable {
    var origin: Point { get set }
    var size: Size { get set }
    func getWidthForProposedWidth(_ width: Double) -> Double
    func getHeightForProposedHeight(_ height: Double) -> Double
}
