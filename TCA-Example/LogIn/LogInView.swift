//
//  LogInView.swift
//  TCA-Example
//
//  Created by 박연배 on 2022/09/19.
//

import ComposableArchitecture
import SwiftUI

// MARK: View

public struct LogInView: View {

  @ObservedObject
  private var viewStore: LogInViewStore

  private let store: LogInStore

  public init(store: LogInStore) {
    self.viewStore = ViewStore(store)
    self.store = store
  }

  public var body: some View {
    let validation = (viewStore.passwordValid && viewStore.emailValid)
    
    ZStack {
      VStack(alignment: .center, spacing: 20) {
        TextField(
          "아이디를 입력해주세요.",
          text: viewStore.binding(
            get: \.emailString,
            send: LogInAction.emailChanged
          )
        )
        
        TextField(
          "비밀번호를 입력해주세요.",
          text: viewStore.binding(
            get: \.passwordString,
            send: LogInAction.passwordChanged
          )
        )
        
        Button {
          validation ? print("DEBUG: 검증완료!") : print("DEBUG: 유효하지 않음")
        } label: {
          Text("다음")
            .foregroundColor(Color.white)
            .fontWeight(.bold)
            .frame(width: 200, height: 44)
        }
        .background(
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(validation ? .blue : .red)
        )
        .contentShape(Rectangle())
        
        Spacer()
      }
      .padding()
    }
  }
}

// MARK: Store

public typealias LogInStore = Store<
  LogInState,
  LogInAction
>

// MARK: ViewStore

public typealias LogInViewStore = ViewStore<
  LogInState,
  LogInAction
>

// MARK: Preview

struct LogInView_Previews: PreviewProvider {

  static var previews: some View {
    LogInView(store: store)
      .previewLayout(.sizeThatFits)
  }

  static let store: LogInStore = .init(
    initialState: .init(),
    reducer: .init(),
    environment: .init()
  )
}
