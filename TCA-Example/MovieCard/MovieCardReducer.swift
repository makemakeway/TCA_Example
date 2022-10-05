//
//  MovieCardReducer.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/10/05.
//

import ComposableArchitecture

public typealias MovieCardReducer = Reducer<
  MovieCardState,
  MovieCardAction,
  MovieCardEnvironment
>

public extension MovieCardReducer {
  init() {
    self = Self
      .combine(
        .init { state, action, environment in
          .none
        }
      )
  }
}
