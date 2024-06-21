//
//  ContentView.swift
//  NewsApp
//
//  Created by Jungjin Park on 2024-06-21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var query: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField("검색", text: $query)
                    Button("검색") {
                        viewModel.searchNews(query: query)
                    }
                }
                .padding()
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(Color.red)
                        .padding()
                }
                List(viewModel.newsItems) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.headline)
                        Text(item.description)
                        Text(item.pubDate)
                            .font(.caption)
                        Link("Read more", destination: URL(string: item.link)!)
                            .font(.caption)
                            .foregroundStyle(Color.blue)
                    }
                    .padding()
                }
            }
            .navigationTitle("Naver News Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
