//
//  AnyNumber.swift
//  WidgetsAndUtilites
//
//  Created by Jimekor Hini on 2023-06-08.
//

import Foundation
struct AnyNumber {
  let someNumber: Any
  let hasDecimal: Bool
  
  private init(someNumber: Any, hasDecimal: Bool = false) {
    self.someNumber = someNumber
    self.hasDecimal = hasDecimal
  }
  
  init(_ number:Int, hasDecimal: Bool = false) {
    self.init(someNumber: number, hasDecimal: hasDecimal)
  }
  
  init(_ number:Float, hasDecimal: Bool = false) {
    self.init(someNumber: number, hasDecimal: hasDecimal)
  }
  
  init(_ number:Double, hasDecimal: Bool = false) {
    self.init(someNumber: number, hasDecimal: hasDecimal)
  }

  
  var stringValue: String {
    
    let optionalValueString = displayValue(someNumber: someNumber, showDecimalPlace: hasDecimal)
    var valueString = ""
    
    /*
      if optionalValueString != nil {
        valueString = optionalValueString!
      } else {
        valueString = "\(someNumber)"
      }
     */
    
    // Ternary version
    /*
     valueString = optionalValueString != nil ? optionalValueString! : "\(someNumber)"
     // In the nil coeliscing code, != nil ? optionalValueString! : is replaced with '??'
     */
    
    // They are the same ^ v
    
                  /* The optional variable to inspect*/
                    /*  | */ /* If is not nil, unwrap it and give me the unwrapped value*/
                    /*  | */      /*  | */ /* Else fall back on this or use this  */
                    /*  | */      /*  | *//*  | */
                    /*  ↓ */      /*  ↓ *//*  ↓ */
    
    valueString = optionalValueString ?? "\(someNumber)"
    return valueString
  
  }
  
  func displayValue(someNumber: Any, showDecimalPlace: Bool) -> String? {
    var stringValue: String?
    // make sure that some number is a type of number
    if type(of: someNumber) == Int.self || type(of: someNumber) == Double.self || type(of: someNumber) == Float.self {
      
      if type(of: someNumber) == Int.self {
        stringValue = showDecimalPlace == false ? "\(someNumber as! Int)" : "\(Double(someNumber as! Int))"
      } else if type(of: someNumber) == Double.self {
        stringValue = showDecimalPlace == false ? "\(Int(someNumber as! Double))" : "\(Double(someNumber as! Double))"
      } else {
        stringValue = showDecimalPlace == false ? "\(Int(someNumber as! Float))" : "\(Float(someNumber as! Float))"
      }
    }
    
    return stringValue
  }
}


