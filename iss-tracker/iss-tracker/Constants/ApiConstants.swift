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
    
    // ElParking coordinates
    static let DEFAULT_LATITUDE     = 40.971230
    static let DEFAULT_LONGITUDE    = -5.662340
    static let DEFAULT_ADDRESS      = "C/ Rodríquez Fabrés, 21, Salamanca 37005, España"
}
