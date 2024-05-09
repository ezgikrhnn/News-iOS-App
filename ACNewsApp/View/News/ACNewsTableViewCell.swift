//
//  ACNewsTableViewCell.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 8.05.2024.
//

import UIKit


final class ACNewsTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "ACNewsTableViewCell"
    
    //IMAGEVIEW
    let newsImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] ///bu satır sayesinde imageView'in sadece üst 2 köşesine cornerRadius uygulandı.
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
    
    //CONSTRATINTS FUNC
    private func addConstraints() {
            /*
             | Image      |
             | nameLabel  |
             | statusLabel|
             */
        
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
    
    /*private func setUpLayer(){
        //contentView.layer.cornerRadius = 20
        //contentView.layer.shadowColor = UIColor(named: "Light0Red")?.cgColor //backgroundcolour'un tersi oldu
        //contentView.layer.shadowOpacity = 1
        contentView.layer.borderWidth = 0.9
        contentView.layer.borderColor = UIColor(named: "LightRed")?.cgColor

    } */
    
    override func prepareForReuse() { ///hücre yeniden kullanılmak üzere hazırlandıgında çağrırlır.
        super.prepareForReuse() /// metod super.prepareForReuse() çağrısı yapmakta, reperareforreuse hücre yeniden kullanılmak için çağırıldıgında yazılır. ARAŞTIR YENİDEN !!!
        
        newsImage.image = nil
        titleLabel.text = nil
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            // contentView için iç boşluklar ayarlanıyor
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    
    //FUNC LOAD IMAGE
    func loadImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            newsImage.image = nil // URL geçersiz ise veya yoksa varsayılan bir görüntü gösterebilirsiniz.
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                DispatchQueue.main.async {
                    self?.newsImage.image = nil // Hata oluştuğunda varsayılan bir resim gösterebilirsiniz.
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
