import SwiftUI
import Combine
import Foundation // Ensure Date is available





func showContactList() {
    
}

struct ChatUI: View {
    @State private var selectedContact: Contact?
    @State private var visibility = NavigationSplitViewVisibility.all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $visibility) {
            ContactList(selectedContact: $selectedContact)
        } detail: {
            if let contact = selectedContact {
                ChatDetailUI(name: contact.name)
            } else {
                Color.clear
            }
        }
    }
}

#Preview {
    ChatUI()
}
