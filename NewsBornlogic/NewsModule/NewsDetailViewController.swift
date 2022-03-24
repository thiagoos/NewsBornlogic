//
//  NewsDetailViewController.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import UIKit

class NewsDetailViewController: UIViewController {
    // MARK: - Variable
    var article: Article?
    
    // MARK: - UI
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let stackViewTitle: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let viewNewsInformation: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let stackViewNewsInformation: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelAuthor: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.numberOfLines = 0
        return label
    }()
    
    let labelSource: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let labelPublishedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let labelContent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    let stackViewContent: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let stackViewLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonOpenNews: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(openExternalLinkTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "externalLink"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Life Cycle
    init(with article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupData()
        setupUI()
    }
    
    // MARK: - Function
    @objc fileprivate func buttonShareTapped() {
        let string = "Veja esse artigo que interessante!"
        var urlToShare = URL(string: "http://www.google.com")!
        
        if let urlArticle = article?.url, let url = URL(string: urlArticle) {
            urlToShare = url
        }
        
        let sharedObjects = [urlToShare as AnyObject, string as AnyObject]
        let activityViewController = UIActivityViewController(activityItems : sharedObjects, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToTwitter, UIActivity.ActivityType.mail]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    fileprivate func setupController() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        let barButtonRight = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(buttonShareTapped))
        self.navigationItem.rightBarButtonItem = barButtonRight
        
        title = article?.source?.name
    }
    
    fileprivate func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewContainer)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        viewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        viewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        viewContainer.addSubview(imageView)
        viewContainer.addSubview(stackViewLabels)
        
        viewNewsInformation.addSubview(stackViewNewsInformation)
        viewNewsInformation.addSubview(buttonOpenNews)
        
        stackViewTitle.addArrangedSubview(labelTitle)
        
        stackViewLabels.addArrangedSubview(stackViewTitle)
        stackViewLabels.addArrangedSubview(viewNewsInformation)
        
        stackViewNewsInformation.addArrangedSubview(labelAuthor)
        stackViewNewsInformation.addArrangedSubview(labelSource)
        stackViewNewsInformation.addArrangedSubview(labelPublishedDate)
        
        stackViewContent.addArrangedSubview(labelDescription)
        stackViewContent.addArrangedSubview(labelContent)
        stackViewLabels.addArrangedSubview(stackViewContent)
        
        stackViewTitle.layoutMargins = .init(top: 8, left: 8, bottom: 0, right: 8)
        stackViewTitle.isLayoutMarginsRelativeArrangement = true
        
        stackViewContent.layoutMargins = .init(top: 0, left: 8, bottom: 0, right: 8)
        stackViewContent.isLayoutMarginsRelativeArrangement = true
        
        stackViewNewsInformation.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackViewNewsInformation.isLayoutMarginsRelativeArrangement = true
        
        imageView.topAnchor.constraint(equalTo: viewContainer.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        stackViewLabels.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        stackViewLabels.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor).isActive = true
        stackViewLabels.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor).isActive = true
        stackViewLabels.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
        
        stackViewNewsInformation.topAnchor.constraint(equalTo: viewNewsInformation.topAnchor).isActive = true
        stackViewNewsInformation.leadingAnchor.constraint(equalTo: viewNewsInformation.leadingAnchor).isActive = true
        stackViewNewsInformation.trailingAnchor.constraint(equalTo: viewNewsInformation.trailingAnchor).isActive = true
        stackViewNewsInformation.bottomAnchor.constraint(equalTo: viewNewsInformation.bottomAnchor).isActive = true
        
        buttonOpenNews.trailingAnchor.constraint(equalTo: viewNewsInformation.trailingAnchor, constant: -32).isActive = true
        buttonOpenNews.centerYAnchor.constraint(equalTo: viewNewsInformation.centerYAnchor).isActive = true
        buttonOpenNews.widthAnchor.constraint(equalToConstant: 20).isActive = true
        buttonOpenNews.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    fileprivate func setupData() {
        guard let article = article else { return }
        if let urlToImage = article.urlToImage, let url = URL(string: urlToImage) {
            imageView.load(url: url, placeholder: UIImage(named: "placeholder"))
        }
        labelTitle.text = article.title
        labelAuthor.text = "Publicado por: \(article.author ?? "Autor desconhecido")"
        labelSource.text = "Fonte: \(article.source?.name ?? "Desconhecida")"
        labelPublishedDate.text = "Publicado: \(article.publishedAt?.toDateBR() ?? "")"
        labelDescription.text = article.description
        labelContent.text = article.content
    }
    
    @objc fileprivate func openExternalLinkTapped() {
        if let urlArticle = article?.url, let url = URL(string: urlArticle) {
            self.navigationController?.pushViewController(NewsWebViewController(url: url, source: article?.source?.name ?? "Desconhecida"), animated: true)
        }
    }
}
