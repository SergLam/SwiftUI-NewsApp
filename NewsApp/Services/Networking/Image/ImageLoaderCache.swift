//
//  ImageLoaderCache.swift
//  NewsApp
//
//  Created by Serhii Liamtsev on 2/22/22.
//  Copyright © 2022 Tatiana Kornilova. All rights reserved.
//

import UIKit
import Combine

final class ImageLoaderCache {
    static let shared = ImageLoaderCache()
    var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    func loaderFor(article: ArticleJSON) -> ImageLoader {
        let key = NSString(string: "\(article.title)")
        if let loader = loaders.object(forKey: key) {
            return loader
        } else {
            let url = (article.urlToImage != nil && article.urlToImage != "null")
                ? URL(string: article.urlToImage!)
                : nil
            let loader = ImageLoader (url: url)
            loaders.setObject(loader, forKey: key)
            return loader
        }
    }
}
