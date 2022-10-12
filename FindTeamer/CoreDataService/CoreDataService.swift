//
//  CoreDataService.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 6.10.22.
//

import SwiftUI
import CoreData
import Combine

final class CoreDataService : EventManager {
    // MARK: - Private properties
    private var context: NSManagedObjectContext!

    // MARK: - Initializators
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    // MARK: - Methods
    func observeEvents() -> AnyPublisher<[EventModel], Never> {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        let subject = CurrentValueSubject<[EventModel], Never>([EventModel]())
        subject.send(getEvents())
        return subject.eraseToAnyPublisher()
    }
    func addEvent(event eventModel: EventModel) {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        guard let context = self.context else { return }
        let event = Event(context: context)
        event.eventTitle = eventModel.eventTitle
        event.eventType = eventModel.eventType
        event.eventPhoneNumber = eventModel.eventPhoneNumber
        event.eventTime = eventModel.eventTime
        event.eventAddress = eventModel.eventAddress
        event.eventEmail = eventModel.eventEmail
        event.eventDescription = eventModel.eventDescription
        saveContext()
    }

    private func getEvents() -> [EventModel] {
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        do {
            let events = try context.fetch(fetchRequest)
            return events.map {
                EventModel(eventType: $0.eventType ?? "", eventTitle: $0.eventTitle ?? "",
                           eventEmail: $0.eventEmail ?? "", eventPhoneNumber: $0.eventPhoneNumber ?? "",
                           eventAddress: $0.eventAddress ?? "", eventTime: $0.eventTime ?? Date(),
                           eventDescription: $0.eventDescription ?? "")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [EventModel]()
        }
    }
    private func saveContext() {
        guard let context = self.context else { return }
        do {
            try context.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }

    func storeEventsInCoreData(fromFirebase events: [EventModel]) {
        if getEvents().count < events.count {
            let countDifference = events.count - getEvents().count
            for index in stride(from: events.count, to: events.count - countDifference, by: -1) {
                addEvent(event: events[index - 1])
            }
        }
    }
}
