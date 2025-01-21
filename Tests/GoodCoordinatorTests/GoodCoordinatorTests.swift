//
//  GoodCoordinatorTests.swift
//  GoodReactor
//
//  Created by Matúš Mištrik on 20/01/2025.
//

import XCTest

final class GoodCoordinatorTests: XCTestCase {

    @MainActor func testCoordinatorTypeCasting() {
        let firstCoordinator = CoordinatorA()
        let secondCoordinator = CoordinatorB(parentCoordinator: firstCoordinator)

        let secondCoordinatorParentAsBaseOfRandom = secondCoordinator.parentCoordinator as? BaseCoordinator<CustomStep>
        let secondCoordinatorParentAsBaseOfFirst = secondCoordinator.parentCoordinator as? BaseCoordinator<AppStep>
        let secondCoordinatorParentAsFirst = secondCoordinator.parentCoordinator as? CoordinatorA

        XCTAssertNil(firstCoordinator.parentCoordinator)
        XCTAssertNil(secondCoordinatorParentAsBaseOfRandom)

        XCTAssertNotNil(secondCoordinatorParentAsBaseOfFirst)
        XCTAssertNotNil(secondCoordinatorParentAsFirst)
    }

    @MainActor func testCoordinatorSearchBasedOnType() {
        let firstCoordinator = CoordinatorA()
        let secondCoordinator = CoordinatorB(parentCoordinator: firstCoordinator)
        let thirdCoordinator = CoordinatorA(parentCoordinator: secondCoordinator)
        let fourthCoordinator  = CoordinatorC(parentCoordinator: thirdCoordinator)

        let firstCoordinatorOfTypeA = fourthCoordinator.firstCoordinatorOfType(type: CoordinatorA.self)
        XCTAssertNotNil(firstCoordinatorOfTypeA)
        XCTAssertNotNil(firstCoordinatorOfTypeA?.parentCoordinator)

        let lastCoordinatorOfTypeA = fourthCoordinator.lastCoordinatorOfType(type: CoordinatorA.self)
        XCTAssertNotNil(lastCoordinatorOfTypeA)
        XCTAssertNil(lastCoordinatorOfTypeA?.parentCoordinator)
    }

    @MainActor func testCoordinatorSearchBasedOnItsChildren() {
        let firstCoordinator = CoordinatorA()
        let secondCoordinator = CoordinatorC(parentCoordinator: firstCoordinator)
        secondCoordinator.id = 1
        let thirdCoordinator = CoordinatorB(parentCoordinator: firstCoordinator)
        let fourthCoordinator  = CoordinatorC(parentCoordinator: firstCoordinator)
        fourthCoordinator.id = 2
        let fifthCoordinator = CoordinatorB(parentCoordinator: firstCoordinator)

        let lastCoordinatorOfTypeC = firstCoordinator.lastChildOfType(type: CoordinatorC.self)
        XCTAssertNotNil(lastCoordinatorOfTypeC)
        XCTAssertTrue(lastCoordinatorOfTypeC?.id == 2)

        let lastChild = firstCoordinator.lastChild()
        XCTAssertNotNil(lastChild)

        let lastChildCastedToTypeB = lastChild as? CoordinatorB
        XCTAssertNotNil(lastChildCastedToTypeB)

        let lastChildCastedToTypeC = lastChild as? CoordinatorC
        XCTAssertNil(lastChildCastedToTypeC)

        firstCoordinator.resetChildReferences()
    }

}
