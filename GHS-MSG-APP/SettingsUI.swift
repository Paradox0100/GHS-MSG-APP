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
    
    @State private var fontSize: Double = 32.5 //variable for font size slider
    @State private var scalingFactor: Double = 32.5 //variable for scaling slider

    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                //invisible section to create more space between title and body
                
                Section {
                    Spacer()
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                                
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
                                Slider(value: $fontSize, in: 15...50) {
                                    Text("Font Size Slider")
                                } minimumValueLabel: {
                                    Text("15pt")
                                        .font(.title2)
                                } maximumValueLabel: {
                                    Text("50pt")
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
            
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsUI()
}
