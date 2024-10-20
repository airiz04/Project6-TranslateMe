//
//  Project6_TranslateMeApp.swift
//  Project6 TranslateMe
//
//  Created by Anthony Irizarry on 10/14/24.
//

import SwiftUI
import FirebaseCore

@main
struct Project6_TranslateMeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(isMocked: false)
        }
    }
}
