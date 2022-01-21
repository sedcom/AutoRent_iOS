//
//  OrderMainView.swift
//  autorent
//
//  Created by Viacheslav Lazarev on 21.01.2022.
//

import SwiftUI

struct OrderMainView: View, Equatable {
    @ObservedObject var mViewModel: OrderViewModel
    var mCurrentMode: ModeView
    var mEntityId: Int
    @Binding var SelectedStatus: Int?
    @Binding var ActionResult: OperationResult?
    @State var ToastMessage: String?
    
    init(entityId: Int, mode: ModeView, status: Binding<Int?>, result: Binding<OperationResult?>) {
        self.mEntityId = entityId
        self.mCurrentMode = mode
        self._SelectedStatus = status
        self._ActionResult = result
        self.mViewModel = OrderViewModel(entityId: entityId, include: "applications,companies,items,history,vehicles")
    }
    
    static func == (lhs: OrderMainView, rhs: OrderMainView) -> Bool {
        return true
    }
    
    var body: some View {
        ZStack {
            VStack {
                if self.mViewModel.IsLoading == true  {
                    LoadingView()
                }
                else if self.mViewModel.IsError {
                    ErrorView()
                }
                else if self.mViewModel.Order != nil {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            VStack {
                                CustomText("string_provider", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Order!.Company!.getCompanyName(), image: "address-book")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                CustomText("string_application_address", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Order!.Application!.Address!.getAddressName(), image: "map-marker-alt")
                            }
                            .padding(.bottom, 4)
                            VStack {
                                ForEach(self.mViewModel.Order!.Items) { item in
                                    let index = self.mViewModel.Order!.Items.firstIndex(of: item)!
                                    OrderItemView(orderItem: item, index: index)
                                }
                            }
                            VStack {
                                CustomText("string_description", maxLines: 1, bold: true)
                                CustomText(self.mViewModel.Order!.Application!.Notes!)
                            }
                        }
                        .padding(.all, 8)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .background(Color.primary)
            .onAppear {
                if self.mViewModel.Order == nil {
                    self.mViewModel.loadData()
                }
            }
            .onChange(of: self.mViewModel.Order) { newValue in
                if (newValue != nil) {
                    self.SelectedStatus = newValue!.getStatus().Status.Id
                }
            }
            .onChange(of: self.ActionResult) { newValue in
                if newValue != nil {
                    switch(newValue!) {
                        case OperationResult.Update:
                            self.ToastMessage = NSLocalizedString("message_save_success", comment: "")
                            self.mViewModel.loadData()
                    case OperationResult.Approve:
                            self.ToastMessage = NSLocalizedString("message_order_approve_success", comment: "")
                            self.mViewModel.loadData()
                        default: print()
                    }
                    self.ActionResult = nil
                }
            }
            ToastView($ToastMessage)
        }
    }
}
