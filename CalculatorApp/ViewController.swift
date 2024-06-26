//
//  ViewController.swift
//  CalculatorApp
//
//  Created by mac on 6/25/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // 계산기 레이블 생성
    let numberLabel = UILabel()
    
    // 계산기 버튼 생성 위한 배열 생성
    let (firstLineButtons, secondLineButtons, thirdLineButtons, fourthLineButtons) = (
        ["7", "8", "9", "+"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "*"],
        ["AC", "0", "=", "/"])
    
    
    // vStackView 생성
    let vStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = .black
        
        // subView 추가
        [numberLabel, vStackView]
            .forEach { view.addSubview($0) }
        
        // 레이블 속성
        var num: Int = 0
        numberLabel.text =  "\(num)"
        numberLabel.backgroundColor = .black
        numberLabel.textColor = .white
        numberLabel.textAlignment = .right
        numberLabel.font = .boldSystemFont(ofSize: 60)
        // 레이블 레이아웃
        numberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(100)
        }
        
        // hStackView 생성 및 배열에 추가
        let buttonLines: Array<UIStackView> = [
            makeHorizontalStackView(firstLineButtons),
            makeHorizontalStackView(secondLineButtons),
            makeHorizontalStackView(thirdLineButtons),
            makeHorizontalStackView(fourthLineButtons)]
        
        // hStackView -> vStackView에 추가
        buttonLines.forEach { vStackView.addArrangedSubview($0) }
        
        // vStackView 속성
        vStackView.axis = .vertical
        vStackView.backgroundColor = .black
        vStackView.spacing = 10
        vStackView.distribution = .fillEqually
        // vStackView 레이아웃
        vStackView.snp.makeConstraints {
            $0.width.equalTo(350)
            $0.top.equalTo(numberLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
    }
    
    // 버튼 및 hStackView 생성 함수
    private func makeHorizontalStackView(_ views: [String]) -> UIStackView {
        
        // hStackView 생성
        let hStackView = UIStackView()
        
        hStackView.axis = .horizontal
        hStackView.backgroundColor = .black
        hStackView.spacing = 10
        hStackView.distribution = .fillEqually
        // hStackView 레이아웃
        hStackView.snp.makeConstraints { $0.height.equalTo(80) }
        
        // 버튼 생성 로직
        for title in views {
            let button = UIButton()
            
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
            button.frame.size.height = 80
            button.frame.size.width = 80
            button.layer.cornerRadius = 40
            
            // 연산 버튼(+, -, *, /, =, AC) 색상 변경 로직
            if Int(title) ==  nil {
                button.backgroundColor = UIColor.orange
            } else {
                button.backgroundColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1.0)
            }
            // 생성된 버튼 hStackView에 삽입
            hStackView.addArrangedSubview(button)
            
        }
        return hStackView
    }
    
}

