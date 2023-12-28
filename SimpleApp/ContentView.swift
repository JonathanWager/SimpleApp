//
//  ContentView.swift
//  SimpleApp
//
//  Created by Jonathan Wåger on 2023-12-20.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var newPostTitle = ""
    @State private var newPostContent = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Title", text: $newPostTitle)
                    .padding()
                TextField("Content", text: $newPostContent)
                    .padding()
                Button("Create Post") {
                    viewModel.createPost(title: newPostTitle, content: newPostContent)
                    newPostTitle = ""
                    newPostContent = ""
                }
            }

            Button("Fetch Posts") {
                viewModel.fetchPosts()
            }

            List(viewModel.posts, id: \.id) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.content)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                HStack {
                    Button("Update") {
                        viewModel.updatePost(post: post)
                    }
                }
                HStack{
                    Button("Delete") {
                        viewModel.deletePost(post: post)
                    }
                }
            }
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
