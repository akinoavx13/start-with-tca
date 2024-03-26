//
//  StartWithTCAApp.swift
//  StartWithTCA
//
//  Created by Maxime Maheo on 25/03/2024.
//

import ComposableArchitecture
import SwiftUI

@main
struct StartWithTCAApp: App {
    let store = Store(initialState: AppFeature.State()) {
        AppFeature()
    }

    var body: some Scene {
        WindowGroup {
            AppView(store: store)
        }
    }
}
