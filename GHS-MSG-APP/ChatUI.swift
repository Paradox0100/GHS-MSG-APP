import SwiftUI
import Foundation // Ensure Date is available


struct ChatMessage: Identifiable {
    let id: UUID
    let time: Date
    let msg: String
    let me: Bool
    
    init(
        id: UUID = UUID(),
        time: Date = Date(),
        msg: String,
        me: Bool
    ) {
        self.id = id
        self.time = time
        self.msg = msg
        self.me = me
    }
}


struct ChatUI: View {
    
    private var name = "None"
    
    @State private var msg: String = ""
    @State private var content: [ChatMessage] = []
    @State private var isAnimating = false
    @State private var showing = true
    
    init(
        name: String
    ) {
        self.name = name
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Button(action: {
                            
                        }) {
                            Image(systemName: "chevron.backward")
                            Text("Contacts")
                        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        
                            .overlay(alignment: .center) {
                                
                                VStack {
                                    Image(systemName: "person.circle.fill").resizable().scaledToFit()
                                    Text(name)
                                }
                            }
                    }.frame(maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.1)
                .padding()
                .background(Color.gray.opacity(0.1))
                
                ScrollView {
                    LazyVStack {
                        ForEach(content) { item in
                            HStack {
                                if item.me {
                                    Spacer()
                                    Text(item.msg)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(50)
                                } else {
                                    Text(item.msg)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(50)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                
                
                // Input Area: Fixed at bottom
                
                VStack {
                    HStack {
                        HStack(spacing: 4) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 8, height: 8)
                                    .scaleEffect(isAnimating ? 1.0 : 0.5)
                                    .opacity(isAnimating ? 1.0 : 0.3)
                                    .animation(
                                        .easeInOut(duration: 0.4)
                                        .repeatForever(autoreverses: true)
                                        .delay(Double(index) * 0.15), // Staggered delay
                                        value: isAnimating
                                    )
                            }
                        }
                        .onAppear {
                            isAnimating = true
                        }
                        .padding(.leading)
                        .opacity(showing ? 1 : 0)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        TextField("Message", text: $msg)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(50)
                        
                        
                        Button(action: {
                            guard !msg.isEmpty else { return }
                            content.append(ChatMessage(
                                time: Date(),
                                msg: msg,
                                me: true
                            ))
                            msg = ""
                        }) {
                            Image(systemName: "paperplane")
                                .font(.title2)
                                .foregroundColor(.blue)
                                .padding()
                                .background(Color.blue.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                }
            }
        }
        
    }
}

#Preview {
    ChatUI(name: "John Pork")
}
