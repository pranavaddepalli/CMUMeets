//
//  MeetsLibraryViewModel.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 12/2/22.
//

import Foundation
import Combine

class MeetsLibraryViewModel: ObservableObject {
  @Published var meetViewModels: [MeetViewModel] = []
  private var cancellables: Set<AnyCancellable> = []

  @Published var meetsRepository = MeetsRepository()
  @Published var library: [Meet] = []
    
  @Published var usersRepository = UsersRepository()
  @Published var userLibrary: [User] = []
    
  init() {
    meetsRepository.$meets.map { meets in
      meets.map(MeetViewModel.init)
    }
    .assign(to: \.meetViewModels, on: self)
    .store(in: &cancellables)
      
    getUsers()
  }

  func add(_ meet: Meet) {
    meetsRepository.add(meet)
  }
    
  func getUsers() {
    userLibrary = usersRepository.users
    //print(usersRepository.printUsers())
      print(meetsRepository.meets)
  }
    
}
