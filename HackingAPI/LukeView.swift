//
//  LukeView.swift
//  HackingAPI
//
//  Created by Vereker, Luke (PRKB) on 13/12/2023.
//

import SwiftUI

struct NewsStory: Identifiable {
    let id = UUID()
    let title: String
    let url: URL
}

struct LukeView: View {
    let stories: [NewsStory] = [NewsStory]()
    var body: some View {
        Text("Hello Luke")
    }
}

#Preview {
    LukeView()
}
