//
//  AboutView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/9.
//

import SwiftUI
import MessageUI


struct AboutView: View {
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false

    var body: some View {
        NavigationView {
            
            List {
                Section {
                    HStack {
                        Link(
                            "Associated Site",
                            destination: URL(string: "https://www.l2sybils.xyz")!
                        )
                        Spacer()
                        
                        Text("l2sybils.xyz")
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Link("Privacy Policy", destination: URL(string: "https://www.l2sybils.xyz/privacy/policy")!)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Button("Review this App") {
                            ReviewHandler.requestReview()
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Text("App version")
                        
                        Spacer()
                        
                        Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }

                } header: {
                    SectionHeaderView(text: "This APP")
                }
                            
//                AdmobBannerView()
                
                Section {
                    HStack {
                        Link("Twitter", destination: URL(string: "https://twitter.com/ligulfzhou")!)
                        Spacer()
                        Image(systemName: "chevron.right").imageScale(.medium)
                    }
                    HStack {
                        
                        if (MFMailComposeViewController.canSendMail()) {
                            Button("Email") {
                                self.isShowingMailView.toggle()
                            }                                .sheet(isPresented: $isShowingMailView) {
                                    MailView(result: self.$result)
                                }
                        } else {
                            Link("Email", destination: URL(string: "mailto:ligulfzhou53@gmail.com")!)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right").imageScale(.medium)
                    }
                } header: {
                    SectionHeaderView(text: "About Us")
                }
            }
            .listStyle(.insetGrouped)
            .navigationViewStyle(.stack)
            .navigationTitle("About")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
