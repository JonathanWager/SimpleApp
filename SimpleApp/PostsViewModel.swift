//
//  PostsViewModel.swift
//  SimpleApp
//
//  Created by Jonathan Wåger on 2023-12-20.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    
    func fetchPosts() {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decodedPosts
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func createPost(title: String, content: String) {
            guard let url = URL(string: "http://localhost:3000/posts") else {
                return
            }

            let timestamp = Date().timeIntervalSince1970
            let newPost = Post(id: String(timestamp), title: title, content: content)

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONEncoder().encode(newPost)
            } catch {
                print("Error encoding JSON: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle response or error as needed
                self.fetchPosts()
            }.resume()
        }
    
    /*func updatePost(post: Post, newContent: String) {
        guard let url = URL(string: "http://localhost:3000/posts/\(post.id)") else {
            return
        }

        var updatedPost = post
        updatedPost.content = newContent

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(updatedPost)
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error as needed
            self.fetchPosts()
        }.resume()
    }

        */
    func updatePost(post: Post) {
        // Create a new Post object with updated title and content
        let updatedPost = Post(id: post.id, title: "update", content: "upadte")

        guard let url = URL(string: "http://localhost:3000/posts/\(post.id)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            // Encode the updated post object in the request body
            request.httpBody = try JSONEncoder().encode(updatedPost)
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error as needed
            self.fetchPosts()
        }.resume()
    }


        func deletePost(post: Post) {
            guard let url = URL(string: "http://localhost:3000/posts/\(post.id)") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle response or error as needed
                self.fetchPosts()
            }.resume()
        }
}

/*
import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts() {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
                DispatchQueue.main.async {
                    self.posts = decodedPosts
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func createPost(title: String, content: String) {
        guard let url = URL(string: "http://localhost:3000/posts") else {
            return
        }
        
        let timestamp = Date().timeIntervalSince1970
        let newPost = Post(id: Int(timestamp),title: title, content: content)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(newPost)
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error as needed
            self.fetchPosts()
        }.resume()
    }
    
    func updatePost(post: Post) {
        guard let url = URL(string: "http://localhost:3000/posts/\(post.id)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(post)
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error as needed
            self.fetchPosts()
        }.resume()
    }

    func deletePost(post: Post) {
        guard let url = URL(string: "http://localhost:3000/posts/\(post.id)") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response or error as needed
            self.fetchPosts()
        }.resume()
    }
}
*/
