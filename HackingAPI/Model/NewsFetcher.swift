//
//  NewsFetcher.swift
//  HackingAPI
//
//  Created by Leo Hammond on 13/12/2023.
//

import Foundation

func fetchNewsIDs(completion: @escaping (Result<[Int], APIError>) -> Void) {
    
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
            let newsIDs = try decoder.decode([Int].self, from: data)
            completion(.success(newsIDs))
        } catch {
            print("Error decoding JSON: \(error)")
            completion(.failure(.invalidData))
        }
    }

    task.resume()
}

func fetchNews(storyIDs: [Int], completion: @escaping (Result<[NewsStory], APIError>) -> Void) {
    let newsFetchGroup = DispatchGroup()
    var newsStories: [NewsStory] = []

    for storyID in storyIDs {
        newsFetchGroup.enter()

        let apiEndpoint = "https://hacker-news.firebaseio.com/v0/item/\(storyID).json?print=pretty"

        guard let url = URL(string: apiEndpoint) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            defer {
                newsFetchGroup.leave()
            }

            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data else {
                return
            }

            do {
                let decoder = JSONDecoder()
                let newsStory = try decoder.decode(NewsStory.self, from: data)
                newsStories.append(newsStory)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }

        task.resume()
    }

    newsFetchGroup.notify(queue: DispatchQueue.main) {
        completion(.success(newsStories))
    }
}
