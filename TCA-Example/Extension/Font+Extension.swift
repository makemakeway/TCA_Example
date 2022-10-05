//
//  Font+Extension.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/06.
//

import SwiftUI

extension Font {
  enum MyFont: String {
    case bold = "AppleSDGothicNeo-Bold"
    case regular = "AppleSDGothicNeo-Regular"
    case light = "AppleSDGothicNeo-Light"
    case semibold = "AppleSDGothicNeo-SemiBold"
  }
  
  static func fontMaker(weight: Self.MyFont, size: CGFloat) -> Font {
    return .custom(weight.rawValue, size: size)
  }
}
