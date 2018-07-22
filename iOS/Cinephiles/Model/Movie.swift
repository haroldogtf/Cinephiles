//
//  Movie.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import ObjectMapper

class MoviesList: Mappable  {

    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var movies: [Movie]?

    required init?(map: Map) { }

    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        movies <- map["results"]
    }

}

class Movie: Mappable  {
    
    var title: String?
    var popularity: Double?
    var voteAverage: Double?
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var genreId: [Int]?

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        popularity <- map["popularity"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
        releaseDate <- map["release_date"]
        genreId <- map["genre_ids"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
    }

}

extension Movie: Hashable {

    var hashValue: Int {
        return ((title ?? "") + (overview ?? "") + (releaseDate ?? "")).hashValue
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title
            && lhs.overview == rhs.overview
            && lhs.releaseDate == rhs.releaseDate
    }

}
