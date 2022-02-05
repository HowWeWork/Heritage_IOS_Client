//
//  CardCell.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit

class CardCell: UITableViewCell {
    @IBOutlet var titleAdded: UILabel!
    @IBOutlet var commentAdded: UILabel!
    @IBOutlet var likeCount: UILabel!
    @IBOutlet var rankLabel: UILabel!
    @IBOutlet var cardBubble: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardBubble.layer.cornerRadius = cardBubble.frame.size.height/5
        cardBubble.layer.borderWidth = 2
        cardBubble.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
    }
    func commonInit(title:String, comment:String) {
        titleAdded.text = title
        commentAdded.text = comment
    }
}
