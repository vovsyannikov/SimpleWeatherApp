//
//  WeatherResponse.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import Foundation

struct WeatherResponse: Decodable {
	enum CodingKeys: CodingKey {
		case hourly
	}

	let weatherData: WeatherData

	init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		weatherData = try container.decode(forKey: .hourly)
	}
}
