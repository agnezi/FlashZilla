////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct EditCardsView: View {
	@Environment(\.dismiss) var dismiss
	
	@EnvironmentObject var model: CardsViewModel
	
	@State private var prompt = ""
	@State private var answer = ""
	
	var body: some View {
		NavigationStack {
			List {
				Section("Add new card") {
					TextField("Prompt", text: $prompt)
					TextField("Answer", text: $answer)
					
					Button("Add card") {
						
						let trimmedPrompt = prompt.trimmingCharacters(in: .whitespaces)
						let trimmedAnswer = answer.trimmingCharacters(in: .whitespaces)
						
						guard trimmedPrompt.isEmpty == false && trimmedAnswer.isEmpty == false else { return }
						
						let newCard = CardModel(prompt: trimmedPrompt, answer: trimmedAnswer)
						
						model.addCard(newCard)
						
						prompt = ""
						answer = ""
					}
					.buttonStyle(.bordered)
				}
				Section {
					ForEach(Array(model.cards.enumerated()), id: \.element) { index, element in
						VStack(alignment: .leading) {
							Text(model.cards[index].prompt)
								.font(.headline)
							
							Text(model.cards[index].answer)
								.foregroundColor(.secondary)
						}
					}
					.onDelete { offsets in
						Task {
							await MainActor.run {
								model.removeCardOffset(at: offsets)
							}
						}
					}
				}
			}
			.navigationTitle("Edit Cards")
			.toolbar {
				Button("Done", action: { dismiss() })
			}
			.listStyle(.grouped)
		}
	}
}

struct EditCardsView_Previews: PreviewProvider {
	static var previews: some View {
		EditCardsView()
	}
}
