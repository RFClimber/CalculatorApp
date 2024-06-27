//
//  Logic.swift
//  CalculatorApp
//
//  Created by mac on 6/26/24.
//

import Foundation

let (firstLineButtons, secondLineButtons, thirdLineButtons, fourthLineButtons) = (
    ["7", "8", "9", "+"],
    ["4", "5", "6", "-"],
    ["1", "2", "3", "*"],
    ["AC", "0", "=", "/"])


var userInput: Array<String> = []

var inputNumber: String = ""

var operators = ["+", "-", "*", "/"]

var operated: Array<String> = []


