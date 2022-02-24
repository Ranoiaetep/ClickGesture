//
//  File.swift
//  
//
//  Created by Peter Cong on 2/24/22.
//

import SwiftUI

public extension View {
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
    func onClickGesture(count: Int = 1, coordinateSpace: CoordinateSpace = .local, perform action: @escaping (CGPoint) -> Void) -> some View {
        return Gestures.onClickGesture(self, count: count, coordinateSpace: coordinateSpace, perform: action)
    }
}
