//
//  NewUserView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/9/22.
//

import SwiftUI
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift


struct NewUserView: View {
    
    @State private var name: String = ""
    @State private var phone: String = ""
    @State private var major: String = ""
    @State private var gradYear: String = ""
    @State private var age: String = ""
    @State private var gender: String = ""
    @State private var pronouns: String = ""
    @State private var ethnicity: String = ""
    @State private var username: String = ""
    
    var body: some View {
        VStack {
            Text("New User")
                .font(.title)
                .fontWeight(.bold)
            Form {
                TextField("Username", text: $username)
                TextField("Name: ", text: $name)
                TextField("Phone Number: ", text: $phone)
                TextField("Major: ", text: $major)
                TextField("Graduation Year: ", text: $gradYear)
                    .keyboardType(.numberPad)
                    .onReceive(Just(gradYear)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.gradYear = filtered
                        }
                    }
                TextField("Age: ", text: $age)
                    .keyboardType(.numberPad)
                    .onReceive(Just(age)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.age = filtered
                        }
                    }
                Picker(selection: $gender,
                       label: Text("Gender: ")) {
                  ForEach(Gender.allGenders, id: \.self) { gender in
                       Text(gender).tag(gender)
                    }
                  }
                Picker(selection: $pronouns,
                       label: Text("Pronouns: ")) {
                  ForEach(Pronouns.allPronouns, id: \.self) { pronoun in
                       Text(pronoun).tag(pronoun)
                    }
                  }
                Picker(selection: $ethnicity,
                       label: Text("Ethnicity: ")) {
                  ForEach(Ethnicity.allEthnicities, id: \.self) { ethnicity in
                       Text(ethnicity).tag(ethnicity)
                    }
                  }
                
                if self.isValidUser() {
                    Button("Add User") {
                        addUser()
                        clearFields()
                    }
                }
            }
        }
    }
    
    private func isValidUser() -> Bool {
      if name.isEmpty { return false }
      if phone.isEmpty || phone.count < 10 { return false }
      if major.isEmpty { return false }
      if gradYear.isEmpty { return false }
      if age.isEmpty || age < "18" { return false }
      if gender.isEmpty { return false }
      if pronouns.isEmpty { return false }
      if ethnicity.isEmpty { return false }
      if username.isEmpty { return false }
      return true
    }

    private func clearFields() {
      name = ""
      phone = ""
      major = ""
      gradYear = ""
      age = ""
      gender = ""
      pronouns = ""
      ethnicity = ""
    }
    
    private func addUser() {
//      let user = User(name: name, phone: phone, major: major, gradYear: gradYear, age: age, gender: gender, pronouns: pronouns, ethnicity: ethnicity)
        let db = Firestore.firestore()
        let path = db.collection("users").document(UUID().uuidString + "IsaacTest")
        let newUser: [String: Any] = [
            "name": name,
            "phone": phone,
            "major": major,
            "gradYear": gradYear,
            "age": age,
            "gender": gender,
            "pronouns": pronouns,
            "ethnicity": ethnicity,
            "username": username
        ]
        path.setData(newUser) { error in
            if let error = error {
                print("Error writing document: \(error)")
            }
            else {
                print("Document successfully written!")
            }
        }
    }
}



struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
    }
}
