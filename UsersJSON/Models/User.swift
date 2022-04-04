//
//  User.swift
//  UsersJSON
//
//  Created by Artem Paliutin on 04/04/2022.
//

import Foundation


// MARK: - User
struct User: Codable, Identifiable {
    let id: Int
    let name, username, email: String
    let address: Address
    let phone, website: String
    let company: Company
    
    
    // MARK: - Address
    struct Address: Codable {
        let street, suite, city, zipcode: String
        let geo: Geo
    }
    // MARK: - Geo
    struct Geo: Codable {
        let lat, lng: String
    }
    // MARK: - Company
    struct Company: Codable {
        let name, catchPhrase, bs: String
    }
}


