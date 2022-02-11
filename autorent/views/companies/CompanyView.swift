//
//  CompanyView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI

struct CompanyView: View {
    var mCurrentMode: ModeView
    var mEntityId: Int
    @State var SelectedTab: Int = 0
    @State var mEditMode: Bool?
    @StateObject var SelectedStatus = StatusObservable()
    @State var Action: Int?
    @State var ActionResult: OperationResult?
    @Binding var Refresh: Bool?
    
    init(entityId: Int, mode: ModeView, refresh: Binding<Bool?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._Refresh = refresh
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
