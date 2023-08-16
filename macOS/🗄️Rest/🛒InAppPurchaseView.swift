import SwiftUI
import StoreKit

struct 🛒InAppPurchaseWindow: Scene {
    @ObservedObject var 🛒: 🛒InAppPurchaseModel
    var body: some Scene {
        Window(Text("In-App Purchase", tableName: "🌐AD&InAppPurchase"),
               id: "InAppPurchase") {
            Self.menu()
                .environmentObject(🛒)
        }
        .defaultSize(width: 400, height: 500)
        .commandsRemoved()
    }
    init(_ 🛒: 🛒InAppPurchaseModel) {
        self.🛒 = 🛒
    }
}

private extension 🛒InAppPurchaseWindow {
    private static func menu() -> some View {
        List {
            Self.aboutADSection()
            Section {
                GroupBox {
                    VStack {
                        Self.PurchaseView()
                        Self.adPreview()
                        Self.RestoreButton()
                    }
                    .padding()
                }
            } header: {
                Text("In-App Purchase", tableName: "🌐AD&InAppPurchase")
            }
            .headerProminence(.increased)
        }
        .navigationTitle(Text("In-App Purchase", tableName: "🌐AD&InAppPurchase"))
    }
    private static func aboutADSection() -> some View {
        Section {
            GroupBox {
                Text("This App shows advertisement about applications on AppStore. These are several Apps by this app's developer. It is activated after you launch this app 5 times.",
                     tableName: "🌐AD&InAppPurchase")
                .padding()
            }
        } header: {
            Text("About AD", tableName: "🌐AD&InAppPurchase")
        }
    }
    private static func adPreview() -> some View {
        HStack(alignment: .bottom) {
            Spacer()
            Image(.adPreview)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .padding(.leading, 45)
            Image(systemName: "trash.square.fill")
                .resizable()
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, .red)
                .frame(width: 60, height: 60)
                .rotationEffect(.degrees(8))
                .offset(x: -45)
                .shadow(radius: 5)
                .padding(.bottom, 60)
            Spacer()
        }
        .padding(12)
    }
    private struct PurchaseView: View {
        @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
        @State private var buyingInProgress = false
        @State private var showError = false
        @State private var errorMessage = ""
        var body: some View {
            HStack {
                Label(🛒.productName, systemImage: "cart")
                Spacer()
                if 🛒.purchased {
                    Image(systemName: "checkmark")
                        .imageScale(.small)
                        .foregroundStyle(.tertiary)
                        .transition(.slide)
                }
                Button(🛒.productPrice) {
                    Task {
                        do {
                            self.buyingInProgress = true
                            try await 🛒.purchase()
                        } catch 🛒Error.failedVerification {
                            self.errorMessage = "Your purchase could not be verified by the App Store."
                            self.showError = true
                        } catch {
                            print("Failed purchase: \(error)")
                            self.errorMessage = error.localizedDescription
                            self.showError = true
                        }
                        self.buyingInProgress = false
                    }
                }
                .accessibilityLabel(Text("Buy", tableName: "🌐AD&InAppPurchase"))
                .disabled(self.buyingInProgress)
                .buttonStyle(.borderedProminent)
                .overlay {
                    if self.buyingInProgress { ProgressView() }
                }
                .alert(isPresented: self.$showError) {
                    Alert(title: Text("Error", tableName: "🌐AD&InAppPurchase"),
                          message: Text(self.errorMessage),
                          dismissButton: .default(Text("OK", tableName: "🌐AD&InAppPurchase")))
                }
            }
            .disabled(🛒.unconnected)
            .disabled(🛒.purchased)
            .animation(.default, value: 🛒.purchased)
        }
    }
    private struct RestoreButton: View {
        @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
        @State private var restoringInProgress = false
        @State private var showAlert = false
        @State private var syncSuccess = false
        @State private var alertMessage = ""
        var body: some View {
            Button {
                Task {
                    do {
                        self.restoringInProgress = true
                        try await AppStore.sync()
                        self.syncSuccess = true
                        self.alertMessage = "Restored transactions"
                    } catch {
                        print("Failed sync: \(error)")
                        self.syncSuccess = false
                        self.alertMessage = error.localizedDescription
                    }
                    self.showAlert = true
                    self.restoringInProgress = false
                }
            } label: {
                Label(String(localized: "Restore Purchases", table: "🌐AD&InAppPurchase"),
                      systemImage: "arrow.clockwise")
                .font(.subheadline)
                .foregroundColor(🛒.unconnected ? .secondary : nil)
                .grayscale(🛒.purchased ? 1 : 0)
                .overlay {
                    if self.restoringInProgress { ProgressView() }
                }
            }
            .disabled(self.restoringInProgress)
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text(self.syncSuccess ? "Done" : "Error", tableName: "🌐AD&InAppPurchase"),
                      message: Text(LocalizedStringKey(self.alertMessage)),
                      dismissButton: .default(Text("OK", tableName: "🌐AD&InAppPurchase")))
            }
        }
    }
}
