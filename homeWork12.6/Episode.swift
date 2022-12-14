//
//  Episode.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 31.10.22.
//

import Foundation

struct Episode: Decodable {
    let results: [EpisodeResult]
}
struct EpisodeResult: Decodable {
    let name: String
    let episode: String
    let characters: [String]
    let url: String
}
