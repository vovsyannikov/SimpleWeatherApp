//
//  LocationTracker.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import Combine
import CoreLocation
import Foundation
import OSLog

class WeatherLocationTracker: NSObject, LocationTracker, ObservableObject {
	static let logger = Logger(subsystem: "com.t3rr4.SimpleWeatherApp", category: "LocationTracker")

	private let manager = CLLocationManager()
	private var currentLocationPublisher = PassthroughSubject<CLLocation, CLError>()

	override init() {
		super.init()

		manager.delegate = self

		do {
			try requestLocationTracking()
		} catch let error as CLError {
			currentLocationPublisher.send(completion: .failure(error))
		} catch {
			Self.logger.error(error)
		}
	}

	func getCurrentLocation() -> AnyPublisher<CLLocation, CLError> {
		manager.startUpdatingLocation()

		return currentLocationPublisher.eraseToAnyPublisher()
	}

	private func requestLocationTracking() throws {
		switch manager.authorizationStatus {
		case .authorizedAlways, .authorizedWhenInUse:
			break

		case .notDetermined:
			manager.requestWhenInUseAuthorization()
			manager.requestAlwaysAuthorization()

		default:
			let error = CLError(.denied)
			Self.logger.error(error)
			throw error
		}
	}
}

extension WeatherLocationTracker: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = manager.location else { return }

		currentLocationPublisher.send(location)
	}
}
