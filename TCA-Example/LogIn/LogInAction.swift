//
//  LogInAction.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

public enum LogInAction: Equatable {
  case emailChanged(text: String)
  case emailValidation
  case passwordChanged(text: String)
  case passwordValidation
}
