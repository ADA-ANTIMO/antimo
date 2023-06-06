//
//  ProfileViewModel.swift
//  Antimo
//
//  Created by Roli Bernanda on 29/05/23.
//

import SwiftUI
import PhotosUI
import CoreTransferable

@MainActor
class ProfileModel: ObservableObject {
    // MARK: - Profile Details
    
    @AppStorage("dogName") var persistDogName: String = ""
    @AppStorage("gender") var persistGender: String = ""
    @AppStorage("breed") var persistBreed: String = ""
    @AppStorage("age") var persistAge: String = ""
    @AppStorage("weight") var persistWeight: String = ""
    @AppStorage("avatarID") var avatarID = ""
    
    @Published var dogName: String = ""
    @Published var gender: String = ""
    @Published var breed: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var bod: Date = Date()
    
    @Published var isEditting: Bool = false
    @Published var showSnackBar: Bool = false
    
    private var persistBODData: Data? {
        get {
            UserDefaults.standard.data(forKey: "bod")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "bod")
        }
    }
    
    var persistBOD: Date {
        get {
            guard let persistBODData = persistBODData,
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
        return !persistDogName.isEmpty ? "\(persistDogName) \(persistGender)" : "-"
    }
    
    var renderedBOD: String {
        if persistBODData == nil {
                return "-"
        }
        return Utilities.formattedDate(from: persistBOD)
    }
    
    var renderedBreed: String {
        return !persistBreed.isEmpty ? persistBreed : "-"
    }
    
    var renderedAge: String {
        if persistBODData == nil {
            return "-"
        }
        
        if let ageInYears = Calendar.current.dateComponents([.year], from: persistBOD, to: Date()).year {
            return "\(ageInYears) years"
        }
        return "-"
    }
    
    var renderedWeight: String {
        let weightInKilograms = Float(persistWeight) ?? 0.0
        let formattedWeight = String(format: "%.2f KG", weightInKilograms)
        return !persistWeight.isEmpty ? formattedWeight : "-"
    }
    
    // MARK: - Profile Image
    
    func saveProfileData() {
        persistDogName = dogName
        persistGender = gender
        persistBreed = breed
        persistAge = age
        persistWeight = weight
        persistBOD = bod
        resetForm()
        closeProfileForm()
        showSnackBar.toggle()
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
        breed =  persistBreed
        age = persistAge
        weight = persistWeight
        bod = persistBOD
        isEditting = true
    }
    
    func closeProfileForm() {
        isEditting = false
        resetForm()
    }
}


