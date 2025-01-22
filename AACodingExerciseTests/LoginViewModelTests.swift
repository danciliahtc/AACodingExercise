//
//  LoginViewModelTests.swift
//  AACodingExerciseTests
//
//  Created by Dancilia Harmon   on 1/16/25.
//

import XCTest

@testable import AACodingExercise
final class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    override func setUp() {
        loginViewModel = LoginViewModel()
    }
    
    override func tearDown() {
        loginViewModel = nil
    }
    
    func testLoginSuccess() {
        // GIVEN
        let userName = "Abc"
        let passWord = "1234"
        // WHEN
        let actualOutput = loginViewModel.validateCredentials(userName: userName, passWord: passWord)
        // THEN
        let expectedOutput = LoginResult.success
        
        XCTAssert(actualOutput == expectedOutput)
    }
    
    func testLoginFailureWhenEmptyUserNameEmptyPassWord() {
        // GIVEN
        let userName = ""
        let passWord = ""
        // WHEN
        let actualOutput = loginViewModel.validateCredentials(userName: userName, passWord: passWord)
        // THEN
        let expectedOutput = LoginResult.failure("Username and password are required")
        
        XCTAssert(actualOutput == expectedOutput)
    }
    
    func testLoginFailureWhenNilUserNameNilPassWord() {
        // GIVEN
        let userName: String? = nil
        let passWord: String? = nil
        // WHEN
        let actualOutput = loginViewModel.validateCredentials(userName: userName, passWord: passWord)
        // THEN
        let expectedOutput = LoginResult.failure("Username and password are required")
        
        XCTAssert(actualOutput == expectedOutput)
    }
    
    func testLoginWrongUserName() {
        // GIVEN
        let userName = "asdfgk"
        let passWord = "1234"
        // WHEN
        let actualOutput = loginViewModel.validateCredentials(userName: userName, passWord: passWord)
        // THEN
        let expectedOutput = LoginResult.failure("Username is invalid")
        
        XCTAssert(actualOutput == expectedOutput)
    }
    
    func testLoginCorrectUserNameWrongPassword() {
        // GIVEN
        let userName = "Abc"
        let passWord = "asdfdg"
        // WHEN
        let actualOutput = loginViewModel.validateCredentials(userName: userName, passWord: passWord)
        // THEN
        let expectedOutput = LoginResult.failure("Password is invalid")
        
        XCTAssert(actualOutput == expectedOutput)
    }
}
