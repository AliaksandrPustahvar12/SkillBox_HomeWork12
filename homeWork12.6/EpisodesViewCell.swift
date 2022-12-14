//
//  EpisodesViewCell.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 1.11.22.
//

import UIKit

class EpisodesViewCell: UITableViewCell {
    
    @IBOutlet var nameEpisodeLabel: UILabel!
    @IBOutlet var numberEpisodeLabel: UILabel!
    
    func configure( for episodeResult: EpisodeResult) {
        nameEpisodeLabel.text = episodeResult.name
        numberEpisodeLabel.text = episodeResult.episode
    }
}
