//
//  NewsListCollectionViewCell.swift
//  NewsBornlogic
//
//  Created by Thiago Soares on 22/03/22.
//

import UIKit

class NewsListCollectionViewCell: UICollectionViewCell {
    //MARK: - Variable
    static let ReusableId = "NewsListCollectionViewCell"
    
    // MARK: UI
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let labelTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelPublishedDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .systemGray4
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackViewLabels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    func setupUI() {
        stackViewLabels.addArrangedSubview(labelTitle)
        stackViewLabels.addArrangedSubview(labelPublishedDate)
        
        stackViewLabels.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        stackViewLabels.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(stackViewLabels)
        addSubview(stackView)
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isHidden = true
    }
    
    func setupData(with article: Article) {
        stackView.isHidden = false
        if let url = URL(string: article.urlToImage ?? "https://prolinkveiculos.com.br/images/news-default-image.jpg") {
            imageView.load(url: url, placeholder: UIImage(named: "placeholder"))
        }
        labelTitle.text = article.title
        labelPublishedDate.text = article.publishedAt?.toDateBR()
    }
}
