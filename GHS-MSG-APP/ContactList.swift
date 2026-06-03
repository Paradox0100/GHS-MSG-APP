import SwiftUI

struct Contact: Identifiable {
    let id = UUID()
    var name: String
    var lastMsg: String
    var sent: Bool
    var seen: Bool
    var unread: Bool
}

struct ContactList: View {
    
    @State private var contacts: [Contact] = [
        Contact(name: "John Pork", lastMsg: "I'm still typing lmao", sent: true, seen: false, unread: true)
    ]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($contacts) { $contact in
                    HStack {
                        Circle()
                            .frame(maxWidth: 15, maxHeight: 15)
                            .foregroundColor(.blue)
                            .opacity(contact.unread ? 1 : 0)
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        VStack {
                            Text(contact.name)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(contact.lastMsg)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Circle()
                            .frame(maxWidth: 15, maxHeight: 15)
                            .foregroundColor(contact.sent ? .blue : .gray)
                        
                        Circle()
                            .frame(maxWidth: 15, maxHeight: 15)
                            .foregroundColor(contact.seen ? .blue : .gray)
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContactList()
}
