//
//  CharacterViewController.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 30.10.22.
//

import UIKit
import Alamofire

class CharacterViewController: UIViewController, UITableViewDelegate {
    var charEpisodes: [String] = []
    var char: Result?
    var characterEpisodes: [EpisodeResult] = []
    var characterUrl: String = ""
    var image: UIImage?
    
    @IBOutlet var episodesTableView: UITableView!
    @IBOutlet var namelabel: UILabel!
    @IBOutlet var characterImage: UIImageView!
    @IBOutlet var liveStatusLabel: UILabel!
    @IBOutlet var statusMarkLabel: UILabel!
    @IBOutlet var speciesLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var episodeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.episodesTableView.dataSource = self
        self.episodesTableView.delegate = self
        setUpView()
        
        Task {
            if let result: Result = await CharactersLoader.parseJson(from: characterUrl) {
                self.charEpisodes = result.episode
                await self.getAllEpisodeNames()
                self.image = await CharactersLoader.getChImage(from: result.image)
                await MainActor.run {
                    setupCharInfo(with: result)
                }
                if let epResult: EpisodeResult = await CharactersLoader.parseJson(from: result.episode[0]) {
                    await MainActor.run { self.episodeLabel.text = epResult.name}
                }
            }
        }
    }
    func getAllEpisodeNames() async {
        for episode in charEpisodes {
            if let result: EpisodeResult = await CharactersLoader.parseJson(from: episode) {
                self.characterEpisodes.append(result)
            }
        }
        self.episodesTableView.reloadData()
    }
    private func setUpView() {
        episodesTableView.backgroundColor = .systemMint
        characterImage.layer.cornerRadius = 14
        statusMarkLabel.clipsToBounds = true
        statusMarkLabel.layer.cornerRadius = statusMarkLabel.frame.height / 2
    }
    private func setupCharInfo(with result: Result) {
        characterImage.image = image
        namelabel.text = result.name
        locationLabel.text = result.location.name
        liveStatusLabel.text = result.status
        speciesLabel.text = result.species
        switch result.status {
        case "Alive": statusMarkLabel.backgroundColor = .green
        case "Dead": statusMarkLabel.backgroundColor = .red
        case "unknown": statusMarkLabel.backgroundColor = .yellow
        default: statusMarkLabel.backgroundColor = .gray
        }
    }
}
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charEpisodes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesViewCell") as! EpisodesViewCell
        cell.configure(for: characterEpisodes[indexPath.row])
        return cell
    }
}
