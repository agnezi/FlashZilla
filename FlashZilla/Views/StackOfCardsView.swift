////
// FlashZilla
// Created by: itsjagnezi on 20/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct StackOfCardsView: View {
	@Environment(\.accessibilityDifferentiateWithoutColor) private var differentiateWithoutColor
	@Environment(\.accessibilityVoiceOverEnabled) private var voiceOverEnabled
	@Environment(\.scenePhase) private var scenePhase
	
	@EnvironmentObject var model: CardsViewModel
	
	@State private var timeRemaining = 100
	@State private var isActive = true
	@State private var showingEditScreen = false
	
	var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	var body: some View {
		ZStack {
			Image(decorative: "background")
				.resizable()
				.ignoresSafeArea()
			
			VStack {
				TimerText(timeRemaining: timeRemaining)
				
				ZStack {
					ForEach(Array(model.cards.enumerate()), id: \.element) { index, element in
						CardComponent(card: model.cards[index]) {
							withAnimation {
								model.removeCard(at: index)
							}
						}
						.stacked(at: index, in: model.cards.count)
						.allowsHitTesting(index == model.cards.count - 1)
						.accessibilityHidden(index < model.cards.count - 1)
					}
				}
				.allowsHitTesting(timeRemaining > 0)
				
				if model.cards.isEmpty {
					RestartGameButton(reset: resetCards)
				}
			}
			
			VStack {
				HStack {
					Spacer()
					
					Button {
						showingEditScreen = true
					} label: {
						Image(systemName: "plus.circle")
							.padding()
							.background(.black.opacity(0.7))
							.clipShape(Circle())
					}
				}
				
				Spacer()
			}
			.foregroundColor(.white)
			.font(.largeTitle)
			.padding()
			
			if differentiateWithoutColor || voiceOverEnabled {
				VStack {
					Spacer()
					HStack {
						AccessibleCardActionButton(
							accessibleLabel: "Wrong",
							accessibleHint: "Mark your answer as being incorrect.",
							imageSystemName: "xmark.circle"
						) {
							model.removeCard(at: model.cards.count - 1)
						}
						
						Spacer()
						
						AccessibleCardActionButton(
							accessibleLabel: "Correct",
							accessibleHint: "Mark your answer as being correct.",
							imageSystemName: "checkmark.circle"
						) {
							model.removeCard(at: model.cards.count - 1)
						}
					}
				}
				.foregroundColor(.white)
				.font(.largeTitle)
				.padding()
			}
			
		}
		.onReceive(timer) { time in
			guard isActive else { return }
			
			if timeRemaining > 0 {
				timeRemaining -= 1
			}
		}
		.onChange(of: scenePhase) { newPhase in
			if newPhase == .active {
				if model.cards.isEmpty == false {
					isActive = true
				}
			} else {
				isActive = false
			}
		}
		.sheet(isPresented: $showingEditScreen) {
			EditCardsView()
		}
	}
		
		func resetCards() {
			model.resetCards()
			timeRemaining = 100
			isActive = true
		}
}

	struct StackOfCardsView_Previews: PreviewProvider {
		static var previews: some View {
			StackOfCardsView()
		}
	}
