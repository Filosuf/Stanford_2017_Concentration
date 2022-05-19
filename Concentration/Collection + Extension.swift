//
//  Collection + Extension.swift
//  Concentration
//
//  Created by 1234 on 19.05.2022.
//

import Foundation

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
