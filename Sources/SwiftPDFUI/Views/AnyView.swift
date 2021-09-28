protocol AnyViewStorageBase {}

public class AnyViewStorage<V>: AnyViewStorageBase {
    
    let view: V
    
    let type: V.Type
    
    init(_ view: V) {
        self.view = view
        self.type = V.self
    }
    
    init(_ view: V) where V: View {
        self.view = view
        self.type = V.self
    }
    
    init(_ view: V) where V: PrimitiveView {
        self.view = view
        self.type = V.self
    }
}

public struct AnyView: View {

	let view: AnyViewStorageBase

    public init<V>(_ view: V) where V: View {
        self.view = AnyViewStorage(view)
	}
    
    init<V>(_ view: V) where V: PrimitiveView {
        self.view = AnyViewStorage(view)
    }
    
    init<V>(_ view: V) {
        self.view = AnyViewStorage(view)
    }
}
