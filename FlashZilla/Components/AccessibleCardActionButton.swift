////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import SwiftUI

struct AccessibleCardActionButton: View {
	
	let accessibleLabel: String
	let accessibleHint: String
	let imageSystemName: String
	let removeCardAction: () -> Void
	
    var body: some View {
			Button {
				withAnimation {
					removeCardAction()
				}
			} label: {
				Image(systemName: imageSystemName)
					.padding()
					.background(.black.opacity(0.7))
					.clipShape(Circle())
			}
			.accessibilityLabel(accessibleLabel)
			.accessibilityHint(accessibleHint)
    }
}

struct AccessibleCardActionButton_Previews: PreviewProvider {
    static var previews: some View {
        AccessibleCardActionButton(
					accessibleLabel: "Wrong",
					accessibleHint: "Mark your answer as being incorrect.",
					imageSystemName: "xmark.circle", removeCardAction: {}
				)
    }
}
