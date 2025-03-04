//
//  WeatherCard.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 03.03.2025.
//

import SwiftUI

struct WeatherCard: View {
	@Environment(\.redactionReasons) var redactionReasons

	let state: WeatherState

    var body: some View {
		VStack(spacing: 20) {
			HStack {
				Spacer()
				Text(state.currentTimeString)
			}

			if redactionReasons.contains(.placeholder) {
				ProgressView()
					.progressViewStyle(.circular)
			} else {
				Image(systemName: state.icon)
					.resizable()
					.scaledToFit()
					.frame(maxWidth: 150)
					.aspectRatio(contentMode: .fit)
					.symbolRenderingMode(.multicolor)
			}

			Text(state.temperature)
				.font(.largeTitle)

			Text(state.weatherType)
				.font(.headline)

			HStack {
				subtitleView(image: "gauge", title: state.pressure)
				subtitleView(image: "drop", title: state.humidity)
				subtitleView(image: "wind", title: state.windSpeed)
			}
		}
		.padding()
		.background(.thinMaterial)
		.clipShape(.rect(cornerRadius: 20))
		.padding()
    }

	private func subtitleView(image: String, title: String) -> some View {
		HStack(spacing: 5) {
			Image(systemName: image)
			Text(title)
		}
		.frame(maxWidth: .infinity)
	}
}

#Preview {
	ScrollView {
		WeatherCard(state: .example)
			.redacted(reason: .placeholder)

		WeatherCard(state: .example)
	}
	.background(Color.blue.gradient)
	.preferredColorScheme(.dark)
}

#Preview("EN WeatherCard") {
	WeatherCard(state: .example)
		.background(Color.blue.gradient)
		.environment(\.locale, Locale(identifier: "en-EN"))
}
