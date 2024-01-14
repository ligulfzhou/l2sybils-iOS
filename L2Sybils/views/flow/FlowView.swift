//
//  FlowView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/12/31.
//
import SwiftUI
struct FlowView: View {
    @ObservedObject private var viewModel: FlowViewModel
    
    @State private var addAddress: Bool = false
    @State private var address: String = ""

    
    init(viewModel: FlowViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            VStack {
                empty
            }.navigationTitle("zkSync Flow")
        }
        .navigationViewStyle(.stack)
    }

    var empty: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {

            Button("search") {
                addAddress = true
                print("click. search...")
            }

            Text(String(viewModel.interaction?.total ?? 0.0))
            
//            HStack {
//                TextField("Address", text: $viewModel.address)
//                    .border(.black)
//                    .cornerRadius(3)
//                Spacer()

//                Button("Search") {
//                    print("searching...")
//                }
//            }

        }
        
//        .overlay {
//            ContentUnavailableView {
//                Label("No Categories", systemImage: "tray.fill")
//                    .onTapGesture {
//                        addAddress = true
//                        print("click....")
//                    }
//            }
//        }

        .sheet(isPresented: $addAddress, content: {
            NavigationStack {
                List {
                    Section("Title") {
                        TextField("General", text: $address)
                    }
                }
                .navigationTitle("Category Name")
                .navigationBarTitleDisplayMode(.inline)
                /// Add & Cancel Button
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            addAddress = false
                        }
                        .tint(.red)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add") {
                            viewModel.address = address
                            addAddress = false
                        }
                        .disabled(address.isEmpty)
                    }
                }
            }
            .presentationDetents([.height(180)])
            .presentationCornerRadius(20)
            .interactiveDismissDisabled()
        })
        
    }
}


#Preview {
    FlowView(viewModel: FlowViewModel())
}
