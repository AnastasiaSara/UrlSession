//
//  Аrticle.swift
//  UrlSession_0
//
//  Created by Настя Сарамуд on 10.03.2024.
//
import Foundation

struct Response: Decodable {
    let results: [Article]
}

struct Article: Decodable {
    let section: String?
    let title: String?
    let abstract: String?
    let byline: String?
    let source: String?
    let publishedDate: String?
    let updated: String?
    let media: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case section, title, abstract, byline, source, updated, media
        case publishedDate = "published_date"
    }
}

struct Media: Decodable {
    let mediaMetadata: [MediaMetadata]?

    enum CodingKeys: String, CodingKey {
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetadata: Decodable {
    let url: URL?
}
