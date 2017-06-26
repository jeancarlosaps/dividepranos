//
//  ViewController.swift
//  dividepranos
//
//  Created by Jean Carlos on 5/19/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import UIKit
//import UberRides

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
        
//        // China based apps should specify the region
//        Configuration.setRegion(.Brazil)
//        // If true, all requests will hit the sandbox, useful for testing
//        Configuration.setSandboxEnabled(true)
//        // If true, Native login will try and fallback to using Authorization Code Grant login (for privileged scopes). Otherwise will redirect to App store
//        Configuration.setFallbackEnabled(false)
//        // Complete other setup
//        return true
    }

    //MARK: Função que realiza o cálculo da divisão da conta.
    @IBAction func btnDivideUs(_ sender: UIButton) {
        
        self.numberOfPeople = Float(self.txfNumberOfPeople.text!)!
        self.accountAmount = Float(self.txfAccountAmount.text!)!
        self.extras = Float(self.txfExtras.text!)!
        self.serviceCharge = Float(self.txfServiceCharge.text!)!
        
        let result = self.accountAmount + self.extras + self.serviceCharge / self.numberOfPeople
        
        self.lblAccountResult.text = String(result)
    }
    
    @IBAction func btnCallUber(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnCallTaxi(_ sender: UIButton) {
        
        
    }
    
}

