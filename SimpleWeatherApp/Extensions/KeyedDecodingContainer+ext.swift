//
//  KeyedDecodingContainer+ext.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import Foundation

extension KeyedDecodingContainer {
	func decode<T: Decodable>(forKey key: Key) throws -> T {
		try decode(T.self, forKey: key)
	}
}
