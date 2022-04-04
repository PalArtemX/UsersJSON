//
//  UsersJSONApp.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import SwiftUI

@main
struct UsersJSONApp: App {
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some Scene {
        WindowGroup {
            UsersView()
                .environmentObject(userViewModel)
        }
    }
}
