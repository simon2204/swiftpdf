/// DSL zum Erstellen einer PDF.
///
/// Erstellt eine verschachtelte Datenstruktur, aus einem Block von Statements.
/// Der `ViewBuilder` kann auf eine Funktion, Methode oder Closure angewendet werden,
/// in dem der Parameter, mit einem vorangestellten `@ViewBuilder`, versehen wird.
/// Nach dem Aufruf dieser  Funktion, Methode oder Closure, wird eine View geliefert.
///
/// In diesem Beispiel wird `@ViewBuilder` auf `content` im Initializer des ``HStack``s angewendet,
/// um aus dem Block, mit potenziell mehreren Statements, einen einzigen Rückgabewert zu liefern:
/// ```swift
/// public struct HStack<Content>: View where Content: View {
///
///     let alignment: VerticalAlignment
///     let spacing: Double?
///     let content: () -> Content
///
///     public init(
///         alignment: VerticalAlignment = .center,
///         spacing: Double? = nil,
///         @ViewBuilder content: @escaping () -> Content)
///     {
///         self.alignment = alignment
///         self.spacing = spacing
///         self.content = content
///     }
/// }
/// ```
///
/// In dem `ViewBuilder` sind statische Funktionen definiert,
/// die automatisch vom Compiler zum bestehenden Code hinzugefügt werden,
/// um aus einem Block von Statements, ein Ergebnis zu erzeugen und zu liefern.
///
/// Um zu verdeutlichen,
/// wie aus einem Block von Anweisungen ein einzelner Wert erstellt wird,
/// wird für dieses Beispiel der `Seperator` verwendet.
/// Der `Seperator` ist eine horizontale Line, mit einem optionalen Titel,
/// um einen neuen Abschnitt innerhalb einer PDF zu erstellen.
/// Die Linie wird mit Hilfe von zwei Farben erstellt,
/// die horizontal gestapelt werden und eine Höhe von 1 bekommen.
/// Wenn ein Titel übergeben wurde,
/// wird der Titel zwischen den beiden Farben positioniert,
/// mit einem zusätzlichen Padding auf der horizontalen Achse,
/// damit die beiden Linien den Text nicht berühren.
///
/// ```swift
/// struct Seperator: View {
///
///     var title: String?
///
///     var body: some View {
///         HStack(spacing: 0) {
///             Color.black
///                 .frame(height: 1)
///
///             if let title = title {
///                 Text(title)
///                     .padding(.horizontal)
///             }
///
///             Color.black
///                 .frame(height: 1)
///         }
///     }
/// }
/// ```
///
/// Um zu zeigen, was der Compiler implizit hinzufügen würde,
/// wurden die ViewBuilder-Funktionsaufrufe, in diesem Beispiel,
/// explizit hinzugefügt:
///
/// ```swift
/// struct Seperator: View {
///
///     var title: String?
///
///     var body: some View {
///         HStack(spacing: 0) {
///
///             let v0 = Color.black.frame(height: 1)
///
///             let v1: some View
///
///             if let title = title {
///                 let v1_1 = Text(title).padding(.horizontal)
///                 let v1_block = ViewBuilder.buildBlock(v1_1)
///                 v1 = ViewBuilder.buildOptional(v1_block)
///             } else {
///                 v1 = ViewBuilder.buildOptional(nil)
///             }
///
///             let v2 = Color.black.frame(height: 1)
///
///             return ViewBuilder.buildBlock(v0, v1, v2)
///         }
///     }
/// }
/// ```
///
/// Das Ergebnis jedes Statements wird in einer Variable erfasst,
/// die Variablen werden der `buildBlock` Funktion übergeben
/// und das Ergebnis der `buildBlock` Funktion wird der Closure
/// als Rückgabewert zurück gegeben.
/// Hier in diesem Beispiel zu erkennen an den Variablen `v0`, `v1` und `v2`,
/// die hinzugefügt worden sind. `v1` liefert das Ergebnis des `if` Statements.
/// Da in `Swift` jede Variable initialisiert werden muss, wurde dem `if` Statement
/// ein zusätzlicher `else` Zweig angehangen, um `v1` in jedem Fall zu initialisieren,
/// falls der Block des `if` Statements nicht ausgeführt wird.
/// In dem Block des `if` Statements wird jedes Statement in einer Variable erfasst
/// und der `buildBlock` Funktion übergeben.
/// Zusätzlich wird das Ergebnis dieser `buildBlock` Funktion
/// der `buildOptional` Funktion übergeben,
/// um das Ergebnis des `if` Statements zu liefern.
/// Bei dem `else` Zweig, wird der `buildOptional` Funktion `nil` übergeben,
/// um eine entsprechende `View` zu liefern, die nicht Teil des Layoutsystems ist,
/// diese somit später auch nicht dargestellt wird.
///
@resultBuilder
public enum ViewBuilder {
    
