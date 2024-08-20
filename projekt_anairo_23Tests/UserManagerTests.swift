//
//  UserManagerTests.swift
//  projekt_anairo_23
//
//  Created by Jakub Iwaszek on 13/08/2024.
//

import XCTest
@testable import projekt_anairo_23

final class UserManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetupUser() {
        let testUser = User(id: "1", email: "test@test.com", nickname: "test")
        UserManager.shared.setupUser(with: testUser)
        XCTAssert(UserManager.shared.currentUser != nil)
        XCTAssert(UserManager.shared.currentUser?.nickname == "test")
        XCTAssert(UserManager.shared.currentUser?.id == "1")
        XCTAssert(UserManager.shared.currentUser?.email == "test@test.com")
    }
    
    func testUserSession() {
        let testUser = User(id: "1", email: "test@test.com", nickname: "test")
        UserManager.shared.saveUserSession(currentUser: testUser)
        let sessionUser = UserManager.shared.getUserSession()
        XCTAssert(sessionUser?.id == "1")
        XCTAssert(sessionUser?.email == "test@test.com")
        XCTAssert(sessionUser?.nickname == "test")
        UserManager.shared.removeUserSession()
        XCTAssert(UserManager.shared.getUserSession() == nil)
    }
}
