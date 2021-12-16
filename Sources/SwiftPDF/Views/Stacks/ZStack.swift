/// Eine `View`, die `View`s übereinander stapelt.
///
/// Views im ZStack, die später aufgelistet werden, erscheinen über den vorherigen Views.
/// In diesem Beispiel werden die verschiedenen Farben übereinander gestapelt, wobei
/// die höheren Schichten durch den
/// ``View/frame(width:height:alignment:)``-Modifikator immer kleiner werden:
/// ```swift
/// struct ContentView: View {
///
///     let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]
///
///     let maxFrameSize = 100.0
///
///     let minFrameSize = 50.0
///
///     var stepAmount: Double {
///         (maxFrameSize - minFrameSize) / Double(colors.count)
///     }
///
///     var frameSizes: [Double] {
///         stride(from: minFrameSize, through: maxFrameSize, by: stepAmount).reversed()
///     }
///
///     var body: some View {
///         ZStack {
///             ForEach(zip(colors, frameSizes)) { color, frameSize in
///                 color.frame(width: frameSize, height: frameSize)
///             }
///         }
///     }
/// }
/// ```
/// ![ZStack geschichteten Farben, die immer kleiner werden.](ZStack.png)
///
/// Die Ausrichtung der Kinder kann durch Übergabe von eines der neun Werte erfolgen,
/// die in ``Alignment`` definiert sind.
/// Zum Beispiel werden die Views mit ``Alignment/topLeading``
/// an der oberen linken Ecke ausgerichtet:
///
/// ```swift
/// ZStack(alignment: .topLeading) {
///     ForEach(zip(colors, frameSizes)) { color, frameSize in
///         color.frame(width: frameSize, height: frameSize)
///     }
/// }
/// ```
/// ![ZStack mit TopLeading-Alignment](ZStackTopLeading.png)
public struct ZStack<Content>: View where Content: View {
	let alignment: Alignment
	let content: () -> Content
	
	public init(
		alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content)
	{
		self.alignment = alignment
        self.content = content
	}
}

extension ZStack: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let node = ZStackNode(alignment: alignment)
		parent.add(child: node)
		content().unwrapped().buildTree(node)
	}
}
