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
                            "associated_site",
                            destination: URL(string: "https://www.l2sybils.xyz")!
                        )
                        Spacer()
                        
                        Text("l2sybils.xyz")
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Link("privacy_policy", destination: URL(string: "https://www.l2sybils.xyz/privacy/policy")!)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Button("review_this_app") {
                            ReviewHandler.requestReview()
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Link("view_in_app_store", destination: URL(string: "https://apps.apple.com/us/app/airdrop-sybils/id6448769452")!)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }
                    
                    HStack {
                        Text("app_version")
                        
                        Spacer()
                        
                        Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "")
                        Image(systemName: "chevron.right")
                            .imageScale(.medium)
                    }

                } header: {
                    SectionHeaderView(text: LocalizedStringKey("this_app"))
                }
                            
//                AdmobBannerView()
                
                Section {
                    HStack {
                        Link("twitter", destination: URL(string: "https://twitter.com/ligulfzhou")!)
                        Spacer()
                        Image(systemName: "chevron.right").imageScale(.medium)
                    }
                    HStack {
                        
                        if (MFMailComposeViewController.canSendMail()) {
                            Button("email") {
                                self.isShowingMailView.toggle()
                            }
                            .sheet(isPresented: $isShowingMailView) {
                                MailView(result: self.$result)
                            }
                        } else {
                            Link("email", destination: URL(string: "mailto:ligulfzhou53@gmail.com")!)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right").imageScale(.medium)
                    }
                } header: {
                    SectionHeaderView(text: LocalizedStringKey("about_us"))
                }
            }
            .listStyle(.insetGrouped)
            .navigationViewStyle(.stack)
            .navigationTitle("about")
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
