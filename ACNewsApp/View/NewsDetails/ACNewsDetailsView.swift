//
//  ACNewsDetailsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 9.05.2024.
//

import UIKit

class ACNewsDetailsView: UIView {

    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(scrollView)
         // ScrollView içine contentView ekleniyor.
        contentView.addSubviews(newsImage, titleLabel, descriptionLabel, authorImage, authorNameLabel, dateImage, publishDateLabel, viewSourceButton)  // İçerik öğeleri contentView içine ekleniyor.
            
        scrollView.addSubview(contentView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Properties
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: 500, height: 1000)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        }()
    
    //IMAGEVIEW
    var newsImage : UIImageView = {
        let imageee = UIImage(named: "pencil")
        let imageView = UIImageView(image: imageee)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    var titleLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 20, weight: .medium)
       label.numberOfLines = 5
       label.textAlignment = .center
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var authorImage : UIImageView = {
        let newspaper = UIImage(systemName: "newspaper")
        let imageView = UIImageView(image: newspaper)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var authorNameLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = "Author Name"
       label.font = .systemFont(ofSize: 16, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var dateImage : UIImageView = {
        let newspaper = UIImage(systemName: "calendar")
        let imageView = UIImageView(image: newspaper)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var publishDateLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.text = "Publish Date"
       label.font = .systemFont(ofSize: 16, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    var descriptionLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 16, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    /*
    var contentLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
        label.text = "Content Label"
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
     */
    
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
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(named: "noImage") // Hata oluştuğunda varsayılan bir resim gösterilebilir.
                }
                return
            }
            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
            }
        }
        task.resume()
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
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor),

            // Set up the rest of your constraints relative to contentView instead of self.
            newsImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newsImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newsImage.heightAnchor.constraint(equalToConstant: 250),
                       
            titleLabel.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            authorImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            authorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            authorImage.heightAnchor.constraint(equalToConstant: 30),
            authorImage.widthAnchor.constraint(equalToConstant: 30),
                       
            authorNameLabel.centerYAnchor.constraint(equalTo: authorImage.centerYAnchor),
            authorNameLabel.leadingAnchor.constraint(equalTo: authorImage.trailingAnchor, constant: 10),
            
            dateImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            dateImage.leadingAnchor.constraint(equalTo: authorNameLabel.trailingAnchor, constant: 30),
            dateImage.heightAnchor.constraint(equalToConstant: 30),
            dateImage.widthAnchor.constraint(equalToConstant: 30),
             
            publishDateLabel.leadingAnchor.constraint(equalTo: dateImage.trailingAnchor, constant: 10),
            publishDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 40),
            publishDateLabel.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor),
                       
            descriptionLabel.topAnchor.constraint(equalTo: authorImage.bottomAnchor, constant: 30),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                       
           /* contentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),  // Important for scroll content size
            */
            viewSourceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            viewSourceButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            viewSourceButton.widthAnchor.constraint(equalToConstant: 200),
            viewSourceButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            ])
    }
}
