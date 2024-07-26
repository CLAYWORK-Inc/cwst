//
//  CWSLDatabaseHandler.swift
//  OSFCam
//
//  Created by Kentaro Kawai on 2022/10/25.
//

import Foundation
import FirebaseDatabase

class CWSLDatabaseHandler {
  private var handles = [DatabaseHandle]()

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
    let ref = Database.database().reference()
    let handle = ref.child(path).observe(event,
                                         with: with,
                                         withCancel: withCancel)
    self.handles.append(handle)
  }

  func detachAllHandles() {
    for handle in self.handles {
      Database.database().reference().removeObserver(withHandle: handle)
    }
  }

}
