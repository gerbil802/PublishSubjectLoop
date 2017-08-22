//
//  ViewModel.swift
//  Testing
//
//  Created by Tal Shrestha on 02/08/2017.
//  Copyright © 2017 None. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum AppInput {
    case goToIdle
    case inputToA
    case inputToB
    case end
}

enum AppState {
    case idle
    case A
    case B
    case end
}

class ViewModel {
    
    var appInput = PublishSubject<AppInput>()
    var appState: Observable<AppState>
    
    init() {
        self.appState = self.appInput
            .debug("AppInput")
            .scan(.idle, accumulator: { previousState, input in
                switch input {
                case .goToIdle: return .idle
                case .inputToA: return .A
                case .inputToB: return .B
                case .end: return .end
                }
        })
    }
}
