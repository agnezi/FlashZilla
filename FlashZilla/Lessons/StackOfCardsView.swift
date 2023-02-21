////
// FlashZilla
// Created by: itsjagnezi on 20/02/23
// Copyright (c) today and beyond
//

import SwiftUI

extension View {
	func stacked(at position: Int, in total: Int) -> some View {
		let offset = Double(total - position)
		return self.offset(x: 0, y: offset * 10)
	}
}

struct StackOfCardsView: View {
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	
	@State private var cards = [CardModel](repeating: CardModel.example, count: 10)
	
	var body: some View {
		ZStack {
			Image("background")
				.resizable()
				.ignoresSafeArea()
			
			VStack {
				ZStack {
					ForEach(0..<cards.count, id: \.self) { index in
						CardView(card: cards[index]) {
							withAnimation {
								removeCard(at: index)
							}
						}
						.stacked(at: index, in: cards.count)
					}
				}
			}
			
			if differentiateWithoutColor {
				
				VStack {
					Spacer()
					HStack {
						Image(systemName: "xmark.circle")
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(Circle())
						
						Spacer()
						
						Image(systemName: "checkmark.circle")
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(Circle())
					}
					.foregroundColor(.white)
					.font(.largeTitle)
					.padding()
				}
			}
		}
	}
	
	func removeCard(at index: Int) {
		cards.remove(at: index)
	}
}

struct StackOfCardsView_Previews: PreviewProvider {
	static var previews: some View {
		StackOfCardsView()
	}
}