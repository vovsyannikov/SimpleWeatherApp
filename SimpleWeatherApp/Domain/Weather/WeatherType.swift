//
//  WetherType.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import SwiftUI

enum WeatherType: Int, CaseIterable, Codable {
	case clearSky = 				0
	case mainlyClear = 				1
	case partlyCloudy = 			2
	case overcast = 				3
	case foggy = 					45
	case depositingRimeFog = 		48
	case lightDrizzle = 			51
	case moderateDrizzle = 			53
	case denseDrizzle = 			55
	case lightFreezingDrizzle = 	56
	case denseFreezingDrizzle = 	57
	case slightRain = 				61
	case moderateRain = 			63
	case heavyRain = 				65
	case lightFreezingRain = 		66
	case heavyFreezingRain = 		67
	case slightSnowFall = 			71
	case moderateSnowFall = 		73
	case heavySnowFall = 			75
	case snowGrains = 				77
	case slightRainShowers = 		80
	case moderateRainShowers = 		81
	case violentRainShowers = 		82
	case slightSnowShowers = 		85
	case heavySnowShowers = 		86
	case moderateThunderstorm = 	95
	case slightHailThunderstorm = 	96
	case heavyHailThunderstorm = 	99

	var title: LocalizedStringResource {
		switch self {
		case .clearSky: 				"Clear sky"
		case .mainlyClear: 				"Mainly clear"
		case .partlyCloudy: 			"Partly cloudy"
		case .overcast: 				"Overcast"
		case .foggy: 					"Foggy"
		case .depositingRimeFog: 		"Depositing rime fog"
		case .lightDrizzle: 			"Light drizzle"
		case .moderateDrizzle: 			"Drizzle"
		case .denseDrizzle: 			"Dense drizzle"
		case .lightFreezingDrizzle: 	"Light freezing drizzle"
		case .denseFreezingDrizzle: 	"Dense freezing drizzle"
		case .slightRain: 				"Slight rain"
		case .moderateRain: 			"Rainy"
		case .heavyRain: 				"Heavy rain"
		case .lightFreezingRain: 		"Light freezing rain"
		case .heavyFreezingRain: 		"Heavy freezing rain"
		case .slightSnowFall: 			"Slight snow fall"
		case .moderateSnowFall: 		"Snow fall"
		case .heavySnowFall: 			"Heavy snow fall"
		case .snowGrains: 				"Snow grains"
		case .slightRainShowers: 		"Slight rain showers"
		case .moderateRainShowers: 		"Moderate rain showers"
		case .violentRainShowers: 		"Violent rain showers"
		case .slightSnowShowers: 		"Slight snow showers"
		case .heavySnowShowers: 		"Heavy snow showers"
		case .moderateThunderstorm: 	"Thunderstorm"
		case .slightHailThunderstorm: 	"Thunderstorm with slight hail"
		case .heavyHailThunderstorm: 	"Thunderstorm with heavy hail"
		}
	}

	var iconName: String {
		switch self {
		case .clearSky: 					"sun.max.fill"
		case .mainlyClear, 
				.partlyCloudy: 				"cloud.sun.fill"
		case .overcast: 					"cloud.fill"
		case .foggy: 						"cloud.fog.fill"
		case .depositingRimeFog: 			"smoke.fill"
		case .lightDrizzle,
				.moderateDrizzle,
				.denseDrizzle: 				"cloud.drizzle.fill"
		case .lightFreezingDrizzle,
				.denseFreezingDrizzle: 		"cloud.sleet.fill"
		case .slightRain, 
				.moderateRain: 				"cloud.rain.fill"
		case .heavyRain: 					"cloud.heavyrain.fill"
		case .lightFreezingRain,
				.heavyFreezingRain: 		"cloud.hail.fill"
		case .slightSnowFall,
				.moderateSnowFall,
				.heavySnowFall: 			"cloud.snow.fill"
		case .snowGrains: 					"snowflake"
		case .slightRainShowers: 			"cloud.rain.fill"
		case .moderateRainShowers,
				.violentRainShowers: 		"cloud.heavyrain.fill"
		case .slightSnowShowers,
				.heavySnowShowers: 			"cloud.snow.fill"
		case .moderateThunderstorm: 		"cloud.bolt.fill"
		case .slightHailThunderstorm,
				.heavyHailThunderstorm: 	"cloud.bolt.rain.fill"
		}
	}
}

#Preview("Weather type preview") {
	ScrollView {
		VStack(alignment: .leading) {
			ForEach(WeatherType.allCases, id: \.rawValue) { type in
				HStack {
					Image(systemName: type.iconName)
						.symbolRenderingMode(.multicolor)
						.font(.largeTitle)

					Text(type.title)
				}
			}
		}
		.padding(.vertical)
		.frame(maxWidth: .infinity)
		.background(
			RoundedRectangle(cornerRadius: 25)
				.foregroundStyle(.secondary)
		)
		.padding(16)
	}
}
