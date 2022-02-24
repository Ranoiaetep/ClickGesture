import SwiftUI

/// Create a clicking `Gesture` that infers the location where it was clicked to be used in closure
public struct ClickGesture: Gesture {
    /// The required number of tap events.
    public let count: Int
    /// The coordinate space in which to receive location values.
    public let coordinateSpace: CoordinateSpace
    
    public typealias Value = SimultaneousGesture<TapGesture, DragGesture>.Value
    
    /// Creates a click gesture with the number of required taps and the coordinate space of the gesture’s location.
    public init(count: Int = 1, coordinateSpace: CoordinateSpace = .local) {
        precondition(count > 0, "Count must be greater than or equal to 1.")
        self.count = count
        self.coordinateSpace = coordinateSpace
    }
    
    public var body: SimultaneousGesture<TapGesture, DragGesture> {
        SimultaneousGesture(
            TapGesture(count: count),
            DragGesture(minimumDistance: 0, coordinateSpace: coordinateSpace)
        )
    }
    
    /// Adds an action to perform when the gesture ends.
    ///
    /// - Parameter action: a closure that can infer the clicking location as a `CGPoint`
    public func onEnded(perform action: @escaping (CGPoint) -> Void) -> _EndedGesture<ClickGesture> {
        self.onEnded { (value: Value) -> Void in
            guard value.first != nil else { return }
            guard let location = value.second?.startLocation else { return }
            guard let endLocation = value.second?.location else { return }
            guard ((location.x-1)...(location.x+1)).contains(endLocation.x),
                  ((location.y-1)...(location.y+1)).contains(endLocation.y) else {
                return
            }
            action(location)
        }
    }
}

/// Modifier to apply a `ClickGesture` onto a `View`
///
/// - Parameter action: a closure that can infer the clickling location as a `CGPoint`
///
/// ```swift
/// Rectangle()
/// .onClickGesture { location in
///     print(location)
/// }
/// ```
public func onClickGesture<T: View>(_ view: T, count: Int = 1, coordinateSpace: CoordinateSpace = .local, perform action: @escaping (CGPoint) -> Void) -> some View {
    return view.gesture(ClickGesture().onEnded(perform: action))
}
