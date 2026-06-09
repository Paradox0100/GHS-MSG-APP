//
//  GHS_MSG_APPApp.swift
//  GHS-MSG-APP
//
//  Created by Student on 5/28/26.
//

import SwiftUI
import SwiftData

@main
struct GHS_MSG_APPApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ChatUI(name: "John Pork")
        }
        .modelContainer(sharedModelContainer)
    }
}
