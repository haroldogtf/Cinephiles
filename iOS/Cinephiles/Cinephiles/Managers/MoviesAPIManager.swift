//
//  MoviesAPIManager.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import Alamofire
import AlamofireObjectMapper

class MoviesAPIManager: NSObject {

    class func getPopupar(page: Int, completion: @escaping (_ list: [Movies], _ error: Error?) -> ()) {

        let parameters: Parameters = [
            "api_key": "1f54bd990f1cdfb230adb312546d765d",
            "language": "en-US",
            "page": page
        ]
        
        let url = "https://api.themoviedb.org/3/movie/popular"
        
        Alamofire.request(url, method: .get, parameters: parameters).responseObject { (response: DataResponse<MoviesList>) in
            
            if let movies = response.result.value?.movies {
                completion(movies, nil)
            } else {
                completion([], response.error)
            }
        }
    }

}
