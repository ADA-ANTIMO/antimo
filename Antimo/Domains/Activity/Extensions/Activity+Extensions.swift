//
//  Activity+Extensions.swift
//  Antimo
//
//  Created by Bisma Mahendra I Dewa Gede on 18/08/23.
//

import Foundation
import SwiftUI

extension Activity {
  var uiImage: UIImage {
    if
      !image.isEmpty,
      let image = FileManager().retrieveImage(with: image)
    {
      return image
    } else {
      return UIImage(systemName: "photo")!
    }
  }
}
