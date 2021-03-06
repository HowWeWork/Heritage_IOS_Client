//
//  MainViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let writeVC = WriteViewController()
    let cellColors = Colors()
    
    private let tableView:UITableView = {
        let table = UITableView()
        
        table.register(
            CollectionTableViewCell.self,
            forCellReuseIdentifier: CollectionTableViewCell.identifier
        )
        table.register(
            UINib(nibName: "CardCell", bundle: nil),
            forCellReuseIdentifier: "ReusableCell"
        )
  
        return table
    }()
    
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(
            viewModels: [
                TopRankCollectionViewCellViewModel(section:"영화", title: "라라랜드", comment: "I'm Always Gonna Love You.", backgroundColor: UIColor(red: 235/255, green: 201/255, blue: 201/255, alpha: 1.0)),
                TopRankCollectionViewCellViewModel(section:"음악", title: "Stronger", comment: "What doesn't kill you make you stronger", backgroundColor: UIColor(red: 194/255, green: 225/255, blue: 232/255, alpha: 1.0)),
                TopRankCollectionViewCellViewModel(section:"뮤지컬", title: "그리스", comment: "Tell me about it, stud", backgroundColor: UIColor(red: 165/255, green: 178/255, blue: 131/255, alpha: 1.0)),
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        //네비게이션바 타이틀 크기 설정
        self.navigationController?.navigationBar.prefersLargeTitles = true
        //테이블뷰 등록
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return writeVC.firstLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1 {
            let viewModel = viewModels[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CardCell
        cell.commonInit(rank:"\(writeVC.sectorLabel.index(after: indexPath.item))", sector: writeVC.sectorLabel.reversed()[indexPath.item] , title: writeVC.firstLabel.reversed()[indexPath.item], comment: writeVC.comment.reversed()[indexPath.item])
        cell.textLabel?.numberOfLines = 0
        cell.commentAdded.numberOfLines = 0
        
        //색상이 순서대로 나오게 하기
        if indexPath.row >= 1 {
            if indexPath.item%4 == 0{
                cell.cardBubble.backgroundColor = cellColors.colorBlue
            } else if indexPath.item%4 == 1{
                cell.cardBubble.backgroundColor = cellColors.colorPink
            } else if indexPath.item%4 == 2{
                cell.cardBubble.backgroundColor = cellColors.colorOrange
            } else if indexPath.item%4 == 3{
                cell.cardBubble.backgroundColor = cellColors.colorGreen
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return view.frame.size.width/1.4
        }
        return 160
    }

}
