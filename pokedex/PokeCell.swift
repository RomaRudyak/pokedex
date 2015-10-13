//
//  PokeCell.swift
//  pokedex
//
//  Created by Admin on 10/13/15.
//  Copyright © 2015 Roman Rudyak. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {

	@IBOutlet weak var thumbImg: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	
	var pokemon: Pokemon!
	
	func configureCell(pokemon: Pokemon) {
		self.pokemon = pokemon
		
		nameLbl.text = self.pokemon.name.capitalizedString
		thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
	}
}
