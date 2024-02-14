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
    ///   - completion: Data will return as Follower if no follower it return String (Error)
    ///                 Both should optional because if there is no error there should be followers also opposite of this situation ok
    func getFollowers(for username: String, page: Int, completion: @escaping ([Follower]?, String?) -> Void) {
        ///Creating endpoint
        let endpoint = baseUrl + "\(username)/followers?per_page=60&page=\(page)"
        
        ///Check if url valid
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created an invalid request. Please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            ///Check if error exists
            if let _ = error {
                completion(nil, "Unable to complete your request. Please check your internet connection")
                return
            }
            
            ///Check if response valid and response code OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
             completion(nil, "Invalid response from the server. Please Try Again.")
                return
            }
            
            //Check if there is any data
            guard let data = data else {
                completion(nil, "The Data recieved from the server was invalid. Please Try Again!")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil) ///Getting Data without any error
                
            } catch {
                completion(nil, "The Data recieved from the server was invalid. Please Try Again!")
            }
            
        }
        
        ///To start task
        task.resume()
    }
}
