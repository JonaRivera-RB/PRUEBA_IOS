//
//  PersonInfoDependencyProvider.swift
//  JUSTO
//
//  Created by Jonathan Misael Rivera on 25/09/22.
//

import Foundation
import UIKit

struct PersonInfoDependencyProvider {

    static var personInformation: PersonInformation {
        return PersonInformationUseCase()
    }

    static var viewModel: PersonInformationViewModel {
        return PersonInformationViewModel(personInformationUseCase: personInformation)
    }

    static var viewController: PersonInfoViewController {
        guard let vc = UIViewController.instatiate(storyboardName: "Main",
                                                   viewControllerIdentifier: "PersonInfoViewController") as? PersonInfoViewController else { fatalError() }
        vc.viewModel = self.viewModel

        return vc
    }
}
