//
//  AlertModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import Foundation

enum ActiveAlert {
    case first, second
}

class AlertModel {
    var title: String = ""
    var message: String = ""
    var buttonNaming: String
    init() {
        self.buttonNaming = "Got It!"
    }
}
