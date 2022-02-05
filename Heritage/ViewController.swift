//
//  ViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    let firstLabel = ["Begin","Love Actually","LaLa Land","Movie#4", "Movie#5", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10"]
    let comment = ["20년간 이어진 시리즈의 팬들에게 바치는 헌사, 스파이더맨: 노웨이 홈의 리뷰를 시작한다.", "EWWW","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance"]
    let cellColors = Colors()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "UITableView"
        tableView.dataSource = self
        tableView.delegate = self
       
        tableView.register(UINib(nibName: "CardCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        as! CardCell
        
        cell.commonInit(title: firstLabel[indexPath.item], comment: comment[indexPath.item])
        
        
        cell.textLabel?.numberOfLines = 0
        cell.commentAdded.numberOfLines = 0
        
        //색상이 순서대로 나오게 하기
        if indexPath.item%3 == 0{
            cell.cardBubble.backgroundColor = cellColors.colorBlue
        } else if indexPath.item%3 == 1{
            cell.cardBubble.backgroundColor = cellColors.colorPink
        } else if indexPath.item%3 == 2{
            cell.cardBubble.backgroundColor = cellColors.colorOrange
        }
        
        
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  160
    }
}

