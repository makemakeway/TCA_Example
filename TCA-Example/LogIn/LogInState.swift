//
//  LogInState.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

public struct LogInState: Equatable {
  public var emailString: String = ""
  public var passwordString: String = ""
  public var emailValid: Bool = false
  public var passwordValid: Bool = false
  
  public init() {
  }
}
