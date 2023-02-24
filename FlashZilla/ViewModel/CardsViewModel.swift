////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import Foundation
import System


@MainActor
class CardsViewModel: ObservableObject {
	@Published private(set) var cards: [CardModel]
	
	let saveKey = "SavedData"
	let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

	
	private func save() {
		if let jsonData = try? JSONEncoder().encode(cards) {
			let url = paths[0].appendingPathComponent("cards.json")
			
			do {
				try jsonData.write(to: url)
			} catch {
				print("could not save data: \(error.localizedDescription)")
			}
		}
	}
	
	func removeCard(at index: Int) {
		guard index >= 0 else { return }
		
		cards.remove(at: index)
		save()
	}
	
	func removeCardOffset(at offsets: IndexSet) {
		cards.remove(atOffsets: offsets)
		save()
	}
	
	func resetCards() {
		cards = [CardModel](repeating: CardModel.example, count: 3)
		save()
	}
	
	func addCard(_ card: CardModel) {
		cards.insert(card, at: 0)
		save()
	}
	
	
	init() {
		print("Init")
		let url = paths[0].appendingPathComponent("cards.json")
		do {
			let data = try Data(contentsOf: url)
			let decoded = try JSONDecoder().decode([CardModel].self, from: data )
			
			cards = decoded
		
		} catch {
			print("Error on load file: \(error.localizedDescription)")
			cards = [CardModel](repeating: CardModel.example, count: 3)
		}
	}
}
