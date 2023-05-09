//
//  ProjectsView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/6.
//

import SwiftUI




let LiteBridges: [Task] = [
    Task(
        name: "Official Bridge",
        icon: "zksync",
        site: "https://lite.zksync.io",
        code:  "zksyncLiteBridgeToLiteCode"
    ),
    Task(
        name: "Orbiter.Finance",
        icon: "orbiterfinance",
        site: "https://www.orbiter.finance/?source=Ethereum&dest=zkSync%20Lite"
    ),
    Task(
        name: "LayerSwap.io",
        icon: "layerswap",
        site: "https://www.layerswap.io"
    )
]



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
                                NavigationLink(
                                    destination: TaskDetailView()) {
                                        Image(bridge.icon)
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                        Text(bridge.name)
                                    }
                            }
                        }, header: {
                            Text("bridge")
                        })

                        Section {
                            NavigationLink("Activate") {
                                BridgeView()
                            }
                            NavigationLink("Mint NFT") {
                                BridgeView()
                            }
                            NavigationLink("Transfer NFT") {
                                BridgeView()
                            }
                            NavigationLink("Transfer ETH") {
                                BridgeView()
                            }
                        } header: {
                            Text("asdf")
                        }
                    } else {
                        Section(content: {
                            NavigationLink(destination: BridgeView()) {
                                Image("optimism").resizable().frame(width: 18, height: 18)
                                Text("Official Bridge")
                            }

                            NavigationLink("Official Bridge") {
                                BridgeView()
                            }
                            NavigationLink("Orbiter.Finance") {
                                BridgeView()
                            }
                            NavigationLink("LayerSwap.io") {
                                BridgeView()
                            }
                        }, header: {
                            Text("bridge")
                        })

                        Section {
                            NavigationLink("Transfer ETH") {
                                BridgeView()
                            }
                        } header: {
                            Text("asdf")
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

    private var lite: some View {
        Group {
            NavigationLink("Official Bridge") {
                BridgeView()
            }
            NavigationLink("Task") {
                BridgeView()
            }
        }
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}

