////
////  ProfileCardView.swift
////  Antimo
////
////  Created by Roli Bernanda on 05/06/23.
////
//
import SwiftUI
import PhotosUI

struct EditableCircularProfileImage: View {
    @ObservedObject var viewModel: ProfileModel
    @StateObject var imagePicker = ImagePicker()
    
    var uiImage: UIImage {
        if !viewModel.avatarID.isEmpty,
           let image = FileManager().retrieveImage(with: viewModel.avatarID) {
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
        .frame(width: 80, height: 80)
        .background {
            Circle().fill(
                LinearGradient(
                    colors: [.yellow, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .overlay(alignment: .bottomTrailing) {
            PhotosPicker(selection: $imagePicker.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
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
