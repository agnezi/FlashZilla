////
// FlashZilla
// Created by: itsjagnezi on 23/02/23
// Copyright (c) today and beyond
//

import SwiftUI

extension View {
	func stacked(at position: Int, in total: Int) -> some View {
		let offset = Double(total - position)
		return self.offset(x: 0, y: offset * 10)
	}
}
