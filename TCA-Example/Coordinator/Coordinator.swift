//
//  CoordinatorFeature.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/11/01.
//

import SwiftUI

import ComposableArchitecture

public struct Coordinator {
  public var popToRoot: () -> ()
  public var popLast: () -> ()
  public var currentStack: () -> (NavigationPath)
  public var setStack: (NavigationPath) -> ()
  private static var stack: NavigationPath = .init()
  
  static let live = Self(
    popToRoot: { Self.stack = .init() },
    popLast: {
      if !Self.stack.isEmpty {
        Self.stack.removeLast()
      } else {
        print("DEBUG: stack is Empty")
      }
    },
    currentStack: { Self.stack },
    setStack: { stack in
      Self.stack = stack
    }
  )
}

fileprivate enum CoordinatorKey: DependencyKey {
  static let liveValue = Coordinator.live
}

extension DependencyValues {
  var coordinator: Coordinator {
    get { self[CoordinatorKey.self] }
    set { self[CoordinatorKey.self] = newValue }
  }
}
