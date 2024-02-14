//
//  NetworkManager.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 14.02.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    
    /// Get followers method
    /// - Parameters:
    ///   - username: Follower username
    ///   - page: For Pagination
    ///   - completion: Data will return as Follower if no follower it'll return ErrorMessage (Enum Error)
    ///                 Both should optional because if there is no error there should be followers also opposite of this situation ok
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        ///Creating endpoint
        let endpoint = baseUrl + "\(username)/followers?per_page=60&page=\(page)"
        
        ///Check if url valid
        guard let url = URL(string: endpoint) else {
            completion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            ///Check if error exists
            if let _ = error {
                completion(nil, .unableToComplete)
                return
            }
            
            ///Check if response valid and response code OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            ///Check if there is any data
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil) ///Getting Data without any error
                
            } catch {
                completion(nil, .invalidData)
            }
            
        }
        
        ///To start task
        task.resume()
    }
}
