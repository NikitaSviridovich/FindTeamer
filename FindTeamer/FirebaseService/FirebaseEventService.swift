//
//  FirebaseEventManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import FirebaseFirestore
import Combine

final class FirebaseEventService: EventManager {
    // MARK: - Private properties
    private var firebaseDB = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    // MARK: - Initializators
    init() { }

    // MARK: - Methods
    func addEvent(event: EventModel) {
        let eventData: [String: Any?] = [
            "id" : event.id,
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
    func observeEvents() -> AnyPublisher<[EventModel], Never> {
        let subject = PassthroughSubject<[EventModel], Never>()
        listenerRegistration = firebaseDB.collection("events")
            .addSnapshotListener { (querySnapshot, _) in
                guard let documents = querySnapshot?.documents else { return }
                subject.send(documents.map { queryDocumentSnapshot -> EventModel in
                    let data = queryDocumentSnapshot.data()
                    return EventModel(id: queryDocumentSnapshot.documentID,
                                      eventType: data["eventType"] as? String ?? "",
                                      eventTitle: data["eventTitle"] as? String ?? "",
                                      eventEmail: data["eventEmail"] as? String ?? "",
                                      eventPhoneNumber: data["eventPhoneNumber"] as? String ?? "",
                                      eventAddress: data["eventAddress"] as? String ?? "",
                                      eventTime: data["eventTime"] as? Date ?? Date(),
                                      eventDescription: data["eventDesctiption"] as? String ?? "")
                })
            }
        return subject.eraseToAnyPublisher()
    }
}
