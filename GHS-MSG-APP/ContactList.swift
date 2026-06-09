import SwiftUI

/*
struct Contact: Identifiable {
    let id = UUID()
    var name: String
    var lastMsg: String
    var sent: Bool
    var seen: Bool
    var unread: Bool
    var time: Date
}
 */

struct Contact: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var lastMsg: String
    var sent: Bool
    var seen: Bool
    var unread: Bool
    var time: Date
}

struct ContactList: View {

    @Binding var selectedContact: Contact?
    
    @State private var contacts: [Contact] = [
        Contact(name: "John Pork", lastMsg: "I'm still typing lmao", sent: true, seen: false, unread: true, time: Date.now),
        Contact(name: "Jane Doe", lastMsg: "See you tomorrow at the cafe!", sent: true, seen: true, unread: false, time: Date.now),
        Contact(name: "Alex Smith", lastMsg: "Can you send me the file?", sent: false, seen: false, unread: false, time: Date.now)
    ]
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            let isLandscape = screenWidth > screenHeight
            
            let referenceWidth = isLandscape ? screenHeight : screenWidth
            
            let nameFontSize = max(14, referenceWidth * 0.043)
            let msgFontSize = max(12, referenceWidth * 0.038)
            let avatarSize = referenceWidth * 0.12
            let dotSize = referenceWidth * 0.03
            let spacingSize = referenceWidth * 0.03
            
            List(selection: $selectedContact) {
                ForEach(contacts) { contact in
                    NavigationLink(value: contact) {
                        HStack(spacing: spacingSize) {
                            
                            // 1. Unread status indicator
                            Circle()
                                .fill(Color.blue)
                                .frame(width: dotSize, height: dotSize)
                                .opacity(contact.unread ? 1 : 0)
                            
                            // 2. Profile Avatar
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: avatarSize, height: avatarSize)
                                .foregroundColor(.gray)
                            
                            // 3. Central labels stack
                            VStack(alignment: .leading, spacing: 4) {
                                Text(contact.name)
                                    .font(.system(size: nameFontSize, weight: .bold))
                                    .lineLimit(1)
                                
                                Text(contact.lastMsg)
                                    .font(.system(size: msgFontSize, weight: .regular))
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                            }
                            
                            Spacer()
                            
                            // 4. Sent and Seen markers
                            HStack(spacing: referenceWidth * 0.02) {
                                Circle()
                                    .fill(contact.sent ? Color.blue : Color.gray.opacity(0.4))
                                    .frame(width: dotSize, height: dotSize)
                                
                                Circle()
                                    .fill(contact.seen ? Color.blue : Color.gray.opacity(0.4))
                                    .frame(width: dotSize, height: dotSize)
                            }
                        }
                        .padding(.vertical, referenceWidth * 0.015)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Contacts")
        }
    }
}

