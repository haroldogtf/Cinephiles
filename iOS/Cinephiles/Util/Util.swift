//
//  Util.swift
//  Cinephiles
//
//  Created by Haroldo Gondim on 20/07/18.
//

import PKHUD
import UIKit

class Util: NSObject {

    class func showAlert(_ viewController: UIViewController, title: String, message: String) {
        HUD.hide()
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        viewController.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: Constants.STRING_OK, style: UIAlertActionStyle.default, handler: nil))
    }

    class func showAlert(_ viewController: UIViewController, message: String) {
        showAlert(viewController, title: "", message: message)
    }

    class func checkError(_ viewController: UIViewController, error: Error?, f:(()->())) {
        if let _ = error {
            Util.showAlert(viewController, message: Constants.ERROR_SERVER_GENERAL_ERRROR)
            
        } else {
            f()
        }
    }

}
