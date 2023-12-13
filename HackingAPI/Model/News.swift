//
//  News.swift
//  HackingAPI
//
//  Created by Leo Hammond on 13/12/2023.
//

import Foundation

struct NewsStory: Decodable {
    var title: String
    var url: String
}

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidData
}
