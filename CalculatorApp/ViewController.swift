//
//  ViewController.swift
//  CalculatorApp
//
//  Created by mac on 6/25/24.
//

import UIKit
import SnapKit




class ViewController: UIViewController {
    
    let numberLabel = UILabel()
    
    let firstLineButtons = ["7", "8", "9", "+"]
    let secondLineButtons = ["4", "5", "6", "-"]
    let thirdLineButtons = ["1", "2", "3", "*"]
    let fourthLineButtons = ["AC", "0", "=", "/"]
    
    let vStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .black
        
        
        let firstButtonsLine = makeHorizontalStackView(firstLineButtons)
        let secondButtonsLine = makeHorizontalStackView(secondLineButtons)
        let thirdButtonsLine = makeHorizontalStackView(thirdLineButtons)
        let fourthButtonsLine = makeHorizontalStackView(fourthLineButtons)
        
        let buttonLines: Array<UIStackView> = [firstButtonsLine, secondButtonsLine, thirdButtonsLine, fourthButtonsLine]
        
        buttonLines.forEach { vStackView.addArrangedSubview($0) }
        
        // 레이블 속성
        numberLabel.backgroundColor = .black
        numberLabel.text =  "\(12345)"
        numberLabel.textColor = .white
        numberLabel.textAlignment = .right
        numberLabel.font = .boldSystemFont(ofSize: 60)
        
        vStackView.axis = .vertical
        vStackView.backgroundColor = .black
        vStackView.spacing = 10
        vStackView.distribution = .fillEqually
        
        [numberLabel, vStackView]
            .forEach { view.addSubview($0) }
        
        
    
        
        // 라벨 레이아웃
        numberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(100)
        }
        
        buttonLines.forEach { $0.snp.makeConstraints { $0.height.equalTo(80) } }
        
        vStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(numberLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        
        
    }

    
    private func makeHorizontalStackView(_ views: [String]) -> UIStackView {
        let hStackView = UIStackView()
        hStackView.axis = .horizontal
        hStackView.backgroundColor = .black
        hStackView.spacing = 10
        hStackView.distribution = .fillEqually
        
        for title in views {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            
            hStackView.addArrangedSubview(button)
        }
        return hStackView
    }
    
}

