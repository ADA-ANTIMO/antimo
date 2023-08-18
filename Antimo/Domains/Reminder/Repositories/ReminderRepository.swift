//
//  ReminderRepository.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 16/08/23.
//

import Foundation

protocol ReminderRepository {
  // MARK: Event

  func createNewEvent(newEvent: Event) -> Event?
  func getAllEvents() -> [Event]
  func getEventById(id: UUID) -> Event?
  func updateEventById(id: UUID, newEvent: Event) -> Event?
  func updateEventIsActiveStatus(id: UUID, newStatus: Bool) -> Event?
  func deleteEventById(id: UUID) -> Event?

  // MARK: Routine

  func createNewRoutine(newRoutine: Routine) -> Routine?
  func getAllRoutines() -> [Routine]
  func getRoutineById(id: UUID) -> Routine?
  func updateRoutineById(id: UUID, newRoutine: Routine) -> Routine?
  func updateRoutineIsActiveStatus(id: UUID, newStatus: Bool) -> Routine?
  func deleteRoutineById(id: UUID) -> Routine?
}
