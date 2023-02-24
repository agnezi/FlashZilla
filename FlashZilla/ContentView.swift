////
// FlashZilla
// Created by: itsjagnezi on 16/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct ContentView: View {
	
	@StateObject var model = CardsViewModel()
	
	var body: some View {
		StackOfCardsView()
			.environmentObject(model)
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
