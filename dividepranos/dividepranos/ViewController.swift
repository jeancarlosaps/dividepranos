//
//  ViewController.swift
//  dividepranos
//
//  Created by Jean Carlos on 5/19/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var txfNumberOfPeople: UITextField!
    @IBOutlet weak var txfAccountAmount: UITextField!
    @IBOutlet weak var txfExtras: UITextField!
    @IBOutlet weak var txfServiceCharge: UITextField!
    @IBOutlet weak var lblAccountResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.txfNumberOfPeople.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.txfAccountAmount.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.txfExtras.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.txfServiceCharge.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.lblAccountResult.text = nil
        
    }

    //MARK: Função que realiza o cálculo da divisão da conta.
    @IBAction func btnDivideUs(_ sender: UIButton) {
        
        
    }
    
    func sumExpenses() -> Float {
        
        let result = 0.0
        
        return Float(result)
    }


}

