//
//  ImageUploader.swift
//  Antimo
//
//  Created by Roli Bernanda on 07/06/23.
//

import SwiftUI
import PhotosUI

struct ANImageUploader: View {
    @StateObject var imagePicker = ImagePicker()
    var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label).font(.inputLabel)
            
            PhotosPicker(selection: $imagePicker.imageSelection,
                         matching: .images,
                         photoLibrary: .shared()) {
                
                Group {
                    if let uiImage = imagePicker.uiImage {
                        HStack {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 150)
                                .overlay(alignment: .topTrailing) {
                                    Image(systemName: "pencil.circle.fill")
                                        .symbolRenderingMode(.multicolor)
                                        .font(.system(size: 20))
                                        .foregroundColor(.anPrimary)
                                }
                            Spacer()
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(height: 150)
                            .foregroundColor(.anPrimaryLight)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.anPrimary, lineWidth: 1)
                            )
                            .overlay(
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.anPrimary)
                                    .frame(width: 71, height: 57)
                            )
                    }
                }
            }
            .buttonStyle(.borderless)
        }
    }
}

struct ANImageUploader_Previews: PreviewProvider {
    static var previews: some View {
        ANImageUploader(label: "")
    }
}
