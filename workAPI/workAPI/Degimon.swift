//
//  Degimon.swift
//  workAPI
//
//  Created by NoON .. on 20/04/1443 AH.
//

import Foundation
struct Degimons:Codable{
    var degimons: [Degimon]
}
struct Degimon:Codable{
    var name:String
    var img:String
    var level:String
}
