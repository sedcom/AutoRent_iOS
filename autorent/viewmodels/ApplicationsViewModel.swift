//
//  ApplicationsViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 28.11.2021.
//

import Foundation
import Combine

class ApplicationsViewModel: ObservableObject {
    @Published var Applications: [Application] = []
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository = ApplicationRepository()
    var mMaxItems: Int
    var mSkipCount: Int
    
    init(maxItems: Int, skipCount: Int) {
        self.mMaxItems = maxItems
        self.mSkipCount = skipCount
    }

    func loadData() {
        self.cancellation = self.mApplicationRepository.loadItems(self.mMaxItems, self.mSkipCount)
            .mapError({ (error) -> Error in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Applications = result.Elements;
        })
    }
}
