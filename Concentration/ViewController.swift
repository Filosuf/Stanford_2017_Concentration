//
//  ViewController.swift
//  Concentration
//
//  Created by 1234 on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var emoji = [Card: String]()
    private var backgroundColorView = UIColor.black
    private var backgroundColorCard = UIColor.orange
    private var emojiChoices = "🦇😱🙀😈🎃👻🍭🍬🍎"
    var indexTheme = 0 {
        didSet{
            emojiChoices = emojiThemes[indexTheme].emojis
            backgroundColorCard = emojiThemes[indexTheme].cardColor
            backgroundColorView = emojiThemes[indexTheme].viewColor

            view.backgroundColor = backgroundColorView
            flipCountLabel.textColor = backgroundColorCard
            scoreLabel.textColor = backgroundColorCard
            titleLabel.textColor = backgroundColorCard
            newGameButton.setTitleColor(backgroundColorView, for: .normal)
            newGameButton.backgroundColor = backgroundColorCard

            updateViewFromModel()
            titleLabel.text = emojiThemes[indexTheme].name
        }
    }


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    //массив Кнопок
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    @IBAction func newGame(_ sender: UIButton) {
        game.newGame()
        indexTheme = Int.random(in: 0..<emojiThemes.count)
        emoji = [:]
//        updateViewFromModel()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme = Int.random(in: 0..<emojiThemes.count)
//        updateViewFromModel()
    }


    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Choosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji (for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : backgroundColorCard
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }

    private struct Theme {
        var name: String
        var emojis: String
        var viewColor: UIColor
        var cardColor: UIColor
    }

    private var emojiThemes: [Theme] = [
        Theme(name: "Fruits",
              emojis:"🍏🍊🍓🍉🍇🍒🍌🥝🍆🍑🍋",
              viewColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
              cardColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
        Theme(name: "Faces",
              emojis:"😀😂🤣😃😄😅😆😉😊😋😎",
              viewColor: #colorLiteral(red: 1, green: 0.8999392299, blue: 0.3690503591, alpha: 1),
              cardColor: #colorLiteral(red: 0.5519944677, green: 0.4853407859, blue: 0.3146183148, alpha: 1)),
        Theme(name: "Activity",
              emojis:"⚽️🏄‍♂️🏑🏓🚴‍♂️🥋🎸🎯🎮🎹🎲",
              viewColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
              cardColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
        Theme(name: "Animals",
              emojis:"🐶🐭🦊🦋🐢🐸🐵🐞🐿🐇🐯",
              viewColor: #colorLiteral(red: 0.8306297664, green: 1, blue: 0.7910112419, alpha: 1),
              cardColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        Theme(name: "Christmas",
              emojis:"🎅🎉🦌⛪️🌟❄️⛄️🎄🎁🔔🕯",
              viewColor: #colorLiteral(red: 0.9678710938, green: 0.9678710938, blue: 0.9678710938, alpha: 1),
              cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        Theme(name: "Clothes",
              emojis:"👚👕👖👔👗👓👠🎩👟⛱🎽",
              viewColor: #colorLiteral(red: 0.9098039269, green: 0.7650054947, blue: 0.8981300767, alpha: 1),
              cardColor: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)),
        Theme(name: "Halloween",
              emojis:"💀👻👽🙀🦇🕷🕸🎃🎭😈⚰",
              viewColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
              cardColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
        Theme(name: "Transport",
              emojis:"🚗🚓🚚🏍✈️🚜🚎🚲🚂🛴",
              viewColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
              cardColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
    ]

    private func emoji(for card: Card) -> String {
        //1-я форма записи
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: randomIndex)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    
    
    
}

