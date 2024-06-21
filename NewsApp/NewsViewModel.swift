//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Jungjin Park on 2024-06-21.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var newsItems: [NewsItem] = []
    @Published var errorMessage: String?
    
    private let newsService = NewsService()
    private var cancellables = Set<AnyCancellable>()
    
    func searchNews(query: String) {
        newsService.searchNews(query: query)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                case .finished:
                    self.errorMessage = nil
                }
            }, receiveValue: { newsItems in
                self.newsItems = newsItems
            })
            .store(in: &cancellables)
    }
}
