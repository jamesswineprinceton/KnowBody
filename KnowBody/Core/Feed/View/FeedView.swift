//
//  FeedView.swift
//  KnowBody
//
//  Created by James Swinehart on 7/30/25.
//

import SwiftUI

struct FeedView: View {
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        Color.clear.frame(height: 0).id("top") // ID for scrolling
                        ForEach(viewModel.posts) { post in
                            PostCell(post: post)
                        }
                    }
                }
                .refreshable {
                    Task { try await viewModel.fetchPosts() }
                }
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation {
                                proxy.scrollTo("top", anchor: .top)
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image("feedlogo")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                Text("KnowBody")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedView()
        }
    }
}
