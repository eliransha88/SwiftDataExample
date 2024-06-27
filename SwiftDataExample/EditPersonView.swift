//
//  EditPersonView.swift
//  SwiftDataExample
//
//  Created by Eliran Sharabi on 26/06/2024.
//

import SwiftUI
import SwiftData

struct EditPersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var teams: [Team]
    @Bindable var person: Person
    @Binding var navigationPath: NavigationPath
    
    var body: some View {
        List {
            Section {
                TextField("Name", text: $person.name)
                    .textContentType(.name)
                
                TextField("Email address", text: $person.email)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }
            
            Section("Your favorite football team?") {
                Picker("Fan of", selection: $person.team) {
                    Text("Unknown team")
                        .tag(Optional<Team>.none)
                    
                    if teams.isEmpty == false {
                        Divider()
                        
                        ForEach(teams) { team in
                            Text(team.name)
                                .tag(Optional(team))
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    validatePerson()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                }
            }
        }
        .navigationTitle(person.name)
    }
    
    
    func validatePerson() {
        if person.name.isEmpty {
            modelContext.delete(person)
        }
        navigationPath.removeLast()
    }
}
