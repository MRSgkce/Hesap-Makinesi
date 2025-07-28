//
//  CalculatorViewController.swift
//  HesapMakinesi
//
//  Created by Mürşide Gökçe on 27.07.2025.
//

import Foundation
import UIKit


enum Operation: Int {
    case divide = 10
    case multiply = 11
    case subtract = 12
    case add = 13
}


class CalculatorViewController : UIViewController {
    var firstNumber: Double = 0
    var currentOperation: Operation? = nil
    var isTypingNumber = false

    @IBOutlet weak var sonucLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag

        // 0-9 arası sayı butonları
        if tag >= 0 && tag <= 9 {
            if isTypingNumber {
                sonucLabel.text! += "\(tag)"
            } else {
                sonucLabel.text = "\(tag)"
                isTypingNumber = true
            }
            return
        }

        // İşlem butonları (enum'dan kontrol)
        if let operation = Operation(rawValue: tag) {
            if let text = sonucLabel.text, let number = Double(text) {
                firstNumber = number
                currentOperation = operation
                isTypingNumber = false
            }
            return
        }

        // "=" butonu örneğin tag = 20
        if tag == 19 {
            if let operation = currentOperation,
               let text = sonucLabel.text,
               let secondNumber = Double(text) {

                var result: Double = 0

                switch operation {
                case .divide:
                    result = firstNumber / secondNumber
                case .multiply:
                    result = firstNumber * secondNumber
                case .subtract:
                    result = firstNumber - secondNumber
                case .add:
                    result = firstNumber + secondNumber
                }

                sonucLabel.text = "\(result)"
                isTypingNumber = false
                currentOperation = nil
            }
            return
        }

        // "C" (clear) butonu örneğin tag = 99
        if tag == 99 {
            sonucLabel.text = "0"
            firstNumber = 0
            currentOperation = nil
            isTypingNumber = false
        }
    }


}
