//
//  NewsService.swift
//  NewsApp
//
//  Created by Jungjin Park on 2024-06-21.
//

import Foundation
import Combine

class NewsService {
    // API request needs header info
    private let clientID = NaverSearchApplicationInfo().clientID
    private let clientSecret = NaverSearchApplicationInfo().clientSecret
    
    func searchNews(query: String) -> AnyPublisher<[NewsItem], Error> {
        guard let url = URL(string: "https://openapi.naver.com/v1/search/news.json?query=\(query)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        // add header info
        var request = URLRequest(url: url)
        request.setValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            // data returns items as JSON
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
