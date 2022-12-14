//
//  ViewController.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 9.10.22.
//

import UIKit


class ViewController: UIViewController {
    
    var characters: [Result] = []
    var vybor: Result?
    private var urlRequest: String = "https://rickandmortyapi.com/api/character"
    private var charactersPageURL = "https://rickandmortyapi.com/api/character?page="
    
    @IBOutlet var charactersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersTableView.dataSource = self
        self.charactersTableView.delegate = self
        charactersTableView.backgroundColor = .darkGray
        
        Task{
            if let charactersFromJson: Character = await CharactersLoader.parseJson(from: urlRequest) {
                self.characters.append(contentsOf: charactersFromJson.results)
                await self.getCharacters(for: charactersFromJson.info.pages)
                await MainActor.run{
                    self.charactersTableView.reloadData()
                }
            }
        }
    }
    func getCharacters(for pages: Int) async {
        for number in 2...pages{
            if let charactersFromJson: Character = await CharactersLoader.parseJson(from: String(format: charactersPageURL, number)) {
                self.characters.append(contentsOf: charactersFromJson.results)
            }
        }
    }
}
extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as! CharacterCell
        let model = characters[indexPath.row]
        cell.configure(for: model)
        Task { @MainActor in cell.characterImage.image = await CharactersLoader.getChImage(from: model.image)}
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vybor = characters[indexPath.row]
        performSegue(withIdentifier: "showCharacter", sender: self)
        charactersTableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            let destination = segue.destination as! CharacterViewController
            destination.characterUrl = vybor!.url
            destination.char = vybor!
        }
    }
}

