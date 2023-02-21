////
// FlashZilla
// Created by: itsjagnezi on 20/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct CardView: View {
	@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
	
	let card: CardModel
	var removal: (() -> Void)? = nil
	
	@State private var isShowingAnswer = false
	@State private var offset = CGSize.zero
	
    var body: some View {
			ZStack {
				RoundedRectangle(cornerRadius: 25)
					.fill(
						differentiateWithoutColor
						?	.white
						: .white.opacity(1 - Double(abs(offset.width / 50)))
					)
					.background(
						differentiateWithoutColor
						? nil
						:	RoundedRectangle(cornerRadius: 25)
							.fill(offset.width > 0 ? .green : .red)
					)
					.shadow(radius: 10)
				
				VStack {
					Text(card.prompt)
						.font(.largeTitle)
						.foregroundColor(.black)
					
					if isShowingAnswer {
						
					Text(card.answer)
						.font(.title)
						.foregroundColor(.gray)
					}
				}
				.padding(20)
				.multilineTextAlignment(.center)
			}
			.frame(width: 450, height: 250)
			.rotationEffect(.degrees(Double(offset.width / 5)))
			.offset(x: offset.width * 5, y: 0)
			.opacity(2 - Double(abs(offset.width / 50)))
			.gesture(
				DragGesture()
					.onChanged { gesture in
						offset = gesture.translation
					}
					.onEnded { _ in
						if abs(offset.width) > 100 {
							removal?()
						} else {
							offset = .zero
						}
					}
			)
			.onTapGesture {
				isShowingAnswer.toggle()
			}
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
			CardView(card: CardModel.example)
    }
}