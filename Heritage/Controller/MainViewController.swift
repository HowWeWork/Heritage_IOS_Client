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
    
    var indexPathNum = Int() //indexPath.row 저장을 위한 Int 변수 생성
 
    //아래 viewModels를 다른 파일로 뺄 수는 없을까??
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(
            viewModels: [
                TopRankCollectionViewCellViewModel(section:"영화", title: "라라랜드", comment: "I'm Always Gonna Love You.", backgroundColor: .white),
                TopRankCollectionViewCellViewModel(section:"음악", title: "Stronger", comment: "What doesn't kill you make you stronger", backgroundColor: .white),
                TopRankCollectionViewCellViewModel(section:"뮤지컬", title: "그리스", comment: "Tell me about it, stud", backgroundColor: .white)
            ]
        )
    ]
    
    var sectorLabelExample: Array<String> = [" ","영화","영화","영화","영화","영화","영화","영화","영화","영화","영화"]
    var firstLabel = [" ","스파이더맨","Love Actually","LaLa Land","Movie#4", "Movie#5", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10"]
    var comment = [" ","20년간 이어진 시리즈의 팬들에게 바치는 헌사, 스파이더맨: 노웨이 홈의 리뷰를 시작한다.", "EWWW","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance"]
    var likeNumber = [1,2,3,4,5,6,7,8,9,10]
    
    
    //두 종류의 셀 형태를 같는 테이블 뷰 생성 (첫번째 행은 CollectiontableView, 두번째 이하는 CardCell Nib 사용)
    let tableView:UITableView = {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = cellColors.viewBackgroundColor
        //네비게이션바 타이틀 크기 설정
        self.navigationController?.navigationBar.prefersLargeTitles = true

        //네비게이션바 버튼 설정
        configureItems()
        navigationController?.navigationBar.tintColor = .label //.label은 dark or light mode에 따라 글자 색상이 바뀌게 하는 것
        //테이블뷰 등록
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue){
        
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstLabel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 1 {
            let viewModel = viewModels[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CardCell
            
            cell.commonInit(
                rank:"\(sectorLabelExample.index(after: indexPath.row)-1)",
                sector: sectorLabelExample[indexPath.row],
                title: firstLabel[indexPath.row],
                comment: comment[indexPath.row],
                likeNumber: "0"
            )
            
            //String(likeNumber.reversed()[indexPath.item]+cell.likeAdded)
            
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
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 1 {
            return view.frame.size.width/1.4
        }
        return 160
    }

    //Swipe 기능 추가 (수정&삭제)
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "삭제", handler: {action, view, completionHandler in
            self.sectorLabelExample.remove(at: indexPath.row)
            self.firstLabel.remove(at: indexPath.row)
            self.comment.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        let editAction = UIContextualAction(style: .normal, title: "수정", handler: {action, view, completionHandler in
            
            self.indexPathNum = indexPath.row //indexPath.row 값 저장
            
            DispatchQueue.main.async() {
                self.performSegue(withIdentifier: "goToEdit", sender: self)
            }
        })
        
        deleteAction.backgroundColor = .red
        editAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    private func configureItems() {
        
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(image: UIImage(systemName: "plus.bubble") , style: .done, target: self, action: #selector(btnTapped))

    }
    
    @objc func btnTapped() {
        self.performSegue(withIdentifier: "goToWrite", sender: self)
    }
    
    @objc func presentModalController() {
        let vc = CustomModalViewController()
        vc.modalPresentationStyle = .overCurrentContext
        // Keep animated value as false
        // Custom Modal presentation animation will be handled in VC itself
        self.present(vc, animated: false)
    }
    
    //MARK: - Prepare for Segue
    //화면 전환 전 값 저장
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit"{
            let destinationVC = segue.destination as! EditViewController
            destinationVC.sectorPassed = sectorLabelExample[indexPathNum]
            destinationVC.titlePassed = firstLabel[indexPathNum]
            destinationVC.commentPassed = comment[indexPathNum]
            destinationVC.indexPathSelected = indexPathNum
        }
    }
    

}

