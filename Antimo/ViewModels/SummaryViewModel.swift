//
//  SummaryViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI

//
//  ProfileViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import CoreData
import CoreTransferable
import PhotosUI

@MainActor
class SummaryViewModel: ObservableObject {

  // MARK: Internal

  // MARK: - Profile Details

  @AppStorage("dogName") var persistDogName = ""
  @AppStorage("gender") var persistGender = ""
  @AppStorage("breed") var persistBreed = ""
  @AppStorage("age") var persistAge = ""
  @AppStorage("weight") var persistWeight = ""
  @AppStorage("avatarID") var avatarID = ""

  @Published var dogName = ""
  @Published var gender = ""
  @Published var breed = ""
  @Published var age = ""
  @Published var weight = ""
  @Published var bod: Date = .init()

  @Published var isEditting = false
  @Published var showSnackBar = false
  @Published var isExerciseSheetPresented = false
  @Published var isWeightSheetPresented = false

  var disabledSubmit: Bool {
    dogName.isEmpty || gender.isEmpty || breed.isEmpty || weight.isEmpty
  }

  var persistBOD: Date {
    get {
      guard
        let persistBODData,
        let date = try? JSONDecoder().decode(Date.self, from: persistBODData)
      else {
        return Date()
      }
      return date
    }
    set {
      if let data = try? JSONEncoder().encode(newValue) {
        persistBODData = data
      }
    }
  }

  var renderedDogName: String {
    !persistDogName.isEmpty ? "\(persistDogName) \(persistGender)" : "-"
  }

  var renderedBOD: String {
    if persistBODData == nil {
      return "-"
    }
    return Utilities.formattedDate(from: persistBOD)
  }

  var renderedBreed: String {
    !persistBreed.isEmpty ? persistBreed : "-"
  }

  var renderedAge: String {
    if persistBODData == nil {
      return "-"
    }

    if let ageInYears = Calendar.current.dateComponents([.year], from: persistBOD, to: Date()).year {
      return ageInYears > 1 ? "\(ageInYears) years" : "\(ageInYears) year"
    }
    return "-"
  }

  var renderedWeight: String {
    let weightInKilograms = Float(persistWeight) ?? 0.0
    let formattedWeight = String(format: "%.2f KG", weightInKilograms)
    return !persistWeight.isEmpty ? formattedWeight : "-"
  }

  // MARK: - Profile Image

  func saveProfileData(viewContext: NSManagedObjectContext) {
    persistDogName = dogName
    persistGender = gender
    persistBreed = breed
    persistAge = age
    persistWeight = weight
    persistBOD = bod

    do {
      let newPetData = Pet(context: viewContext)
      newPetData.id = UUID()
      newPetData.createdAt = Date()
      newPetData.weight = Int16(weight) ?? 0
      try viewContext.save()

      resetForm()
      closeProfileForm()
      showSnackBar.toggle()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }

  func resetForm() {
    dogName = ""
    gender = ""
    breed = ""
    age = ""
    weight = ""
    bod = Date()
  }

  func openProfileForm() {
    dogName = persistDogName
    gender = persistGender
    breed = persistBreed
    age = persistAge
    weight = persistWeight
    bod = persistBOD
    isEditting = true
  }

  func closeProfileForm() {
    isEditting = false
    resetForm()
  }

  func closeWeightSheet() {
    weight = ""
    isWeightSheetPresented = false
  }

  func openWeightSheet() {
    weight = persistWeight
    isWeightSheetPresented = true
  }

  // MARK: Private

  private var persistBODData: Data? {
    get {
      UserDefaults.standard.data(forKey: "bod")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "bod")
    }
  }

}
