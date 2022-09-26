//
//  PersonInformationViewModel.swift
//  JUSTO
//
//  Created by Jonathan Misael Rivera on 25/09/22.
//

import Foundation
import APIJR
import UIKit

final class PersonInformationViewModel {

    var error: Observable<String?> = Observable(nil)
    var requestResponse: Observable <Bool?> = Observable(nil)

    private var personInformationUseCase: PersonInformation!
    private var justoPersonResponse: JustoPersonModel?
    private var notAvailable = "NA"

    init(personInformationUseCase: PersonInformation) {
        self.personInformationUseCase = personInformationUseCase
    }

    public func getPersonInformation() {
        personInformationUseCase.request { [weak self] result in
            switch result {
            case .success(let response):
                self?.justoPersonResponse = response
                self?.requestResponse.value = true
            case .failure(let error):
                print("error wey :/")
                self?.error.value = error.localizedDescription
            }
        }
    }

    public var name: String {
        guard let nameModel = justoPersonResponse?.results?.first?.name else { return notAvailable }
        let firstName = nameModel.first ?? notAvailable
        let secondName = nameModel.last ?? notAvailable
        let title = nameModel.title ?? notAvailable

        return title + " " + firstName + " " + secondName
    }

    public var username: String {
        return justoPersonResponse?.results?.first?.login?.username ?? notAvailable
    }

    public var email: String {
        return justoPersonResponse?.results?.first?.email ?? notAvailable
    }

    public var phone: String {
        return justoPersonResponse?.results?.first?.phone ?? notAvailable
    }

    public var ID: String {
        return justoPersonResponse?.results?.first?.id?.name ?? notAvailable
    }

    public var numberID: String {
        return justoPersonResponse?.results?.first?.id?.value ?? notAvailable
    }

    public var imageURL: URL? {
        guard let URLString = justoPersonResponse?.results?.first?.picture?.large else { return nil }
        guard let URL = URL(string: URLString) else { return nil }
        return URL
    }

    public var coordinates: Coordinates? {
        return justoPersonResponse?.results?.first?.location?.coordinates
    }
}
