//
//  File.swift
//  
//
//  Created by Yoga Prasetyo on 19/08/23.
//

import Foundation
import Combine

// MARK: Watch-out different code from reference project
public class GetListPresenter<Request, Response, Interactor: UseCase> where Interactor.Request == Request, Interactor.Response == [Response] {
    
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: Interactor
    
    @Published public var list: [Response] = []
    @Published public var errorMessage: String = ""
    @Published public var isLoading: Bool = false
    @Published public var isError: Bool = false
    
    public init(useCase: Interactor) {
        self.useCase = useCase
    }
    
    public func getList(request: Request?) {
        isLoading = true
        self.useCase.execute(request: request)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.isError = true
                        self.isLoading = false
                    case .finished:
                        self.isLoading = false
                    }
                },
                receiveValue: { list in
                    self.list = list
                }
            ).store(in: &cancellables)
    }
}
