//
//  Settings.swift
//  GHS-MSG-APP
//
//  Created by Student on 5/28/26.
//

import SwiftUI

struct SettingsUI: View {
    
    //Toggle Variables
    
    @State private var notificationsEnabled = true //variable for notifacations toggle
    @State private var darkModeEnabled = false //variable for dark mode toggle
    @State private var rememberMeEnabled = false //variable for remeber me toggle
    
    //Dropdown Variables
    
    @State private var isExpanded = false //variable for accessibility dropdown
    
    //Slider Variables
    
    @State private var fontSize: Double = 20.0 //variable for font size slider
    
    //Background Variables
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [
                Color(red: 0.27, green: 0.02, blue: 0.08),
                Color(red: 0.48, green: 0.05, blue: 0.14),
                Color(red: 0.70, green: 0.12, blue: 0.22)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }


    
    var body: some View {
                    
            NavigationStack {
                
                Form {
                    
                    Section {
                        HStack {
                            Toggle("Enable Notifications", isOn: $notificationsEnabled)
                                .font(.title)
                                .padding()
                        }
                    }
                    
                    Section {
                        HStack {
                            Toggle("Enable Dark Mode", isOn: $darkModeEnabled)
                                .font(.title)
                                .padding()
                        }
                    }
                    
                    Section {
                        HStack {
                            Toggle("Enable Remember Me", isOn: $rememberMeEnabled)
                                .font(.title)
                                .padding()
                        }
                    }
                    
                    Section {
                        DisclosureGroup("Accessibility", isExpanded: $isExpanded) {
                            
                            VStack {
                                
                                HStack(spacing: 15){
                                    Text("Font Size")
                                        .font(.title2)
                                    Spacer()
                                }
                                .padding()
                                
                                HStack(spacing: 15) {
                                    Slider(value: $fontSize, in: 10...30) {
                                        Text("Font Size Slider")
                                    } minimumValueLabel: {
                                        Text("10pt")
                                            .font(.title2)
                                    } maximumValueLabel: {
                                        Text("30pt")
                                            .font(.title2)
                                    }
                                }
                                .padding()
                                
                            }
                            
                        }
                    }
                    
                    .font(.title)
                    .padding()
                    
                }
                
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Settings")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                
                .scrollContentBackground(.hidden)
                .background(backgroundGradient.ignoresSafeArea())
                

            }
    }
}

#Preview {
    SettingsUI()
}
