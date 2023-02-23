////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct TimerText: View {
	var timeRemaining: Int
	
    var body: some View {
			Text("Time: \(timeRemaining)")
				.font(.largeTitle)
				.foregroundColor(.white)
				.padding(.horizontal, 20)
				.padding(.vertical, 5)
				.background(.black.opacity(0.75))
				.clipShape(Capsule())
    }
}

struct TimerText_Previews: PreviewProvider {
    static var previews: some View {
			TimerText(timeRemaining: 99)
    }
}
