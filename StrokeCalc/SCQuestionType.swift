//
//  SCQuestionType.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/12/17.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import Foundation

enum SCQType: String {
    case Q1A = "Q1A"
    case Q1B = "Q1B"
    case Q1C = "Q1C"
    case Q2 = "Q2"
    case Q3 = "Q3"
    case Q4 = "Q4"
    case Q5A = "Q5A"
    case Q5B = "Q5B"
    case Q6A = "Q6A"
    case Q6B = "Q6B"
    case Q7 = "Q7"
    case Q8 = "Q8"
    case Q9 = "Q9"
    case Q10 = "Q10"
    case Q11 = "Q11"
    
    static let allTypes = [Q1A, Q1B, Q1C, Q2, Q3, Q4, Q5A, Q5B, Q6A, Q6B, Q7, Q8, Q9, Q10, Q11]
}

enum SCQ9Type: String {
    case Q9A = "Q9A"
    case Q9B = "Q9B"
    case Q9C = "Q9C"
    
    static let allTypes = [Q9A, Q9B, Q9C]
}

enum SCQ11Type: String {
    case Q11A = "Q11A"
    case Q11B = "Q11B"
    
    static let allTypes = [Q11A, Q11B]
}
