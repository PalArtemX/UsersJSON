//
//  DetailUserView.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import SwiftUI
import MapKit

struct DetailUserView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    let user: User
    
    var body: some View {
        // MARK: - Map
        VStack(alignment: .leading) {
            Map(coordinateRegion: $userViewModel.region, annotationItems: userViewModel.users, annotationContent: { loc in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: Double(loc.address.geo.lat) ?? 1.1, longitude: Double(loc.address.geo.lng) ?? 1.1), tint: .blue)
            })
            .cornerRadius(25)
            .ignoresSafeArea()
            .frame(height: 300)
            
            
            
            // MARK: - Header
            HStack {
                Spacer()
                Text(user.name)
                    .font(.title)
                    .bold()
                Spacer()
            }
            .foregroundColor(.mint)
            
            
            // MARK: - Address
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "house.circle.fill")
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.mint)
                        .font(.title)
                    Text(user.address.city)
                        .font(.headline)
                    Text(user.address.street)
                        .font(.subheadline)
                    Text(user.address.suite)
                        .font(.subheadline)
                }
                Text("Zipcode: \(user.address.zipcode)")
                    .font(.subheadline)
            }
            .padding(.horizontal)
            
            // MARK: - Company
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bag.circle.fill")
                        .font(.title)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.mint)
                    Text(user.company.name)
                        
                }
                .font(.headline)
                Text(user.company.bs)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(user.company.catchPhrase)
            }
            .padding()
            
            Spacer()
            // MARK: - Contacts
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "phone.and.waveform")
                        .font(.title2)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.mint)
                    Text(user.phone)
                }
                HStack {
                    Image(systemName: "network")
                        .font(.title2)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.mint)
                    Text(user.website)
                        .foregroundColor(.blue)
                }
                
                HStack {
                    Image(systemName: "mail.and.text.magnifyingglass")
                        .font(.title2)
                        .symbolRenderingMode(.hierarchical)
                        .foregroundColor(.mint)
                    Text(user.email)
                        .foregroundColor(.blue)
                }
            }
            .padding()
   
        }
        
        .onAppear {
            userViewModel.coordinateCenter(lat: Double(user.address.geo.lat) ?? 1.1, lon: Double(user.address.geo.lng) ?? 1.1)
        }
    }
}










struct DetailUserView_Previews: PreviewProvider {
    static var previews: some View {
        DetailUserView(user: previewUser)
            .environmentObject(UserViewModel())
    }
}
