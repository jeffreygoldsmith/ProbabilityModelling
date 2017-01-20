//
//  Deck.swift
//  Blackjack
//
//  Created by Jeffrey on 2017-01-18.
//  Copyright © 2017 Jeffrey. All rights reserved.
//

import Foundation

// An enumeration for the suits of a deck of cards
enum Suit : Int {
    
    // List possible cases
    case clubs = 1, diamonds = 2, hearts = 3, spades = 4
    
    // Computed property to return rank
    // Really just a convenience property to make code more readable, it just returns the raw value of the enumeration case
    var rank : Int {
        switch self {
        default: return self.rawValue
        }
    }
    
    // Computed property to return glyph
    var glyph : Character {
        switch self {
        case .spades: return "♠️"
        case .hearts: return "❤️"
        case .diamonds: return "♦️"
        case .clubs: return "♣️"
        }
    }
    
    // Does one rank (this instance) beat another rank?
    func beats(_ otherSuit: Suit) -> Bool {
        return self.rank > otherSuit.rank
    }
}

// Create a new datatype to represent a playing card
struct Card {
    
    // Properties
    var value : Int
    var suit : Suit
    
    // Computed property to return card name
    var name : String {
        switch value {
        case 1: return "Ace"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        case 5: return "five"
        case 6: return "six"
        case 7: return "seven"
        case 8: return "eight"
        case 9: return "nine"
        case 10: return "ten"
        case 11: return "Jack"
        case 12: return "Queen"
        case 13: return "King"
        default: return "undefined"
        }
    }
    
    // Does the value for this card beat another card?
    func beats(_ otherCard: Card) -> Bool {
        return self.value > otherCard.value
    }
    
    // Initializer accepts arguments to set up this instance of the struct
    init?(value : Int, suit : Int) {
        // Only initialize the card if a valid valid is provided
        if value > 0 && value < 14 {
            self.value = value
            // Assign the correct Suit enumeration case
            switch suit {
            case 1: self.suit = Suit.spades
            case 2: self.suit = Suit.diamonds
            case 3: self.suit = Suit.hearts
            case 4: self.suit = Suit.spades
            default: return nil
            }
        } else {
            return nil
        }
    }
}



struct Deck {
    
    // Properties
    var cards : [Card]
    
    // Initializer(s)
    init(acesHigh : Bool = false, withJokers : Bool = false) {
        
        // Initalize the deck of cards
        cards = []
        for suit in 1...4 {
            for value in 1...13 {
                if let newCard = Card(value: value, suit: suit) {
                    cards.append(newCard)
                }
            }
        }
        
    }
    
    // Prints status of the deck
    func status() {
        // Iterate over the deck of cards
        for card in self.cards {
            print("Suit is \(card.suit.glyph) and value is \(card.value)")
        }
    }
    
    // Deals the specified number of cards to a hand
    mutating func deal(_ cardsToDeal : Int) -> [Card]? {
        
        // Track cards left to deal
        var cardsLeftToDeal = cardsToDeal
        
        // Make an array that will be passed back out of the function
        var cardsDealt : [Card] = []
        
        // "Shuffle" the deck and give half the cards to the player
        while cardsLeftToDeal > 0 && self.cards.count > 0 {
            
            // Generate a random number between 0 and the count of cards still left in the deck
            let position = Int(arc4random_uniform(UInt32(self.cards.count)))
            
            // Copy the card in this position to the player's hand
            cardsDealt.append(self.cards[position])
            
            // Remove the card from the deck for this position
            self.cards.remove(at: position)
            
            // We've dealt a card
            cardsLeftToDeal -= 1
            
        }
        
        // Check that we could deal the requested number of cards, otherwise return nil
        if cardsDealt.count < cardsToDeal {
            
            // Return dealt cards to deck
            self.cards.append(contentsOf: cardsDealt)
            
            // Clear cards dealt
            cardsDealt = []
            
            // Return nothing, since we couldn't deal the requested number of cards
            return nil
            
        } else {
            
            // We successfully dealt the right number of cards
            return cardsDealt
        }
    }
}


// Create a new datatype to represent a game of war
struct Blackjack
{
    var hands : Int
    var playerWins : Int
    
    // Default values for initializer
    init(hands : Int = 0, playerWins : Int = 0)
    {
        self.hands = hands
        self.playerWins = playerWins
    }
    
    // Report results
    func report()
    {
        print("===================")
        print("Game results are...")
        print("\(self.hands) total hands played")
        print("Player won \(self.playerWins) hands")
        print("Computer won \(self.hands - self.playerWins) hands")
    }
}


// Structure to define hand
struct Hand {
    
    // Properties
    var hand : [Card]
    var description : String
    var type : String
    var topCard : Card {
        return hand[0]
    }
    
    // Initializer(s)
    init(description : String, type : String) {
        self.hand = []
        self.description = description
        self.type = type
    }
    
    // Print status of this hand
    func status() {
        print("=====================================")
        print("All cards in the \(description)'s \(type) hand are...")
        for (index, card) in hand.enumerated() {
            print("Card \(index + 1) in \(description)'s \(type) hand is a suit of \(card.suit.glyph) and value is \(card.value)")
        }
    }
    
    // Remove the top card of this hand
    mutating func removeTopCard() {
        self.hand.remove(at: 0)
    }
}

