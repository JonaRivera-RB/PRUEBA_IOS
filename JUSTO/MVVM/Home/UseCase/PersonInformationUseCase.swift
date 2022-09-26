//
//  PersonInformationUseCase.swift
//  JUSTO
//
//  Created by Jonathan Misael Rivera on 25/09/22.
//

import Foundation
import APIJR

protocol PersonInformation {
    func request(_ completion:@escaping(Result<JustoPersonModel?, Error>) -> () )
}

struct PersonInformationUseCase: PersonInformation {
    func request(_ completion:@escaping(Result<JustoPersonModel?, Error>) -> () ) {
        let network = NetworkEngine(path: "/api/", parameters: nil, method: .get, endpoint: Development())
        network.request(completion: completion)
    }
}
