//
//  CoreDataHelp.swift
//  Pokemon Lite
//
//  Created by Sdot on 1/11/17.
//  Copyright © 2017 SwiftMills. All rights reserved.
//

import Foundation
import UIKit
import CoreData


func addAllPokemon() {
    
    createPokemon(name: "Abra", imageName: "abra")
    createPokemon(name: "Bellsprout", imageName: "bellsprout")
    createPokemon(name: "Bullbasaur", imageName: "bullbasaur")
    createPokemon(name: "Caterpie", imageName: "caterpie")
    createPokemon(name: "Charmander", imageName: "charmander")
    createPokemon(name: "Dratini", imageName: "dratini")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Jigglypuff", imageName: "jigglypuff")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Meowth", imageName: "Meowth")
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Pidgey", imageName: "pidgey")
    createPokemon(name: "Pikachu", imageName: "pikachu")
    createPokemon(name: "Psyduck", imageName: "psyduck")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Squirtle", imageName: "squirtle")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
}

func createPokemon(name:String, imageName:String){
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let pokemon = Pokemon(context: context)
    
    pokemon.name = name
    pokemon.imageName = imageName
    
    
}

func getAllPokemon() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    do {
        let pokemons = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons.count == 0 {
            addAllPokemon()
            return getAllPokemon()
        }
        
        return pokemons
    } catch {}
    
    return []
}

func getAllCaughtPokemon() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    
    return []
}

func getAllUncaughtPokemon() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    
    do {
        let pokemons = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons
    } catch {}
    
    return []

    
}
