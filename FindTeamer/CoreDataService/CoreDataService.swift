//
//  CoreDataService.swift
//  FindTeamer
//
//  Created by Nikita Sviridovich on 6.10.22.
//

import SwiftUI
import CoreData
import Combine

final class CoreDataService: EventManager {
    // MARK: - Private properties

    private var context: NSManagedObjectContext!

    // MARK: - Initializators

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    // MARK: - Internal methods

    func observeEvents() -> AnyPublisher<[EventModel], Never> {
        let subject = CurrentValueSubject<[EventModel], Never>([EventModel]())
        subject.send(getEvents())
        return subject.eraseToAnyPublisher()
    }
    func addEvent(event eventModel: EventModel) {
        guard let context = self.context else { return }
        let event = Event(context: context)
        event.id = eventModel.id
        event.eventTitle = eventModel.eventTitle
        event.eventType = eventModel.eventType
        event.eventPhoneNumber = eventModel.eventPhoneNumber
        event.eventTime = eventModel.eventTime
        event.eventAddress = eventModel.eventAddress
        event.eventEmail = eventModel.eventEmail
        event.eventDescription = eventModel.eventDescription
        saveContext()
    }

    func save(events: [EventModel]) {
        debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        for event in events where getEventById(id: event.id ?? "") == nil {
            addEvent(event: event)
        }
    }

    // MARK: - Private methods

    private func getEvents() -> [EventModel] {
        let fetchRequest = NSFetchRequest<Event>(entityName: Event.entity().name!)
        do {
            let events = try context.fetch(fetchRequest)
            return events.map {
                EventModel(id: $0.id ?? "", eventType: $0.eventType ?? "", eventTitle: $0.eventTitle ?? "",
                           eventEmail: $0.eventEmail ?? "", eventPhoneNumber: $0.eventPhoneNumber ?? "",
                           eventAddress: $0.eventAddress ?? "", eventTime: $0.eventTime ?? Date(),
                           eventDescription: $0.eventDescription ?? "")
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return [EventModel]()
        }
    }

    private func getEventById(id: String) -> EventModel? {
        let fetchRequest = NSFetchRequest<Event>(entityName: Event.entity().name!)
        fetchRequest.predicate = NSPredicate(format: "id == %@ ", id)
        do {
            let event = try context.fetch(fetchRequest).first
            guard let event = event else { return nil }
            return EventModel(id: event.id ?? "", eventType: event.eventType ?? "", eventTitle: event.eventTitle ?? "",
                              eventEmail: event.eventEmail ?? "", eventPhoneNumber: event.eventPhoneNumber ?? "",
                              eventAddress: event.eventAddress ?? "", eventTime: event.eventTime ?? Date(),
                              eventDescription: event.eventDescription ?? "")

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
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
}
