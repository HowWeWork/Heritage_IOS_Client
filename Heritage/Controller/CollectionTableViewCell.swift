//
//  CollectionTableViewCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

struct CollectionTableViewCellViewModel: Codable {
    let viewModels: [TopRankCollectionViewCellViewModel]
}

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    static let identifier = "CollectionTableViewCell"
    
    var cardData = [TopRankCollectionViewCellViewModel]()

//    private var viewModels: [TopRankCollectionViewCellViewModel] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.register(
            TopRankCollectionViewCell.self,
            forCellWithReuseIdentifier: TopRankCollectionViewCell.identifier
        )
        collectionView.backgroundColor = .systemBackground
        //가로 스크롤바 숨기기
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        collectionView.backgroundColor = UIColor(red: 254/255, green: 245/255, blue: 230/255, alpha: 1.0)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getBestThreeRequest {
            self.collectionView.reloadData()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }

    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopRankCollectionViewCell.identifier,
            for: indexPath
        ) as? TopRankCollectionViewCell else {
            fatalError()
        }
        cell.commonInit(sector: cardData[indexPath.row].sector, title: cardData[indexPath.row].title, comment: cardData[indexPath.row].comment)
        
        print(cardData)
        cell.configure(with: cardData[indexPath.row])
        
        return cell
    }
    
    func configure(with viewModel: CollectionTableViewCellViewModel){
        self.cardData = viewModel.viewModels
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width/1.3
        return CGSize(width: width, height: width/1.45)
    }
    
    //Best 3 GET Request
    func getBestThreeRequest(completed: @escaping () -> ()) {
        
        //Create URL
        let url = URL(string: "http://heritage-env-1.eba-dvm4baup.ap-northeast-2.elasticbeanstalk.com/board/best")
        guard let requestUrl = url else { fatalError() }

        //Create URL Request
        var request = URLRequest(url: requestUrl)

        //Specify HTTP Method to use
        request.httpMethod = "GET"

        //Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("1.Response HTTP Status code: \(response.statusCode)")
            }
            // Convert HTTP Response Data to Structure
            guard let data = data else { return }
            do {
                let bestPosts = try JSONDecoder().decode([TopRankCollectionViewCellViewModel].self, from: data)
                print(bestPosts)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    completed()
                })
                self.cardData = bestPosts
            } catch {
                print("2.best Data error:",error.localizedDescription)
            }
            print("Available data:", self.cardData.count)
        }
        task.resume()
    }
}

