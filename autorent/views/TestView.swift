//
//  TestView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 06.01.2022.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        Text("TEST!!!")
            
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color.primary)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
