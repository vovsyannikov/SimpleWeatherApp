//
//  ContentView.swift
//  SimpleWeatherApp
//
//  Created by Виталий Овсянников on 28.02.2025.
//

import CoreLocation
import SwiftUI

struct ContentView: View {
	@ObservedObject var viewModel: ViewModel
	@State private var isLaunching = false

	var weatherState: WeatherState { viewModel.weatherState }

	private let errorIcon = "exclamationmark.circle.fill"
	private let errorTitle: LocalizedStringResource = "Произошла ошибка"

	init(viewModel: ViewModel) {
		self.viewModel = viewModel

		UINavigationBar
			.appearance()
			.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
	}

	var body: some View {
		NavigationStack {
			Group {
				if isLaunching {
					LaunchView()
				} else if viewModel.showError {
					errorView
				} else {
					content
				}
			}
			.background(
				LinearGradient(
					stops: [
						.init(color: .background, location: 0.25),
						.init(color: .background.opacity(0.5), location: 1)
					],
					startPoint: .topLeading,
					endPoint: .bottomTrailing
				)
			)
			.onAppear {
				Task {
					try await Task.sleep(for: .seconds(0.5))
					withAnimation {
						isLaunching = false
					}
				}
			}
		}
	}

	@ViewBuilder
	private var errorView: some View {
		if #available(iOS 17, *) {
			newErrorView
		} else {
			VStack {
				Image(systemName: errorIcon)
					.resizable()
					.scaledToFit()
					.foregroundStyle(.red)
					.frame(height: 50)
					.padding(.bottom, 10)

				Text(errorTitle)
					.font(.title2)
					.bold()

				Text(weatherState.errorText ?? "")
					.font(.subheadline)
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.foregroundStyle(.white)
		}
	}

	@available(iOS 17, *)
	private var newErrorView: some View {
		ContentUnavailableView(
			String(localized: errorTitle),
			systemImage: errorIcon,
			description: Text(weatherState.errorText ?? "")
		)
		.foregroundStyle(.white, .red)
	}

	@ViewBuilder
	private var content: some View {
		let placeholderReason = weatherState.isLoading ? .placeholder : RedactionReasons(rawValue: 0)

		ScrollView {
			VStack {
				WeatherCard(state: weatherState)
					.redacted(reason: placeholderReason)
					.animation(.default, value: weatherState.isLoading)

				if !viewModel.isLoading {
					ForecastView(forecastValues: weatherState.forecastByDay.first ?? [])
						.foregroundStyle(.white)
				}
			}
		}
		.navigationTitle(viewModel.currentLocation)
		.onAppear(perform: viewModel.loadWeatherInfo)
	}
}

#Preview {
	ContentView(viewModel: .errorExample)
}
