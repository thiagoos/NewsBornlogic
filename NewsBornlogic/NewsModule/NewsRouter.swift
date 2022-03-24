//
//  NewsListRouter.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}

class NewsRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = NewsRouter()
        
        var view: AnyView = NewsListViewController()
        var presenter: AnyPresenter = NewsPresenter()
        var interactor: AnyInteractor = NewsInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
