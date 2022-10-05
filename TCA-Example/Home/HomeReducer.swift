//
//  HomeReducer.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture

public typealias HomeReducer = Reducer<
  HomeState,
  HomeAction,
  HomeEnvironment
>

public extension HomeReducer {
  init() {
    self = Self
      .combine(
        .init { state, action, environment in
          .none
        }
      )
  }
}
