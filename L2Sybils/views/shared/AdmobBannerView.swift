//
//  AdmobBannerView.swift
//  L2Sybils
//
//  Created by Ligang Zhou on 2023/5/7.
//

import SwiftUI
import GoogleMobileAds


protocol BannerViewControllerWidthDelegate: AnyObject {
  func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}


class BannerViewController: UIViewController {
  weak var delegate: BannerViewControllerWidthDelegate?

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Tell the delegate the initial ad width.
    delegate?.bannerViewController(
      self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
  }

  override func viewWillTransition(
    to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
  ) {
    coordinator.animate { _ in
      // do nothing
    } completion: { _ in
      // Notify the delegate of ad width changes.
      self.delegate?.bannerViewController(
        self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
    }
  }
}


struct AdmobBannerView: UIViewControllerRepresentable {
    @State private var viewWidth: CGFloat = .zero
    private let bannerView = GADBannerView()
    private let adUnitID = "ca-app-pub-9174125730777485/9647154992"

    func makeUIViewController(context: Context) -> some UIViewController {
      let bannerViewController = BannerViewController()
      bannerView.adUnitID = adUnitID
      bannerView.rootViewController = bannerViewController
      bannerViewController.view.addSubview(bannerView)

        // Tell the bannerViewController to update our Coordinator when the ad
        // width changes.
        bannerViewController.delegate = context.coordinator

      return bannerViewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
      guard viewWidth != .zero else { return }
      // Request a banner ad with the updated viewWidth.
      bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
      bannerView.load(GADRequest())
    }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }

    class Coordinator: NSObject, BannerViewControllerWidthDelegate {
      let parent: AdmobBannerView

      init(_ parent: AdmobBannerView) {
        self.parent = parent
      }

      // MARK: - BannerViewControllerWidthDelegate methods
        
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
          print("\(#function) called")
        }

        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
          print("\(#function) called")
        }

        func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
          print("\(#function) called")
        }

        func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
          print("\(#function) called")
        }

        func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
          print("\(#function) called")
        }

        func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
          print("\(#function) called")
        }


      func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat) {
        // Pass the viewWidth from Coordinator to BannerView.
        parent.viewWidth = width
      }
    }

}
