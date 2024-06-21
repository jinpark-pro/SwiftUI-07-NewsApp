//
//  NewsModels.swift
//  NewsApp
//
//  Created by Jungjin Park on 2024-06-21.
//

import Foundation

struct NewsItem: Codable, Identifiable {
    let id = UUID() // for list
    let title: String
    let link: String
    let description: String
    let pubDate: String
    
    enum CodingKeys: String, CodingKey {
        case title, link, description, pubDate
    }
}
// search returns items
struct NewsResponse: Codable {
    let items: [NewsItem]
}
