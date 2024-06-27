//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Eliran Sharabi on 25/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("isFirstRun") private var isFirstRun = true
    @Environment(\.modelContext) private var modelContext
    @Query private var people: [Person]
    @State private var navigationPath: NavigationPath = .init()
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            PeopleView(searchString: searchQuery,
                       navigationPath: $navigationPath)
            .toolbar {
                ToolbarItem {
                    Button("Add Person",
                           systemImage: "plus",
                           action: addPerson)
                }
                
                ToolbarItem {
                
                    NavigationLink {
                        TeamsView()
                    } label: {
                        Label("Teams",
                        systemImage: "soccerball.inverse")
                    }
                }
                
                ToolbarItem {
                    EditButton()
                }
            }
            .navigationDestination(for: Person.self) {
                EditPersonView(person: $0,
                               navigationPath: $navigationPath)
            }
            .navigationTitle("Persons")
            .searchable(text: $searchQuery)
            .autocorrectionDisabled()
        }
        .onAppear() {
            saveTeams()
    
        }
    }
    
    func saveTeams() {
        guard isFirstRun else {
            return
        }
        
        isFirstRun.toggle()
        
        Team.mock.forEach {
            modelContext.insert($0)
        }
    }
}

private extension ContentView {
    
    func addPerson() {
        let person: Person = .init()
        modelContext.insert(person)
        navigationPath.append(person)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self, inMemory: true)
}
