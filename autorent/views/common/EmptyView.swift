//
//  EmptyView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        VStack {
            Text(NSLocalizedString("message_nothing_found", comment: ""))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(Color.primary)
    }
}

struct EmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
