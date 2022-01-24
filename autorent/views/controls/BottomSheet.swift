//
//  BottomSheet.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 24.01.2022.
//

import SwiftUI


struct BottomSheet<Content: View>: View {
    let mSnapRatio: CGFloat = 0.25
    let mMinHeightRatio: CGFloat = 0
    var mMaxHeight: CGFloat
    var mMinHeight: CGFloat
    let content: Content
    @Binding var Show: Bool
    @GestureState var mTranslation: CGFloat = 0
    
    init(show: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self._Show = show
        self.mMaxHeight = maxHeight
        self.mMinHeight = maxHeight * self.mMinHeightRatio
        self.content = content()
    }

    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.textDark)
                    .frame(width: 60, height: 6)
                    .padding()
                    .onTapGesture {
                        self.Show.toggle()
                    }
                self.content
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .frame(width: geo.size.width, height: self.mMaxHeight, alignment: .top)
            .background(Color.secondary)
            .cornerRadius(corners: [.topLeft, .topRight], radius: 16)
            .frame(height: geo.size.height, alignment: .bottom)
            .offset(y: max((self.Show ? 0 : self.mMaxHeight - self.mMinHeight) + self.mTranslation, 0))
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$mTranslation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.mMaxHeight * self.mSnapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.Show = value.translation.height < 0
                }
            )
        }
    }
}

extension View {
    func cornerRadius(corners: UIRectCorner, radius: CGFloat) -> some View {
        clipShape(RoundedCorners(corners: corners, radius: radius))
    }
}

struct RoundedCorners: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
