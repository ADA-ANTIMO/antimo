//
//  ImagePickerManager.swift
//  Antimo
//
//  Created by Roli Bernanda on 04/06/23.
//

import PhotosUI
import SwiftUI

@MainActor
class ImagePicker: ObservableObject {
  @Published var image: Image?
  @Published var uiImage: UIImage?

  @Published var imageSelection: PhotosPickerItem? {
    didSet {
      Task {
        try await loadTransferable(from: imageSelection)
      }
    }
  }

  func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
    do {
      if let data = try await imageSelection?.loadTransferable(type: Data.self) {
        if let uiImage = UIImage(data: data) {
          self.uiImage = uiImage
          image = Image(uiImage: uiImage)
        }
      }
    } catch {
      print(error.localizedDescription)
    }
  }
}
