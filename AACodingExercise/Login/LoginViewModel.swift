//
//  LoginViewModel.swift
//  AACodingExercise
//
//  Created by Dancilia Harmon   on 1/16/25.
//

import Foundation

enum LoginResult {
    case success
    case failure(String)
} // refer to time 48:43

struct LoginViewModel {
    let expectedUsername = "Abc"
    let expectedPassword = "1234"
    
    func validateCredentials(userName: String?, passWord: String?) -> LoginResult {
        guard let username = userName, !username.isEmpty, let passWord = passWord, !passWord.isEmpty else {
            return .failure("Username and password are required")
        }
        guard expectedUsername == username else {
            return .failure("Username is invalid")
        }
        guard expectedPassword == passWord else {
            return .failure("Password is invalid")
        }
        return .success
    }
}

extension LoginResult: Equatable {
    static func == (lhs: LoginResult, rhs: LoginResult) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success):
            return true
        case (.failure(let message1), .failure(let message2)):
            return message1 == message2
        default:
            return false
        }
    }
}
