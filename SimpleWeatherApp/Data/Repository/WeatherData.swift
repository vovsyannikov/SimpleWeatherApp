//
//  WeatherData.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import Foundation

struct WeatherData: Decodable {
	enum CodingKeys: CodingKey {
		case time
		case temperature_2m
		case weathercode
		case pressure_msl
		case windspeed_10m
		case relativehumidity_2m
	}

	let times: [Date]
	let temperatures: [Double]
	let weatherTypes: [WeatherType]
	let pressures: [Double]
	let windSpeeds: [Double]
	let humidities: [Double]

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		times = try container.decode(forKey: .time)
		temperatures = try container.decode(forKey: .temperature_2m)
		weatherTypes = try container.decode([Int].self, forKey: .weathercode).map { WeatherType(rawValue: $0) ?? .clearSky }
		pressures = try container.decode(forKey: .pressure_msl)
		windSpeeds = try container.decode(forKey: .windspeed_10m)
		humidities = try container.decode(forKey: .relativehumidity_2m)
	}

	func toDayInfoDictionary() -> [Int: [DayInfo]] {
		var result: [Int: [DayInfo]] = [:]

		times.enumerated().forEach { index, time in
			let temperature = temperatures[index]
			let pressure = pressures[index]
			let windSpeed = windSpeeds[index]
			let humidity = humidities[index]
			let weatherType = weatherTypes[index]

			let index = index / 24
			let dayInfo = DayInfo(
				time: time,
				temperature: temperature,
				pressure: pressure,
				windSpeed: windSpeed,
				humidity: humidity,
				weatherType: weatherType
			)

			result[index, default: []].append(dayInfo)
		}

		return result
	}

	func toWeatherInfo() -> WeatherInfo {
		let dayInfos = toDayInfoDictionary()
		let today = Date.now

		let calendar = Calendar.current
		let currentDayComponents = calendar.dateComponents([.hour, .minute], from: today)
		let currentHour = currentDayComponents.hour ?? 0
		let currentMinute = currentDayComponents.minute ?? 0

		let currentDayInfo = dayInfos[0]?.first { data in
			let hour = calendar.component(.hour, from: data.time)

			return currentMinute < 30 ? hour == currentHour : hour + 1 == currentHour
		}

		return WeatherInfo(weatherDataPerDay: dayInfos, currentWeatherData: currentDayInfo)
	}
}
