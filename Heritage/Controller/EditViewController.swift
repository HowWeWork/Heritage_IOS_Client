//
//  EditViewController.swift
//  Heritage
//
//  Created by HappyDuck on 2022/02/16.
//

import UIKit
import DropDown

class EditViewController: UIViewController {

    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "PW"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center

        textField.isSecureTextEntry = true
        
        textField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sectorLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sectorButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택해주세요 ▼", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: 120).isActive = true
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "타이틀"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "입력해주세요"
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.textAlignment = .center
        textField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "한줄평"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 20)
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 130).isActive = true
//        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //StackViews
    private let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let sectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let commentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    let menu: DropDown = {
        let menus = DropdownMenu()
        let menu = DropDown()
        menu.dataSource = menus.menus
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(passwordStackView)
        view.addSubview(sectorStackView)
        view.addSubview(titleStackView)
        view.addSubview(commentStackView)
        stackViewLayout()
        navigationItem.largeTitleDisplayMode = .never
        
        menuButtonGesture() 
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func stackViewLayout() {
        
        //passwordStackView
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        passwordStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        passwordStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
   
        //sectorStackView
        sectorStackView.addArrangedSubview(sectorLabel)
        sectorStackView.addArrangedSubview(sectorButton)
        
        sectorStackView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 20).isActive = true
        sectorStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //titleStackView
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(titleTextField)
        
        titleStackView.topAnchor.constraint(equalTo: sectorStackView.bottomAnchor, constant: 20).isActive = true
        titleStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        //commentStackView
        commentStackView.addArrangedSubview(commentLabel)
        commentStackView.addArrangedSubview(commentTextView)

        commentStackView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 20).isActive = true
        commentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    }
    
    @objc func buttonAction() {
        print("Tapped")
    }
    @objc func didTapInItem() {
        menu.show()
    }
    
    func menuButtonGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapInItem))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        sectorButton.addGestureRecognizer(gesture)
        menu.anchorView = sectorButton
        menu.backgroundColor = .white
        menu.cornerRadius = 8
        menu.selectionAction = { index, title in
            print("\(title)")
            self.sectorButton.setTitle(title, for: .normal)
        }
    }



    

    

}
