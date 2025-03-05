//
//  WeatherViewModel.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 03.03.2025.
//

import Combine
import CoreLocation
import OSLog
import SwiftUI

extension ContentView {

	@MainActor
	class ViewModel: ObservableObject {
		static let logger = Logger(subsystem: "com.t3rr4.SimpleWeatherApp", category: "ContentView-ViewModel")

		@Published var showError: Bool = false
		var isLoading: Bool {
			get { weatherState.isLoading }
			set { weatherState.isLoading = newValue }
		}
		private let noLocationString = String(localized: LocalizedStringResource("Обновляем…"))
		@Published var currentLocation: String

		private let repository: WeatherRepository
		private let locationTracker: LocationTracker

		private(set) var weatherState = WeatherState()

		private var cancellables = Set<AnyCancellable>()

		init(repository: WeatherRepository, locationTracker: LocationTracker) {
			self.repository = repository
			self.locationTracker = locationTracker
			self.currentLocation = noLocationString
		}

		func loadWeatherInfo() {
			weatherState.isLoading = true

			locationTracker.getCurrentLocation()
				.retry(3)
				.throttle(for: 0.5, scheduler: RunLoop.main, latest: true)
				.sink(
					receiveCompletion: { [weak self] completion in
						switch completion {
						case .failure(let error):
							Self.logger.error(error)
							self?.weatherState.errorText = error.localizedDescription
							self?.isLoading = false
						case .finished:
							Self.logger.info("Successfully finished")
						}
					},
					receiveValue: updateLocation
				)
				.store(in: &cancellables)
		}

		func updateLocation(with location: CLLocation) {
			self.weatherState.currentLocation = location
			fetchWeather(for: location)
		}

		func fetchWeather(for location: CLLocation? = nil) {
			guard let location = location ?? weatherState.currentLocation else { return }

			Task {
				do {
					let data = try await repository.getWeatherData(for: location)
					self.weatherState.weatherInfo = data

					let geoCoder = CLGeocoder()
					let placemarks = try await geoCoder.reverseGeocodeLocation(location)

					currentLocation = placemarks.first?.locality ?? noLocationString
				} catch {
					weatherState.errorText = error.localizedDescription
					Self.logger.error(error)
				}

				weatherState.isLoading = false
			}
		}

		static let example = ViewModel(repository: WeatherFetchManager.shared,
									   locationTracker: WeatherLocationTracker())

		static let errorExample = {
			let viewModel = ViewModel(repository: ErrorWeatherRepository(),
									  locationTracker: ErrorLocationTracker())

			viewModel.showError = true
			viewModel.weatherState.errorText = "Example Error"

			return viewModel
		}()
	}
}
