//
//  News.swift
//  NewsIndo
//
//  Created by Hidayat Abisena on 23/04/24.
//

import Foundation

struct News: Codable {
    let messages: String
    let total: Int
    let data: [NewsArticle]
}

struct NewsArticle: Codable, Identifiable {
    var id: String { link }
    let creator, title: String
    let link: String
    let author: String
    let categories: [String]
    let isoDate, description: String
    let image: Image
}

struct Image: Codable {
    let small, medium, large, extraLarge: String
}
