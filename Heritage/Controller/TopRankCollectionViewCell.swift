//
//  TopRankCollectionViewCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

struct TopRankCollectionViewCellViewModel: Codable {
    
    let boardNum: Int
    let userName: String
    let pw: String
    var sector: String
    var title: String
    var comment: String
    var likeCount: Int
    
}

class TopRankCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopRankCollectionViewCell"
    
    let colorPalette = Colors()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "NotoSerifKR-Regular", size: 15.0)
        label.textAlignment = .left
//        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "NotoSerifKR-Bold", size: 20.0)
        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "NotoSerifKR-Regular", size: 15.0)
        label.textAlignment = .center
        //        label.font = .systemFont(ofSize: 15, weight: .light)
        label.widthAnchor.constraint(equalToConstant: 220).isActive = true
        label.heightAnchor.constraint(equalToConstant: 100).isActive = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(sectionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(commentLabel)
        
        setupLayout()
        setupBorder()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with viewModel: TopRankCollectionViewCellViewModel){
        
//        contentView.backgroundColor = viewModel.backgroundColor
        sectionLabel.text = viewModel.sector
        titleLabel.text = viewModel.title
        commentLabel.text = viewModel.comment
        print(viewModel)
        
    }
    
    private func setupLayout(){
        sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        sectionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        sectionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35).isActive = true

        commentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
//        commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80).isActive = true

    }
    
    private func setupBorder(){
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = colorPalette.mainPink.cgColor
    }
    
    func commonInit(sector: String, title: String, comment: String) {
        
        sectionLabel.text = sector
        titleLabel.text = title
        commentLabel.text = comment
        
    }
}
