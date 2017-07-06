//
//  SplitAccount.swift
//  dividepranos
//
//  Created by Jean Carlos on 6/23/17.
//  Copyright © 2017 Jean Carlos. All rights reserved.
//

import Foundation

func SplitAccount(numberOfPeople: Float, accountAmount: Float, extras: Float, serviceCharge: Float) -> Float{
    var result: Float = 0.0
    result = accountAmount + extras + serviceCharge / numberOfPeople
    
    return result
}
