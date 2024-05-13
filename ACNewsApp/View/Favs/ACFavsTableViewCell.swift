//
//  ACFavsTableViewCell.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 11.05.2024.
//

import UIKit

class ACFavsTableViewCell: UITableViewCell {

    static let cellIdentifier = "ACFavsTableViewCell"
    
    //IMAGEVIEW
    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()///closure
    
    
    //LABEL
     let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 5
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
       label.textColor = .label
       label.font = .systemFont(ofSize: 14, weight: .light)
       label.numberOfLines = 5
       label.textAlignment = .left
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           contentView.backgroundColor = UIColor(named: "LigthBlack")
           contentView.addSubviews(newsImage, titleLabel, descriptionLabel)
           addConstraints()
           //setUpLayer()
       }
       
    required init?(coder: NSCoder) { ///storyboard ya da  xib başlatıcısı
        fatalError("Unsupported")    ///desteklenmediği için fatalError
    }
    
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
           
            newsImage.heightAnchor.constraint(equalToConstant: 80),
            newsImage.widthAnchor.constraint(equalToConstant: 120),
            newsImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            newsImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            // Hücrenin sağ kenarından 20 puan uzaklıkta
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.widthAnchor.constraint(equalToConstant: 230),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 50),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 230),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
        ])
    }
    
    override func prepareForReuse() { ///hücre yeniden kullanılmak üzere hazırlandıgında çağrılır.
        super.prepareForReuse() /// metod super.prepareForReuse() çağrısı yapmakta, reperareforreuse hücre yeniden kullanılmak için çağırıldıgında yazılır.
        
        newsImage.image = nil
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // contentView için iç boşluklar
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            newsImage.image = UIImage(named: "noImage") // URL geçersiz ise veya yoksa varsayılan bir görüntü
            return
        }
        
        //SDWebImage kullanabilirsin!!!!!!!
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(named: "noImage") // Hata oluştuğunda varsayılan bir görüntü
                }
                return
            }
            DispatchQueue.main.async {
                self.newsImage.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
}
