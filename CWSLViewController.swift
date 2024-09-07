//
//  CWSLViewController.swift
//  Claywork Swift Library
//
//  Created by Kentaro Kawai on 2024/08/21.
//

import Foundation
import UIKit

class CWSLViewController: UIViewController {
  func safeAreaFrame() -> CGRect {
    let safeAreaFrame = CGRect(
      x: view.safeAreaInsets.left,
      y: view.safeAreaInsets.top,
      width: view.bounds.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
      height: view.bounds.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom
    )
    return safeAreaFrame
  }

  func presentAlert(title: String, message: String, completion: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion?()
    }))
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }

  func presentAlert(title: String, message: String, firstButtonTitle: String, secondButtonTitle: String, firstButtonAction: (() -> Void)? = nil, secondButtonAction: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: firstButtonTitle, style: .default, handler: { _ in
      firstButtonAction?()
    }))

    alert.addAction(UIAlertAction(title: secondButtonTitle, style: .default, handler: { _ in
      secondButtonAction?()
    }))
    DispatchQueue.main.async {
      self.present(alert, animated: true, completion: nil)
    }
  }
}
