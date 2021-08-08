//
//  Observer.swift
//  ZGNewsReading
//
//  Created by 刘铸耿 on 2021/4/24.
//

import Foundation

class Observable<T> {
  typealias Observer = (T) -> Void
  var observer: Observer?

  func observe(_ observer: Observer?) {
    self.observer = observer
    //observer?(value)
  }

  var value: T {
    didSet {
      observer?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }
}
