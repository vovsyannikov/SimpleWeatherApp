//
//  WeatherInfo.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import SwiftUI

struct WeatherInfo {
	let weatherDataPerDay: [Int: [DayInfo]]
	let currentWeatherData: DayInfo?
}
