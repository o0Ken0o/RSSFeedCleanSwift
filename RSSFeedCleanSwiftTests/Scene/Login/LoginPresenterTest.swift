//
//  LoginPresenterTest.swift
//  RSSFeedCleanSwiftTests
//
//  Created by Ken Siu on 9/2/2018.
//  Copyright © 2018 Ken Siu. All rights reserved.
//

import XCTest
@testable import RSSFeedCleanSwift

class LoginPresenterTest: XCTestCase {
    
    var sut: LoginPresenter!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        createLoginPresenter()
    }
    
    func createLoginPresenter() {
        sut = LoginPresenter()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPresentLoginShouldCallLoginViewControllerToDisplayLogin() {
        let loginDisplayLogicMock = LoginDisplayLogicMock()
        sut.viewController = loginDisplayLogicMock
        
        let isSuccessful = true
        let errorMsg = "This is a sample error msg"
        let response = Login.TryLogin.Response(isSuccessful: isSuccessful, errorMsg: errorMsg)
        
        sut.presentLoginResponse(response: response)
        
        XCTAssertTrue(loginDisplayLogicMock.verifyDisplayLoginCalled(), "PresentLogin should call login view controller to display login result")
        XCTAssertTrue(loginDisplayLogicMock.verifyResponseFormattedAs(viewModel: Login.TryLogin.ViewModel(isSuccessful: isSuccessful, errorMsg: errorMsg)))
    }
    
    class LoginDisplayLogicMock: LoginDisplayLogic {
        private var displayLoginCalled = false
        
        private var loginTryLoginViewModel: Login.TryLogin.ViewModel!
        
        func displayLogin(viewModel: Login.TryLogin.ViewModel) {
            displayLoginCalled = true
            loginTryLoginViewModel = viewModel
        }
        
        func verifyDisplayLoginCalled() -> Bool {
            return displayLoginCalled
        }
        
        func verifyResponseFormattedAs(viewModel: Login.TryLogin.ViewModel) -> Bool {
            return loginTryLoginViewModel == viewModel
        }
    }
    
}
