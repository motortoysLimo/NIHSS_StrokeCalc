//
//  UIViewShadowExtension.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/10/17.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setShadowLayer() {
        
//        if isCircle {
//            self.layer.shadowRadius = self.frame.size.width / 2
//        }else {
//            self.layer.shadowRadius = self.layer.cornerRadius
//        }
        
        self.layer.shadowRadius = 2.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: -1.0, height: 1)
        self.layer.shadowOpacity = 0.65
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
    }
}

extension String {
    func index(of string: String, options: String.CompareOptions = .literal) -> String.Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func indexes(of string: String, options: String.CompareOptions = .literal) -> [String.Index] {
        var result: [String.Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: String.CompareOptions = .literal) -> [Range<String.Index>] {
        var result: [Range<String.Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}
