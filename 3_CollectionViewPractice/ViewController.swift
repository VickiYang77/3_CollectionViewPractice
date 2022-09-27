//
//  ViewController.swift
//  3_CollectionViewPractice
//
//  Created by Vicki Yang on 2022/9/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var typeCollectionView: UICollectionView!
    @IBOutlet weak var picWallCollectionView: UICollectionView!
    var viewModel = ViewModel()
    var currentMovieInfo: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTypeCollectionView()
        setupPicWallCollectionView()
        
        currentMovieInfo = viewModel.getMovieInfo()
    }
    
    func setupTypeCollectionView() {
        typeCollectionView.register(typeCollectionViewCell.nib(), forCellWithReuseIdentifier: typeCollectionViewCell.identifier)
        typeCollectionView.delegate = self
        typeCollectionView.dataSource = self
        
        let itemSpace: Double = 7
        let columnCount: Double = 5
        let width = floor((typeCollectionView.bounds.width - itemSpace * columnCount) / columnCount)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: typeCollectionView.bounds.height)
        layout.estimatedItemSize = .zero
        layout.minimumLineSpacing = itemSpace
        layout.scrollDirection = .horizontal
        typeCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    func setupPicWallCollectionView() {
        picWallCollectionView.register(picWallCollectionViewCell.nib(), forCellWithReuseIdentifier: picWallCollectionViewCell.identifier)
        picWallCollectionView.delegate = self
        picWallCollectionView.dataSource = self
        
        let itemSpace: Double = 2
        let columnCount: Double = 3
        let width = floor((UIScreen.main.bounds.width - itemSpace * (columnCount-1)) / columnCount)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width)
        layout.estimatedItemSize = .zero
        layout.minimumInteritemSpacing = itemSpace
        layout.minimumLineSpacing = itemSpace
        picWallCollectionView.setCollectionViewLayout(layout, animated: false)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMovieInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case typeCollectionView:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCollectionViewCell.identifier, for: indexPath) as? typeCollectionViewCell,
               self.currentMovieInfo.count > indexPath.row {
                let movie = self.currentMovieInfo[indexPath.row]
                cell.setup(title: movie.title, image: movie.image)
                return cell
            }
        default:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picWallCollectionViewCell.identifier, for: indexPath) as? picWallCollectionViewCell,
               self.currentMovieInfo.count > indexPath.row {
                let movie = self.currentMovieInfo[indexPath.row]
                cell.setup(image: movie.image)
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
}

extension ViewController {
    // 禁止橫向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
