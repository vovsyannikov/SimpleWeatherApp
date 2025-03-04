//
//  SimpleWeatherAppApp.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import SwiftUI

@main
struct SimpleWeatherAppApp: App {
	private let weatherRepository: WeatherRepository = WeatherFetchManager.shared
	private let locationTracker: LocationTracker = WeatherLocationTracker()

    var body: some Scene {
        WindowGroup {
			ContentView(viewModel: .init(repository: weatherRepository,
										 locationTracker: locationTracker))
        }
    }
}
