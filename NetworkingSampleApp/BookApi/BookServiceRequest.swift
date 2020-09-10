//
//  BookServiceRequest.swift
//  NetworkingSampleApp
//
//  Created by Michel Pires Lourenço on 10/09/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Networking

struct BookServiceRequest: HTTPRequest {
    
    var baseURL: String {
        return "https://www.googleapis.com/books/v1/"
    }
    
    var path: String {
        return "volumes"
    }
    
    var method: HTTPRequestMethod {
        return .get
    }
    
    var header: [String : String]?
    
    var parameters: HTTPRequestParameters? {
        return .urlParameters([
            "q": keywords,
            "maxResults": "40"
        ])
    }
    
    let keywords: String
    
    init(keywords: String) {
        self.keywords = keywords
    }
    
}
