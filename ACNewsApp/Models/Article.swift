//
//  ACArticle.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import Foundation

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
