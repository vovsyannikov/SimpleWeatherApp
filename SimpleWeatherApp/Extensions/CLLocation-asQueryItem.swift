//
//  Coordinates.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import CoreLocation
import Foundation

extension CLLocation {
	var asQueryItem: [URLQueryItem] {
		[
			URLQueryItem(name: "latitude", value: "\(coordinate.latitude)"),
			URLQueryItem(name: "longitude", value: "\(coordinate.longitude)")
		]
	}
}
