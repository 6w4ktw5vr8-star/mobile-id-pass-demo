import SwiftUI

struct AppRootView: View {
    @State private var isLoading = true
    @State private var showPIN = false

    var body: some View {
        Group {
            if isLoading {
                LoadingView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isLoading = false
                                showPIN = true
                            }
                        }
                    }
            } else if showPIN {
                PINVerificationView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 28) {
                Spacer()

                VStack(spacing: 18) {
                    PassWordmarkSmallView()
                        .padding(.bottom, 8)

                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.2)
                }

                Spacer()
            }
        }
    }
}

#Preview {
    AppRootView()
}
