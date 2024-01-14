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
    
    init(viewModel: FlowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                flowView
            }
            .navigationTitle("zkSync Flow")
            .navigationBarItems(trailing: Button("search", action: {
                addAddress = true
                print("click. search...")
            })
                .alert("Enter Address", isPresented: $addAddress) {
                    TextField("Address", text: $viewModel.address)
                        .textInputAutocapitalization(.never)
                    Button("OK", action: {
                        addAddress = false
                        print("address: \(viewModel.address)")
                    })
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("")
                }
            )
        }
        
    }
    
    var flowView: some View {
        VStack {
            Text(String(viewModel.interaction?.total ?? 0.0))
        }
        .overlay {
            
        }
    }
    var empty: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
            
            
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
        
//        .sheet(isPresented: $addAddress, content: {
//            NavigationStack {
//                List {
//                    Section("Title") {
//                        TextField("General", text: $address)
//                    }
//                }
//                .navigationTitle("Category Name")
//                .navigationBarTitleDisplayMode(.inline)
//                /// Add & Cancel Button
//                .toolbar {
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button("Cancel") {
//                            addAddress = false
//                        }
//                        .tint(.red)
//                    }
//                    
//                    ToolbarItem(placement: .topBarTrailing) {
//                        Button("Add") {
//                            viewModel.address = address
//                            addAddress = false
//                        }
//                        .disabled(address.isEmpty)
//                    }
//                }
//            }
//            .presentationDetents([.height(180)])
//            .presentationCornerRadius(20)
//            .interactiveDismissDisabled()
//        })
        
    }
}


#Preview {
    FlowView(viewModel: FlowViewModel())
}
