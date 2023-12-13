//
//  NewsFetcher.swift
//  HackingAPI
//
//  Created by Leo Hammond on 13/12/2023.
//

import Foundation

func fetchNews(completion: @escaping (Result<[NewsStory], APIError>) -> Void) {
    
    let apiEndpoint = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"

    guard let url = URL(string: apiEndpoint) else {
        completion(.failure(.invalidURL))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error: \(error)")
            completion(.failure(.requestFailed))
            return
        }

        guard let data = data else {
            completion(.failure(.invalidData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let newsStories = try decoder.decode([NewsStory].self, from: data)
            completion(.success(newsStories))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.invalidData))
        }
    }

    task.resume()
}
