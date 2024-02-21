//
//  GFAvatarImageView.swift
//  TakeHomeProject
//
//  Created by Berkin KOCA on 14.02.2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: "avatar-placeholder")

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        let cacheKey = NSString(string: urlString)
        
        ///If Image is inside cache than it change image directly or return and do other operations
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if error != nil { return }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            //Settin image into Cache
            self.cache.setObject(image, forKey: cacheKey)
            
            ///Since  image change will affect UI so that it should run in main thread.
            DispatchQueue.main.async { self.image = image }
            
        }
        
        task.resume()
    }


}
