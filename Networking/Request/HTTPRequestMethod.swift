//
//  HTTPRequestMethod.swift
//  beagleNewsPOC
//
//  Created by Michel Pires Lourenço on 10/08/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Foundation

public enum HTTPRequestMethod: String {
    
    case get
    case post
    
    var name: String {
        return self.rawValue.uppercased()
    }
    
}
