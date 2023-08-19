//
//  File.swift
//  
//
//  Created by Yoga Prasetyo on 19/08/23.
//

import Combine

public protocol UseCase {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
