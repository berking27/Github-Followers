//
//  PersistenceManager.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 28.02.2024.
//

import Foundation

enum PersistanceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    /// Updating array. Remove or add
    /// - Parameters:
    ///   - favorite: selected Follower
    ///   - actionType: deletion or addition
    static func updateWith(favorite: Follower, actionType: PersistanceActionType, completion: @escaping (GFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: favorites))
                
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    
    /// Retrieve favorites from user defaults if there is any. If not return an empty array
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([])) ///Instead of giving error, return an empty array.
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    /// Saves Selected user to favorites array in user Defaults
    /// - Parameter favorites: Favorited Followers array
    /// - Returns: Error
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
