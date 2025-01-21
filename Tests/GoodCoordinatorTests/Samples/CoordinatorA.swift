//
//  CoordinatorA.swift
//  GoodReactor
//
//  Created by Matúš Mištrik on 20/01/2025.
//

import UIKit

enum CustomStep { }

class CoordinatorA: BaseCoordinator<AppStep> {

    override func start() -> UIViewController {
        super.start()

        let controller = UIViewController()

        if rootViewController == nil {
            rootViewController = controller
        }

        return controller
    }

    override func navigate(to stepper: AppStep) -> StepAction {
        return .none
    }

}
