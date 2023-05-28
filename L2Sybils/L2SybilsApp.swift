//
//  L2SybilsApp.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/4.
//

import SwiftUI
import FirebaseCore
import GoogleMobileAds


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()

      GADMobileAds.sharedInstance().start(completionHandler: nil)
      GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "46f59f8f919d8093a5ca24292e6cc7f6", GADSimulatorID ]
      return true
  }
}


@main
struct L2SybilsApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var uiState = UIState.shared
    
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            contentView
        }
    }

    private var contentView: some View {
        TabbarView()
            .environmentObject(uiState)
            .onAppear(perform: setupAppearance)
        
    }
    
    private func setupAppearance() {
        
    }
}
