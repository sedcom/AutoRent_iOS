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
    
    init(entityId: Int, include: String) {
        self.mEntityId = entityId
        self.mInclude = include
    }

    func loadData() {
        self.cancellation = self.mApplicationRepository.loadItem(self.mEntityId, self.mInclude)
            .mapError({ (error) -> Error in
                debugPrint(error)
                return error
            })
            .sink(receiveCompletion: { _ in }, receiveValue: { result in
                self.Application = result;
        })
    }
}
