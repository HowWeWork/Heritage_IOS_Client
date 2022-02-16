//
//  CollectionTableViewCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

struct CollectionTableViewCellViewModel{
    let viewModels: [TopRankCollectionViewCellViewModel]
}

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    static let identifier = "CollectionTableViewCell"
    
    private var viewModels: [TopRankCollectionViewCellViewModel] = []
    
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
        return collectionView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = UIColor(red: 254/255, green: 245/255, blue: 230/255, alpha: 1.0)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
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

        // Configure the view for the selected state
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopRankCollectionViewCell.identifier,
            for: indexPath
        ) as? TopRankCollectionViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func configure(with viewModel: CollectionTableViewCellViewModel){
        self.viewModels = viewModel.viewModels
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = contentView.frame.size.width/1.3
        return CGSize(width: width, height: width/1.45)
    }
    


}

