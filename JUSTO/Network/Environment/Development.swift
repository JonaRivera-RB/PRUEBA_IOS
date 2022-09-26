//
//  Development.swift
//  JUSTO
//
//  Created by Jonathan Misael Rivera on 25/09/22.
//

import Foundation
import APIJR

class Development: Endpoint {
    var environment: String = ""
    var scheme: String = "https"
    var baseURL: String = "randomuser.me"
    var headers: [String : String] = [ "Content-Type": "application/json"]
}
