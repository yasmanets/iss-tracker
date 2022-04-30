//
//  ISSResponse.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 29/4/22.
//

import Foundation

struct ISSResponse: Codable {
    let message: String?
    let response: [Flights]?
}
