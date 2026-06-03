//
//  RamChatProtoType1.swift
//  GHS-MSG-APP
//
//  Created by Student on 5/28/26.
//
import SwiftUI

struct PreviewView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Text("Ram Chat")
                    .font(.system(size : 50, weight: .bold, design: .default)).italic()
                    .foregroundStyle(.white)
                Image("Rams Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width : 200, height: 200)
                    .clipShape(Circle())
                Spacer()
                NavigationLink(destination: SignInScreen()){
                    Text("Sign Up")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .buttonStyle(.borderedProminent)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width:200, height:60)
                        )
                    
                }
                .padding(60)
                NavigationLink(destination: LoginScreen()) {
                    Text("Login")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 40, weight: .bold, design: .serif))
                        .buttonStyle(.borderedProminent)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                                .frame(width:200, height:60)
                        )
                    
                }
                
            }
            
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.appBackground)
            //Spacer()
            
            
            
        }
        
    }
}

struct SignInScreen: View {
    var body: some View {
        Text("Welcome to the Sign In Screen!")
            .font(.largeTitle)
            .navigationTitle("Title")
    }
}

struct LoginScreen: View {
    var body: some View {
        Text("Welcome to the Login Screen!")
            .font(.largeTitle)
            .navigationTitle("Title")
    }
}
#Preview {
    PreviewView()
}
