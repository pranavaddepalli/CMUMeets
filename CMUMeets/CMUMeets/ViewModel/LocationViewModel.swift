//
//  LocationViewModel.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject, Identifiable {

  private let locationRepository = LocationsRepository()
  @Published var location: LocationModel
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(location: LocationModel) {
    self.location = location
    $location
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(location: LocationModel) {
    locationRepository.update(location)
  }

  func remove() {
    locationRepository.remove(location)
  }
}
