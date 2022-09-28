//
//  SignUpModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import Foundation
import Combine

class SignUpModel : ObservableObject {
    // MARK: Publishers
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var userRepeatPassword = ""
}
