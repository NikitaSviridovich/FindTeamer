//
//  EventViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 28.08.22.
//

import Foundation
import Combine
import FirebaseFirestore

class EventViewModel: ObservableObject {
    @Published var event: EventModel
    @Published var modified = false
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    
    
    let firebaseManager: FirebaseManager
    
    init(event: EventModel = EventModel()) {
        self.event = event
        firebaseManager = FirebaseManager()
    }
    
    private func addEvent(_ event: EventModel) {
        firebaseManager.addEvent(event)
    }
    func handleDoneTapped() {
        self.addEvent(event)
    }
}
