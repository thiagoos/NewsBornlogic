//
//  Extensions.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import UIKit

extension String {
    func toDateBR() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date1 = formatter.date(from: self)
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        let resultTime = formatter.string(from: date1!)
        return resultTime
    }
}

extension UIImageView {
    func load(url: URL, placeholder: UIImage?, cache: URLCache? = nil) {
        let cache = cache ?? URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
                self.contentMode = .scaleAspectFill
            }
        } else {
            self.image = placeholder
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self.image = image
                        self.contentMode = .scaleAspectFill
                    }
                }
            }).resume()
        }
    }
}
