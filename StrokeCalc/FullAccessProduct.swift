//
//  FullAccessProduct.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/8/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import Foundation

public struct StrokeCalcProducts {
    
    public static let FullAccess = "com.personalrn.strokecalcbeta.FullAccess"
    
    fileprivate static let productIdentifiers: Set<ProductIdentifier> = [StrokeCalcProducts.FullAccess]
    
    public static let store = IAPHelper(productIds: StrokeCalcProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
    return productIdentifier.components(separatedBy: ".").last
}
