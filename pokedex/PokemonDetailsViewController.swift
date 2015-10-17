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
	@IBOutlet weak var mainImagView: UIImageView!
	@IBOutlet weak var descriptionLbl: UILabel!
	@IBOutlet weak var typelbl: UILabel!
	@IBOutlet weak var defenceLbl: UILabel!
	@IBOutlet weak var heightLbl: UILabel!
	@IBOutlet weak var pokedexLbl: UILabel!
	@IBOutlet weak var weightlbl: UILabel!
	@IBOutlet weak var baseAttackLbl: UILabel!
	@IBOutlet weak var currentEvoImg: UIImageView!
	@IBOutlet weak var newtEvoImg: UIImageView!
	@IBOutlet weak var evoLabl: UILabel!
	
	var pokemon: Pokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameLbl.text = pokemon.name
	}
	
	@IBAction func onDismissTapped(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
}
