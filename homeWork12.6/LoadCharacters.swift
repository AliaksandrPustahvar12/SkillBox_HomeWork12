//
//  LoadCharacters.swift
//  homeWork12.6
//
//  Created by Aliaksandr Pustahvar on 20.10.22.
//

import Foundation
import Alamofire 

class CharactersLoader {
    
    static func parseJson<T: Decodable>(from urlString: String) async -> T? {
        guard let url = URL(string: urlString) else {return nil}
        return try? await AF.request(url).serializingDecodable(T.self).value
    }
    
   static func getChImage (from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString), let data = try? await
                 AF.request(url).serializingData().value else { return nil }
        return UIImage(data: data)
    }
}

    
    
    

            
 
