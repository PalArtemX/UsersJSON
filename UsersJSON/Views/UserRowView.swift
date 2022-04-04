//
//  UserRowView.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(user.username)
                    .font(.headline)
                Text(user.website)
                    .foregroundColor(.blue)
            }
            Text(user.phone)
                .font(.subheadline)
        }
    }
}










struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: previewUser)
    }
}
