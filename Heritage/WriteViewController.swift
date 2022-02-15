//
//  ViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit
import DropDown

class WriteViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var titleCommentView: UIView!
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var sectorBtn: UIButton!
    
    let cardCell = CardCell()
    
    let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [
            "영화",
            "음악",
            "책",
            "뮤지컬"
        ]
        return menu
    }()
    
    var sectorLabel: Array<String> = ["영화","영화","영화","영화","영화","영화","영화","영화","영화","영화",""]
    var firstLabel = ["Begin","Love Actually","LaLa Land","Movie#4", "Movie#5", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10",""]
    var comment = ["20년간 이어진 시리즈의 팬들에게 바치는 헌사, 스파이더맨: 노웨이 홈의 리뷰를 시작한다.", "EWWW","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance",""]
    let cellColors = Colors()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
        //DropDownList
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapInItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        sectorBtn.addGestureRecognizer(gesture)
        menu.anchorView = sectorBtn
        menu.selectionAction = { index, title in
            self.sectorBtn.titleLabel?.text = title
        }
        
        //ViewController
        self.view.backgroundColor = UIColor(red: 254/255, green: 245/255, blue: 230/255, alpha: 1.0)
        
        //Title and Comment Text View
        titleCommentView.layer.cornerRadius = titleCommentView.frame.size.height/15
        titleCommentView.layer.borderWidth = 1
        titleCommentView.layer.borderColor = UIColor.black.cgColor
        
        titleTextView.layer.cornerRadius = titleTextView.frame.size.height/10
        titleTextView.layer.borderWidth = 1
        titleTextView.layer.borderColor = UIColor.black.cgColor
        
        commentTextView.layer.cornerRadius = commentTextView.frame.size.height/10
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.black.cgColor
        
        //Share Button
        shareButton.layer.borderWidth = 1
        shareButton.layer.cornerRadius = shareButton.frame.size.height/5
        shareButton.layer.borderColor = UIColor.black.cgColor
        shareButton.titleLabel?.textColor = UIColor.black
        shareButton.backgroundColor = UIColor(red: 254/255, green: 245/255, blue: 230/255, alpha: 1.0)
        
        //Table View
//        self.title = "UITableView"
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        //BottomModalView
        //shareButton.addTarget(self, action: #selector(presentModalController), for: .touchUpInside)
    }
    
    @objc func didTapInItem() {
        menu.show()
        print("Tapped")
    }
    
    @IBAction func sectorBtnPressed(_ sender: UIButton) {
        
    }
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        sectorLabel.append(sectorBtn.titleLabel?.text ?? "영화")
        firstLabel.append(titleTextView.text)
        comment.append(commentTextView.text)
        
        tableView.reloadData()
    }
    
    @objc func presentModalController() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        // Keep animated value as false
        // Custom Modal presentation animation will be handled in VC itself
        self.present(vc, animated: false)
    }
    
}

extension WriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        as! CardCell
        
        cell.commonInit(rank:"\(sectorLabel.index(after: indexPath.item))", sector:sectorLabel.reversed()[indexPath.item] , title: firstLabel.reversed()[indexPath.item], comment: comment.reversed()[indexPath.item])
        cell.textLabel?.numberOfLines = 0
        cell.commentAdded.numberOfLines = 0
        
        //색상이 순서대로 나오게 하기
        if indexPath.item%4 == 0{
            cell.cardBubble.backgroundColor = cellColors.colorBlue
        } else if indexPath.item%4 == 1{
            cell.cardBubble.backgroundColor = cellColors.colorPink
        } else if indexPath.item%4 == 2{
            cell.cardBubble.backgroundColor = cellColors.colorOrange
        } else if indexPath.item%4 == 3{
            cell.cardBubble.backgroundColor = cellColors.colorGreen
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  160
    }
}

