//
//  PokeDexViewController.swift
//  Pokemon Lite
//
//  Created by Sdot on 1/11/17.
//  Copyright © 2017 SwiftMills. All rights reserved.
//

import UIKit

class PokeDexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var pokeDexTableView: UITableView!
    
    var caughtPokemon: [Pokemon] = []
    var uncaughtPokemon: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeDexTableView.delegate = self
        pokeDexTableView.dataSource = self
        
        caughtPokemon = getAllCaughtPokemon()
        uncaughtPokemon = getAllUncaughtPokemon()


        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return caughtPokemon.count
        } else {
            return uncaughtPokemon.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        var pokemon: Pokemon
        
        
        if  indexPath.section == 0 {
            pokemon = caughtPokemon[indexPath.row]
        } else {
            pokemon = uncaughtPokemon[indexPath.row]
        }
        
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "CAUGHT"
        } else {
            return "UNCAUGHT"
        }
    }
    
    @IBAction func mapButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
