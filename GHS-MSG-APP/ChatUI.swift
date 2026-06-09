import SwiftUI
import Combine
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


/* THIS DOESN'T WORK
struct Dittos: View {
    @State private var pulse = false
    @State private var showing = true
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.gray)
                    .frame(width: 8, height: 8)
                    .scaleEffect(pulse ? 1.0 : 0.3)
                    .opacity(pulse ? 1.0 : 0.3)
                    .animation(
                        .easeInOut(duration: 0.4)
                        .repeatForever(autoreverses: true)
                        .delay(Double(index) * 0.15),
                        value: pulse
                    )
            }
        }
        .onAppear {
            pulse = true
        }
        .padding(.leading)
        .opacity(showing ? 1 : 0)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
*/

func showContactList() {
    
}

struct ChatUI: View {
    
    private var name = "None"
    
    @State private var msg: String = ""
    @State private var content: [ChatMessage] = []
    @State private var pulse = false
    @State private var showing = true
    
    @State private var color = Color.brown
    
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
                            showContactList()
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
                                        .padding(20)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(30)
                                } else {
                                    Text(item.msg)
                                        .padding(20)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(30)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }
                .defaultScrollAnchor(.bottom)
                
                
                // Input Area: Fixed at bottom
                
                VStack {
                    //Dittos()  BROKEN
                    HStack {
                        TextField("Message", text: $msg)
                            .font(.body)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(50)
                            .onSubmit {
                                guard !msg.isEmpty else { return }
                                content.append(ChatMessage(
                                    time: Date(),
                                    msg: msg,
                                    me: true
                                ))
                                msg = ""
                            }
                        
                        
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
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ChatUI(name: "John Pork")
}
