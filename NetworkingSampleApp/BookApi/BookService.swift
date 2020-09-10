//
//  BookService.swift
//  NetworkingSampleApp
//
//  Created by Michel Pires Lourenço on 10/09/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import Networking
import UIKit

enum BookServiceError: Error {
    
    case emptyData
    case networking
    case imageError
    
}

class BookService: NetworkService {
    
    var dispatcher: NetworkDispatcher = DefaultNetworkDispatcher(with: DefaultURLRequestBuilder(), for: URLSession.shared)
    
    func search(_ keywords: String, completion: @escaping (Result<[Book], BookServiceError>) -> ()) {
        let request = BookServiceRequest(keywords: keywords)
        dispatcher.execute(request, to: BookServiceResponse.self) { (result) in
            switch result {
            case .success(let response):
                guard let responseData = response else {
                    completion(.failure(.emptyData))
                    return
                }
                guard let items = responseData.items else {
                    completion(.success([]))
                    return
                }
                let bookList: [Book] = items.map {
                    Book(title: $0.volumeInfo?.title ?? "",
                         authors: $0.volumeInfo?.authors ?? [],
                         description: $0.volumeInfo?.description ?? "",
                         thumbnailURL: $0.volumeInfo?.imageLinks?.smallThumbnail)
                }
                completion(.success(bookList))
            case .failure:
                completion(.failure(.networking))
            }
        }
    }
    
    func downloadImage(_ url: URL, completion: @escaping (Result<UIImage, BookServiceError>) -> ()) {
        dispatcher.execute(url) { (result) in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else {
                    completion(.failure(.imageError))
                    return
                }
                completion(.success(image))
            case .failure:
                completion(.failure(.networking))
            }
        }
    }
    
}
