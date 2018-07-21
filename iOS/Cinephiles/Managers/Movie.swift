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
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var relaseDate: String?
    var genreId: [Int]?

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        popularity <- map["popularity"]
        overview <- map["overview"]
        relaseDate <- map["relase_date"]
        genreId <- map["genre_ids"]
        posterPath <- map["poster_path"]
        backdropPath <- map["backdrop_path"]
    }

}

extension Movie: Hashable {

    var hashValue: Int {
        return ((title ?? "") + (overview ?? "") + (relaseDate ?? "")).hashValue
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title
            && lhs.overview == rhs.overview
            && lhs.relaseDate == rhs.relaseDate
    }

}
