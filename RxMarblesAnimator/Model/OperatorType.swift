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
            return "map { $0 * 2 }"
        case .flatMap:
            return ""
        }
    }
}

class Operator: ObservableObject {
    var operatorType: OperatorType
    @Published var isSelected: Bool = false
    
    init(withOperatorType operatorType: OperatorType) {
        self.operatorType = operatorType
    }
}

extension Operator: Hashable {
    static func == (lhs: Operator, rhs: Operator) -> Bool {
        return lhs.operatorType == rhs.operatorType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.operatorType)
    }
}

