struct HStackDrawable: Drawable {
    
    var origin: Point = .zero
    
    var size: Size = .zero
    
    var alignment: VerticalAlignment
    
    func getWidthForProposedWidth(_ width: Double) -> Double {
        width
    }
    
    func getHeightForProposedHeight(_ height: Double) -> Double {
        height
    }
}
