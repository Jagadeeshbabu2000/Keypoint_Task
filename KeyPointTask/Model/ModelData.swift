//
//  ModelData.swift
//  KeyPointTask
//
//  Created by Jagadeesh on 05/07/24.
//

import Foundation

struct BannerModel: Codable {
    let data: [Datum]
}

struct Datum: Codable {
    let title: String
    let imageMobile, imageDesktop: String
}
//YouTube Model

struct YouTubeModel: Codable {
    let id, title: String
    let thumbnailURL: String
    let duration, uploadTime, views, author: String
    let videoURL: String
    let description, subscriber: String
    let isLive: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case thumbnailURL = "thumbnailUrl"
        case duration, uploadTime, views, author
        case videoURL = "videoUrl"
        case description, subscriber, isLive
    }
}

typealias Welcome = [YouTubeModel]

