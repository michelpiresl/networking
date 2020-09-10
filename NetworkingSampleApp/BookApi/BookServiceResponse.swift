//
//  BookServiceResponse.swift
//  NetworkingSampleApp
//
//  Created by Michel Pires Lourenço on 10/09/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Networking

struct BookServiceResponse: Codable {
    var totalItems: Int?
    var items: [BookServiceResponseItems]?
    
    struct BookServiceResponseItems: Codable {
        var volumeInfo: BookServiceResponseItemsVolumeInfo?
        
        struct BookServiceResponseItemsVolumeInfo: Codable {
            var title: String?
            var authors: [String]?
            var description: String?
            var imageLinks: BookServiceResponseItemsVolumeInfoImageLinks?
            
            struct BookServiceResponseItemsVolumeInfoImageLinks: Codable {
                var smallThumbnail: URL?
            }
        }
    }
}
