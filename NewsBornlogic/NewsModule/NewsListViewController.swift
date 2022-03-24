//
//  NewsListViewController.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    func update(with news: News)
    func update(with error: String)
}

class NewsListViewController: UICollectionViewController, AnyView {
    // MARK: - Variables
    var presenter: AnyPresenter?
    
    // MARK: - UI
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.startAnimating()
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transform
        activityIndicator.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupUI()
    }
    
    //MARK: - Functions
    func update(with news: News) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            
            let alertDialog = UIAlertController(title: "Erro", message: error, preferredStyle: .alert)
            alertDialog.addAction(UIAlertAction(title: "Ok", style: .default, handler: { alertAction in
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
                self.presenter?.interactor?.getNews()
            }))
            self.present(alertDialog, animated: true)
        }
    }
    
    fileprivate func setupController() {
        title = "News App"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        
        collectionView.backgroundColor = .systemGray5
        collectionView.register(NewsListCollectionViewCell.self, forCellWithReuseIdentifier: NewsListCollectionViewCell.ReusableId)
        collectionView.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(buttonInfoTapped), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem
    }
    
    @objc fileprivate func buttonInfoTapped() {
        let alertController = UIAlertController(title: "Observações", message: "Cada refresh, está sendo chamado a API com características diferentes.\n\nInclusive está sendo chamado API com erro propositalmente.\n\nUse puxar para atualizar a página.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true) {
        }
    }
    
    fileprivate func setupUI() {
        view.addSubview(activityIndicator)
        activityIndicator.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc fileprivate func refreshNews() {
        self.presenter?.interactor?.getNews()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let presenter = self.presenter else { return 0 }
        return presenter.isLoading ? 3 : self.presenter?.numberOfRows() ?? 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let defaultCell = UICollectionViewCell()
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsListCollectionViewCell.ReusableId, for: indexPath) as? NewsListCollectionViewCell, let presenter = presenter else { return defaultCell }
        if presenter.isLoading {
            return cell
        }
        guard let articles = self.presenter?.news?.articles else { return defaultCell }
        cell.setupData(with: articles[indexPath.row])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let articles = self.presenter?.news?.articles else { return }
        self.navigationController?.pushViewController(NewsDetailViewController(with: articles[indexPath.row]), animated: true)
    }
}


extension NewsListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (view.frame.width / 2) - 26, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 16, bottom: 16, right: 16)
    }
}
