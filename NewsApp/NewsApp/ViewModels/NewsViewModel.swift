//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Chetan N on 23/07/24.
//

import Foundation
import Combine
import SVProgressHUD

class NewsViewModel {
    
    @Published var newsResponseData: [NewsModel] = []
    let apiService : APIService
    let coredataManager: CoredataManager = CoredataManager()
    let networkRecahability: NetworkReachability
    
    // MARK: - Initialisation
    init(apiService: APIService) {
        self.apiService = apiService
        self.networkRecahability = NetworkReachability.shared
    }
    
    // MARK: - fetching records
    func fetchNews() async {
        if networkRecahability.isReachable() {
            do {
                let completeNewsData: NewsResponseModel? = try await apiService.fetchNews(fromUrl: URL(string: ApiEndpoint.mainUrl)!)
                let newsApiData = completeNewsData?.response?.docs ?? []
                newsResponseData = self.getNewsModel(docsData: newsApiData)
                self.coredataManager.deleteAllRecords()
                self.coredataManager.saveNewsData(news: newsResponseData)
            } catch NewsFetchError.networkError {
                print("Network error")
                await self.fetchTheDataFromCoreData()
            } catch NewsFetchError.decodingError {
                print("error while decoing")
            } catch NewsFetchError.httpError(let statusCodes) {
                print("not success \(statusCodes)")
            } catch {
                print("Any other errors mentioned")
            }
        } else {
            await self.fetchTheDataFromCoreData()
        }
    }
    
    // MARK: - fetching record from coredata
    private func fetchTheDataFromCoreData() async {
        do {
            newsResponseData = (try await coredataManager.fetchItemsFromCoreData()).sorted(by: { val1, val2 in
                (val1.date ?? Date() > val2.date ?? Date())
            })
        } catch {
            debugPrint("error fecthing coredata")
        }
    }
    
    // MARK: - supportive methods
    private func getNewsModel(docsData: [Docs]) -> [NewsModel] {
        let finalModelArr : [NewsModel] = docsData.map { doc in
            NewsModel(headLine: doc.headline?.main, description: doc.abstract, imageUrl: doc.multimedia?.first?.url, date: doc.pub_date?.getDateFromString())
        }
        return finalModelArr.sorted(by: { val1, val2 in
            (val1.date ?? Date() > val2.date ?? Date())
        })
    }
}
