//
//  LocationTracker.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 01.03.2025.
//

import Combine
import CoreLocation
import Foundation

protocol LocationTracker {
	func getCurrentLocation() -> AnyPublisher<CLLocation, CLError>
}

/// LocationTracker used specifically to test error states of the UI
class ErrorLocationTracker: LocationTracker {
	func getCurrentLocation() -> AnyPublisher<CLLocation, CLError> {
		Future { promise in
			promise(.failure(CLError(.deferredFailed)))
		}
		.eraseToAnyPublisher()
	}
}
