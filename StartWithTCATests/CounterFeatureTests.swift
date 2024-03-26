//
//  CounterFeatureTests.swift
//  StartWithTCATests
//
//  Created by Maxime Maheo on 26/03/2024.
//

import ComposableArchitecture
import XCTest

final class CounterFeatureTests: XCTestCase {
    @MainActor
    func testCounter() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }

        await store.send(.incrementButtonTapped) {
            $0.count = 1
        }
        await store.send(.decrementButtonTapped) {
            $0.count = 0
        }
    }

    @MainActor
    func testTimer() async {
        let clock = TestClock()
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = true
        }

        await clock.advance(by: .seconds(1))
        await store.receive(\.timerTick) {
            $0.count = 1
        }

        await store.send(.toggleTimerButtonTapped) {
            $0.isTimerRunning = false
        }
    }

    @MainActor
    func testFact() async {
        let store = TestStore(initialState: CounterFeature.State()) {
            CounterFeature()
        }
//        withDependencies: {
//            $0.numberFact.fetch = { "\($0) is a number" }
//        }

        await store.send(.factButtonTapped) {
            $0.isLoading = true
        }

        await store.receive(\.factResponse) {
            $0.isLoading = false
            $0.fact = "0 is a number"
        }
    }
}
