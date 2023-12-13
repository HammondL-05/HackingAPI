//
//  ContentView.swift
//  HackingAPI
//
//  Created by Leo Hammond on 13/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            fetchNewsIDs { result in
                switch result {
                case .success(let newsIDs):
                    let storyIDs = newsIDs
                    fetchNews(storyIDs: storyIDs) { result in
                        switch result {
                        case .success(let newsStories):
                            for story in newsStories {
                                print("Title: \(story.title)\nURL: \(story.url)\n")
                            }
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
