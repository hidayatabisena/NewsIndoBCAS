//
//  Zetizen.swift
//  NewsIndo
//
//  Created by Hidayat Abisena on 23/04/24.
//

import Foundation

struct Zetizen: Codable {
    let message: String
    let total: Int
    let data: [Movies]
}

struct Movies: Codable, Identifiable {
    var id: String { link }
    let creator, title: String
    let link: String
    let content: String
    let categories: [String]
    let isoDate: String
    let image: String
}
