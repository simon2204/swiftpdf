protocol NodeProtocol: AnyObject {
    var children: [NodeProtocol]? { get set }
}

extension NodeProtocol {
    func append(_ child: NodeProtocol) {
        if children?.append(child) == nil {
            children = [child]
        }
    }
}
