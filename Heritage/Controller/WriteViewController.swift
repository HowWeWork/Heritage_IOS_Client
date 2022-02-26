//
//  ViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/04.
//

import UIKit
import DropDown

class WriteViewController: UIViewController {
    
    let cellColors = Colors()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "ID"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return label
    }()
    
    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디"
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.widthAnchor.constraint(equalToConstant: 130).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PW"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.widthAnchor.constraint(equalToConstant: 130).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return textField
    }()
    
    public let sectorLabel: UILabel = {
        let label = UILabel()
        label.text = "Sector"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return label
    }()
    
    private let sectorBtn: UIButton = {
        let button = UIButton()
        button.setTitle("선택해주세요 ▼", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력해주세요"
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.widthAnchor.constraint(equalToConstant: 170).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return textField
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄평"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        return label
    }()
    
    private let commentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        textView.widthAnchor.constraint(equalToConstant: 170).isActive = true
        return textView
    }()
    
    //StackView
    private let userNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let sectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let boardCreateBtn: UIButton = {
        let button = UIButton()
        button.setTitle("글쓰기", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        //Action
        button.addTarget(self, action: #selector(createBoardBtnPressed), for: .touchUpInside)
        return button
    }()
    
    let menu: DropDown = {
        let menus = DropdownMenu()
        let menu = DropDown()
        menu.dataSource = menus.menus
        return menu
    }()
    
    var sectorLabelExample: Array<String> = ["영화","영화","영화","영화","영화","영화","영화","영화","영화","영화",""]
    var firstLabel = ["스파이더맨","Love Actually","LaLa Land","Movie#4", "Movie#5", "Movie#6", "Movie#7", "Movie#8", "Movie#9", "Movie#10",""]
    var comment = ["20년간 이어진 시리즈의 팬들에게 바치는 헌사, 스파이더맨: 노웨이 홈의 리뷰를 시작한다.", "EWWW","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance","Let's Dance",""]
    var likeNumber = [1,2,3,4,5,6,7,8,9,10,0]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션바 타이틀 크기 설정
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        //ViewController
        self.view.backgroundColor = cellColors.viewBackgroundColor
        
        //Layout
        view.addSubview(userNameStackView)
        view.addSubview(passwordStackView)
        view.addSubview(sectorStackView)
        view.addSubview(titleStackView)
        view.addSubview(commentStackView)
        view.addSubview(boardCreateBtn)
        
        setUpLayout()
        
        //DropDownList
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapInItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        sectorBtn.addGestureRecognizer(gesture)
        menu.anchorView = sectorBtn
        menu.selectionAction = { index, title in
            self.sectorBtn.setTitle(title, for: .normal)
        }
        
    }
 
    @objc func didTapInItem() {
        menu.show()
    }
  
    @objc func createBoardBtnPressed () {
        sectorLabelExample.append(sectorBtn.titleLabel?.text ?? "영화")
        firstLabel.append(titleTextField.text!)
        comment.append(commentTextView.text)
        print(sectorLabelExample)
        //앞 화면으로 돌아가기
        self.performSegue(withIdentifier: "unwindToViewController", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToViewController"{
            let mainVC = segue.destination as! MainViewController
//            sectorLabelExample.append(sectorBtn.titleLabel?.text ?? "영화")
//            firstLabel.append(titleTextField.text!)
//            comment.append(commentTextView.text)
           
            mainVC.tableView.reloadData()
            }
        }
    
    func setUpLayout() {
        //userNameStackView
        userNameStackView.addArrangedSubview(userNameLabel)
        userNameStackView.addArrangedSubview(userNameTextField)
        
        userNameStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        userNameStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //passwordStackView
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        passwordStackView.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 20).isActive = true
        passwordStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //sectorStackView
        sectorStackView.addArrangedSubview(sectorLabel)
        sectorStackView.addArrangedSubview(sectorBtn)
        
        sectorStackView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 20).isActive = true
        sectorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //titleStackView
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        
        titleStackView.topAnchor.constraint(equalTo: sectorStackView.bottomAnchor, constant: 20).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
        //commentStackView
        commentStackView.addArrangedSubview(commentLabel)
        commentStackView.addArrangedSubview(commentTextView)
        
        commentStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20).isActive = true
        commentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
//        //boardCreateButton
        boardCreateBtn.topAnchor.constraint(equalTo: commentStackView.bottomAnchor, constant: 20).isActive = true
        boardCreateBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//        boardCreateBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
//
    }
    
}

