//
//  ViewController.swift
//  TicTacToe
//
//  Created by Priyanka Ravi on 30/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var turnLabelText: UILabel!
    @IBOutlet private weak var a1: UIButton!
    @IBOutlet private weak var a2: UIButton!
    @IBOutlet private weak var a3: UIButton!
    @IBOutlet private weak var b1: UIButton!
    @IBOutlet private weak var b2: UIButton!
    @IBOutlet private weak var b3: UIButton!
    @IBOutlet private weak var c1: UIButton!
    @IBOutlet private weak var c2: UIButton!
    @IBOutlet private weak var c3: UIButton!
    @IBOutlet weak var replayButton: UIButton!
    
    private enum Selection: String {
        case X = "X"
        case O = "O"
    }
    
    private var currentTurn: Selection = .X {
        didSet {
            turnLabelText.text = "Player: \(currentTurn.rawValue)"
        }
    }
    
    private var count = 0
    
    private var winnerDeclared = false
    
    private var winner: String = "" {
        didSet {
            turnLabelText.text = "Winner is \(winner)!"
            winnerDeclared = true
        }
    }
    
    private var buttonsInTheBoard = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        createBoard()
    }
    
    //MARK: - Private functions
    
    private func setUpUI() {
        turnLabelText.text = "Player: \(currentTurn.rawValue)"
        replayButton.layer.cornerRadius = 12
    }
    
    private func playGame(sender: UIButton) {
        let currentTitle = sender.currentTitle ?? ""
        let title = currentTurn.rawValue
        if (sender.currentTitle == nil || currentTitle.isEmpty) {
            switch currentTurn {
            case .X:
                currentTurn = .O
                break
            case .O:
                currentTurn = .X
                break
            }
            sender.setTitle(title, for: .normal)
        }
    }
    
    private func checkForVictory() {
        /// Horizontal Victory
        if areTitlesForButtonsEqual(a1, a2, a3) {
            winner = a1.getTitle
        } else if areTitlesForButtonsEqual(b1, b2, b3) {
            winner = b1.getTitle
        } else if areTitlesForButtonsEqual(c1, c2, c3) {
            winner = c1.getTitle
        }
    
        /// Vertical Victory
        if areTitlesForButtonsEqual(a1, b1, c1) {
            winner = a1.getTitle
        } else if areTitlesForButtonsEqual(a2, b2, c2) {
            winner = a2.getTitle
        } else if areTitlesForButtonsEqual(a3, b3, c3) {
            winner = a3.getTitle
        }

        /// Diagonal Victory
        if areTitlesForButtonsEqual(a1, b2, c3) {
            winner = a1.getTitle
        } else if areTitlesForButtonsEqual(a3, b2, c1) {
            winner = a3.getTitle
        }
    }
    
    private func checkForDraw() {
        var count = 0
        for button in buttonsInTheBoard {
            if button.currentTitle != nil && !button.getTitle.isEmpty {
                count = count + 1
                /// This is because you can still win the match in the last move
                if count == 9 && !winnerDeclared {
                    turnLabelText.text = "That's a Draw. Tight match!"
                    return
                }
            }
        }
    }
            
    private func areTitlesForButtonsEqual(_ button1: UIButton, _ button2: UIButton, _ button3: UIButton) -> Bool {
        if !button1.getTitle.isEmpty && !button2.getTitle.isEmpty && !button3.getTitle.isEmpty {
            if button1.getTitle.isEqual(button2.getTitle) && button2.getTitle.isEqual(button3.getTitle) {
                /// Highlight the buttons upon winning to represent the direction which resulted in Victory
                button1.backgroundColor = UIColor.systemGreen
                button2.backgroundColor = UIColor.systemGreen
                button3.backgroundColor = UIColor.systemGreen
                return true
            }
        }
        return false
    }
    
    private func createBoard() {
        buttonsInTheBoard.append(a1)
        buttonsInTheBoard.append(a2)
        buttonsInTheBoard.append(a3)
        buttonsInTheBoard.append(b1)
        buttonsInTheBoard.append(b2)
        buttonsInTheBoard.append(b3)
        buttonsInTheBoard.append(c1)
        buttonsInTheBoard.append(c2)
        buttonsInTheBoard.append(c3)
    }
    
    //MARK: - Button Action
    
    @IBAction private func onTappingAButton(_ sender: UIButton) {
        if !winnerDeclared {
            playGame(sender: sender)
            checkForVictory()
            checkForDraw()
        }
    }
    
    @IBAction private func onTappingReplay(_ sender: UIButton) {
        for button in buttonsInTheBoard {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.white
        }
        winnerDeclared = false
        currentTurn = .X
    }
}
