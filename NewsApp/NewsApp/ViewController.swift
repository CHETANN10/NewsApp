//
//  ViewController.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import UIKit
import Combine
import SVProgressHUD

class ViewController: UIViewController {

    let newsViewModel = NewsViewModel(apiService: APIService())
    
    var cancellableArr = Set<AnyCancellable>()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        fectchRecords()
        
        self.newsTableView.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
    }
    
    // MARK: - fetching record method
    private func fectchRecords() {
        SVProgressHUD.show()
        Task {
            await newsViewModel.fetchNews()
        }
    }

    // MARK: - binding method
    private func bindViewModel() {
        newsViewModel.$newsResponseData.sink { dataModel in
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
                if !dataModel.isEmpty {
                    SVProgressHUD.dismiss()
                }
            }
        }.store(in: &cancellableArr)
    }
}


// MARK: - UITableViewDelegate and UITableViewDataSource methods
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.newsViewModel.newsResponseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.newsData(doc: self.newsViewModel.newsResponseData[indexPath.row])
        return cell
    }
}

