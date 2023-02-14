# #3 CollectionViewPractice

![3_CollectionViewPractice_01](https://user-images.githubusercontent.com/25075180/218796605-eeeaea7d-b2ab-4cda-b073-e70475fa45c5.png)

## Learning Goal

- 基本 MVVM 架構
- Tab Bar：切換不同頁面
- CollectionView
    - 在同一個頁面中，使用2個不同方向的 CollectionView
    - 點選 CollectionView A ，會更新 CollectionView B 資料
- Navigation：點擊 Cell 跳轉詳細頁面
- 讀取 .json 中的資料


## Highlight

- 檔案目錄，使用 MVVM 架構

  ![image](https://user-images.githubusercontent.com/25075180/218796940-22956162-3f9f-44e0-ac67-6f7c1b2cde6a.png)

- Tab Bar：將 VC 全部初始後，加入 self.viewControllers 中
    
    ```swift
    class ViewController: UITabBarController {
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let homeVC = HomeViewController.init(nibName: "HomeViewController", bundle: nil)
            let homeNavigation = UINavigationController(rootViewController: homeVC)
            homeNavigation.tabBarItem.image = UIImage(systemName: "house")
            homeNavigation.tabBarItem.title = "Home"
            
            let favoritesVC = FavoritesViewController()
            let favoritesNavigation = UINavigationController(rootViewController: favoritesVC)
            favoritesNavigation.tabBarItem.image = UIImage(systemName: "star")
            favoritesNavigation.tabBarItem.title = "Favorites"
            
    
            let personalVC = PersonalViewController()
    
    				// 將 VC Embed 到 avigation 中 (若之後該頁面沒有跳轉下一個畫面，也可以省略此行)
            let personalNavigation = UINavigationController(rootViewController: personalVC)
            
    				// 使用系統 image
    				personalNavigation.tabBarItem.image = UIImage(systemName: "person")
    
    				// 設定 tarBar title 與 navigation title
            personalNavigation.tabBarItem.title = "Personal"
            
    				// 將所有 nav 加入 tabbar 中
            viewControllers = [homeNavigation, favoritesNavigation, personalNavigation]
        }
    }
    
    class FavoritesViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
    
    				// 頁面顯示時設定，上方 navigation 和 下方 tabbar title 皆會改變
            self.title = "Favorites"
            self.view.backgroundColor = .systemPink
        }
    }
    
    class PersonalViewController: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            self.title = "個人頁面"
            self.view.backgroundColor = .yellow
        }
    }
    ```
    

- 創建 Resource Folder：將 image 與 資料源(.json) 加入

  ![image](https://user-images.githubusercontent.com/25075180/218797412-302fbb85-32c1-4a79-8067-f6e201480210.png)

- VM 中讀取 image 與 .json file
    
    ```swift
    class ViewModel {
        var movies: [MovieModel] = []
        
        func getMovieInfo() -> [MovieModel] {
            do {
                let url = Bundle.main.url(forResource: "MovieData", withExtension: "json")!
                let data = try Data(contentsOf: url)
                let result = try JSONDecoder().decode([MovieModel].self, from: data)
    
                // json 資料裝載
                for topic in result {
                    self.movies.append(MovieModel(title: topic.title, time: topic.title, info: topic.info, url: topic.url))
                }
                
                return self.movies
            } catch {
                print(error)
            }
            
            return []
        }
    }
    ```
    

- HomeViewController 中創建兩個不同方向的 CollectionView
    - 利用 collectionView tag 區分
    
    ```swift
    class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
        @IBOutlet weak var typeCollectionView: UICollectionView!
        @IBOutlet weak var picWallCollectionView: UICollectionView!
        var viewModel = ViewModel()
        var moviesInfo: [MovieModel] = []
        var currentTopic = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupTypeCollectionView()
            setupPicWallCollectionView()
            
            moviesInfo = viewModel.getMovieInfo()
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
            return collectionView.tag == 0 ? moviesInfo.count : 3 * 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch collectionView {
            case typeCollectionView:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: typeCollectionViewCell.identifier, for: indexPath) as? typeCollectionViewCell,
                   self.moviesInfo.count > indexPath.row {
                    let movie = self.moviesInfo[indexPath.row]
                    let randomInt = Int.random(in: 1...8)
                    let imageName = movie.title + "_0\(randomInt)"
                    cell.setup(title: movie.title, image: imageName)
                    return cell
                }
            default:
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: picWallCollectionViewCell.identifier, for: indexPath) as? picWallCollectionViewCell {
                    let movie = self.moviesInfo[currentTopic]
                    let randomInt = Int.random(in: 1...8)
                    let imageName = movie.title + "_0\(randomInt)"
                    cell.setup(image: imageName)
                    return cell
                }
            }
            
            return UICollectionViewCell()
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            switch collectionView.tag {
            case 0:
                currentTopic = indexPath.row
                picWallCollectionView.reloadData()
            default:
                let detailVC = DetailViewController()
                detailVC.title = "Detail"
                self.navigationController?.pushViewController(detailVC, animated: true)
                break
            }
        }
    }
    ```
    

- Cell .swift 基本架構
    
    ```swift
    class typeCollectionViewCell: UICollectionViewCell {
        static let identifier = "\(typeCollectionViewCell.self)"
    
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var titleLabel: UILabel!
        
        override func awakeFromNib() {
            super.awakeFromNib()
    				
    				// 邊框
            imageView.layer.borderWidth = 3
            imageView.layer.borderColor = UIColor.lightGray.cgColor
    
    			  // 圓角
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
    ```
