//
//  TopRankCollectionViewCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

struct TopRankCollectionViewCellViewModel {
    let section: String
    let title: String
    let comment: String
    let backgroundColor: UIColor
}
class TopRankCollectionViewCell: UICollectionViewCell {
    static let identifier = "TopRankCollectionViewCell"
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(sectionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(commentLabel)
        
//        contentView.layer.cornerRadius = 20
//        contentView.layer.borderWidth = 3
//        contentView.layer.borderColor = UIColor.black.cgColor
        
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
        contentView.backgroundColor = viewModel.backgroundColor
        sectionLabel.text = viewModel.section
        titleLabel.text = viewModel.title
        commentLabel.text = viewModel.comment
        commentLabel.numberOfLines = 0
        
    }
    
    private func setupLayout(){
        sectionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        sectionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        sectionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 15).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35).isActive = true

        commentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        commentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80).isActive = true

    }
    
    private func setupBorder(){
        
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor(red: 159/255, green: 206/255, blue: 232/255, alpha: 1.0).cgColor
        

    }
}
