//
//  ErrorView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        VStack {
            Text(NSLocalizedString("message_connection_error", comment: ""))
                .foregroundColor(Color.textLight)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.primary)
        .navigationBarHidden(true)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
