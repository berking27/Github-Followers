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
    ///   - completion: Returns Result in failure case it retruns Failure, in Success case it returns [Follower]
    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
        ///Creating endpoint
        let endpoint = baseUrl + "\(username)/followers?per_page=60&page=\(page)"
        
        ///Check if url valid
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            ///Check if error exists
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            ///Check if response valid and response code OK
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            ///Check if there is any data
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(.success(followers))
                
            } catch {
                    completion(.failure(.invalidData))
            }
            
        }
        
        ///To start task
        task.resume()
    }
}
