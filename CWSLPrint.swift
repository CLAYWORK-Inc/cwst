//
//  CWSLTools.swift
//  OSFSpeech
//
//  Created by Kentaro Kawai on 2022/08/09.
//

import Foundation

class CWSLPrint {
  static let blanks =
  "                " + //  16
  "                " + //  32
  "                " + //  48
  "                " + //  64
  "                " + //  80
  "                " + //  96
  "                " + // 112
  "                "   // 128

  static func print(_ obj: Any = "",
                    fl: String = #file,
                    fn: String = #function,
                    ln: Int = #line) {

    var message: String? = nil
    switch obj {
    case let objStr as String:
      message = string(count: 80, string: objStr)
    default:
      break
    }

    let fileName   = string(count: 30, string: fl.components(separatedBy: "/").last ?? "FILE_NAME")
    let funcName   = string(count: 50, string: fn)
    let lineNumber = String(format: "%6d", ln)
    // TODO: 各列の幅を指定できるようにする
    Swift.print("| \(fileName) | \(lineNumber) | \(funcName) | \(message != nil ? message! : obj) |")
  }

  static private func string(count: Int, string: String) -> String {
    var convertedString = string
    let countOfBlanks = count - string.count
    if (countOfBlanks < 0) {
      convertedString = String(string.prefix(count))
    } else {
      convertedString.append(contentsOf: CWSLPrint.blanks.prefix(countOfBlanks))
    }
    return convertedString
  }
}

