//
//  ContentView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/01.
//

import SwiftUI

struct ContentView: View {
  @State var hiddened: Bool = false
  @State var currentPage: Int = 0
  var body: some View {
    Group {
      TabView(selection: $currentPage) {
        NavigationView {
          HomeView(
            store: .init(
              initialState: .init(),
              reducer: HomeFeature()._printChanges(.actionLabels)
            )
          )
        }
        .navigationViewStyle(.stack)
        .tabItem {
          Label("홈", systemImage: "house")
        }
        
        NavigationView {
          SearchView(store: .init(
            initialState: .init(),
            reducer: SearchFeature())
          )
        }
        .navigationViewStyle(.stack)
        .tabItem {
          Label("검색", systemImage: "magnifyingglass")
        }
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
