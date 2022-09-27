//
//  typeCollectionViewCell.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/9/24.
//

import UIKit

class typeCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(typeCollectionViewCell.self)"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
    }

    func setup(title: String, image: String) {
        self.titleLabel.text = title
        self.imageView.image = UIImage(named: image)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
