//
//  MovieDBTabFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/11/01.
//

import SwiftUI

import ComposableArchitecture

public typealias MovieDBTabStore = StoreOf<MovieDBTabFeature>
public typealias MovieDBTabViewStore = ViewStoreOf<MovieDBTabFeature>

public struct MovieDBTabFeature: ReducerProtocol {
  @Dependency(\.coordinator) var coordinator
  
  public init() {}
  public struct State: Equatable {
    var home: HomeFeature.State = .init()
    var search: SearchFeature.State = .init()
    var route: Route? = nil
    var stack: NavigationPath? = nil
  }
  
  public enum Action: Equatable {
    case moveToHome(HomeFeature.Action)
    case moveToSearch(SearchFeature.Action)
    case changeTab(Route)
    case onAppear
    case none
  }
  
  public var body: some ReducerProtocol<State, Action> {
    Reduce(self.core(into:action:))
    Scope(state: \.home, action: /MovieDBTabFeature.Action.moveToHome) {
      HomeFeature()
    }
    Scope(state: \.search, action: /MovieDBTabFeature.Action.moveToSearch) {
      SearchFeature()
    }
  }
  
  public func core(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .none:
      return .none
    case .onAppear:
      state.stack = coordinator.currentStack()
      return .none
    case .moveToHome:
      state.route = .home
      return .none
    case .moveToSearch:
      state.route = .search
      return .none
    case .changeTab(let route):
      state.route = route
      return .none
    }
  }
}

public enum Route {
  case home
  case search
}
