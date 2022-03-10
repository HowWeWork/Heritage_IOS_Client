//
//  MainViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/14.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var JSONData = [Data]()
    var testString: String = ""
    
    let writeVC = WriteViewController()
    let cellColors = Colors()
    
    var indexPathNum = Int() //indexPath.row 저장을 위한 Int 변수 생성
 
    //아래 viewModels를 다른 파일로 뺄 수는 없을까??
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(
            viewModels: [
                TopRankCollectionViewCellViewModel(section:"책", title: "달러구트꿈백화점", comment: "따뜻하고 감동적이고 신비한 마법의 묘약을 삼킨 것 같은 아름다운 동화", backgroundColor: .white),
                TopRankCollectionViewCellViewModel(section:"음악", title: "Stronger", comment: "What doesn't kill you make you stronger", backgroundColor: .white),
                TopRankCollectionViewCellViewModel(section:"뮤지컬", title: "그리스", comment: "Tell me about it, stud", backgroundColor: .white)
            ]
        )
    ]
    
    var sectorLabelExample: Array<String> = [" ","영화","영화","책","뮤지컬","뮤지컬","영화","영화","영화","영화","영화"]
    var firstLabel = [" ","스파이더맨","천공의 성 라퓨타","용의자 X의 헌신","데스노트", "위키드", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10"]
    var comment = [" ","With great power comes great responsibility", "여전히 싱싱한 플롯과 색채, 메시지","한번 빠져들면 나올 수 없는 소설","역시 인간은 재밌어","꿈을 이룬다는 건 예상보다는 단순하지 않았네요. 꿈을 이룬 기쁨 생각보다는 덜 해도 뭐 환벽한 해피엔딩","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance"]
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
        //네비게이션바 Large타이틀 글씨체 변경
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "NotoSerifKR-Bold", size: 30) ?? UIFont.systemFont(ofSize: 30)]

        //네비게이션바 버튼 설정
        configureItems()
        navigationController?.navigationBar.tintColor = .label //.label은 dark or light mode에 따라 글자 색상이 바뀌게 하는 것
        
        //테이블뷰 등록
        view.addSubview(tableView)
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
//            self.view.addSubview(self.tableView)
//        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        //GET Request
        getRequest {
            self.tableView.reloadData()
        }
        NotificationCenter.default.post(name: writeVC.DidDismissPostVC, object: nil, userInfo: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didDismissPostNotification(_:)), name: writeVC.DidDismissPostVC, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    @IBAction func prepareForUnWind(segue: UIStoryboardSegue){
        
    }
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               
        return JSONData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Collection view 들어가는 곳
        if indexPath.row < 1 {
            let viewModel = viewModels[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            
            return cell
            
        //Table view 그대로 남아 있는 곳
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! CardCell
            
            cell.commonInit(
                
                //rank는 boardNum,
                rank: String(indexPath.row),
                sector: JSONData[indexPath.row].sector,
                title: JSONData[indexPath.row].title,
                comment: JSONData[indexPath.row].comment,
                likeNumber: String(JSONData[indexPath.row].likeCount)
                
//                rank:"\(sectorLabelExample.index(after: indexPath.row)-1)",
//                sector: sectorLabelExample[indexPath.row],
                
//                title: firstLabel[indexPath.row],
//                comment: comment[indexPath.row],
//                likeNumber: "0"
            )
            
            //String(likeNumber.reversed()[indexPath.item]+cell.likeAdded)
            
            cell.textLabel?.numberOfLines = 0
            cell.commentAdded.numberOfLines = 0
            
            //색상이 순서대로 나오게 하기
            if indexPath.item%4 == 0{
                cell.cardBubble.backgroundColor = cellColors.mainPink
            } else if indexPath.item%4 == 1{
                cell.cardBubble.backgroundColor = cellColors.mainPink
            } else if indexPath.item%4 == 2{
                cell.cardBubble.backgroundColor = cellColors.mainPink
            } else if indexPath.item%4 == 3{
                cell.cardBubble.backgroundColor = cellColors.mainPink
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("IndexPath.row:", indexPath.row)
        print("BoardNum:",JSONData[indexPath.row].boardNum)
    }

    //Swipe 기능 추가 (수정&삭제)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //삭제
        let deleteAction = UIContextualAction(style: .normal, title: "삭제", handler: {action, view, completionHandler in
            
            //API 사용으로 변경 후
            deleteRequest(boardNum: self.JSONData[indexPath.row].boardNum) { (err) in
                if let err = err {
                    print("Failed to delete:", err)
                    return
                }
                print("Successfully deleted post from server")
                print(self.JSONData.count)
            }
            self.JSONData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            //위의 셀 삭제되면 랭킹 라벨에 번호 새로 매겨지도록 테이블뷰를 새로 업로드
            self.tableView.reloadData()
            
            //내부 데이터일 때
//            self.sectorLabelExample.remove(at: indexPath.row)
//            self.firstLabel.remove(at: indexPath.row)
//            self.comment.remove(at: indexPath.row)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        })
        
        //수정
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
    //수정화면 전환 전 값 저장
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit"{
            let destinationVC = segue.destination as! EditViewController
            
            //API 사용 시
            destinationVC.sectorPassed = JSONData[indexPathNum].sector
            destinationVC.titlePassed = JSONData[indexPathNum].title
            destinationVC.commentPassed = JSONData[indexPathNum].comment
            destinationVC.indexPathSelected = indexPathNum
            
            //내부 저장 데이터 사용 시
//            destinationVC.sectorPassed = sectorLabelExample[indexPathNum]
//            destinationVC.titlePassed = firstLabel[indexPathNum]
//            destinationVC.commentPassed = comment[indexPathNum]
//            destinationVC.indexPathSelected = indexPathNum
        }
    }
    
    //MARK: - Get request
    
    func getRequest(completed: @escaping () -> ()) {
        //Create URL
        let url = URL(string: "http://192.168.4.210:5000/board")
        guard let requestUrl = url else { fatalError() }

        //Create URL Request
        var request = URLRequest(url: requestUrl)

        //Specify HTTP Method to use
        request.httpMethod = "GET"

        //Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
                return
            }
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("1.Response HTTP Status code: \(response.statusCode)")
            }

            // Convert HTTP Response Data to Structure
            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([Data].self, from: data)
                DispatchQueue.main.async {
                    completed()
                }
                self.JSONData = posts

            } catch {
                print(error.localizedDescription)
            }
            print("Available data:",self.JSONData.count)
        }
        task.resume()
    }
    
    @objc func didDismissPostNotification(_ noti: Notification) {
        getRequest {
            self.tableView.reloadData()
        }
//        OperationQueue.main.addOperation {
//            self.tableView.reloadData()
//        }
    }
  

}

