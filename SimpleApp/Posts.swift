//
//  Posts.swift
//  SimpleApp
//
//  Created by Jonathan Wåger on 2023-12-20.
//

import Foundation

struct Post: Codable{
    let id: String
    var title: String
    var content: String
}
