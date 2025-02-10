//
//  DetailViewModel.swift
//  GoodReactor-Sample
//
//  Created by Filip Šašala on 11/09/2024.
//

import GoodCoordinator
import GoodReactor
import Observation

@Observable final class DetailViewModel: Reactor {
    
    typealias Event = GoodReactor.Event<Action, Mutation, Destination>
    
    enum Action {
        
        case increment
        
    }
    
    enum Mutation {
        
    }
    
    @Navigable enum Destination {
        
        case detail(Int)
        
    }
    
    @Observable @MainActor final class State {
        
        //        @Bindable var value: Int
        
        //        #Scoped(scope: .parent) {
        //            var value: Int
        //        }
        //
        //        #Persistent {
        //            var text: String
        //        }
        //
        //        #Transient {
        //
        //        }
        
        private struct __Key_Shared_studentsCount: SharedStateKey {
            static var defaultValue: Int { 0 }
        }
        private let __key_shared_studentsCount = __Key_Shared_studentsCount()

        var studentsCount: Int {
            get {
                _$observationRegistrar.access(self, keyPath: \.studentsCount)
                return GlobalScope.global[__key_shared_studentsCount]
            }
            set {
                _$observationRegistrar.willSet(self, keyPath: \.studentsCount)
                GlobalScope.global[__key_shared_studentsCount] = newValue
                _$observationRegistrar.didSet(self, keyPath: \.studentsCount)
            }
        }

    }
    
    func makeInitialState() -> State {
        State()
    }
    
    func reduce(state: inout State, event: Event) {
        switch event.kind {
        case .action(.increment):
            state.studentsCount += 1
            
        default:
            break
        }
    }
    
}
