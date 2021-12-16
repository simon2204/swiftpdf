/// Richtet Knoten entlang einer Achse aus.
///
/// Der Platz der zur Verfügung steht soll unter den Knoten möglichst gerecht aufgeteilt werden,
/// sodass zusätzliche Bedingungen, wie die Mindest- oder Maximalgröße jedes Knotens,
/// eingehalten werden.
/// Zusätzlich soll der zur Verfügung stehende Platz möglichst aufgebraucht werden.
///
/// Es gibt eine verbliebende Länge, die den Knoten zur Verfügung steht,
/// die noch keine Länge zugewiesen bekommen haben.
/// Und eine Länge, die bei Abruf immer das Verhältnis
/// von der verbliebenden Länge und der Anzahl der Knoten,
/// die noch keine Länge zugewiesen bekommen haben, berechnet.
/// Diese Variable, die diese Länge berechnet wird im Folgenden als die
/// gerechte Knotenlänge bezeichnet.
///
/// Zunächst bekommen die Knoten ihre Länge zugeteilt,
/// deren Mindestlänge größer oder gleich der gerechten Knotenlänge ist.
/// Da diese Knoten bereits mehr von der restlichen Länge wollen,
/// als es gerecht wäre,
/// bekommen diese nur die gewünschte Mindestlänge zugewiesen.
/// Nach dem die Konten ihre Länge bekommen haben
/// und die restliche Länge neu berechnet wurde,
/// kann es sein, dass es jetzt weitere Knoten gibt,
/// deren Mindestlänge größer oder gleich der gerechten Knotenlänge ist.
/// Also wird der Vorgang so lange wiederholt,
/// bis sich keine Knoten mehr finden lassen,
/// die die zuvor genannte Bedingung erfüllen.
///
/// Im zweiten Schritt werden die Knoten behandelt,
/// deren Maximalgröße kleiner als die gerechte Knotenlänge ist.
/// Da diese Knoten gar nicht so viel von der Länge wollen,
/// wie sie bekommen könnten, bleibt mehr für die restlichen Knoten übrig,
/// die die gerechte Knotenlänge voll ausnutzen können, um möglichst viel
/// Platz zu verwenden, wie zur Verfügung steht.
///
/// Die restlichen Knoten, die noch keine länge zugeteilt bekommen haben,
/// bekommen die Länge der gerechten Knotenlänge zugeteilt.
/// Falls an diesem Punkt vorher noch Platz vorhanden war, ist dieser nun
/// vollständig aufgebraucht.
class AxisJustifier {
    
    /// Der Datentyp einer Partition.
    private typealias Partition = Array<JustifiableNode>.SubSequence
    
    /// Knoten, die noch keine Länge zugewiesen bekommen haben.
    private var remainingNode: Partition
    
    /// Anzahl der Knoten, die noch keine Länge zugewiesen bekommen haben.
    private var remainingNodeCount: Int
    
    /// Länge, die noch keinem Knoten zugeteilt wurde.
    private(set) var remainingLength: Double
    
    /// Gibt das Verhältnis von der verliebenden Länge
    /// zu der Anzahl der verbliebenden Knoten,
    /// die noch keine Länge zugewiesen bekommen haben,
    /// an.
    private var equitableNodeLength: Double {
        remainingLength / Double(remainingNodeCount)
    }
    
    init<Nodes: Collection>(nodes: Nodes, length: Double) where Nodes.Element == JustifiableNode {
        self.remainingNode = Partition(nodes)
        self.remainingNodeCount = nodes.count
        self.remainingLength = length
    }
    
    func justifyNodes() {
        justifyBiggerNodes()
        justifySmallerNodes()
        justifyRemainingNodes()
    }
    
    /// Richtet die Knoten mit einer Länge aus, die eine bestimmte Bedingung erfüllen.
    /// - Parameters:
    ///   - length: Länge die der übergebene Knoten bekommen soll.
    ///   - condition: Bedingung, die entscheidet, ob der übergebene Knoten ausgerichtet werden soll.
    private func justifyNodes(
        with length: (JustifiableNode) -> Double,
        where condition: (JustifiableNode) -> Bool)
    {
        var partition: Partition
        repeat {
            let pivot = remainingNode.partition { condition($0) }
            partition = remainingNode[pivot...]
            justifyNodes(in: partition, with: length)
            remainingNode = remainingNode[..<pivot]
        } while !partition.isEmpty
    }
    
    /// Richtet Knoten mit einer Länge aus, die sich in der Partition befinden.
    /// - Parameters:
    ///   - partition: Partition, die die Knoten enthält.
    ///   - proposedLength: Länge, mit denen ein Knoten ausgerichtet werden soll.
    private func justifyNodes(
        in partition: Partition,
        with proposedLength: (JustifiableNode) -> Double)
    {
        for node in partition {
            justifyNode(node, proposedLength: proposedLength(node))
            remainingLength -= nodeLength(node)
            remainingNodeCount -= 1
        }
    }
    
    /// Richtet Nodes aus, deren minimale Länge größer ist, als die vorgeschlagene Länge.
    private func justifyBiggerNodes() {
        justifyNodes(with: nodeMinLength, where: { nodeMinLength($0) >= equitableNodeLength })
    }
    
    /// Richtet Nodes aus, deren maximale Länge kleiner ist, als die vorgeschlagene Länge.
    private func justifySmallerNodes() {
        justifyNodes(with: proposedNodeLength, where: { nodeMaxLength($0) < equitableNodeLength })
    }
    
    /// Richtet die übrigen Nodes aus.
    private func justifyRemainingNodes() {
        justifyNodes(in: remainingNode, with: proposedNodeLength)
    }
    
    private func proposedNodeLength(for node: JustifiableNode) -> Double {
        return equitableNodeLength
    }
    
    func justifyNode(_ node: JustifiableNode, proposedLength: Double) {
        fatalError("Method has not been implemented.")
    }
    
    func nodeLength(_ node: JustifiableNode) -> Double {
        fatalError("Method has not been implemented.")
    }
    
    func nodeMinLength(_ node: JustifiableNode) -> Double {
        fatalError("Method has not been implemented.")
    }
    
    func nodeMaxLength(_ node: JustifiableNode) -> Double {
        fatalError("Method has not been implemented.")
    }
}
