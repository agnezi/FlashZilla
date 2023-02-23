////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import Foundation


@MainActor
class CardsViewModel: ObservableObject {
	@Published private(set) var cards: [CardModel]
	
	let saveKey = "SavedData"
	
	init() {
		if let data = UserDefaults.standard.data(forKey: saveKey) {
			if let decoded = try? JSONDecoder().decode([CardModel].self, from: data) {
				cards = decoded
				return
			}
		}
		
		cards = [CardModel](repeating: CardModel.example, count: 3)
	}
	
	private func save() {
		if let encoded = try? JSONEncoder().encode(cards) {
			UserDefaults.standard.set(encoded, forKey: saveKey)
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
}
