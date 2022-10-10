//
// Created by Kentaro Kawai on 2022/10/10.
//

import Foundation

class CWSLTimeInterval {
  static let calendar = Calendar(identifier: .gregorian)

  static func month(timeInterval: TimeInterval) -> TimeInterval? {
    let sourceDate = Date(timeIntervalSince1970: timeInterval)
    let year = calendar.component(.year, from: sourceDate)
    let month = calendar.component(.month, from: sourceDate)
    let resultDate = calendar.date(from: DateComponents(year: year,
                                                        month: month))
    return resultDate?.timeIntervalSince1970
  }
}