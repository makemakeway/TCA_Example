//
//  MovieDBTabFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/11/01.
//

import Foundation

import ComposableArchitecture

public typealias MovieDBTabStore = StoreOf<MovieDBTabFeature>
public typealias MovieDBTabViewStore = ViewStoreOf<MovieDBTabFeature>

public struct MovieDBTabFeature: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    var home: HomeFeature.State = .init()
    var search: SearchFeature.State = .init()
    var coordinator: CoordinatorFeature.State = .init()
    var route: Route? = nil
  }
  
  public enum Action: Equatable {
    case moveToHome(HomeFeature.Action)
    case moveToSearch(SearchFeature.Action)
    case changeTab(Route)
    case coordinator(CoordinatorFeature.Action)
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
    Scope(state: \.coordinator, action: /MovieDBTabFeature.Action.coordinator) {
      CoordinatorFeature()
    }
  }
  
  public func core(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .none:
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
    case .coordinator:
      return .none
    }
  }
}

public enum Route {
  case home
  case search
}
