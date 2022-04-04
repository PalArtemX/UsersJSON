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
        VStack {
            ForEach(userViewModel.users) { user in
                Text(user.name)
            }
        }
    }
}









struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
            .environmentObject(UserViewModel())
    }
}
