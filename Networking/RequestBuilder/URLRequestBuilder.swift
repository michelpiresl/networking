//
//  URLRequestBuilder.swift
//  beagleNewsPOC
//
//  Created by Michel Pires Lourenço on 13/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

public protocol URLRequestBuilder {
    
    func build(_ request: HTTPRequest) -> URLRequest?
    
}


