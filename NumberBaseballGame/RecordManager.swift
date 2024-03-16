//
//  RecordManager.swift
//  NumberBaseballGame
//
//  Created by 김정호 on 3/16/24.
//

import Foundation

final class RecordManager {
    // MARK: - properties
    private var games = Array<Int>()
    
    // MARK: - methods
    func add(trialCount: Int) {
        games.append(trialCount)
    }
    
    func showRecords() {
        print("< 게임 기록 보기 >")
        
        for index in 0...games.count-1 {
            print("\(index+1)번째 게임 : 시도 횟수 - \(games[index])")
        }
    }
}
