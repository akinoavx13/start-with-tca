//
//  AppFeatureTests.swift
//  StartWithTCA
//
//  Created by Maxime Maheo on 26/03/2024.
//

import ComposableArchitecture
import XCTest

final class AppFeatureTests: XCTestCase {
    @MainActor
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }

        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
