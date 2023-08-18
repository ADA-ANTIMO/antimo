//
//  PetCoreDataAdapter.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 18/08/23.
//

import Foundation
import CoreData

class PetCoreDataAdapter: PetRepository {
  private let coreDataContext = CoreDataConnection.shared.context

  func normalizePetEntity(pet: NSPet) -> Pet {
    Pet(
      id: pet.id ?? UUID(),
      weight: pet.weight.toInt,
      updatedAt: pet.updatedAt ?? Date(),
      createdAt: pet.createdAt ?? Date()
    )
  }

  func createNewPetData(petData: Pet) -> Pet? {
    let newPetData = NSPet(context: coreDataContext)
    newPetData.id = petData.id
    newPetData.weight = petData.weight.toInt16
    newPetData.createdAt = petData.createdAt
    newPetData.updatedAt = petData.updatedAt

    do {
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

    let request: NSFetchRequest<NSPet> = NSPet.fetchRequest()
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
}
