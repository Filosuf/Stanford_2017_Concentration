//
//  Card.swift
//  Concentration
//
//  Created by 1234 on 28.10.2021.
//

import Foundation

struct Card
{

    var isFaceUp = false
    var isMatched = false
    var identifier : Int

    static var identifierFactory = 0

    //получение идентификатора для карты
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}

//MARK: -Hashable
extension Card: Hashable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
