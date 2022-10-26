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
      for handle in self.handles {
        Database.database().reference().removeObserver(withHandle: handle)
      }
    }

    func attach(path: String,
                event: DataEventType,
                with: @escaping ((DataSnapshot) -> Void),
                withCancel: ((Error) -> Void)? = nil) {
        let db = Database.database().reference()
        let handle = db.child(path).observe(event,
                                            with: with,
                                            withCancel: withCancel)
        self.handles.append(handle)
    }
}
