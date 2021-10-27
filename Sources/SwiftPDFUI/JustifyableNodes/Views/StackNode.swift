class StackNode: AlignmentNode {
	
	let mainAxis: Axis
	
//	private let mainAxisMinLength: ReferenceWritableKeyPath<JustifiableNode, Double>
//	private let mainAxisMaxLength: ReferenceWritableKeyPath<JustifiableNode, Double>
//	private let mainAxisLength: ReferenceWritableKeyPath<JustifiableNode, Double>
	
//	var totalSpacing: Double {
//		return 0
//	}
	
	init(mainAxis: Axis) {
		self.mainAxis = mainAxis
		
//		switch mainAxis {
//		case .vertical:
//			mainAxisMinLength = \JustifiableNode.minWidth
//			mainAxisMaxLength = \JustifiableNode.maxWidth
//			mainAxisLength = \JustifiableNode.width
//
//		case .horizontal:
//			mainAxisMinLength = \JustifiableNode.minHeight
//			mainAxisMaxLength = \JustifiableNode.maxHeight
//			mainAxisLength = \JustifiableNode.height
//		}
	}
	
//	override func justify(proposedWidth: Double, proposedHeight: Double) {
//
//		let mainAxisProposedLength: Double
//
//		let secondaryAxisProposedLength: Double
//
//		switch mainAxis {
//		case .vertical:
//			mainAxisProposedLength = proposedHeight
//			secondaryAxisProposedLength = proposedWidth
//
//		case .horizontal:
//			mainAxisProposedLength = proposedWidth
//			secondaryAxisProposedLength = proposedHeight
//		}
//
//		var partitionedChildren = self.children
//
//		let p0 = partitionedChildren.partition(by: { $0[keyPath: mainAxisMinLength] > 0 })
//
//		let minChildrenCount = partitionedChildren[..<p0].count
//
//		let minSum = partitionedChildren[p0...].map { $0[keyPath: mainAxisMinLength] }.reduce(0, +)
//
//		var remainingLength = mainAxisProposedLength - totalSpacing - minSum
//
//		let minChildLength = remainingLength / Double(minChildrenCount)
//
//		let _ = partitionedChildren[..<p0].partition(by: { $0[keyPath: mainAxisMaxLength] <= minChildLength })
//
//		remainingLength = justify(
//			children: partitionedChildren[..<p0],
//			totalLength: remainingLength,
//			proposedLength: secondaryAxisProposedLength
//		)
//
//		let p3 = partitionedChildren[p0...].partition(by: { $0[keyPath: mainAxisMaxLength] < .infinity })
//
//		partitionedChildren[p0..<p3].sort(by: { $0[keyPath: mainAxisMinLength] < $1[keyPath: mainAxisMinLength] })
//
//		remainingLength = justify(
//			children: partitionedChildren[p0...],
//			totalLength: remainingLength + minSum,
//			proposedLength: secondaryAxisProposedLength
//		)
//
//		self.width = children.lazy.map { $0[keyPath: self.mainAxisLength] }.reduce(0, +) + totalSpacing
//		self.height = children.lazy.max(by: { $0.height < $1.height })?.height ?? 0
//	}
//
//
//	private func justify(children: Array<JustifiableNode>.SubSequence, totalLength: Double, proposedLength: Double) -> Double {
//
//		var remainingChildren = children.count
//
//		var remainingLength = totalLength
//
//		var childLength: Double {
//			remainingLength / Double(remainingChildren)
//		}
//
//		switch mainAxis {
//		case .vertical:
//			for child in children.reversed() {
//				child.justify(proposedWidth: proposedLength, proposedHeight: childLength)
//				remainingChildren -= 1
//				remainingLength -= child[keyPath: mainAxisLength]
//			}
//
//		case .horizontal:
//			for child in children.reversed() {
//				child.justify(proposedWidth: childLength, proposedHeight: proposedLength)
//				remainingChildren -= 1
//				remainingLength -= child[keyPath: mainAxisLength]
//			}
//		}
//
//		return remainingLength
//	}
}

enum Axis {
	case vertical
	case horizontal
}
