//
//  EventDetailsViewModel.swift
//  FindTeamer
//
//  Created by Mikita Svirydovich on 05/10/2022.
//

import SwiftUI

final class EventDetailsViewModel {
    // MARK: - Initializators
    init() { }
    
    // MARK: - Methods
    func openURLLink(url: String) {
        UIApplication.shared.open(NSURL(string: url)! as URL)
    }
    func copyEmail(email: String) {
        UIPasteboard.general.string = email
    }
}
