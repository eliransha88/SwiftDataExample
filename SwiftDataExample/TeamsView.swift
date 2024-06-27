//
//  TeamsView.swift
//  SwiftDataExample
//
//  Created by Eliran Sharabi on 27/06/2024.
//

import SwiftUI
import SwiftData

struct TeamsView: View {
    @Environment(\.modelContext) var modelContext
    @Query var teams: [Team]
    
    var body: some View {
        List {
            ForEach(teams) { team in
                TeamCellView(team: team)
            }
            .onDelete(perform: deleteTeams)
        }
        .toolbar {
            Button("Undo",
                   systemImage: "xmark") {
                modelContext.undoManager?.undo()
            }
        }
    }
    
    func deleteTeams(at offsets: IndexSet) {
        for offset in offsets {
            let team = teams[offset]
            modelContext.delete(team)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return TeamsView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

struct TeamCellView: View {
    
    let team: Team
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(team.name)
                    .font(.headline)
                
                Text("\(team.city),\(team.country)")
                    .font(.caption)
            }
            
            Spacer()
            
            Text(team.fans.count.description)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .font(.caption)
                .foregroundStyle(.white)
                .background(Color.blue)
                .clipShape(Circle())
        }
        .padding()
    }
}


@MainActor
struct Previewer {
    let container: ModelContainer
    let team: Team
    let person: Person
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Person.self, configurations: config)
        
        team = .haifa
        person = .mock
        person.team = team
        
        container.mainContext.insert(person)
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return TeamCellView(team: .haifa)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
