//
//  ContentView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/01.
//

import SwiftUI

import ComposableArchitecture

public struct MovieDBTabView: View {
  @State var hiddened: Bool = false
  @State var currentPage: Int = 0
  let store: MovieDBTabStore
  @ObservedObject private var viewStore: MovieDBTabViewStore
  
  init(store: MovieDBTabStore) {
    self.store = store
    self.viewStore = ViewStore(store)
  }
  
  public var body: some View {
    Group {
      TabView(selection: $currentPage) {
        NavigationStack(path: viewStore.binding(get: \.stack, send: .none)) {
          HomeView(
            store: self.store.scope(
              state: \.home,
              action: MovieDBTabFeature.Action.moveToHome
            )
          )
        }
        .tabItem {
          Label("홈", systemImage: "house")
        }
        
        NavigationStack(path: viewStore.binding(get: \.stack, send: .none)) {
          SearchView(
            store: self.store.scope(
              state: \.search,
              action: MovieDBTabFeature.Action.moveToSearch
            )
          )
        }
        .tabItem {
          Label("검색", systemImage: "magnifyingglass")
        }
      }
      .onAppear {
        viewStore.send(.onAppear)
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
