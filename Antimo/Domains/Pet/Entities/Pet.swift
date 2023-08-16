//
//  Pet.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

struct Pet {
  var id: UUID = UUID()
  var weight: Int
  var updatedAt: Date = Date()
  var createdAt: Date = Date()
}
