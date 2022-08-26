//
//  CWSLTools.swift
//  OSFSpeech
//
//  Created by Kentaro Kawai on 2022/08/09.
//

import Foundation

class CWSLPrint {
  static func print(_ obj: Any = "",
                    fl: String = #file,
                    fn: String = #function,
                    ln: Int = #line) {
    let fileName = fl.components(separatedBy: "/").last ?? "FILE_NAME"
    // TODO: 各列の幅を指定できるようにする
    Swift.print("| \(obj) | \(fileName) | \(ln) | \(fn) |")
  }
}

