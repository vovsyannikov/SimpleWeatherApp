//
//  ForecastView.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 03.03.2025.
//

import SwiftUI

struct ForecastView: View {
	let forecastValues: [DayInfo]

	private let spacing = 16.0

	init(forecastValues: [DayInfo]) {
		let currentTime = Calendar.current.component(.hour, from: .now)
		self.forecastValues = Array(forecastValues.dropFirst(currentTime))
	}

    var body: some View {
		VStack(alignment: .leading, spacing: spacing) {
			Text("Сегодня")
				.padding(.leading, spacing)

			ScrollView(.horizontal, showsIndicators: false) {
				HStack(spacing: spacing) {
					ForEach(forecastValues) { dayInfo in
						dayView(for: dayInfo)
					}
				}
				.padding(.horizontal, spacing)
			}
			.fixedSize(horizontal: false, vertical: true)
		}
    }

	private func dayView(for day: DayInfo) -> some View {
		VStack(spacing: 15) {
			Text(day.currentTime)
				.fontWeight(.light)

			Image(systemName: day.weatherType.iconName)
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50, alignment: .top)
				.symbolRenderingMode(.multicolor)

			Text(day.temperatureString)
				.font(.headline)
		}
	}
}

#Preview {
	ZStack {
		Rectangle()
			.foregroundStyle(.blue.gradient)
			.ignoresSafeArea()

		ForecastView(forecastValues: WeatherState.example.forecastByDay[0])
	}
	.preferredColorScheme(.dark)
	.environment(\.locale, Locale.init(identifier: "en-EN"))
}
