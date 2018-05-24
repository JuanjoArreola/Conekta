//
//  Card.swift
//  Conekta
//
//  Created by Juan Jose Arreola on 22/02/18.
//

import UIKit
import Foundation

public class Card: Encodable {
    public var number: String
    public var name: String
    public var cvc: String
    public var month: String
    public var year: String
    public var deviceFingerprint: String
    
    public init(number: String, name: String, cvc: String, month: String, year: String) {
        self.number = number
        self.name = name
        self.cvc = cvc
        self.month = month
        self.year = year
        deviceFingerprint = UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "") ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case name, number, cvc
        case month = "exp_month"
        case year = "exp_year"
        case deviceFingerprint = "device_fingerprint"
    }
}
