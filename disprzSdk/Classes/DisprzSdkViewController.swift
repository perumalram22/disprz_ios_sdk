import Foundation
import React
import GoogleMaps
import react_native_config

open class DisprzSdkViewController: UIViewController {
  
  override public func loadView() {
    let bundle: Bundle = Bundle.main
    var bundleURL = bundle.resourceURL
    
    if (bundleURL != nil) {
      bundleURL!.appendPathComponent("DisprzSdk.bundle/rnsdk.jsbundle")
      
      let view = RCTRootView(bundleURL: bundleURL!, moduleName: "DisprzFeature", initialProperties: [:])
      self.view = view
    }
  }
}