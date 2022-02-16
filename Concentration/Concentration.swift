//
//  Concenration.swift
//  Concentration
//
//  Created by 1234 on 27.10.2021.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    private(set) var flipCount = 0 //счетчик нажатий
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set (newValue) {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        //Выбранная карта не является выбывшей из игры или уже открытой
        if !cards[index].isMatched && !cards[index].isFaceUp  {
            flipCount += 1
        }
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //проверка на совпадение карт
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //нет карт или 2 карты перевернуты лицом вверх
                indexOfOneAndOnlyFaceUpCard = index
            }
        }

    }

    func newGame() {
        cards.shuffle()
        flipCount = 0
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        //TODO: Shuffle the cards
        cards.shuffle()
    }
}
