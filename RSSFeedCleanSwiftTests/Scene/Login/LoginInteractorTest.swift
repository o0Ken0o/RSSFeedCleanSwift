//
//  LoginInteractorTest.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class LoginInteractorTest: XCTestCase {
    
    var sut: LoginInteractor!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        setupLoginInteractor()
    }
    
    func setupLoginInteractor() {
        sut = LoginInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTrySigninShouldCallPresenterPresentLoginResponse() {
        let loginPresentationLogicSpy = LoginPresentationLogicSpy()
        sut.presenter = loginPresentationLogicSpy
        sut.accountService = AccountServiceStub()
        
        sut.tryLogin(request: Login.TryLogin.Request(username: nil, password: nil))
        XCTAssert(loginPresentationLogicSpy.presentLoginResponseCalled)
    }
    
    class LoginPresentationLogicSpy: LoginPresentationLogic {
        var presentLoginResponseCalled = false
        
        func presentLoginResponse(response: Login.TryLogin.Response) {
            presentLoginResponseCalled = true
        }
    }
    
    class AccountServiceStub: AccountServiceProtocol {
        func trying2LoginIn(username: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
            completion(true, nil)
        }
    }
}
