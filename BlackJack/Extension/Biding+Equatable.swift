//
//  Biding+Equatable.swift
//  BlackJack
//
//  Created by mai chieu thuy on 01/09/2023.
//

import SwiftUI

extension Binding where Value: Equatable {
    static func proxy(_ source: Binding<Value>) -> Binding<Value> {
        self.init(get: { source.wrappedValue },
                  set: {source.wrappedValue = $0}
        )
    }
}