    /// Erstellt eine leere View, wenn ein Block keine Statements beinhaltet.
    public static func buildBlock() -> EmptyView {
        EmptyView()
    }
    
    /// Bei einem Block, der eine einzige View beinhaltet, wird die View weiter gereicht.
    public static func buildBlock<Content>(_ content: Content) -> Content where Content: View {
		return content
	}
			
    /// Ermöglicht das Verwenden von `if` Statements, die keinen `else` Zweig verwenden.
    ///
    /// Wenn die Bedingung des `if` Statements `true` ist, wird der Inhalt des `if` Blocks übergeben.
    /// Wenn der Block nicht ausgeführt wird, wird `nil` übergeben.
	public static func buildOptional<Content>(_ content: Content?) -> Content? where Content: View {
		return content
	}

    /// Ermöglicht das Verwenden von `switch` Statements und `if` Statements mit `else` Zweigen.
	public static func buildEither<Content>(first content: Content) -> Content where Content: View {
		return content
	}

    /// Ermöglicht das Verwenden von `switch` Statements und `if` Statements mit `else` Zweigen.
	public static func buildEither<Content>(second content: Content) -> Content where Content: View {
		return content
	}
    
    /// Erstellt eine TupleView, aus einem Block, mit zwei Views.
    public static func buildBlock<C0, C1>(_ c0: C0, _ c1: C1) -> TupleView<(C0, C1)> where C0: View, C1: View {
        return TupleView((c0, c1))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit drei Views.
    public static func buildBlock<C0, C1, C2>(_ c0: C0, _ c1: C1, _ c2: C2) -> TupleView<(C0, C1, C2)> where C0: View, C1: View, C2: View {
        return TupleView((c0, c1, c2))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit vier Views.
    public static func buildBlock<C0, C1, C2, C3>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3) -> TupleView<(C0, C1, C2, C3)> where C0: View, C1: View, C2: View, C3: View {
        return TupleView((c0, c1, c2, c3))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit fünf Views.
    public static func buildBlock<C0, C1, C2, C3, C4>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4) -> TupleView<(C0, C1, C2, C3, C4)> where C0: View, C1: View, C2: View, C3: View, C4: View {
        return TupleView((c0, c1, c2, c3, c4))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit sechs Views.
    public static func buildBlock<C0, C1, C2, C3, C4, C5>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5) -> TupleView<(C0, C1, C2, C3, C4, C5)> where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View {
        return TupleView((c0, c1, c2, c3, c4, c5))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit sieben Views.
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6) -> TupleView<(C0, C1, C2, C3, C4, C5, C6)> where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View {
        return TupleView((c0, c1, c2, c3, c4, c5, c6))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit acht Views.
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7)> where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View {
        return TupleView((c0, c1, c2, c3, c4, c5, c6, c7))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit neun Views.
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8)> where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View {
        return TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8))
    }
    
    /// Erstellt eine TupleView, aus einem Block, mit zehn Views.
    public static func buildBlock<C0, C1, C2, C3, C4, C5, C6, C7, C8, C9>(_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8, _ c9: C9) -> TupleView<(C0, C1, C2, C3, C4, C5, C6, C7, C8, C9)> where C0: View, C1: View, C2: View, C3: View, C4: View, C5: View, C6: View, C7: View, C8: View, C9: View {
        return TupleView((c0, c1, c2, c3, c4, c5, c6, c7, c8, c9))
    }
}
