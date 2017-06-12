//
//  SCAnswerStatus.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/14/17.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import Foundation

class SCAnswerStatus {
    
    //MARK: - Shared Instance
    
    static let sharedInstance : SCAnswerStatus = {
        let instance = SCAnswerStatus()
        return instance
    }()
    
    //MARK: - Local Variable
    
    // Flow 5
    // just using isAdjustForGuardRail1 for Guardrail 1C/1B
    var isYesForGuardrail1B = false
    
    // Flow 3
    var isAdjustForGuardRail1 = false
    var isGuardRail2A = false
    var isAdjustForQ9 = false
    var isAdjustForGuardRail6 = false
    var isNotBlind = false
    
    //MARK: - Init
    
    convenience init() {
        self.init( guardRailStatus : false)
    }
    
    //MARK: - Init Array
    
    init( guardRailStatus : Bool) {
        self.isAdjustForGuardRail1 = guardRailStatus
        self.isGuardRail2A = guardRailStatus
        self.isAdjustForQ9 = guardRailStatus
        self.isAdjustForGuardRail6 = guardRailStatus
        self.isYesForGuardrail1B = guardRailStatus
        self.isNotBlind = guardRailStatus
    }
    
    //MARK: - Methods
    
    func calculateQ9Score(total: Int) -> Int{
        let score = Float(total) / Float(2) as Float
        var q9Score: Int = 0
        if score == 0 {
            q9Score = 0
        }else if score > 0 && score <= 1.5 {
            q9Score = 1
        }else if score > 1.5 && score <= 2.4 {
            q9Score = 2
        }else if score > 2.4 && score <= 3 {
            q9Score = 3
        }
        
        return q9Score
    }
}
