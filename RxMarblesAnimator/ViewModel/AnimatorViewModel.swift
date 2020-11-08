//
//  AnimatorViewModel.swift
//  RxMarblesAnimator
//
//  Created by vit on 08.11.2020.
//

import Foundation
import Combine

class AnimatorViewModel: ObservableObject {
    
    @Published var operatorType: OperatorType = .map
    @Published var outputMarbles = [MarbleModel]()
    
    private var subscriptions = Set<AnyCancellable>()
    let inputMarbles = [(12, 20), (44, 80), (37, 130), (5, 220)].map { MarbleModel(title: $0, xOffset: $1) }

    init() {
        $operatorType
            .sink(receiveValue: {
                self.outputMarbles = self.performOperator(operatorType: $0)
            })
            .store(in: &subscriptions)
    }
    
    private func performOperator(operatorType: OperatorType) -> [MarbleModel] {
        switch operatorType {
        case .filter:
            return inputMarbles.filter { $0.title > 5 }
        case .map:
            return inputMarbles.map { MarbleModel(title: $0.title * 2, xOffset: $0.xOffset) }
        default:
            return []
        }
    }
}
