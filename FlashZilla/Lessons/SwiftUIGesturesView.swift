////
// FlashZilla
// Created by: itsjagnezi on 16/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct SwiftUIGesturesView: View {
	@State private var currentAmount = 0.0
	@State private var finalAmount = 1.0
	
	@State private var currentAngle = Angle.zero
	@State private var finalAngle = Angle.zero
	
	@State private var isDragging = false
	@State private var offset = CGSize.zero
	
	var body: some View {
		
		let dragGesture = DragGesture()
			.onChanged { value in offset = value.translation }
			.onEnded {_ in
				withAnimation {
					isDragging = false
					offset = .zero
				}
			}
		
		let pressGesture = LongPressGesture()
			.onEnded { value in
				withAnimation{
					isDragging = true
				}
			}
		
		let combinedGestures = pressGesture.sequenced(before: dragGesture)
		
		
		VStack(spacing: 20) {
			
			Circle()
				.fill(
					LinearGradient(
						colors: [Color.blue, Color.red],
						startPoint: UnitPoint(x: 0,y: 0),
						endPoint: UnitPoint(x: 1, y:1)
					)
				)
				.frame(width: 64, height: 64)
				.scaleEffect(isDragging ? 1.5 : 1.0)
				.offset(offset)
				.gesture(combinedGestures)
			
			Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
				.scaleEffect(finalAmount + currentAmount)
				.gesture(
					MagnificationGesture()
						.onChanged { amount in
							currentAmount = amount - 1
						}
						.onEnded { amount in
							finalAmount += currentAmount
							currentAmount = 0
						}
				)
			
			Text("Hello rotate")
			
				.rotationEffect(currentAngle + finalAngle)
				.gesture(
					RotationGesture()
						.onChanged { angle in
							currentAngle = angle
						}
						.onEnded {angle in
							finalAngle += currentAngle
							currentAngle = .zero
						}
				)
		}
		.font(.largeTitle)
	}
}

struct SwiftUIGesturesView_Previews: PreviewProvider {
	static var previews: some View {
		SwiftUIGesturesView()
	}
}
