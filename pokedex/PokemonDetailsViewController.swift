//
//  PokemonDetailsViewController.swift
//  pokedex
//
//  Created by Admin on 10/13/15.
//  Copyright © 2015 Roman Rudyak. All rights reserved.
//

import UIKit

class PokemonDetailsViewController: UIViewController {

	
	@IBOutlet weak var nameLbl: UILabel!
	
	var pokemon: Pokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameLbl.text = pokemon.name
	}
	
}
