//
//  ProjectsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI


enum Tabs: String, CaseIterable, CustomStringConvertible {
    case zksynclite, zksyncera
        
    var description: String {
        switch self {
        case .zksynclite:
            return "zkSync Lite"
        case .zksyncera:
            return "zkSync Era"
        }
    }
}


struct ProjectsView: View {

    @State private var selectedTab: Tabs = .zksynclite
    
    var body: some View {
        NavigationView {
            VStack {
                picker
                
                List {
                    if (selectedTab == .zksynclite) {
                        Section(content: {
                            ForEach(LiteBridges) { bridge in
                                navigationRow(task: bridge)
                            }
                        }, header: {
                            Text("Bridges")
                        })
                        
                        Section {
                            ForEach(LiteTasks) { task in
                                navigationRow(task: task)
                            }
                        } header: {
                            Text("Tasks")
                        }
                    } else {
                        Section(content: {
                            ForEach(LiteBridges) { bridge in
                                navigationRow(task: bridge)
                            }
                        }, header: {
                            Text("Bridges")
                        })
                        
                        Section {
                            ForEach(LiteTasks) { task in
                                navigationRow(task: task)
                            }
                        } header: {
                            Text("Tasks")
                        }
                    }
                    
                }
                .listStyle(.grouped)
            }
            
            .navigationTitle("Projects")
        }
    }
    
    private var picker: some View {
        Picker(selection: $selectedTab, label: Text("")) {
            ForEach(Tabs.allCases, id: \.self) { tab in
                Text(tab.description)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private func navigationRow(task: Task) -> some View {
        NavigationLink(
            destination: TaskDetailView(task: task)) {
                Image(task.icon)
                    .resizable()
                    .frame(width: 18, height: 18)
                Text(task.name)
            }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}

