//
//  ReminderService.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 17/08/23.
//

import Foundation

class ReminderService {
  private let reminderRepository: ReminderRepository

  init(reminderRepository: ReminderRepository) {
    self.reminderRepository = reminderRepository
  }

  // MARK: Event
  func createNewEvent(newEvent: Event) -> Event? {
    reminderRepository.createNewEvent(newEvent: newEvent)
  }

  func getAllEvents() -> [Event] {
    reminderRepository.getAllEvents()
  }

  func getEventById(id: UUID) -> Event? {
    reminderRepository.getEventById(id: id)
  }

  func updateEventById(id: UUID, newEvent: Event) -> Event? {
    reminderRepository.updateEventById(id: id, newEvent: newEvent)
  }

  func updateEventIsActiveStatus(id: UUID, newStatus: Bool) -> Event? {
    reminderRepository.updateEventIsActiveStatus(id: id, newStatus: newStatus)
  }

  func deleteEventById(id: UUID) -> Event? {
    reminderRepository.deleteEventById(id: id)
  }

  // MARK: Routine
  func createNewRoutine(newRoutine: Routine) -> Routine? {
    reminderRepository.createNewRoutine(newRoutine: newRoutine)
  }

  func getAllRoutines() -> [Routine] {
    reminderRepository.getAllRoutines()
  }

  func getRoutineById(id: UUID) -> Routine? {
    reminderRepository.getRoutineById(id: id)
  }

  func updateRoutineById(id: UUID, newRoutine: Routine) -> Routine? {
    reminderRepository.updateRoutineById(id: id, newRoutine: newRoutine)
  }

  func updateRoutineIsActiveStatus(id: UUID, newStatus: Bool) -> Routine? {
    reminderRepository.updateRoutineIsActiveStatus(id: id, newStatus: newStatus)
  }

  func deleteRoutineById(id: UUID) -> Routine? {
    reminderRepository.deleteRoutineById(id: id)
  }
}
