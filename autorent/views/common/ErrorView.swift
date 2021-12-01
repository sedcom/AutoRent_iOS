//
//  ErrorView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 01.12.2021.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text(NSLocalizedString("message_connection_error", comment: ""))
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
