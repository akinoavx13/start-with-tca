//
//  NumberFactClient.swift
//  StartWithTCA
//
//  Created by Maxime Maheo on 26/03/2024.
//

import ComposableArchitecture
import Foundation

struct NumberFactClient {
    var fetch: @Sendable (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
    static let liveValue = Self(
        fetch: { number in
            let (data, _) = try await URLSession.shared.data(
                from: URL(string: "http://numbersapi.com/\(number)")!
            )

            return String(decoding: data, as: UTF8.self)
        }
    )

    static let testValue = Self(
        fetch: { "\($0) is a number" }
    )
}

extension DependencyValues {
    var numberFact: NumberFactClient {
        get { self[NumberFactClient.self] }
        set { self[NumberFactClient.self] = newValue }
    }
}
