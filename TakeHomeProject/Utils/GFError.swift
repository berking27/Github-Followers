//
//  GFError.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 14.02.2024.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please Try Again."
    case invalidData        = "The Data recieved from the server was invalid. Please Try Again!"
    case unableToFavorite   = "There was an error favoriting this user. Please Try Again"
    case alreadyInFavorites = "You've already favorited this user.🤨"
}
