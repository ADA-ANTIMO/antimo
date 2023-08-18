//
//  PetService.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 18/08/23.
//

import Foundation

class PetService {
  private let petRepository: PetRepository

  init(petRepository: PetRepository) {
    self.petRepository = petRepository
  }

  func createNewPetData(petData: Pet) -> Pet? {
    petRepository.createNewPetData(petData: petData)
  }

  func getAllPetDatas() -> [Pet] {
    petRepository.getAllPetDatas()
  }
}
