//
//  MovieImagePlaceholder.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/23.
//

import SwiftUI

public struct MovieImagePlaceholder: View {
  public var body: some View {
    ZStack {
      Rectangle()
        .foregroundColor(Color(uiColor: .darkGray))
      ProgressView()
        .progressViewStyle(.circular)
        .tint(.orange)
    }
  }
}
