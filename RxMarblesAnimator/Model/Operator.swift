//
//  Operators.swift
//  RxMarblesAnimator
//
//  Created by vit on 08.11.2020.
//

import Foundation

enum OperatorType: CustomStringConvertible {
    case filter
    case filterDevisionWithReminder
    case filterDevisionWithoutReminder
    case map
    case flatMap
    
    var description: String {
        switch self {
        case .filter:
            return "filter { $0 > 5 }"
        case .filterDevisionWithReminder:
            return ""
        case .filterDevisionWithoutReminder:
            return ""
        case .map:
            return ""
        case .flatMap:
            return ""
        }
    }
}
