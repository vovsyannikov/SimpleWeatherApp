//
//  DayInfo.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import SwiftUI

struct DayInfo: Codable, Identifiable {
	private(set) var id = UUID().uuidString

	let time: Date
	let temperature: Double
	let pressure: Double
	let windSpeed: Double
	let humidity: Double
	let weatherType: WeatherType

	// UI friendly values
	var currentTime: String { time.formatted(.dateTime.hour().minute()) }
	var temperatureString: String { "\(rounded(temperature)) ˚C" }
	var pressureDescription: LocalizedStringResource { "\(rounded(pressure)) гПа" }
	var humidityDescription: LocalizedStringResource { "\(rounded(humidity)) %" }
	var windSpeedDescription: LocalizedStringResource { "\(rounded(windSpeed)) км/ч" }

	private func rounded(_ value: Double) -> Int {
		Int(value.rounded())
	}
}
