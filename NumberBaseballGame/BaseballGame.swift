//
//  BaseballGame.swift
//  NumberBaseballGame
//
//  Created by 김정호 on 3/14/24.
//

import Foundation

final class BaseballGame {
    // MARK: - properties
    let recordManager = RecordManager()
    
    // MARK: - methods
    func start() {
        var isRunning = true
        
        while isRunning {
            print("환영합니다! 원하시는 번호를 입력해주세요")
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            
            let userInput = Int(readLine()!)
            
            switch userInput {
            case 1:
                recordManager.add(trialCount: startGame())
            case 2:
                recordManager.showRecords()
            case 3:
                print("< 숫자 야구 게임을 종료합니다 >")
                isRunning = false
            default:
                print("올바른 숫자를 입력해주세요!")
            }
        }
    }
    
    private func startGame() -> Int {
        print("< 게임을 시작합니다 >")
        print("1에서 9까지의 서로 다른 임의의 수 3개를 입력하세요.")
        
        let answer = makeAnswer()
        var count = 0
        
        while true {
            let userInput = readLine()!
            count += 1
            
            if let userNumber = validateInputNumber(userInput: userInput) {
                if answer == userNumber {
                    print("정답입니다!")
                    break
                } else {
                    printScore(number: String(userNumber), answer: String(answer))
                }
            }
        }
        
        return count
    }
    
    private func makeAnswer() -> Int {
        var answer = 0
        var numbersArray = [0,1,2,3,4,5,6,7,8,9]
        
        for digit in 1...3 {
            if let index = numbersArray.firstIndex(of: 0), digit == 3 {
                numbersArray.remove(at: index)
            }
            
            let randomNumber = numbersArray.randomElement()!
            numbersArray.remove(at: numbersArray.firstIndex(of: randomNumber)!)
            
            answer += getDigitNumber(digit: digit, number: randomNumber)
        }
        
        return answer
    }
    
    private func getDigitNumber(digit: Int, number: Int) -> Int {
        switch digit {
        case 1:
            return number
        case 2:
            return number * 10
        default:
            return number * 100
        }
    }
    
    private func validateInputNumber(userInput: String) -> Int? {
        if userInput == "" {
            print("입력이 비어있습니다. 다시 입력해주세요.")
        } else if Int(userInput) == nil {
            print("숫자 형식을 지켜 입력해주세요.")
        } else if Int(userInput)! < 100 || Int(userInput)! > 999 {
            print("3자리의 숫자를 입력해주세요.")
        } else if !validateUniqueNumbers(number: userInput) {
            print("서로 다른 3개의 숫자를 입력해주세요.")
        } else {
            return Int(userInput)!
        }
        
        return nil
    }
    
    private func validateUniqueNumbers(number: String) -> Bool {
        var uniqueNumber = Set<String>()
        let arrayNumber = number.map { String($0) }
        
        for i in 0...2 {
            uniqueNumber.insert(arrayNumber[i])
        }
        
        return uniqueNumber.count == 3 ? true : false
    }
    
    private func printScore(number: String, answer: String) {
        let numberArray = Array(number).map { String($0) }
        let answerArray = Array(answer).map { String($0) }
        
        var strike = 0
        var ball = 0
        
        for i in 0...2 {
            if numberArray[i] == answerArray[i] {
                strike += 1
            }
            
            if numberArray[i] != answerArray[i] && answerArray.contains(numberArray[i]){
                ball += 1
            }
        }
        
        if strike > 0 && ball > 0 {
            print("\(strike)스트라이크 \(ball)볼")
        } else if strike > 0 {
            print("\(strike)스트라이크")
        } else if ball > 0 {
            print("\(ball)볼")
        } else {
            print("Nothing")
        }
    }
}
