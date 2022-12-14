//
//  CharacterCell.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 20.10.22.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var characterLocationLabel: UILabel!
    @IBOutlet var characterStatusLabel: UILabel!
    @IBOutlet var characterMarkLabel: UILabel!
    @IBOutlet var characterNameLabel: UILabel!
    
    func configure(for character: Result) {
        characterNameLabel.text = character.name
        characterStatusLabel.text = "\(character.status)      \(character.species)"
        characterMarkLabel.clipsToBounds = true
        characterMarkLabel.layer.cornerRadius = characterMarkLabel.frame.height / 2
        //  characterImage.image = self.setImage(from: character.image)
        characterImage.layer.cornerRadius = 10
        layer.cornerRadius = 14
        // backgroundColor = .darkGray
        switch character.status {
        case "Alive": characterMarkLabel.backgroundColor = .green
        case "Dead": characterMarkLabel.backgroundColor = .red
        case "unknown": characterMarkLabel.backgroundColor = .yellow
        default: characterMarkLabel.backgroundColor = .gray
        }
        characterLocationLabel.text = "Last unknown location:\n\(character.location.name)"
        backgroundColor = .systemMint
        layer.borderWidth = 5
        layer.borderColor = UIColor.darkGray.cgColor
    }
}
