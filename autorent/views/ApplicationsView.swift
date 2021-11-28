//
//  ApplicationsView.swift
//  autorent
//
//  Created by Semyon Kravchenko on 27.11.2021.
//

import SwiftUI

struct ApplicationsView: View {
    @ObservedObject var mViewModel = ApplicationsViewModel(maxItems: 10, skipCount: 0)
    
    var body: some View {
        VStack {
            HStack {
                Text("All").padding()
                Text("Draft").padding()
                Text("Process").padding()
                Text("Complete").padding()
            }
            List(mViewModel.Applications) { application in
                VStack {
                    HStack  {
                        Text(String(application.Id)).padding()
                        Text(application.Notes)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationsView()
    }
}
