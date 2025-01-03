//
//  CWSLLoading.swift
//  SmiralWatcher
//
//  Created by Kentaro Kawai on 2024/09/04.
//

import Foundation
import UIKit

class CWSLLoading {

  enum NotificationName {
    static let didFinishLoading = Notification.Name("didFinishLoading")
    // 必要に応じて他の通知も追加
  }

  enum Status: String {
    case unload
    case loading
    case loaded
  }

  /*
  protocol Delegate {
    // 読み込み完了
    func didFinishLoading()
  }
   */

  class Model {
    //let delegate: Delegate?
    var status = [String: Status]()

    /*
    init (delegate: Delegate?) {
      self.delegate = delegate
    }
     */

    func setStatus(key: String, value: Status) {
      status[key] = value
      if (self.isLoaded()) {
        //self.delegate?.didFinishLoading()
        NotificationCenter.default.post(name: NotificationName.didFinishLoading,
                                        object: self)
      }
    }

    // 読み込み完了を確認
    func isLoaded() -> Bool {
      guard status.count != 0 else {
        return false
      }

      for (_, value) in status {
        if value != .loaded {
          return false
        }
      }
      return true
    }
  }

  class View: CWSLView {
    let loadingLabel: UILabel = UILabel()

    init (parentViewController: CWSLViewController) {
      super.init(parentViewController: parentViewController)
      self.loadingLabel.text = "Loading..."
    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
      super.layoutSubviews()

      self.loadingLabel.frame = self.bounds
      self.backgroundColor = .yellow
    }
  }

  class ViewController: CWSLViewController {
    init() {
      super.init(nibName: nil, bundle: nil)

      self.view = View(parentViewController: self)
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }
}
