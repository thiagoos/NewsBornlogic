//
//  NewsListInteractor.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    func getNews()
}

class NewsInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    func getNews() {
        let apiKey = "8efc9578760a4a7cb6bad468e2375129"
        let apiUrls = [
            "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)",
            "https://newsapi.org/v2/top-headlines?country=br&apiKey=\(apiKey)",
            "https://newsapi.org/v2/top-headlines?country=br&category=technology&apiKey=\(apiKey)",
            "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(apiKey)",
            "https://newsapi.org/v2/top-headlines?country=br&category=sports&apiKey=\(apiKey)",
            "https://newsapi.org/v2/error"
        ]
        
        guard let randomUrl = apiUrls.randomElement(), let url = URL(string: randomUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                self?.presenter?.interactorDidFetchNews(with: .failure(FetchError.failed))
                return
            }
            do {
                let news = try JSONDecoder().decode(News.self, from: data)
                self?.presenter?.interactorDidFetchNews(with: .success(news))
            } catch {
                self?.presenter?.interactorDidFetchNews(with: .failure(error))
            }
        }
        task.resume()
    }
}
