//
//  UIImageView+Extension.swift
//  SearchApp
//
//  Created by Vural Çelik on 28.06.2021.
//

import UIKit
import Alamofire

extension UIImageView {
    var imageCache: NSCache<AnyObject, AnyObject> {
        return NSCache<AnyObject, AnyObject>()
    }
    
    func setImageWithCaching(urlString: String? = nil)  {
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        guard let validatedUrlString = urlString else {
            self.image = Asset.unknownIcon.image
            return
        }
        
        AF.request("https://image.tmdb.org/t/p/w500" + validatedUrlString,
                   method: .get).response { (responseData) in
            if let data = responseData.data {
                DispatchQueue.main.async { [weak self] in
                    if let imageToCache = UIImage(data: data){
                        self?.imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self?.image = imageToCache
                    }
                }
            }
        }
    }
}
