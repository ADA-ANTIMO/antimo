//
//  UINavigationController+Gesture.swift
//  Antimo
//
//  Created by Roli Bernanda on 08/06/23.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {

  // MARK: Open

  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  // MARK: Public

  public func gestureRecognizerShouldBegin(_: UIGestureRecognizer) -> Bool {
    viewControllers.count > 1
  }

  // To make it works also with ScrollView
  public func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith _: UIGestureRecognizer) -> Bool {
    true
  }
}
