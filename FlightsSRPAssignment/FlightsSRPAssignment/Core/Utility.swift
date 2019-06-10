//
//  Utility.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class Utility {
    static func showAlert(title: String = StringConstants.emptyString, message: String, onController controller: UIViewController) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let dismissAction = UIAlertAction(title: StringConstants.okButtonTitle, style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(dismissAction)
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
