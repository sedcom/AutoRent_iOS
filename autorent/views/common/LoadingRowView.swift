//
//  LoadingRowView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct LoadingRowView: View {
    var body: some View {
        GeometryReader { geometry in
            ProgressView()
                .frame(width: geometry.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .progressViewStyle(CircularProgressViewStyle(tint: Color.secondary))
        }
    }
}

struct LoadingRowView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingRowView()
    }
}
