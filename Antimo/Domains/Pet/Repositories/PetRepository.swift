//
//  PetRepository.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 18/08/23.
//

import Foundation

protocol PetRepository {
  func createNewPetData(petData: Pet) -> Pet?
  func getAllPetDatas() -> [Pet]
}
