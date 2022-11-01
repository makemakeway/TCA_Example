//
//  CoordinatorFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/11/01.
//

import SwiftUI

import ComposableArchitecture

public struct CoordinatorFeature: ReducerProtocol {
  public init() {}
  public struct State: Equatable {
    var stack: NavigationPath = .init()
  }
  
  public enum Action: Equatable {
    case popToRoot
    case popLast
  }
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action, Never> {
    switch action {
    case .popToRoot:
      state.stack = .init()
      return .none
    case .popLast:
      state.stack.removeLast()
      return .none
    }
  }
}
