////
////  LoginViewModel.swift
////  CMUMeets
////
////  Created by Isaac Ahn on 11/17/22.
////
//
//import Foundation
//import Combine
//
//class LoginViewModel {
//    @ObservedObject var viewController: ViewController = ViewController()
//
//    @Published var username: String = ""
//    @Published private var name: String = ""
//    @Published private var goToMain: Bool = false
//    
//
//
//    private func getUsers() -> [String: Dictionary<String, Any>] {
//        viewController.readUsers()
//        return viewController.users
//    }
//
//
//    private func getNameAndUsername() -> [String: String] {
//        getUsers()
//        var userRepo = viewController.users
//        var nameList: [usersName] = []
//        var usernameList: [usersUserame] = []
//        var userToNameDict: [String:String] = [:]
//
//        for (x, y) in userRepo {
//            for (x2, y2) in y {
//                if x2 == "name" {
//                    nameList.append(usersName(name: y2 as! String))
//                }
//                if x2 == "username" {
//                    usernameList.append(usersUserame(username: y2 as! String))
//                }
//            }
//        }
//
//        for (index, element) in nameList.enumerated() {
//            userToNameDict[element.name] = usernameList[index].username
//        }
//        return userToNameDict
//    }
//
//    private func isUser() -> Bool {
//        var usersDict = getNameAndUsername()
//        if usersDict.keys.contains(name) {
//            if usersDict[name] == username {
//                goToMain = true
//            }
//        }
//        return goToMain
//    }
//
////    func storeUser() {
////        let store = Firestore.firestore()
////        let path: String = "users"
////        store.collection(path).whereField("username", isEqualTo: username)
////            .getDocuments() { (querySnapshot, err) in
////                if let err = err {
////                    print("Error getting documents: \(err)")
////                } else {
////                    for document in querySnapshot!.documents {
////                        print("\(document.documentID) => \(document.data())")
////                        var currentUser = User(id: document.documentID,
////                                                                 name: document["name"] as! String,
////                                                                 phone: document["phone"] as! String,
////                                                                 major: document["major"] as! String,
////                                                                 gradYear: document["gradYear"] as! Int,
////                                                                 age: document["age"] as! Int,
////                                                                 gender: document["gender"] as! String,
////                                                                 pronouns: document["pronouns"] as! String,
////                                                                 ethnicity: document["ethnicity"] as! String,
////                                                                 username: document["username"] as! String
////                        )
////                        print(currentUser)
////                    }
////                }
////            }
////    }
//
//
//}
//
//class usersUserame {
//    let username: String
//
//    init(username: String) {
//        self.username = username
//    }
//}
//
//class usersName {
//    let name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//}
