//
//  LoginViewControllerTest.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class LoginViewControllerTest: XCTestCase {
    
    var sut: LoginViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createLoginViewController()
    }
    
    func createLoginViewController() {
        sut = LoginViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUsersTappingOnSubmittButtonShouldCallInteractorToTryLogin() {
        let loginInteractorMock = LoginInteractorMock()
        sut.interactor = loginInteractorMock
        
        let username = "username"
        let password = "password"
        sut.usernameTF.text = username
        sut.passwordTF.text = password
        
        sut.submitBtnTapped(sender: UIButton())
        XCTAssertTrue(loginInteractorMock.verifyTryLoginCalled(), "Users tapping on submit button should call interactor to try login")
        XCTAssertTrue(loginInteractorMock.verifyWith(request: Login.TryLogin.Request(username: username, password: password)))
    }
    
    class LoginInteractorMock: LoginBusinessLogic {
        private var tryLoginCalled = false
        
        private var request: Login.TryLogin.Request!
        
        func tryLogin(request: Login.TryLogin.Request) {
            tryLoginCalled = true
            self.request = request
        }
        
        func verifyTryLoginCalled() -> Bool {
            return tryLoginCalled
        }
        
        func verifyWith(request: Login.TryLogin.Request) -> Bool {
            return self.request == request
        }
    }
    
}
