//
//  PetCoreDataAdapter.swift
//  Antimo
//
//  Created by Roli Bernanda on 22/08/23.
//

import Foundation
import CoreData

class PetCoreDataAdapter: PetRepository {

  // MARK: Internal

  func normalizePetEntity(pet: PetMO) -> Pet {
    Pet(
      id: pet.id ?? UUID(),
      weight: pet.weight.toInt,
      updatedAt: pet.updatedAt ?? Date(),
      createdAt: pet.createdAt ?? Date())
  }

  func createNewPetData(petData: Pet) -> Pet? {
    let newPetData = PetMO(context: coreDataContext)
    newPetData.id = petData.id
    newPetData.weight = petData.weight.toInt16
    newPetData.createdAt = petData.createdAt
    newPetData.updatedAt = petData.updatedAt

    do {
      print(normalizePetEntity(pet: newPetData))
      print("here, before")
      try coreDataContext.save()

      return normalizePetEntity(pet: newPetData)
    } catch {
      print("Failed creating new pet data")
      print("Error: \(error.localizedDescription)")

      return nil
    }
  }

  func getAllPetDatas() -> [Pet] {
    var petDatas: [Pet] = []

    let request: NSFetchRequest<PetMO> = PetMO.fetchRequest()
    request.sortDescriptors = [
      NSSortDescriptor(key: "createdAt", ascending: false),
    ]

    do {
      let NSPetDatas = try coreDataContext.fetch(request)

      for NSPet in NSPetDatas {
        let petData = normalizePetEntity(pet: NSPet)

        petDatas.append(petData)
      }

      return petDatas
    } catch {
      print("Failed getting pet datas")
      print("Error: \(error.localizedDescription)")

      return []
    }
  }

  // MARK: Private

  private let coreDataContext = PersistenceController.shared.context

}
