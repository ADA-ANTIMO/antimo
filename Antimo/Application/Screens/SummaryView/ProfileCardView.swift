////
////  ProfileCardView.swift
////  Antimo
////
////  Created by Roli Bernanda on 05/06/23.
////
//
import PhotosUI
import SwiftUI

// MARK: - CircularProfileImage

struct CircularProfileImage: View {

  // MARK: Internal

  var uiImage: UIImage {
    if
      !viewModel.avatarID.isEmpty,
      let image = FileManager().retrieveImage(with: viewModel.avatarID)
    {
      return image
    } else {
      return UIImage(systemName: "exclamationmark.triangle.fill")!
    }
  }

  var body: some View {
    Group {
      if !viewModel.avatarID.isEmpty {
        Image(uiImage: uiImage)
          .resizable()
      } else {
        Image(uiImage: uiImage)
          .font(.system(size: 20))
          .foregroundColor(.white)
      }
    }
    .scaledToFill()
    .clipShape(Circle())
    .frame(width: 40, height: 40)
    .background {
      Circle().fill(
        LinearGradient(
          colors: [.yellow, .orange],
          startPoint: .top,
          endPoint: .bottom))
    }
  }

  // MARK: Private

  @EnvironmentObject private var viewModel: SummaryViewModel

}

// MARK: - EditableCircularProfileImage

struct EditableCircularProfileImage: View {
  @EnvironmentObject private var viewModel: SummaryViewModel
  @StateObject private var imagePicker = ImagePicker()

  let width: CGFloat
  let height: CGFloat

  var uiImage: UIImage {
    if
      !viewModel.avatarID.isEmpty,
      let image = FileManager().retrieveImage(with: viewModel.avatarID)
    {
      return image
    } else {
      return UIImage(systemName: "exclamationmark.triangle.fill")!
    }
  }

  var body: some View {
    Group {
      if !viewModel.avatarID.isEmpty {
        Image(uiImage: uiImage)
          .resizable()
      } else {
        Image(uiImage: uiImage)
          .font(.system(size: 20))
          .foregroundColor(.white)
      }
    }
    .scaledToFill()
    .clipShape(Circle())
    .frame(width: width, height: height)
    .background {
      Circle().fill(
        LinearGradient(
          colors: [.yellow, .orange],
          startPoint: .top,
          endPoint: .bottom))
    }
    .overlay(alignment: .bottomTrailing) {
      PhotosPicker(
        selection: $imagePicker.imageSelection,
        matching: .images,
        photoLibrary: .shared())
      {
        Image(systemName: "pencil.circle.fill")
          .symbolRenderingMode(.multicolor)
          .font(.system(size: 30))
          .foregroundColor(.accentColor)
      }
      .buttonStyle(.borderless)
    }
    .onChange(of: imagePicker.uiImage) { newImage in
      if let newImage {
        let id = UUID().uuidString
        FileManager().saveImage(with: id, image: newImage)

        let currentAvatarId = viewModel.avatarID
        viewModel.avatarID = id

        FileManager().deleteImage(with: currentAvatarId)
      }
    }
  }
}
