//
//  MapView.swift
//  hw6
//
//  Created by Julian Hoffmann on 05.06.23.
//

import SwiftUI
import MapKit
import CoreLocation
import _CoreLocationUI_SwiftUI
import UserNotifications

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: viewModel.bindableRegion(), showsUserLocation: true)
                .ignoresSafeArea()
                .accentColor(Color(.systemMint))
                .onAppear(){
                    viewModel.checkIfLocationServiceIsEnabled()
                }
            VStack {
                Text("Location: \(viewModel.currentLocation?.latitude ?? 0), \(viewModel.currentLocation?.longitude ?? 0)")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(20)
                Spacer()
                HStack {
                    Button(action: sendNotification) {
                        Text("Send Notification")
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.white)
                            .cornerRadius(20)
                    }
                    Spacer()
                    LocationButton(.currentLocation) {
                        viewModel.updateCurrentLocation()
                    }
                    .cornerRadius(20)
                }
                .padding()
            }
        }
    }
    
    private func sendNotification() {
           let center = UNUserNotificationCenter.current()
           
           let content = UNMutableNotificationContent()
           content.title = "Current Location"
           content.body = "Location: \(viewModel.currentLocation?.latitude ?? 0), \(viewModel.currentLocation?.longitude ?? 0)"
           
           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
           
           let uuidString = UUID().uuidString
           let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
           
           center.add(request) { (error) in
               if let error = error {
                   print("Error: \(error)")
               }
           }
       }
   }
