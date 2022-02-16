//
//  VehiclesView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 11.02.2022.
//

import SwiftUI

struct VehiclesView: View, Equatable {
    @ObservedObject var mViewModel: VehiclesViewModel
    @State var mCurrentFilter: Int
    @State var ActionResult: OperationResult?
    @State var Refresh: Bool?
    @State var ToastMessage: String?
    
    init() {
        self.mCurrentFilter = 1
        let user = AuthenticationService.getInstance().getCurrentUser()
        self.mViewModel = VehiclesViewModel(userId: user!.Id, maxItems: 10, skipCount: 0, orderBy: "", include: "", filter: "")
    }

    static func == (lhs: VehiclesView, rhs: VehiclesView) -> Bool {
        return true
    }
    
    var body: some View {
        VStack {
            if self.mViewModel.IsLoading == true && self.mViewModel.mSkipCount == 0 {
                LoadingView()
            }
            else if self.mViewModel.IsError {
                ErrorView()
            }
            else {
                VStack (spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack () {
                            Button("status_all", action: { self.setFilter(filterIndex: 1, filter: "") })
                                 .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter == 1))
                            ForEach(self.mViewModel.VehicleTypes) { vehicleType in
                                let index = self.mViewModel.VehicleTypes.firstIndex { $0.id == vehicleType.id }!
                                Button(vehicleType.Name, action: { self.setFilter(filterIndex: index + 2, filter: String(format: "vehicleType==%@", String(vehicleType.Id))) })
                                    .buttonStyle(FilterButtonStyle(selected: self.mCurrentFilter ==  (index + 2)))
                            }
                        }
                        .padding(.all, 8)
                    }
                    .background(Color.primaryDark)
                    if self.mViewModel.Data.Elements.count == 0 {
                        EmptyView()
                    }
                    else {
                        ZStack {
                            List {
                                ForEach(self.mViewModel.Data.Elements) { vehicle in
                                    VStack {
                                        if vehicle.Id == 0 {
                                            LoadingRowView()
                                        }
                                        else {
                                            NavigationLink(destination: VehicleView(entityId: vehicle.Id, mode: ModeView.View, refresh: $Refresh), isActive: Binding.constant(false))  {
                                                VehiclesRowView(vehicle)
                                            }
                                        }
                                    }
                                    .listRowBackground(Color.primary)
                                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: -20))
                                    .onAppear {
                                        //TODO
                                        if self.mViewModel.IsLoading == false {
                                            if self.mViewModel.Data.Elements.count < self.mViewModel.Data.Total {
                                                if  vehicle == self.mViewModel.Data.Elements.last {
                                                    self.mViewModel.mSkipCount = self.mViewModel.Data.Elements.count
                                                    self.mViewModel.loadData()
                                               }
                                            }
                                        }
                                    }
                                }
                            }
                            .listStyle(PlainListStyle())
                            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            /*ZStack {
                                NavigationLink(destination: CompanyEditView(entityId: 0, mode: ModeView.Create, result: $ActionResult)) {
                                    ZStack {
                                        Circle().fill(Color.secondary)
                                        Image("plus")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(Color(UIColor.darkGray))
                                    }
                                }
                                .frame(width: 60, height: 60)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                            .offset(x: -10, y: -10)*/
                            ZStack {
                                ToastView($ToastMessage)
                            }
                        }
                    }
                }
                .background(Color.primary)
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(false)
        .navigationBarTitle(NSLocalizedString("title_vehicles", comment: ""), displayMode: .inline)
        .onAppear {
            if self.mViewModel.Data.Elements.count == 0 || self.Refresh ?? false {
                self.Refresh = nil
                self.loadData()
            }
        }
        .onChange(of: self.ActionResult) { newValue in
            if newValue != nil {
                switch(newValue!) {
                    case OperationResult.Create:
                        self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                    case OperationResult.Update:
                        self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                    default: ()
                }
                self.Refresh = true
                self.ActionResult = nil
            }
        }
        .onChange(of: self.Refresh) { newValue in
            if newValue != nil {

            }
        }
    }
 
    private func loadData() {
        self.mViewModel.clearData()
        self.mViewModel.loadData()
    }
    
    private func setFilter(filterIndex: Int, filter: String) {
        self.mCurrentFilter = filterIndex
        self.mViewModel.setFilter(filter)
        self.loadData()
    }
}

