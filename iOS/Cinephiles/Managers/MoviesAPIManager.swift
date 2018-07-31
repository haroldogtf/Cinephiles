//
//  MoviesAPIManager.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import Alamofire
import AlamofireObjectMapper

class MoviesAPIManager: NSObject {

    class func getPopular(page: Int, completion: @escaping (_ list: [Movie], _ error: Error?) -> ()) {

        let parameters: Parameters = [
            "api_key": Constants.API_KEY,
            "language": Constants.API_LANGUAGE,
            "page": page
        ]
        
        let url = Constants.API_URL + "/movie/popular"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject { (response: DataResponse<MoviesList>) in
            
            if let movies = response.result.value?.movies {
                completion(movies, nil)
            } else {
                completion([], response.error)
            }
        }
    }

    class func searchBy(string: String, completion: @escaping (_ list: [Movie], _ error: Error?) -> ()) {
        
        let parameters: Parameters = [
            "api_key": Constants.API_KEY,
            "language": Constants.API_LANGUAGE,
            "query": string
        ]
        
        let url = Constants.API_URL + "/search/movie"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject { (response: DataResponse<MoviesList>) in
            
            if let movies = response.result.value?.movies {
                completion(movies, nil)
            } else {
                completion([], response.error)
            }
        }
    }

}
