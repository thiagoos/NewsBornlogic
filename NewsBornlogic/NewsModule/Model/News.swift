//
//  News.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import Foundation

struct News: Decodable {
    let status: String?
    let totalResults: Int?
    var articles: [Article]?
}

struct Article: Decodable {
    let source: Source?
    var author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
