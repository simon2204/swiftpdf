protocol AnyViewStorageBase {}

class AnyViewStorage<V>: AnyViewStorageBase where V: View {
    let view: V
	
	init(_ view: V) {
		self.view = view
	}
}

public struct AnyView: View {

	let view: AnyViewStorageBase

    public init<V>(_ view: V) where V: View {
        self.view = AnyViewStorage(view)
    }
}
