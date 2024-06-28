//
//  ReadFilePlugin.swift
//  Runner
//
//  Created by Mbola Raharison 2 on 26/10/2022.
//  Copyright © 2022 The Chromium Authors. All rights reserved.
//

import UIKit
import WebKit
import Flutter
import GoogleMaps
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let googleApiKey = Bundle.main.infoDictionary?["GoogleAPIKey"] as? String ?? ""
        GeneratedPluginRegistrant.register(with: self)
        GMSServices.provideAPIKey(googleApiKey)

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
