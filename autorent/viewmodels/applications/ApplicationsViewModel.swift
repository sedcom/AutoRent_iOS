//
//  ApplicationsViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation
import Combine

class ApplicationsViewModel: ObservableObject {
    var Data: Pagination<Application>
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository
    var mMaxItems: Int
    var mSkipCount: Int
    var IsLoading: Bool
    var IsError: Bool
    
    init(maxItems: Int, skipCount: Int) {
        self.Data = Pagination<Application>()
        self.mApplicationRepository = ApplicationRepository()
        self.mMaxItems = maxItems
        self.mSkipCount = skipCount
        self.IsLoading = false
        self.IsError = false
    }
    
    func clearData() {
        self.mSkipCount = 0
        self.Data.Elements.removeAll()
    }
    
    func loadData() {
        self.IsLoading = true
        self.IsError = false
        self.Data.Elements.append(Application())
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItems(self.mMaxItems, self.mSkipCount)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.IsLoading = false
                self.IsError = true
                self.objectWillChange.send()
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Data.Elements.remove(at: self.Data.Elements.count - 1)
                self.Data.MaxItems = result.MaxItems
                self.Data.SkipCount = result.SkipCount
                self.Data.Total = result.Total
                self.Data.Elements.append(contentsOf: result.Elements)
                self.IsLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.objectWillChange.send()
                }
            })
    }
}
