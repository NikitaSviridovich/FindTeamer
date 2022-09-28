//
//  EventsViewModel.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 1.09.22.
//

import Foundation
import Combine
import FirebaseFirestore

class EventsViewModel: ObservableObject {
    @Published var events = [EventModel]()
    private var firebaseDB = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    func initialLoadData() {
        do {
            if listenerRegistration == nil && events.isEmpty {
              listenerRegistration = firebaseDB.collection("events")
                    .addSnapshotListener {(querySnapshot, _) in
                guard let documents = querySnapshot?.documents else { return }
                self.events = documents.compactMap { queryDocumentSnapshot in
                  try? queryDocumentSnapshot.data(as: EventModel.self)
                }
              }
            }
        }
    }
    func reloadData() async throws -> [EventModel] {
        do {
            let snapshot = try await firebaseDB.collection("events").getDocuments()
            return snapshot.documents.compactMap { queryDocumentSnapshot in
                try? queryDocumentSnapshot.data(as: EventModel.self)
            }
        }
    }
}
