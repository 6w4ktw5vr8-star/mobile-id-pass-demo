import SwiftUI

struct PINVerificationView: View {
    @State private var pinInput: String = ""
    @State private var showPINPad = true
    @State private var isVerifying = false
    @State private var verificationComplete = false
    
    let pinLength = 6
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Status Bar
                HStack {
                    Text("7:26")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 10) {
                        Image(systemName: "wifi")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Image(systemName: "cellularbars")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Image(systemName: "battery.75")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Text("21")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                
                // PIN Card
                ZStack {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color(UIColor.systemGray6))
                    
                    VStack(alignment: .center, spacing: 24) {
                        // Header
                        HStack {
                            Spacer()
                            
                            PassWordmarkSmallView()
                            
                            Spacer()
                            
                            Button(action: {}) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundStyle(.black)
                            }
                            .frame(width: 40, height: 40)
                        }
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                        
                        // PIN Input Instructions
                        VStack(alignment: .center, spacing: 16) {
                            Text("등록한 비밀번호를\n입력해주세요.")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.black)
                                .multilineTextAlignment(.center)
                                .lineSpacing(2)
                            
                            // PIN Dots Display
                            HStack(spacing: 12) {
                                ForEach(0..<pinLength, id: \.self) { index in
                                    ZStack {
                                        Circle()
                                            .stroke(Color.black.opacity(0.15), lineWidth: 2)
                                            .frame(width: 32, height: 32)
                                        
                                        if index < pinInput.count {
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width: 28, height: 28)
                                                .transition(.scale.combined(with: .opacity))
                                        }
                                    }
                                    .animation(.easeInOut(duration: 0.2), value: pinInput.count)
                                }
                            }
                        }
                        
                        // QR Button
                        Button(action: {}) {
                            HStack(spacing: 8) {
                                Image(systemName: "qrcode")
                                    .font(.system(size: 16, weight: .semibold))
                                Text("QR인증")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity)
                            .frame(height: 48)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 40)
                        
                        // Forgot PIN
                        Text("비밀번호를 잊어버렸나요?")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.black.opacity(0.6))
                            .underline()
                        
                        Spacer(minLength: 0)
                        
                        // PIN Pad
                        VStack(spacing: 8) {
                            // Row 1: 7, 8, 9, 2
                            HStack(spacing: 8) {
                                PINButton("7") { addPIN("7") }
                                PINButton("8") { addPIN("8") }
                                PINButton("9") { addPIN("9") }
                                PINButton("2") { addPIN("2") }
                            }
                            
                            // Row 2: Empty, 5, 4, 6
                            HStack(spacing: 8) {
                                Color.clear.frame(height: 50)
                                PINButton("5") { addPIN("5") }
                                PINButton("4") { addPIN("4") }
                                PINButton("6") { addPIN("6") }
                            }
                            
                            // Row 3: 1, Empty, 3, 0
                            HStack(spacing: 8) {
                                PINButton("1") { addPIN("1") }
                                Color.clear.frame(height: 50)
                                PINButton("3") { addPIN("3") }
                                PINButton("0") { addPIN("0") }
                            }
                            
                            // Row 4: Delete, Submit
                            HStack(spacing: 8) {
                                Button(action: deletePIN) {
                                    Image(systemName: "xmark")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color.white.opacity(0.5))
                                        .cornerRadius(12)
                                }
                                
                                Button(action: submitPIN) {
                                    Text("입력완료")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 50)
                                        .background(Color(UIColor(hex: "#E84141")))
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 24)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                
                Spacer()
            }
        }
    }
    
    private func addPIN(_ digit: String) {
        if pinInput.count < pinLength {
            pinInput.append(digit)
        }
    }
    
    private func deletePIN() {
        if !pinInput.isEmpty {
            pinInput.removeLast()
        }
    }
    
    private func submitPIN() {
        if pinInput.count == pinLength {
            isVerifying = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                verificationComplete = true
            }
        }
    }
}

struct PINButton: View {
    let label: String
    let action: () -> Void
    @State private var isPressed = false
    
    init(_ label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            isPressed = true
            action()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPressed = false
            }
        }) {
            Text(label)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.white)
                .cornerRadius(12)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: isPressed)
        }
    }
}

struct PassWordmarkSmallView: View {
    private let letters = ["P", "A", "S", "S"]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(letters.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(UIColor(hex: "#E84141")))
                    .frame(width: 24, height: 32)
                    .overlay(
                        Text(letters[index])
                            .font(.system(size: 18, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                    )
            }
        }
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255
        let g = CGFloat((rgb >> 8) & 0xFF) / 255
        let b = CGFloat(rgb & 0xFF) / 255
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

#Preview {
    PINVerificationView()
}
