//
//  NetworkManager.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 14.02.2024.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    
    
    /// Network calls Swift Concurency way
    /// - Parameters:
    /// - Returns: Throw means if there is error throw the error, In succes case return an Array of Follower
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        ///Creating endpoint
        let endpoint = baseUrl + "\(username)/followers?per_page=60&page=\(page)"
        
        ///Check if url valid
        guard let url = URL(string: endpoint) else { throw GFError.invalidUsername }
        
        /// Handles error, tasks , Tuple returns a tuple that is not optional
        let (data, response) = try await URLSession.shared.data(from: url)
        
        ///Check if response valid and response code OK
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }

    
    
    func getUserInfo(for username: String) async throws -> User {
        ///Creating endpoint
        let endpoint = baseUrl + "\(username)"
        
        guard let url = URL(string: endpoint) else { throw GFError.invalidUsername}
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw GFError.invalidResponse }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    //There is only async because This func don't care about errors!
     func downloadImage(from urlString: String) async -> UIImage? {
          let cacheKey = NSString(string: urlString)
         
          ///If Image is inside cache than it change image directly or return and do other operations
          if let image = cache.object(forKey: cacheKey) { return image }
         
          guard let url = URL(string: urlString) else { return nil }
         
             do {
                 let (data, _) = try await URLSession.shared.data(from: url)
                 guard let image = UIImage(data: data) else { return nil }
                 cache.setObject(image, forKey: cacheKey)
                 return image
             } catch {
                 return nil
             }
     }
}



//MARK: Old Network Calls (Result Type and completion)

//    /// Get followers method
//    /// - Parameters:
//    ///   - username: Follower username
//    ///   - page: For Pagination
//    ///   - completion: Returns Result in failure case it retruns Failure, in Success case it returns [Follower]
//    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GFError>) -> Void) {
//        ///Creating endpoint
//        let endpoint = baseUrl + "\(username)/followers?per_page=60&page=\(page)"
//
//        ///Check if url valid
//        guard let url = URL(string: endpoint) else {
//            completion(.failure(.invalidUsername))
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            ///Check if error exists
//            if let _ = error {
//                completion(.failure(.unableToComplete))
//                return
//            }
//
//            ///Check if response valid and response code OK
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//
//            ///Check if there is any data
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
//                let followers = try decoder.decode([Follower].self, from: data)
//                completion(.success(followers))
//
//            } catch {
//                    completion(.failure(.invalidData))
//            }
//
//        }
//
//        ///To start task
//        task.resume()
//    }


//func getUserInfo(for username: String, completion: @escaping (Result<User, GFError>) -> Void) {
//    ///Creating endpoint
//    let endpoint = baseUrl + "\(username)"
//    
//    ///Check if url valid
//    guard let url = URL(string: endpoint) else {
//        completion(.failure(.invalidUsername))
//        return
//    }
//    
//    let task = URLSession.shared.dataTask(with: url) { data, response, error in
//        
//        ///Check if error exists
//        if let _ = error {
//            completion(.failure(.unableToComplete))
//            return
//        }
//        
//        ///Check if response valid and response code OK
//        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//        
//        ///Check if there is any data
//        guard let data = data else {
//            completion(.failure(.invalidData))
//            return
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase ///Converting snake_Case to camleCase
//            decoder.dateDecodingStrategy = .iso8601
//            let user = try decoder.decode(User.self, from: data)
//            completion(.success(user))
//            
//        } catch {
//                completion(.failure(.invalidData))
//        }
//        
//    }
//    
//    ///To start task
//    task.resume()
//}
