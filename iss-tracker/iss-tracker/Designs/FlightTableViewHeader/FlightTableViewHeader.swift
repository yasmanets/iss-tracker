//
//  FlightTableViewHeader.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 30/4/22.
//

import UIKit

class FlightTableViewHeader: UITableViewCell {

    @IBOutlet weak var informationLabel:    UILabel!
    @IBOutlet weak var locationLabel:       UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupInformationLabelText()
    }
    
    private func setupInformationLabelText() {
        self.informationLabel.text = R.string.localizable.flight_header_label()
    }
    
}
