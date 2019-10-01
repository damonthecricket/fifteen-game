//
//  MainViewController.swift
//  Fifteen
//
//  Created by Damon Cricket on 30.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - MainViewController

class MainViewController: UIViewController {

    @IBOutlet weak var oneButton: UIButton?
    @IBOutlet weak var twoButton: UIButton?
    @IBOutlet weak var threeButton: UIButton?
    @IBOutlet weak var fourButton: UIButton?
    @IBOutlet weak var fiveButton: UIButton?
    @IBOutlet weak var sixButton: UIButton?
    @IBOutlet weak var sevenButton: UIButton?
    @IBOutlet weak var eightButton: UIButton?
    @IBOutlet weak var nineButton: UIButton?
    @IBOutlet weak var tenButton: UIButton?
    @IBOutlet weak var elevenButton: UIButton?
    @IBOutlet weak var twelveButton: UIButton?
    @IBOutlet weak var thirteenButton: UIButton?
    @IBOutlet weak var fourteenButton: UIButton?
    @IBOutlet weak var fifteenButton: UIButton?
    @IBOutlet weak var boardView: UIView?
    
    var board: Board = Board()

    override func viewDidLoad() {
        super.viewDidLoad()

        board.random()
        
        print("Bones = \(board.bones)")

        adjust(oneButton)
        adjust(twoButton)
        adjust(threeButton)
        adjust(fourButton)
        adjust(fiveButton)
        adjust(sixButton)
        adjust(sevenButton)
        adjust(eightButton)
        adjust(nineButton)
        adjust(tenButton)
        adjust(elevenButton)
        adjust(twelveButton)
        adjust(thirteenButton)
        adjust(fourteenButton)
        adjust(fifteenButton)
    }
    
    @IBAction func refreshButtonTap(sender: UIBarButtonItem) {
        board.random()
        
        layoutBoard()
    }
    
    @IBAction func buttonTap(sender: UIButton) {
        let bone = Bone(rawValue: sender.tag)!
        board.move(bone: bone)
        layoutBoard()
        if board.isSolved() {
            let alert = UIAlertController(title: "End", message: "You win", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    private func adjust(_ button: UIButton?) {
        button?.layer.cornerRadius = 5.0
        button?.layer.borderColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1.0).cgColor
        button?.layer.borderWidth = 3.0
        
        position(button)
    }
    
    private func layoutBoard() {
        position(oneButton)
        position(twoButton)
        position(threeButton)
        position(fourButton)
        position(fiveButton)
        position(sixButton)
        position(sevenButton)
        position(eightButton)
        position(nineButton)
        position(tenButton)
        position(elevenButton)
        position(twelveButton)
        position(thirteenButton)
        position(fourteenButton)
        position(fifteenButton)
    }
    
    private func position(_ button: UIButton?) {
        let bone = Bone(rawValue: button!.tag)!
        let line = board.line(forBone: bone)
        let column = board.column(forBone: bone)
        
        let size = boardView!.frame.size.width / 4.0
        button?.frame = CGRect(x: CGFloat(column) * size, y: CGFloat(line) * size, width: size, height: size)
    }
}
