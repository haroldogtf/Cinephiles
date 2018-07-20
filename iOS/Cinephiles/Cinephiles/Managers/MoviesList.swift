//
//  Movies.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import ObjectMapper

class MoviesList: Mappable  {

    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var movies: [Movies]?

    required init?(map: Map) { }

    func mapping(map: Map) {
        page <- map["page"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
        movies <- map["results"]
    }

}

class Movies: Mappable  {
    
    var title: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
    }
    
}
