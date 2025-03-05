//
//  WeatherState.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 03.03.2025.
//

import CoreLocation
import Foundation

class WeatherState: ObservableObject {
	@Published var currentLocation: CLLocation?
	@Published var weatherInfo: WeatherInfo?
	@Published var isLoading: Bool
	@Published var errorText: String?

	private var currentDayData: DayInfo? { weatherInfo?.currentWeatherData }

	init(
		currentLocation: CLLocation? = nil,
		weatherInfo: WeatherInfo? = nil,
		isLoading: Bool = true,
		errorText: String? = nil
	) {
		self.currentLocation = currentLocation
		self.weatherInfo = weatherInfo
		self.isLoading = isLoading
		self.errorText = errorText
	}

	var currentTimeString: String {
		let localizedToday: LocalizedStringResource = "Сегодня"
		let today = String(localized: localizedToday)

		guard let time = currentDayData?.time else { return "\(today)" }

		if Calendar.current.isDateInToday(time) {
			return "\(today), \(time.formatted(date: .omitted, time: .shortened))"
		}

		return "\(time.formatted(.dateTime.day().month().hour().minute()))"
	}

	var icon: String { currentDayData?.weatherType.iconName ?? "cloud.fill" }
	var temperature: String { currentDayData?.temperatureString ?? "" }
	var weatherType: LocalizedStringResource { (currentDayData?.weatherType ?? .overcast).title }
	var pressure: String { currentDayData?.pressureDescription ?? "" }
	var humidity: String { currentDayData?.humidityDescription ?? "" }
	var windSpeed: String { currentDayData?.windSpeedDescription ?? "" }

	var forecastByDay: [[DayInfo]] {
		weatherInfo?.weatherDataPerDay.map { $0.value } ?? []
	}


	// MARK: - Examples
	static let example = {
		let date = Date.now
		let today = DayInfo(
			time: date,
			temperature: 31.7,
			pressure: 1014,
			windSpeed: 14,
			humidity: 30,
			weatherType: .overcast
		)

		let calendar = Calendar.current
		var days = [Int: [DayInfo]]()

		for offset in 0...23 {
			let newDate = calendar.date(bySettingHour: offset, minute: 0, second: 0, of: date)

			let day = DayInfo(
				time: newDate!,
				temperature: Double.random(in: 20...30),
				pressure: 1000,
				windSpeed: 25,
				humidity: 30,
				weatherType: .allCases[offset % WeatherType.allCases.count]
			)

			let todayDay = calendar.component(.day, from: date)
			let newDateDay = calendar.component(.day, from: newDate!)

			days[newDateDay - todayDay, default: []].append(day)
		}

		return WeatherState(
			weatherInfo: WeatherInfo(
				weatherDataPerDay: days,
				currentWeatherData: today
			)
		)
	}()
}
