//
//  picWallCollectionViewCell.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/9/24.
//

import UIKit

class picWallCollectionViewCell: UICollectionViewCell {
    static let identifier = "\(picWallCollectionViewCell.self)"

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(image: String) {
        self.imageView.image = UIImage(named: image)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: self.identifier, bundle: nil)
    }
}
