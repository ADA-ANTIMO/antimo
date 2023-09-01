//
//  Pet.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

struct Pet: Identifiable {
  var id: UUID = .init()
  var weight: Int
  var updatedAt: Date = .init()
  var createdAt: Date = .init()
}
