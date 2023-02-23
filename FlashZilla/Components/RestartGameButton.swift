////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct RestartGameButton: View {
	
	var reset: () -> Void
	
    var body: some View {
			Button("Start Again", action: reset)
				.padding()
				.background(.white)
				.foregroundColor(.black)
				.clipShape(Capsule())
    }
}

struct RestartGameButton_Previews: PreviewProvider {
    static var previews: some View {
			RestartGameButton(reset: {})
    }
}
