//
//  File.swift
//  
//
//  Created by Yoga Prasetyo on 18/08/23.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
