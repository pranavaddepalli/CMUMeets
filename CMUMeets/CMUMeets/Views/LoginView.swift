//
//  LoginView.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 11/17/22.
//

import Foundation
import SwiftUI
import Combine
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct LoginView: View {
    @ObservedObject var firebase: Firebase = Firebase()
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var goToMain: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray.brightness(0.4))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                Button(action: {
                    if isUser() {
                        storeUser()
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                NavigationLink(destination: MainPageView(firebase: firebase).navigationBarBackButtonHidden(true), isActive: $goToMain) {}

                NavigationLink(destination: NewUserView(firebase: firebase)) {
                    Text("Register")
                }
            }
        }
        .onAppear(perform: getUsers )
        
    }
    
    private func getUsers() {
        firebase.updatedUsers()
    }
    
    
    private func getNameAndUsername() -> [String: String] {
        var userRepo = firebase.users
        var nameList: [usersName] = []
        var usernameList: [usersUserame] = []
        var userToNameDict: [String:String] = [:]
        
        for (x, y) in userRepo {
            for (x2, y2) in y {
                if x2 == "name" {
                    nameList.append(usersName(name: y2 as! String))
                }
                if x2 == "username" {
                    usernameList.append(usersUserame(username: y2 as! String))
                }
            }
        }
        
        for (index, element) in nameList.enumerated() {
            userToNameDict[element.name] = usernameList[index].username
        }
        return userToNameDict
    }
    
    private func isUser() -> Bool {
        var usersDict = getNameAndUsername()
        if usersDict.keys.contains(name) {
            if usersDict[name] == username {
                goToMain = true
            }
        }
        return goToMain
    }
    
    func storeUser() {
        let db = Firestore.firestore()

        db.collection("users").whereField("username", isEqualTo: username)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        //print("\(document.documentID) => \(document.data())")
                        self.firebase.currentUser = User(id: document.documentID,
                                                          name: document["name"] as? String ?? "",
                                                          phone: document["phone"] as? String ?? "",
                                                          major: document["major"] as? String ?? "",
                                                          gradYear: document["gradYear"] as? String ?? "",
                                                          age: document["age"] as? String ?? "",
                                                          gender: document["gender"] as? String ?? "",
                                                          pronouns: document["pronouns"] as? String ?? "",
                                                          ethnicity: document["ethnicity"] as? String ?? "",
                                                          username: document["username"] as? String ?? ""
                        )
                        print(firebase.currentUser)
                      
                    }
                }
        }
    }
    
    
}

class usersUserame {
    let username: String
    
    init(username: String) {
        self.username = username
    }
}

class usersName {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
