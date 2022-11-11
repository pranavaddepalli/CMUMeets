//
//  MeetViewModel.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/7/22.
//

import Foundation
import Combine

class MeetViewModel: ObservableObject, Identifiable {

  private let meetsRepository = MeetsRepository()
  @Published var meet: Meet
    
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(meet: Meet) {
    self.meet = meet
    $meet
      .compactMap { $0.id }
      .assign(to: \.id, on: self)
      .store(in: &cancellables)
  }

  func update(meet: Meet) {
    meetsRepository.update(meet)
  }

  func remove() {
    meetsRepository.remove(meet)
  }
}
