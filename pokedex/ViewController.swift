//
//  ViewController.swift
//  pokedex
//
//  Created by Admin on 10/13/15.
//  Copyright © 2015 Roman Rudyak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

	@IBOutlet weak var collection: UICollectionView!
	@IBOutlet weak var searchBar: UISearchBar!
	
	private var pokemons = [Pokemon]()
	private var filteredPokemons = [Pokemon]()
	private var musicPlayer: AVAudioPlayer!
	private var inSearchMode = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collection.delegate = self
		collection.dataSource = self
		
		searchBar.delegate = self
		searchBar.returnKeyType = UIReturnKeyType.Done
		
		initAudio()
		parsePokemonCSV()
	}
	
	func parsePokemonCSV() {
		let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
		
		do {
			let csv = try CSV(contentsOfURL: path)
			let rows = csv.rows
			
			for row in rows {
				let pokeId = Int(row["id"]!)!
				let name = row["identifier"]!
				let poke = Pokemon(name: name, pokedexId: pokeId)
				
				var t = "\(name)"
				
				pokemons.append(poke)
			}
			
		} catch let er as NSError {
			print(er.debugDescription)
		}
	}
	
	func initAudio(){
		
		let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
		
		do {
			
			musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
			musicPlayer.prepareToPlay()
			musicPlayer.numberOfLoops = -1
			musicPlayer.play()
			
		} catch let er as NSError {
			print(er.debugDescription)
		}
		
	}
	
	func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		
		if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
			
			let poke: Pokemon! = inSearchMode
					? filteredPokemons[indexPath.row]
					: pokemons[indexPath.row]
			cell.configureCell(poke)
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		
		let poke: Pokemon! = inSearchMode
			? filteredPokemons[indexPath.row]
			: pokemons[indexPath.row]
		
		performSegueWithIdentifier("PokemonDetailsViewController", sender: poke)
		
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return inSearchMode ? filteredPokemons.count : pokemons.count
	}
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(105, 105)
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar) {
		view.endEditing(true)
	}
	
	func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
		if searchBar.text == nil || searchBar.text == "" {
			inSearchMode = false
			view.endEditing(true)
		} else {
			inSearchMode = true
			let lower = searchBar.text!.lowercaseString
			filteredPokemons = pokemons.filter({$0.name.rangeOfString(lower) != nil})
		}
		collection.reloadData()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "PokemonDetailsViewController" {
			if let controller = segue.destinationViewController as? PokemonDetailsViewController {
				if let poke = sender as? Pokemon {
					controller.pokemon = poke
				}
			}
		}
	}

	@IBAction func onToggelMusic(sender: UIButton!) {
		if musicPlayer.playing {
			musicPlayer.stop()
			sender.alpha = 0.2
		} else {
			musicPlayer.play()
			sender.alpha = 1.0
		}
	}
}

