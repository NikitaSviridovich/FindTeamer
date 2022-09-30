//
//  ErrorSelection.swift
//  FindTeamer
//
//  Created by Mikita Svirydovich on 18/08/2022.
//

import Foundation

public enum ErrorTitle: String {
    case nameError = "nameError"
    case emailError = "emailError"
    case shortPassword = "shortPassword"
    case longPassword = "longPassword"
    case repeatedPassword = "repeatedPassword"
}

public enum ErrorCases: Error {
    case nameError
    case emailError
    case shortPassword
    case longPassword
    case repeatedPassword
}
extension ErrorCases: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .nameError:
            return NSLocalizedString("Name is too short!", comment: "")
        case .emailError:
            return NSLocalizedString("Incorrect email!", comment: "")
        case .shortPassword:
            return NSLocalizedString("Password too short!", comment: "")
        case .longPassword:
            return NSLocalizedString("Password is too long!", comment: "")
        case .repeatedPassword:
            return NSLocalizedString("Passwords not matches", comment: "")
        }
    }
}
