//
//  FirebaseEventManager.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 22.08.22.
//

import FirebaseFirestore

final class FirebaseEventService: EventManager {
    
    // MARK: - Public properties
    @Published var events = [EventModel]()
    var eventsPublisher: Published<[EventModel]>.Publisher { $events }
    
    // MARK: - Private properties
    private var firebaseDB = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    // MARK: - Initializators
    init() { }
    
    // MARK: - Methods
    func addEvent(event: EventModel) {
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
    func addEventsListener() {
        guard listenerRegistration == nil && events.isEmpty else { return }
        listenerRegistration = firebaseDB.collection("events")
            .addSnapshotListener { [weak self] (querySnapshot, _) in
                guard let documents = querySnapshot?.documents, let strongSelf = self else { return }
                strongSelf.events = documents.map {queryDocumentSnapshot -> EventModel in
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
