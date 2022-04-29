//
//  SplashViewController.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 29/4/22.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTitleLabel()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.navigateToFlightsList()
        }
    }
    

    private func setupTitleLabel() {
        self.titleLabel.text = R.string.localizable.app_name()
    }
    
    private func navigateToFlightsList() {
        self.performSegue(withIdentifier: R.segue.splashViewController.flightsSegue, sender: nil)
    }
}
