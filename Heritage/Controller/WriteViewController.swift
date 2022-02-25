//
//  ViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit
import DropDown

class WriteViewController: UIViewController {
    
//    let mainVC = MainViewController()
    
    let cellColors = Colors()
    
    
    @IBOutlet var titleCommentView: UIView!
    @IBOutlet var titleTextView: UITextView!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet var shareButton: UIButton!
    @IBOutlet var sectorBtn: UIButton!
    
    let menu: DropDown = {
        let menus = DropdownMenu()
        let menu = DropDown()
        menu.dataSource = menus.menus
        return menu
    }()
    
    var sectorLabel: Array<String> = ["영화","영화","영화","영화","영화","영화","영화","영화","영화","영화",""]
    var firstLabel = ["Begin","Love Actually","LaLa Land","Movie#4", "Movie#5", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10",""]
    var comment = ["20년간 이어진 시리즈의 팬들에게 바치는 헌사, 스파이더맨: 노웨이 홈의 리뷰를 시작한다.", "EWWW","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance",""]
    var likeNumber = [1,2,3,4,5,6,7,8,9,10,0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 타이틀 크기 설정
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
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
    }
    
 
    @objc func didTapInItem() {
        menu.show()
    }
    
    @IBAction func sectorBtnPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        sectorLabel.append(sectorBtn.titleLabel?.text ?? "영화")
        firstLabel.append(titleTextView.text)
        comment.append(commentTextView.text)
 
        //앞 화면으로 돌아가기
        self.performSegue(withIdentifier: "unwindToViewController", sender: self)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToViewController"{
            let mainVC = segue.destination as! MainViewController
            sectorLabel.append(sectorBtn.titleLabel?.text ?? "영화")
            firstLabel.append(titleTextView.text)
            comment.append(commentTextView.text)
           
            mainVC.tableView.reloadData()
            }
        }
    
}

