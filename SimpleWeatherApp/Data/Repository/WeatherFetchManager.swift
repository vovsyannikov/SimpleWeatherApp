//
//  WeatherFetchManager.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import CoreLocation
import Foundation

class WeatherFetchManager: WeatherRepository {
	static let shared = WeatherFetchManager()

	private init() {}

	private var weatherComponentsItem: URLQueryItem {
		let temperature = "temperature_2m"
		let weatherCode = "weathercode"
		let relativeHumidity = "relativehumidity_2m"
		let windSpeed = "windspeed_10m"
		let pressure = "pressure_msl"

		let values = [temperature, weatherCode, relativeHumidity, windSpeed, pressure].joined(separator: ",")

		return URLQueryItem(name: "hourly", value: values)
	}

	private let weatherEndpoint = {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "api.open-meteo.com"
		urlComponents.path = "/v1/forecast"

		return urlComponents
	}()

	func getWeatherData(for coordinates: CLLocation) async throws -> WeatherInfo {
		var urlComponents = weatherEndpoint
		urlComponents.queryItems = coordinates.asQueryItem
		urlComponents.queryItems?.append(weatherComponentsItem)

		guard let url = urlComponents.url else { throw URLError(.badURL) }

		let (data, response) = try await URLSession.shared.data(from: url)

		guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode
		else { throw URLError(.badServerResponse) }

		let dateFormater = DateFormatter()
		dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm"

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(dateFormater)

		let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)

		return weatherResponse.weatherData.toWeatherInfo()
	}
}
