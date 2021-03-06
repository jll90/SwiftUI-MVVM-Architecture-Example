//
//  File.swift
//  Swift MVVM Compose
//
//  Created by Jesus Luongo Lizana on 6/27/20.
//  Copyright © 2020 Jesus Luongo Lizana. All rights reserved.
//

import Foundation
import Combine

struct Agent {
  func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<T, Error> {
    return URLSession.shared
      .dataTaskPublisher(for: request)
      .map { $0.data }
      .handleEvents(receiveOutput: { print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue)!) })
      .decode(type: T.self, decoder: JSONDecoder())
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
}
