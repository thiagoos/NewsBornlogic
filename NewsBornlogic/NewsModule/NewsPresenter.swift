//
//  NewsListPresenter.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import Foundation

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    var news: News? { get set }
    var isLoading: Bool { get set }
    
    func numberOfRows() -> Int
    func interactorDidFetchNews(with result: Result<News,Error>)
}

class NewsPresenter: AnyPresenter {
    var router: AnyRouter?
    var view: AnyView?
    var news: News?
    var isLoading: Bool = true
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getNews()
        }
    }
    
    func interactorDidFetchNews(with result: Result<News, Error>) {
        switch result {
        case .success(let news):
            self.news = news
            self.isLoading = false
            view?.update(with: news)
            
        case .failure:
            self.isLoading = false
            view?.update(with: "Falha no carregamento das notícias, tente novamente...")
        }
    }
    
    func numberOfRows() -> Int {
        guard let articles = news?.articles else { return 0 }
        return articles.count
    }
}
