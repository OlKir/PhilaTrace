import SwiftUI

struct ExamplePaywallView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Image("example_paywall")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
            .ignoresSafeArea()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "xmark")
                    }
                    .accessibilityLabel("Close")
                }
            }
    }
}

#Preview {
    NavigationStack {
        ExamplePaywallView()
    }
}
