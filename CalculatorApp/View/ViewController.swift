//
//  ViewController.swift
//  CalculatorApp
//
//  Created by mac on 6/25/24.
//
//  view UI <-> Model: Data / controller: 병합(Action 등)

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // 계산기 레이블 생성
    let numberLabel = UILabel()
    
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
        numberLabel.text =  "0"
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
            button.addTarget(self, action: #selector(buttonClicked(_ :)), for: .touchDown)
            
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
    
    
    
    
    @objc
    private func buttonClicked(_ sender: UIButton) {
        
        let buttonTitle = sender.titleLabel!.text ?? "0"
        
        if buttonTitle == "AC" {
            userInput = []
            numberLabel.text = "0"
            return
        } else if buttonTitle == "=" {
            if userInput.count == 0 {
                return
            } else if operators.contains(userInput.last!) {
                userInput.removeLast()
            }
            numberLabel.text = "\(calculate(expression: userInput.map { String($0) }.joined())!)"
            userInput = [numberLabel.text!]
            guard operated.count != 1 else {
                return
            }
            operated.append(numberLabel.text!)
        } else if buttonTitle == "0" {
            if userInput.count == 0 || userInput[0] == "0" {
                return
            } else if operated.count == 1 {
                operated = []
                userInput = []
                numberLabel.text = "0"
                return
            } else {
                userInput.append(buttonTitle)
                numberLabel.text = userInput.map { String($0) }.joined()
            }
        } else if operators.contains(buttonTitle) {
            
            if userInput.count == 0 {
                return
            } else if operators.contains(userInput.last!) {
                userInput.removeLast()
                userInput.append(buttonTitle)
                numberLabel.text = userInput.map { String($0) }.joined()
            } else {
                operated = []
                userInput.append(buttonTitle)
                numberLabel.text = userInput.map { String($0) }.joined()
            }

            
        } else {
            if operated.count == 0 {
                userInput.append(buttonTitle)
                numberLabel.text = userInput.map { String($0) }.joined()
            } else {
                operated = []
                userInput = []
                userInput.append(buttonTitle)
                numberLabel.text = userInput.map { String($0) }.joined()
                return
            }
            
        }
        
    }
    func calculate(expression: String) -> Int? {
        let expression = NSExpression(format: expression)
        if let result = expression.expressionValue(with: nil, context: nil) as? Int {
            return result
        } else {
            return nil
        }
    }
    
}


//#Preview {
// let name = ViewController()
// return name
//}
