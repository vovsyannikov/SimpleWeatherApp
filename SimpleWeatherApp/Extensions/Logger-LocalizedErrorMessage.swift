//
//  Logger-LocalizedErrorMessage.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 04.03.2025.
//

import Foundation
import OSLog

extension Logger {
	public func error(_ error: Error) {
		self.error("\(error.localizedDescription)")
	}
}
