//
//  PetService.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation

class PetService {

  // MARK: Lifecycle

  init(petRepository: PetRepository) {
    self.petRepository = petRepository
  }

  // MARK: Internal

  func createNewPetData(petData: Pet) -> Pet? {
    petRepository.createNewPetData(petData: petData)
  }

  func getAllPetDatas() -> [Pet] {
    petRepository.getAllPetDatas()
  }

  // MARK: Private

  private let petRepository: PetRepository

}
