//
//  ApplicationViewModel.swift
//  autorent
//
//  Created by Semyon Kravchenko on 29.11.2021.
//

import Foundation
import Combine

class ApplicationViewModel: ObservableObject {
    @Published var Application: Application?
    var cancellation: AnyCancellable?
    var mApplicationRepository: ApplicationRepository = ApplicationRepository()
    var mEntityId: Int
    var mInclude: String
    var IsLoading: Bool
    var IsError: Bool
    
    init(entityId: Int, include: String) {
        self.mEntityId = entityId
        self.mInclude = include
        self.IsLoading = false
        self.IsError = false
    }

    func loadData() {
        debugPrint("Start loadData")
        self.IsLoading = true
        self.IsError = false
        self.objectWillChange.send()
        self.cancellation = self.mApplicationRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                self.IsLoading = false
                self.IsError = true
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                debugPrint("Finish loadData")
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                    self.Application = result;
                    self.IsLoading = false
                }
        })
    }
}
