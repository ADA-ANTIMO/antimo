//
//  Activity+Extensions.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 15/08/23.
//

import Foundation

extension NSActivity {
  var imagePath: String {
    image ?? ""
  }

  var uiImage: UIImage {
    if
      !imagePath.isEmpty,
      let image = FileManager().retrieveImage(with: imagePath)
    {
      return image
    } else {
      return UIImage(systemName: "photo")!
    }
  }
}
