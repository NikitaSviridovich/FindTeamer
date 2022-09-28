//
//  LogInModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.09.22.
//

import Foundation

class LogInModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
}
