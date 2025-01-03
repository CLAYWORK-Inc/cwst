//
//  CWSLDatabaseHandler.swift
//  OSFCam
//
//  Created by Kentaro Kawai on 2022/10/25.
//

import Foundation
import FirebaseDatabase

class CWSLDatabaseHandler {
  private var handles = [String: DatabaseHandle]()

  deinit {
    self.detachAllHandles()
  }

  func synchronize(path: String,
                   with: @escaping ((DataSnapshot) -> Void),
                   withCancel: ((Error) -> Void)? = nil) {
    let db = Database.database().reference()
    db.child(path).observeSingleEvent(of: .value,
                                      with: with,
                                      withCancel: withCancel)
  }

  func attach(path: String,
              event: DataEventType,
              with: @escaping ((DataSnapshot) -> Void),
              withCancel: ((Error) -> Void)? = nil) {
    guard self.handles[path] == nil else {
      print("Already attached: \(path)")
      return
    }

    /*
    // handleが既に存在する場合はエラーを返す
    do {
      if self.handles[path] != nil {
        throw NSError(domain: "CWSLDatabaseHandler", code: 1, userInfo: ["path": path])
      }
    } catch {
      throw error
    }
    */

    let ref = Database.database().reference()
    let handle = ref.child(path).observe(event,
                                         with: with,
                                         withCancel: withCancel)
    self.handles[path] = handle
  }

  func detach(path: String) {
    guard let handle = self.handles[path] else {
      print("Handle not found: \(path)")
      return
    }

    let ref = Database.database().reference()
    ref.removeObserver(withHandle: handle)
  }

  func detachAllHandles() {
    let ref = Database.database().reference()
    for handle in self.handles {
      ref.removeObserver(withHandle: handle.value)
    }
  }

}
