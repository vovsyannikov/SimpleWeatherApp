//
//  DayInfo.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import SwiftUI

struct DayInfo: Codable, Identifiable {
	var id = UUID().uuidString

	let time: Date
	let temperature: Double
	let pressure: Double
	let windSpeed: Double
	let humidity: Double
	let weatherType: WeatherType

	// UI friendly values
	var currentTime: String { time.formatted(.dateTime.hour().minute()) }
	var temperatureString: String { "\(rounded(temperature))" + "˚C" }
	var pressureDescription: String { "\(rounded(pressure)) " + String(localized: LocalizedStringResource("гПа")) }
	var humidityDescription: String { "\(rounded(humidity)) %" }
	var windSpeedDescription: String { "\(rounded(windSpeed))" + String(localized: LocalizedStringResource("км/ч")) }

	private func rounded(_ value: Double) -> Int {
		Int(value.rounded())
	}
}
