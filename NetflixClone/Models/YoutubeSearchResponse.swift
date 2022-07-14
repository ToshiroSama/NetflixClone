//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by Alisher Djuraev on 14/07/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [Video]
}

struct Video: Codable {
    let id: VideoElement
}

struct VideoElement: Codable {
    let kind: String
    let videoId: String
}
