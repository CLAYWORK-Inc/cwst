//
//  CWSTProgress.swift
//  OSFSpeech
//
//  Created by Kentaro Kawai on 2022/08/08.
//

import Foundation

class CWSLProgress {

  enum State: String {
    case before
    case during
    case done
    case aborted
  }

  enum StateError: Error {
    case overwrite
    case undefined
  }

  enum StateEvent: String {
    case appended
    case removed
    case changed
  }

  private var observers = [String: [StateEvent: ()->Void]]()

  //private var children= [String: CWSLProgress]()
  //private var _state: State = .before
  private var key: String?
  private var parent: CWSLProgress?
  private var states = [String: State]() {
    didSet {
      guard let key = self.key else {
        return
      }
      guard let state = self.state else {
        return
      }
      CWSLPrint.print("CWSLProgress KEY: " + key + ", STATE: " + state.rawValue)
      for state in self.states {
        print("  STATE_KEY: " + state.key + ", VALUE: " + state.value.rawValue)
      }
      guard let parent = self.parent else {
        return
      }
      try! parent.setState(key: key, value: state)
    }
  }

  var state: State? {
    if (self.states.count == 0) { return nil }
    if (self.isMatchSome(state: .aborted)) { return .aborted }
    if (self.isMatchAll (state: .done   )) { return .done    }
    if (self.isMatchAll (state: .before )) { return .before  }
    return .during
  }

  init(stateKeys: [String], parent: CWSLProgress?, key: String?) {
    for stateKey in stateKeys {
      self.states[stateKey] = .before
    }
    self.setParent(parent: parent, key: key)
    self.key = key
  }

  func state(key: String) -> State? {
    return states[key]
  }

  func setParent(parent: CWSLProgress?, key: String?) {
    guard let parent = parent else { return }
    guard let key = key else { return }
    self.parent = parent
    try! parent.appendState(key: key)
  }

  func setState(key: String, value: State) throws {
    if (self.states[key] == nil) {
      throw StateError.undefined
    }
    self.states[key] = value
    self.observers[key]?[.changed]?()
  }

  func appendState(key: String) throws {
    if (self.states[key] != nil) {
      throw StateError.overwrite
    }
    self.states[key] = .before
    self.observers[key]?[.appended]?()
    self.observers[key]?[.changed]?()
  }

  func removeState(key: String) throws {
    if (self.states[key] == nil) {
      throw StateError.undefined
    }
    self.observers[key]?[.removed]?()
    self.states.removeValue(forKey: key)
  }

  func observe(key: String, event: StateEvent, block: @escaping ()->Void) {
    if observers[key] == nil {
      observers[key] = [StateEvent: ()->Void]()
    }
    observers[key]![event] = block
  }

  /*
  func child(key: String) -> CWSLProgress? {
    return self.children[key]
  }
   */

  /*
  func add(key: String) {
    self.children[key] = CWSLProgress()
  }

  func remove(key: String) {
    self.children.removeValue(forKey: key)
  }

  func child(path: [String]) -> CWSLProgress? {
    guard let key = path.first else {
      return nil
    }
    let slicedPath = path.dropFirst()
    let child = self.children[key]?.child(path: Array(slicedPath))
    return child
  }

  func child(path: String) -> CWSLProgress? {
    return self.child(path: path.components(separatedBy: "/"))
  }

  func add(path: [String]) {
    guard self.child(path: path) != nil else {
      return
    }
    guard let key = path.first else {
      return nil
    }

    let slicedPath = path.dropFirst()

  }
   */
}

private extension CWSLProgress {
  func isMatchAll(state: State) -> Bool {
    let matched = states.values.filter { (value) in
      value == state
    }
    return matched.count == states.count
  }

  func isMatchSome(state: State) -> Bool {
    let matched = states.values.first { (value) in
      value == state
    }
    return matched != nil
  }

  func isMatchNone(state: State) -> Bool {
    let matched = states.values.filter { (value) in
      value == state
    }
    return matched.count == 0
  }
}
