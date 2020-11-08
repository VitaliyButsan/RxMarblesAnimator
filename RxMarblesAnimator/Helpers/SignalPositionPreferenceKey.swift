//
//  SignalPositionPreferenceKey.swift
//  RxMarblesAnimator
//
//  Created by vit on 08.11.2020.
//

import SwiftUI

struct SignalPositionPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
