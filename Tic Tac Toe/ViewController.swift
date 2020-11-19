//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Remis on 2020-11-19.
//

import UIKit

class ViewController: UIViewController {
    
    // 1 - kryziukai, 0 - nuliukai
    var activePlayer = 1
    var countMoves = 0
    var gameIsActive = true
    var gameState = [0,0,0,0,0,0,0,0,0] // 0 - empty, 2 - cross, 1 - nuliukas
    var winCombos = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    var imagesOX = [#imageLiteral(resourceName: "cross.png"),#imageLiteral(resourceName: "nought.png")]
    var imagesOXcolor = [#imageLiteral(resourceName: "cross_color.png"),#imageLiteral(resourceName: "nought_color.png")]
    
    var timer = Timer()

    @IBAction func playAgainPressed(_ sender: UIButton) {
        resetGame()
    }
    
    @IBOutlet weak var playAgainButt: UIButton!
    @IBOutlet weak var butt01: UIButton!
    @IBOutlet weak var butt02: UIButton!
    @IBOutlet weak var butt03: UIButton!
    @IBOutlet weak var butt04: UIButton!
    @IBOutlet weak var butt05: UIButton!
    @IBOutlet weak var butt06: UIButton!
    @IBOutlet weak var butt07: UIButton!
    @IBOutlet weak var butt08: UIButton!
    @IBOutlet weak var butt09: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let activePosition = sender.tag - 1
        
        if gameState[activePosition] == 0 && gameIsActive && countMoves < 9 {
            if activePlayer == 0 {
                sender.setImage(imagesOX[0], for: [])
                activePlayer = 1
                gameState[activePosition] = 1
            } else {
                sender.setImage(imagesOX[1], for: [])
                activePlayer = 0
                gameState[activePosition] = 2
            }
            countMoves += 1
            checkIfWon()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetGame()
    }
    
    func checkIfWon() {
        for combo in winCombos {
            if gameState[combo[0]] != 0 && gameState[combo[0]] == gameState[combo[1]] && gameState[combo[1]] == gameState[combo[2]] {
                // We have a winner!
                let winnerIcon = gameState[combo[0]]
                gameIsActive = false
                playAgainButt.isHidden = false
                animateUpButton()
                animateWinner(combo, winnerIcon)
            }
        }
        
        if countMoves == 9 {
            gameIsActive = false
            playAgainButt.isHidden = false
            animateUpButton()
        }
        
    }

    func animateUpButton() {
        UIView.animate(withDuration: 0.5) {
            self.playAgainButt.center = CGPoint(x: self.playAgainButt.center.x, y: self.playAgainButt.center.y - 500)
        }
    }
    
    func animateWinner(_ combo: [Int], _ iconNumber: Int) {
        // blink animation of a winner line
//        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(animateIntro), userInfo: nil, repeats: true)
        for i in combo {
            if let button = view.viewWithTag(i+1) as? UIButton {
                button.setImage(imagesOXcolor[iconNumber-1], for: [])
            }
        }
    }
    
    func resetGame() {
        
        playAgainButt.isHidden = true
        activePlayer = 1
        countMoves = 0
        gameState = [0,0,0,0,0,0,0,0,0]
        gameIsActive = true
        
        for i in 0...9 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
    }

    @objc func animateIntro() {
        // animate board someday
    }
    
}

