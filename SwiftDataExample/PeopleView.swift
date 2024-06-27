//
//  PeopleView.swift
//  SwiftDataExample
//
//  Created by Eliran Sharabi on 26/06/2024.
//

import SwiftUI
import SwiftData

struct PeopleView: View {
    @Environment(\.modelContext) var modelContext
    @Query var people: [Person]
    @Binding var navigationPath: NavigationPath

    init(searchString: String = "",
         navigationPath: Binding<NavigationPath>) {
        _people = Query(filter: #Predicate { person in
            if searchString.isEmpty {
                true
            } else {
                person.name.localizedStandardContains(searchString) ||
                person.email.localizedStandardContains(searchString)
            }
        })
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        List {
            ForEach(people) { person in
                PersonCell(person: person)
                    .onTapGesture {
                        navigationPath.append(person)
                    }
            }
            .onDelete(perform: deletePeople)
        }
    }

    func deletePeople(at offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let person = people[offset]
                modelContext.delete(person)
            }
        }
    }
}

struct PersonCell: View {
    
    let person: Person
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.headline)
                
                Text(person.email)
                    .font(.caption)
                
                if let team = person.team {
                    Text("Fan of: \(team.name)")
                        .font(.caption)
                }
            }
        .padding()
    }
}

#Preview {
    PersonCell(person: .mock)
}
