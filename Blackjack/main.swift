//
//  main.swift
//  Blackjack
//
//  Created by Jeffrey on 2017-01-18.
//  Copyright © 2017 Jeffrey. All rights reserved.
//

import Foundation

// Function to handle a round of blackjack


var inputTaken = false
var playerCount = 0

repeat
{
    print("How many people would like to play?")
    if let playerCountInput = Int(readLine()!)
    {
        playerCount = playerCountInput
        inputTaken = true
    }
} while !inputTaken

print("The number of people playing this game of Blackjack, not including the dealer, is \(playerCount).")

var players : [Hand] = []

// Initialize a hand for each of the players
for player in 0...playerCount - 1
{
    players.append(Hand(description: "player\(player)", type: "regular"))
}

var deck = Deck()

deck.status()

