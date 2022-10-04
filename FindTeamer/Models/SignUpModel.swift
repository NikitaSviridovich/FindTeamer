//
//  SignUpModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 16.08.22.
//

import Combine

class SignUpModel {
    @Published var userName = ""
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var userRepeatPassword = ""
}
