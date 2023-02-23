////
// FlashZilla
// Created by: itsjagnezi on 20/02/23
// Copyright (c) today and beyond
//

import Foundation

struct CardModel: Codable, Identifiable {
	var id = UUID()
	let prompt: String
	let answer: String
	
#if DEBUG
	static let example = CardModel(prompt: "Who was Luiz Barsi Filho?", answer: "The greatest dividend investor.")
#endif
}
