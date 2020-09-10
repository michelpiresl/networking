//
//  TableViewController.swift
//  NetworkingSampleApp
//
//  Created by Michel Pires Lourenço on 10/09/20.
//  Copyright © 2020 Michel Pires Lourenço. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
        
    let service = BookService()
    var bookList = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Books"
        searchBar.delegate = self
    }
    
    private func searchFor(_ keywords: String) {
        service.search(keywords) { [weak self] (result) in
            switch result {
            case .success(let books):
                self?.bookList = books
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure:
                DispatchQueue.main.async {
                    self?.showErrorAlert()
                }
            }
        }
    }
    
    private func setImageFor(indexPath: IndexPath, from url: URL) {
        service.downloadImage(url) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.bookList[indexPath.row].image = image
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            case .failure:
                break
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "An error occurred while requesting data.", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let book = bookList[indexPath.row]
        cell.textLabel!.text = book.title
        cell.detailTextLabel?.text = book.description
        if let image = book.image {
            cell.imageView?.image = image
        } else {
            if let url = book.thumbnailURL {
                setImageFor(indexPath: indexPath, from: url)

            }
        }
        return cell
    }

}

extension TableViewController: UISearchBarDelegate {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchFor(text)
        }
    }
    
}
