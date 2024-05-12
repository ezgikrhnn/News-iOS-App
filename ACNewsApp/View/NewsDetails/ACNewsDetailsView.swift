//
//  ACNewsDetailsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit
import SDWebImage

class ACNewsDetailsView: UIView {

    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(scrollView)
         // ScrollView içine contentView ekleniyor.
        contentView.addSubviews(newsImage, titleLabel, contentLabel, authorImage, authorNameLabel, dateImage, publishDateLabel, viewSourceButton)  // İçerik öğeleri contentView içine ekleniyor.
            
        scrollView.addSubview(contentView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Properties
    var viewModel: ACNewsDetailsViewModel? {
            didSet {}
    }

    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: 500, height: 800)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        }()
    
    var newsImage : UIImageView = {
        let imageee = UIImage(named: "pencil")
        let imageView = UIImageView(image: imageee)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var titleLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 25, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var authorImage : UIImageView = {
        let newspaper = UIImage(systemName: "newspaper")
        let imageView = UIImageView(image: newspaper)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = UIColor(named: "LightRed")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var authorNameLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = "Author Name"
       label.font = .systemFont(ofSize: 18, weight: .light)
       label.numberOfLines = 0
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var dateImage : UIImageView = {
        let calendar = UIImage(systemName: "calendar")
        let imageView = UIImageView(image: calendar)
        imageView.tintColor = UIColor(named: "LightRed")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var publishDateLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = "Publish Date"
       label.font = .systemFont(ofSize: 16, weight: .light)
       label.numberOfLines = 2
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var contentLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 16, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    public var viewSourceButton : UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "View Source"
        config.baseForegroundColor = .white // Yazı rengi
        let backgroundColor = UIColor(named: "DarkRed") ?? .red
        config.background = UIBackgroundConfiguration.clear()
        config.background.backgroundColor = backgroundColor
        config.background.cornerRadius = 10
        let button = UIButton(configuration: config, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: -Functions
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            newsImage.image = nil // URL geçersiz ise veya yoksa varsayılan bir görüntü gösterilebilir
            return
        }
        newsImage.sd_setImage(with: url, placeholderImage: UIImage(named: "loadingImage"))
        
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // contentView için yükseklik kısıt ı
            //contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 250),
                       
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            authorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            authorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            authorImage.heightAnchor.constraint(equalToConstant: 30),
            authorImage.widthAnchor.constraint(equalToConstant: 30),
                       
            authorNameLabel.centerYAnchor.constraint(equalTo: authorImage.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 15),
            authorNameLabel.heightAnchor.constraint(equalToConstant: 70),
            authorNameLabel.widthAnchor.constraint(equalToConstant: 100),
              
            dateImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            dateImage.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 30),
            dateImage.heightAnchor.constraint(equalToConstant: 30),
            dateImage.widthAnchor.constraint(equalToConstant: 30),
             
            publishDateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 10),
            publishDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 30),
            publishDateLabel.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor),
                       
            contentLabel.topAnchor.constraint(equalTo: authorImage.bottomAnchor, constant: 30),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                       
            viewSourceButton.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 30),
            viewSourceButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewSourceButton.widthAnchor.constraint(equalToConstant: 200),
            viewSourceButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            ])
    }
}
