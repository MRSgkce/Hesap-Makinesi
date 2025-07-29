//
//  CalculatorViewController.swift
//  HesapMakinesi
//
//  Created by Mürşide Gökçe on 27.07.2025.
//

import Foundation
import UIKit
import UIKit

enum Operation: Int {
    case divide = 10
    case multiply = 11
    case subtract = 12
    case add = 13
}

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var sonucLabel: UILabel!
    
    var firstNumber: Double?
    var currentOperation: Operation?
    var isTypingNumber = false
    var expressionText = ""  // Tüm ifadenin gösterimi (8 × 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        sonucLabel.text = "0"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        let tag = sender.tag

        // Sayı tuşları (0–9)
        if tag >= 0 && tag <= 9 {
            if isTypingNumber {
                expressionText += "\(tag)"
            } else {
                if currentOperation == nil {
                    expressionText = "\(tag)"
                } else {
                    expressionText += " \(tag)"
                }
                isTypingNumber = true
            }
            sonucLabel.text = expressionText
            return
        }

        // İşlem tuşları
        if let operation = Operation(rawValue: tag) {
            if let text = sonucLabel.text, let number = Double(text.components(separatedBy: " ").last ?? "") {
                firstNumber = number
                currentOperation = operation
                expressionText += " \(symbolForOperation(operation))"
                isTypingNumber = false
                sonucLabel.text = expressionText
            }
            return
        }

        // "=" tuşu
        if tag == 19 {
            if let op = currentOperation,
               let first = firstNumber,
               let secondStr = expressionText.components(separatedBy: " ").last,
               let second = Double(secondStr) {

                var result: Double = 0

                switch op {
                case .divide: result = first / second
                case .multiply: result = first * second
                case .subtract: result = first - second
                case .add: result = first + second
                }

                sonucLabel.text = "\(result.cleanValue)"
                expressionText = ""
                firstNumber = nil
                currentOperation = nil
                isTypingNumber = false
            }
            return
        }

        // "C" tuşu (tag = 99)
        if tag == 99 {
            sonucLabel.text = "0"
            expressionText = ""
            firstNumber = nil
            currentOperation = nil
            isTypingNumber = false
        }
    }

    func symbolForOperation(_ op: Operation) -> String {
        switch op {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
}

extension Double {
    var cleanValue: String {
        return truncatingRemainder(dividingBy: 1) == 0 ?
            String(Int(self)) : String(self)
    }
}
