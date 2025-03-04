//
//  WeatherRepository.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import CoreLocation
import Foundation

protocol WeatherRepository {
	func getWeatherData(for coordinates: CLLocation) async throws -> WeatherInfo
}

/// WeatherRepository specifically made to test error states of the UI
class ErrorWeatherRepository: WeatherRepository {
	func getWeatherData(for coordinates: CLLocation) async throws -> WeatherInfo {
		throw URLError(.cancelled)
	}
}
