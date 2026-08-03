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

struct ChatDetailUI: View {
    
    private var name = "None"
    
    @State private var msg: String = ""
    @State private var content: [ChatMessage] = []
    
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
                            VStack {
                                let nameInitial = name[name.startIndex]
                                Text(String(nameInitial))
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .clipShape(Circle())
                                //Image(systemName: "person.circle.fill").resizable().scaledToFit()
                                Text(name)
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
                        HStack {
                            TextField("Message", text: $msg)
                                .font(.body)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(50)
                                .onSubmit {
                                    guard !msg.isEmpty else { return }
                                    content.append(ChatMessage(
                                        msg: msg,
                                        me: true
                                    ))
                                    msg = ""
                                }
                            
                            
                            Button(action: {
                                guard !msg.isEmpty else { return }
                                content.append(ChatMessage(
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
    ChatDetailUI(name: "John Pork")
}
