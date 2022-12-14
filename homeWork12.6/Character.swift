//
//  Character.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 20.10.22.
//

import Foundation

struct Character: Decodable{
    let results: [Result]
    let info: Info
}
struct Result: Decodable {
    let name: String
    let status: String
    let species: String
    let image: String
    let location: Location
    let url: String
    let episode: [String]
}
struct Info: Decodable{
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
struct Location: Decodable{
    let name: String
}

