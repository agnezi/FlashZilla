////
// FlashZilla
// Created by: itsjagnezi on 19/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct DisablingUserInteractivityView: View {
    var body: some View {
			VStack {
				Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
				
				Spacer()
					.frame(width: 300, height: 200)
			
				Text("Hello")
			}
			.contentShape(Rectangle())
			.onTapGesture {
				print("VStack tapped")
			}
			.allowsHitTesting(false)
    }
}

struct DisablingUserInteractivityView_Previews: PreviewProvider {
    static var previews: some View {
        DisablingUserInteractivityView()
    }
}
