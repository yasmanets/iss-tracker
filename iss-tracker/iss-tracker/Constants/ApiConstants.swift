//
//  ApiConstants.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 30/4/22.
//

import Foundation

class ApiConstants {
    
    enum HttpMethods: String {
        case GET
    }
    
    static let ISS_BASE_URL     = "http://api.open-notify.org/iss/v1/"
    static let NUMBERS_BASE_URL = "http://numbersapi.com/"

    static let ISS_FLIGHTS_NUMBER = 10
}
