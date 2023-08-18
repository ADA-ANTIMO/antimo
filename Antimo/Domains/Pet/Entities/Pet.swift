//
//  Pet.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

struct Pet: Identifiable {
  var id: UUID = .init()
  var weight: Int
  var updatedAt: Date = .init()
  var createdAt: Date = .init()
}
