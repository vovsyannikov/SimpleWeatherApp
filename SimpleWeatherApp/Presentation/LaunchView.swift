//
//  LaunchView.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 04.03.2025.
//

import SwiftUI

struct LaunchView: View {
	@State private var isGradient = false

	var body: some View {
		ZStack {
			LinearGradient(
				stops:
					[
						.init(color: .background, location: 0),
						.init(color: .background.opacity(isGradient ? 0.5 : 1), location: 1)
					],
				startPoint: .topLeading,
				endPoint: .bottomTrailing
			)

			Image(.iconBorderless)
				.transition(.opacity)
		}
		.ignoresSafeArea()
		.onAppear {
			withAnimation {
				isGradient = true
			}
		}
    }
}

#Preview {
    LaunchView()
}
