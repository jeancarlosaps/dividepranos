//
//  ViewController.swift
//  dividepranos
//
//  Created by Jean Carlos on 5/19/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: Variáveis de controle
    var numberOfPeople: Float = 0.0
    var accountAmount: Float = 0.0
    var extras: Float = 0.0
    var serviceCharge: Float = 0.0
    
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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }

    //MARK: Função que realiza o cálculo da divisão da conta.
    @IBAction func btnDivideUs(_ sender: UIButton) {
        self.numberOfPeople = Float(self.txfNumberOfPeople.text!)!
        self.accountAmount = Float(self.txfAccountAmount.text!)!
        self.extras = Float(self.txfExtras.text!)!
        self.serviceCharge = Float(self.txfServiceCharge.text!)!
        
        let result = SplitAccount(numberOfPeople: self.numberOfPeople, accountAmount: self.accountAmount, extras: self.extras, serviceCharge: self.serviceCharge)
        
        self.lblAccountResult.text = String(result)
    }
    
    //TODO
    @IBAction func btnCallUber(_ sender: UIButton) {
        
        
    }
    
    //TODO
    @IBAction func btnCallTaxi(_ sender: UIButton) {
        
        
    }
    
}

