//
//  Models.swift
//  SwiftDataExample
//
//  Created by Eliran Sharabi on 25/06/2024.
//

import Foundation
import SwiftData
import SwiftUI


@Model
final class Person {
    @Attribute(.unique) let id: String
    var name: String
    var email: String
    var team: Team?
    var age: Int = 0
    
    init(name: String = "",
         email: String = "",
         age: Int = 0,
         team: Team? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.email = email
        self.team = team
        self.age = age
    }
    
    static var mock: Person = .init(name: "Eliran Sharabi", email: "email@gmail.com")
}

@Model
final class Team {
    @Attribute(.unique) var name: String
    var city: String
    var country: String
    var fans: [Person] = []
    
    init(
        name: String,
        city: String,
        country: String,
        fans: [Person] = []
    ) {
        self.name = name
        self.city = city
        self.country = country
        self.fans = fans
    }
    
    static var haifa: Team = .init(name: "Maccabi Haifa", city: "Haifa", country: "Israel")
    static var marmoorek: Team = .init(name: "Hapoel Marmoorek", city: "Rehovot", country: "Israel")
    static var real: Team = .init(name: "Real Madrid", city: "Madrid", country: "Spain")
    static var barca: Team = .init(name: "Barcelona FC", city: "Barcelona", country: "Spain")
    static var juventus: Team = .init(name: "Juventus", city: "Torino", country: "Italy")
    
    static var mock: [Team] = [.haifa, .marmoorek, .juventus, .real, .barca]
    
}
