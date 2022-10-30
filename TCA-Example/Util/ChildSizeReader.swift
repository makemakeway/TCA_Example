//
//  ChildViewReader.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/25.
//

import SwiftUI

public struct ChildSizeReader<Content: View>: View {
  @Binding var size: CGFloat
  let content: () -> Content
  
  public var body: some View {
    ZStack {
      content()
        .background(
          GeometryReader { proxy in
            Color.clear
              .preference(key: SizePreferenceKey.self, value: proxy.size)
          }
        )
    }
  }
}

fileprivate struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero
  
  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}
