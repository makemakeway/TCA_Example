//
//  LogInReducer.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture

public typealias LogInReducer = Reducer<
  LogInState,
  LogInAction,
  LogInEnvironment
>

public extension LogInReducer {
  init() {
    self = Self
      .combine(
        .init { state, action, environment in
          switch action {
          case let .emailChanged(text):
            state.emailString = text
            return .init(value: .emailValidation)
          case let .passwordChanged(text):
            state.passwordString = text
            return .init(value: .passwordValidation)
          case .emailValidation:
            let emailCount = state.emailString.count
            if emailCount >= 6 {
              state.emailValid = true
            } else {
              state.emailValid = false
            }
            return .none
          case .passwordValidation:
            let passwordCount = state.passwordString.count
            if passwordCount >= 6 {
              state.passwordValid = true
            } else {
              state.passwordValid = false
            }
            return .none
          }
        }
      )
  }
}
