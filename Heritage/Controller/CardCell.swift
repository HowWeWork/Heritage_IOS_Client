//
//  CardCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit

class CardCell: UITableViewCell {
    @IBOutlet var sectorAdded: UILabel!
    @IBOutlet var titleAdded: UILabel!
    @IBOutlet var commentAdded: UILabel!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var cardBubble: UIStackView!
    @IBOutlet var likeImage: UIImageView! {
        didSet {
            likeImage.isUserInteractionEnabled = true
        }
    }
    var likeNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        cardBubble.layer.cornerRadius = cardBubble.frame.size.height/5
        cardBubble.layer.borderWidth = 0.5
        cardBubble.layer.borderColor = UIColor.black.cgColor
        
       //Tap Gesture Recognizer 실행하기
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageView(_:)))
        likeImage.addGestureRecognizer(tapGestureRecognizer)
        
        //Like count 올리기
        likeCount.text = String(likeNumber)
  
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //테이블뷰 행 간 공백 주기
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func commonInit(rank:String, sector:String, title:String, comment:String) {
        rankLabel.text = rank
        sectorAdded.text = sector
        titleAdded.text = title
        commentAdded.text = comment
    }
    
    @objc func didTapImageView(_ sender: UITapGestureRecognizer) {
        if likeImage.image == UIImage(named: "filledHeart"){
            likeImage.image = UIImage(named: "emptyHeart")
            likeNumber -= 1
            likeCount.text = String(likeNumber)
        } else {
            likeImage.image = UIImage(named: "filledHeart")
            likeNumber += 1
            likeCount.text = String(likeNumber)
        }
    }
}
