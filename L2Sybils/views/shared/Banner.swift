//
//  Banner.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/28.
//

import SwiftUI
import GoogleMobileAds
import UIKit

private struct BannerVC: UIViewControllerRepresentable {
    var bannerID: String
    var width: CGFloat

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width))

        let viewController = UIViewController()
        view.adUnitID = bannerID
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        view.load(GADRequest())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

struct Banner: View {
    var bannerID: String
    var width: CGFloat

    var size: CGSize {
        return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width).size
    }

    var body: some View {
        BannerVC(bannerID: bannerID, width: width)
            .frame(width: size.width, height: size.height)
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Banner(bannerID: "ca-app-pub-9174125730777485/9647154992", width: UIScreen.main.bounds.width)
    }
}
