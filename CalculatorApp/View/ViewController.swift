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
    
    
    
    // 버튼 액션
    @objc
    private func buttonClicked(_ sender: UIButton) {
        
        // 버튼 텍스트 확인
        let buttonTitle = sender.titleLabel!.text ?? "0"
        
        // AC 버튼을 누른 경우
        if buttonTitle == "AC" {
            userInput = []
            numberLabel.text = "0"
            return
            
        // = 연산자 버튼을 누른 경우
        } else if buttonTitle == "=" {
            // 아무것도 입력받은게 없는 경우
            if userInput.count == 0 {
                return
            // 마지막으로 입력받은게 연산자일 경우
            } else if operators.contains(userInput.last!) {
                userInput.removeLast()
            }
            // 결과값 출력 및 결과값을 가지고 재연산을 하기 위해 저장
            numberLabel.text = "\(calculate(expression: userInput.map { String($0) }.joined())!)"
            userInput = [numberLabel.text!]
            
            guard operated.count != 1 else {
                return
            }
            
            operated.append(numberLabel.text!)
            
        // 0 버튼을 누른 경우
        } else if buttonTitle == "0" {
            //  0 부터 숫자가 시작하지 않게하기 위한 예외처리
            if userInput.count == 0 || userInput[0] == "0" {
                return
            // 연산자 이후의 숫자에도 0으로 시작하지 않도록 예외처리
            } else if operators.contains(userInput.last!) {
                return
            // 결과값이 이미 있는 경우, 초기화
            } else if operated.count == 1 {
                operated = []
                userInput = []
                numberLabel.text = "0"
                return
            // 모든 조건을 만족하는 경우, 0을 추가해 레이블에 표시
            } else {
                userInput.append(buttonTitle)
                displayText()
            }
            
        // 연산자 버튼["+", "-", "*", "/"]을 누른 경우
        } else if operators.contains(buttonTitle) {
            // 아무것도 입력 받은 값이 없는 경우
            if userInput.count == 0 {
                return
            // 연산자 뒤에 연산자를 또 입력하는 경우
            } else if operators.contains(userInput.last!) {
                userInput.removeLast()
                userInput.append(buttonTitle)
                displayText()
            // 모든 조건을 만족하는 경우
            } else {
                operated = []
                userInput.append(buttonTitle)
                displayText()
            }
            
        // 숫자 버튼을 누른 경우
        } else {
            // 결과값이 없는 경우
            if operated.count == 0 {
                userInput.append(buttonTitle)
                displayText()
            // 결과값이 존재하는 경우
            } else {
                operated = []
                userInput = []
                userInput.append(buttonTitle)
                displayText()
                return
            }
            
        }
        
    }
    
    func displayText() {
        numberLabel.text = userInput.map { String($0) }.joined()
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
