//
//  ResultsViewController.swift
//  Roshambo
//  Created by Danny Nguyen on 7/10/16.
//  Copyright © 2016 Danny Nguyen. All rights reserved.
//
import UIKit

// The enum "Shape" represents a play or move
enum Shape: String {
    case Rock = "Rock"
    case Paper = "Paper"
    case Scissors = "Scissors"

    // This function randomly generates an opponent's play
    static func randomShape() -> Shape {
        let shapes = ["Rock", "Paper", "Scissors"]
        let randomChoice = Int(arc4random_uniform(3))
        return Shape(rawValue: shapes[randomChoice])!
    }
}

class ResultsViewController: UIViewController {


    @IBOutlet private weak var resultImage: UIImageView!
    @IBOutlet private weak var resultLabel: UILabel!

  
    // Once resultsViewController is initialized ,a userChoice is passed in and an opponent's play turn is generated
    var userChoice: Shape!
    private let opponentChoice: Shape = Shape.randomShape()

   

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayResult()
    }



    // The displayResult method generates the images and message for the results of a match.
    private func displayResult() {
    
        var imageName: String
        var text: String
        let matchup = "\(userChoice.rawValue) vs. \(opponentChoice.rawValue)"

        switch (userChoice!, opponentChoice) {
        case let (user, opponent) where user == opponent:
            text = "\(matchup): You are BOTH LOSERS!"
            imageName = "tie"
        case (.Rock, .Scissors), (.Paper, .Rock), (.Scissors, .Paper):
            text = "Winner! \(matchup)! "
            imageName = "\(userChoice.rawValue)-\(opponentChoice.rawValue)"
        default:
            text = "Womp Womp, what a LOSER!! \(matchup) :(."
            imageName = "\(opponentChoice.rawValue)-\(userChoice.rawValue)"
        }

        imageName = imageName.lowercaseString
        resultImage.image = UIImage(named: imageName)
        resultLabel.text = text
    }

    @IBAction private func playAgain() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
