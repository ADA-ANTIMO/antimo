//
//  PetRepository.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

protocol PetRepository {
  func createNewPetData(petData: Pet) -> Pet?
  func getAllPetDatas() -> [Pet]
}
