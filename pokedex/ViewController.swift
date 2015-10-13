//
//  ViewController.swift
//  pokedex
//
//  Created by Admin on 10/13/15.
//  Copyright © 2015 Roman Rudyak. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	@IBOutlet weak var collection: UICollectionView!
	
	var pokemons = [Pokemon]()
	var musicPlayer: AVAudioPlayer!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		collection.delegate = self
		collection.dataSource = self
		
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
			let poke = pokemons[indexPath.row]
			cell.configureCell(poke)
			return cell
		}
		
		return UICollectionViewCell()
	}
	
	func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
		
	}
	
	func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return pokemons.count
	}
	
	func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		return CGSizeMake(105, 105)
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

