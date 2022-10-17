//
//  SearchFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/17.
//

import Foundation

import ComposableArchitecture

public typealias SearchStore = StoreOf<SearchFeature>
public typealias SearchViewStore = ViewStoreOf<SearchFeature>

public struct SearchFeature: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    var searchText: String = ""
  }
  
  public enum Action: Equatable {
    case searchTextDidChange(String)
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case let .searchTextDidChange(text):
      state.searchText = text
      return .none
    }
  }
}
