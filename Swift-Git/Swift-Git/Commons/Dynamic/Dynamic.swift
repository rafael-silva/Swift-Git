import Foundation

public final class Dynamic<T> {
   
    public typealias Listener = (T) -> Void

    private(set) var listener: Listener?
    private(set) var observer: DynamicObserver<T>?
    
    public var value: T {
        didSet {
            observer?.addValue(value)
            callListener()
        }
    }
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
    }
    
    public func bindAndFire(listener: Listener?) {
        self.listener = listener
        callListener()
    }
    
    public func isBinded() -> Bool {
        return listener != nil
    }
    
    public func setObserver(with observer: DynamicObserver<T>) {
        self.observer = observer
    }
    
    private func callListener() {
        //Jumping queues https://www.swiftbysundell.com/posts/reducing-flakiness-in-swift-tests
        if Thread.isMainThread {
            listener?(value)
        } else {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
}

public final class DynamicObserver<T> {
    private(set) var values: [T] = []
    
    func addValue(_ value: T) {
        values.append(value)
    }
}
