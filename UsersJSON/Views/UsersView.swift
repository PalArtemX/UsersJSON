//
//  UsersView.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import SwiftUI

struct UsersView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userViewModel.users) { user in
                    NavigationLink {
                        DetailUserView(user: user)
                    } label: {
                        UserRowView(user: user)
                    }

                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Users")
        }
    }
}









struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
            .environmentObject(UserViewModel())
    }
}
