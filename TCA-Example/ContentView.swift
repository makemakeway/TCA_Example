//
//  ContentView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
  @State var hiddened: Bool = false
  var body: some View {
    Group {
      NavigationView {
        HomeView(
          store: .init(
            initialState: .init(),
            reducer: HomeFeature()
          )
        )
      }
    }
  }
}

extension View {
  @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
    if hidden {
      if !remove {
        self.hidden()
      }
    } else {
      self
    }
  }
}
