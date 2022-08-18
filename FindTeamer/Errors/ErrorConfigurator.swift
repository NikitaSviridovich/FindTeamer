//
//  ErrorConfigurator.swift
//  FindTeamer
//
//  Created by Mikita Svirydovich on 18/08/2022.
//

import Foundation

public enum ErrorNaming: String {
    case emailError = "emailError"
    case shortPassword = "shortPassword"
    case longPassword = "longPassword"
    case repeatedPassword = "repeatedPassword"
}

public enum ErrorConfigurator: Error {
    case emailError
    case shortPassword
    case longPassword
    case repeatedPassword
}
extension ErrorConfigurator: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emailError:
            return NSLocalizedString("Incorrect email!", comment: "")
        case .shortPassword:
            return NSLocalizedString("Password too short!", comment: "")
        case .longPassword:
            return NSLocalizedString("Password too long!", comment: "")
        case .repeatedPassword:
            return NSLocalizedString("Passwords not matches", comment: "")
        }
    }
}
