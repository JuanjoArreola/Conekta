//
//  Card.swift
//  Conekta
//
//  Created by Juan Jose Arreola on 22/02/18.
//

#if canImport(UIKit)

import UIKit
import Foundation

public class Card: Encodable {
    public var number: String
    public var name: String
    public var cvc: String
    public var expirationMonth: String
    public var expirationYear: String
    var deviceFingerprint: String
    
    public init(number: String, name: String, cvc: String, month: String, year: String) {
        self.number = number
        self.name = name
        self.cvc = cvc
        self.expirationMonth = month
        self.expirationYear = year
        self.deviceFingerprint = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name, number, cvc
        case expirationMonth = "exp_month"
        case expirationYear = "exp_year"
        case deviceFingerprint = "device_fingerprint"
    }
}

#endif
