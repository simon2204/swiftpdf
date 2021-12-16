/// Die Form einer Ellipse.
public struct Ellipse: Shape {
    
    public init() {}
    
    public func path(in rect: Rect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}
