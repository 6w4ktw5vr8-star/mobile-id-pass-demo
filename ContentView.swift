import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 18) {
                StatusBarView()

                HStack {
                    Button(action: {}) {
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundStyle(.white)
                            )
                    }

                    Spacer()

                    VStack(alignment: .center, spacing: 2) {
                        Text("오늘")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.9))
                        Text("오전 7:18")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    Spacer()

                    Button(action: {}) {
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: "ellipsis")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundStyle(.white)
                            )
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 6)

                PassMainCardView()
                    .frame(width: UIScreen.main.bounds.width - 32, height: 620)

                MiniAppTrayView()
                    .frame(width: UIScreen.main.bounds.width - 32)

                CustomTabBar(selectedTab: $selectedTab)
                    .padding(.top, 8)
            }
            .padding(.top, 14)
        }
    }
}

struct StatusBarView: View {
    var body: some View {
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
                    .padding(.leading, 2)
            }
        }
        .padding(.horizontal, 18)
        .frame(height: 26)
    }
}

struct PassMainCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 28)
                .fill(Color(UIColor.systemGray6))

            VStack(alignment: .center, spacing: 18) {
                Spacer().frame(height: 44)

                PassWordmarkView()

                VStack(alignment: .center, spacing: 8) {
                    Text("한화생명")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.75))
 
                    Text("출금한데\n상품권 좀 받아볼까?")
                        .font(.system(size: 30, weight: .heavy))
                        .foregroundStyle(.black)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                }

                DonationCardView()

                VStack(spacing: 8) {
                    Text("※ 준비금사이 확인과 25-06-006 (2025.06.18~2026.06.17)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.black.opacity(0.5))
                        .multilineTextAlignment(.center)

                    Text("가입한 요금제에 따라 일부 메뉴의 경우\n데이터 요금이 발생할 수 있습니다.")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.black.opacity(0.55))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                .padding(.top, 6)

                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct PassWordmarkView: View {
    private let letters = ["P", "A", "S", "S"]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(letters.indices, id: \ .self) { index in
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor(hex: "#E84141")))
                    .frame(width: 54, height: 72)
                    .overlay(
                        Text(letters[index])
                            .font(.system(size: 48, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .offset(y: -2)
                    )
            }
        }
    }
}

struct DonationCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color(UIColor(hex: "#0A1B4B")), Color(UIColor(hex: "#153D91"))]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 290, height: 110)

            HStack(alignment: .center, spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.12))
                        .frame(width: 90, height: 70)

                    Image(systemName: "gift.fill")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("모바일 상품권")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))

                    Text("GS25")
                        .font(.system(size: 34, weight: .heavy))
                        .foregroundStyle(.white)

                    Text("10,000원")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

struct MiniAppTrayView: View {
    var body: some View {
        HStack(spacing: 14) {
            ForEach(1..<6) { index in
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.12))
                    .frame(width: 54, height: 54)
                    .overlay(
                        Group {
                            if index == 1 {
                                Image(systemName: "folder.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            } else if index == 2 {
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            } else if index == 3 {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.pink)
                            } else if index == 4 {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            } else {
                                Image(systemName: "list.bullet")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                    )
            }
        }
        .padding(.vertical, 6)
    }
}

enum Tab {
    case home
    case favorite
    case info
    case chart
    case menu
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    private let items: [(Tab, String)] = [
        (.home, "house.fill"),
        (.favorite, "heart"),
        (.info, "info.circle"),
        (.chart, "chart.bar.fill"),
        (.menu, "list.bullet")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items, id: \ .0) { tab, systemName in
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 0) {
                        Image(systemName: systemName)
                            .font(.system(size: 26, weight: .medium))
                            .frame(width: 50, height: 50)
                            .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.7))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(
            RoundedRectangle(cornerRadius: 26)
                .fill(Color(UIColor(hex: "#1A1B1E")))
        )
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
    ContentView()
}
