//
//  FirebaseEventManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import FirebaseFirestore

final class FirebaseEventManager: ObservableObject {
    private var firebaseDB = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    // MARK: Publishers
    @Published var events = [EventModel]()
    // MARK: Initializator
    init() { }
    // MARK: Methods
    func addEvent(_ event: EventModel) {
        let eventData: [String: Any] = [
            "eventAddress" : event.eventAddress,
            "eventDesctiption" : event.eventDescription,
            "eventEmail" : event.eventEmail,
            "eventPhoneNumber" : event.eventPhoneNumber,
            "eventTime" : event.eventTime,
            "eventTitle" : event.eventTitle,
            "eventType" : event.eventType
        ]
        _ = firebaseDB.collection("events").addDocument(data: eventData)
    }
    func getEvents(events: [EventModel]) {
        if listenerRegistration == nil && events.isEmpty {
            listenerRegistration = firebaseDB.collection("events")
                .addSnapshotListener {(querySnapshot, _) in
                    guard let documents = querySnapshot?.documents else { return }
                    self.events = documents.map { queryDocumentSnapshot -> EventModel in
                        let data = queryDocumentSnapshot.data()
                        return EventModel(eventType: data["eventType"] as? String ?? "",
                                          eventTitle: data["eventTitle"] as? String ?? "",
                                          eventEmail: data["eventEmail"] as? String ?? "",
                                          eventPhoneNumber: data["eventPhoneNumber"] as? String ?? "",
                                          eventAddress: data["eventAddress"] as? String ?? "",
                                          eventTime: data["eventTime"] as? Date ?? Date(),
                                          eventDescription: data["eventDesctiption"] as? String ?? "")
                    }
                }
        }
    }
}
