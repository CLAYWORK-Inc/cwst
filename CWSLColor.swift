//
//  CWSLColor.swift
//  OSFSpeech
//
//  Created by Kentaro Kawai on 2022/10/09.
//

import UIKit

extension UIColor {
  class func hex(_ hex: String) -> UIColor {
    UIColor.hex(hex, alpha: 1.0)
  }

  class func hex(_ hex: String, alpha: CGFloat) -> UIColor {
    let code = hex.replacingOccurrences(of: "#", with: "")
    let scanner = Scanner(string: code as String)
    var color: UInt64 = 0
    if scanner.scanHexInt64(&color) {
      let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
      let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
      let b = CGFloat(color & 0x0000FF) / 255.0
      return UIColor(red: r, green: g, blue: b, alpha:alpha)
    } else {
      return UIColor.white;
    }
  }
}

class CWSLColor {
  enum Color {
    enum Label: String {
      case red        = "E80000"
      case orange     = "FF6600"
      case deepYellow = "FFAA00"
      case yellow     = "C3C300"
      case paleGreen  = "75C300"
      case green      = "109E00"
      case deepGreen  = "008783"
      case cyan       = "00B6DA"
      case violet     = "D83CFF"
      case pink       = "FF3CB1"
    }
    static func label(code: Label) -> UIColor {
      return UIColor.hex(code.rawValue)
    }

    enum Sdgs: String {
      case red          = "E5243B"
      case mustard      = "DDA63A"
      case kellyGreen   = "4C9F38"
      case darkRed      = "C5192D"
      case redOrange    = "FF3A21"
      case brightBlue   = "26BDE2"
      case yellow       = "FCC30B"
      case burgundyRed  = "A21942"
      case orange       = "FD6925"
      case magenta      = "DD1367"
      case goldenYellow = "FD9D24"
      case darkMustard  = "BF8B2E"
      case darkGreen    = "3F7E44"
      case blue         = "0A97D9"
      case limeGreen    = "56C02B"
      case royalBlue    = "00689D"
      case navyBlue     = "19486A"
    }
    static func sdgs(code: Sdgs) -> UIColor {
      return UIColor.hex(code.rawValue)
    }
  }
}


