//
//  SendNewsView.swift
//  ACNewsApp
//
//  Created by Ezgi Karahan on 17.07.2024.
//

import UIKit

protocol sendNewsViewDelegate : AnyObject {
    func addImageButtonTapped()
}

class SendNewsView: UIView {

    weak var delegate : sendNewsViewDelegate?
    
    // MARK: - Properties
        let titleTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Başlık"
            textField.borderStyle = .roundedRect
            return textField
        }()
        
        let detailsTextView: UITextView = {
            let textView = UITextView()
            textView.layer.borderColor = UIColor.gray.cgColor
            textView.layer.borderWidth = 1
            textView.layer.cornerRadius = 8
            textView.font = UIFont.systemFont(ofSize: 16)
            return textView
        }()
        
        let addImageButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Resim Ekle", for: .normal)
            button.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
            return button
        }()
        
        let selectedImagesCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .clear
            return collectionView
        }()
        
        // MARK: - Init
        override init(frame: CGRect) {
            super.init(frame: frame)
            addConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup
        private func addConstraints() {
            addSubview(titleTextField)
            addSubview(detailsTextView)
            addSubview(addImageButton)
            addSubview(selectedImagesCollectionView)
            
            titleTextField.translatesAutoresizingMaskIntoConstraints = false
            detailsTextView.translatesAutoresizingMaskIntoConstraints = false
            addImageButton.translatesAutoresizingMaskIntoConstraints = false
            selectedImagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                
                detailsTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
                detailsTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                detailsTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                detailsTextView.heightAnchor.constraint(equalToConstant: 200),
                
                addImageButton.topAnchor.constraint(equalTo: detailsTextView.bottomAnchor, constant: 20),
                addImageButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                
                selectedImagesCollectionView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 20),
                selectedImagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                selectedImagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                selectedImagesCollectionView.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
        
        // MARK: - Actions
        @objc private func addImageButtonPressed() {
            // Resim ekleme işlemi daha sonra eklenecek
            print("Resim ekleme işlemi başlatıldı.")
            delegate?.addImageButtonTapped()
        }
}


