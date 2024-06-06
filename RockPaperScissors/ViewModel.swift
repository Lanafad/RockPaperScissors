//
//  ViewModel.swift
//  RockPaperScissors
//
//  Created by lana alfaadhel on 07/06/2024.
//

import SwiftUI

final class ViewModel : ObservableObject {
    
    
    //VARIABLES
    let moves : [Moves] = [.Rock, .Paper, .Scissor]
    @Published var appMove = Int.random(in: 0...2)
    @Published var shouldWin = Bool.random()
    @Published var userScore = 0
    @Published var alertItem : AlertItem?
    
    
    //FUNCTIONS
    func rightAnswe () -> Moves {
        let move = moves[appMove]
        
        switch move {
        case .Rock:
            if shouldWin {
                return .Paper
            } else {
                return .Scissor
            }
        case .Paper:
            if shouldWin {
                return .Scissor
            } else {
                return .Rock
            }
        case .Scissor:
            if shouldWin {
                return .Rock
            } else {
                return .Paper
            }
            
        default:
            return .none
        }
        
        
    }
    
    func buttonPressed(move : Moves){
        
        if move == moves[appMove] {
            userScore = 0
            alertItem = AlertConext.lostStreak
        } else if move == rightAnswe() {
            if (userScore + 1) % 10 == 0 && userScore != 0 {
                alertItem = AlertConext.ReachedTen
                userScore += 1
            } else {
                userScore += 1
            }
        } else {
            userScore = 0
            alertItem = AlertConext.lostStreak
        }
        newTap()
        
        
        
    }
    
    func newTap() {
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func reset(){
        appMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        userScore = 0
    }
    
    
    //ALERTS
    struct AlertItem : Identifiable {
        let id = UUID()
        let title : Text
        let message : Text
        let resetButtonText : Text
    }

    struct AlertConext {
        static let lostStreak = AlertItem(
            title: Text("Oops!"),
            message: Text("You Have Lost Your Streak"),
            resetButtonText: Text("Play Again"))
        
        static let ReachedTen = AlertItem(
            title: Text("Congrats!"),
            message: Text("You Reached A New Milestone"),
            resetButtonText: Text("Continue"))
    }

    
    //ENUM
    enum Moves {
        case Rock, Paper, Scissor, none
    }
}
