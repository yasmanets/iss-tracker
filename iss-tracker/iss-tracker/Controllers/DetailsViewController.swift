//
//  DetailsViewController.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 2/5/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var locationPrefixLabel: UILabel!
    @IBOutlet weak var locationLabel:       UILabel!
    @IBOutlet weak var flightLabel:         UILabel!
    @IBOutlet weak var secondsNumberLabel:  UILabel!
    @IBOutlet weak var secondsTextLabel:    UILabel!
    @IBOutlet weak var durationLabel:       UILabel!
    @IBOutlet weak var numberView:          UIView!
    @IBOutlet weak var numberLabel:         UILabel!
    
    var flight:     Flights?
    var location:   String?
    
    private var seconds: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar()
        self.setupLocationLabels()
        self.setupNumberView()
        self.setupFlightLabelText()
        self.setupSecondsLabelText()
        self.setupDurationLabelText()
        self.getRandomMessage()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.navigationController?.navigationBar.tintColor = .black
        self.title = R.string.localizable.detail_navigation_title()
    }
    
    private func setupLocationLabels() {
        self.locationPrefixLabel.text = R.string.localizable.you_are_in_label()
        self.locationLabel.text = self.location!
    }
    
    private func setupNumberView() {
        self.numberView.isHidden = true
    }
    
    private func setupFlightLabelText() {
        self.flightLabel.text = R.string.localizable.detail_information_text()
    }
    
    private func setupSecondsLabelText() {
        if let flight = flight, let timestamp = flight.risetime {
            let currentTimestamp = NSDate().timeIntervalSince1970
            let timestampDiff = Int(timestamp) - Int(currentTimestamp)
            self.secondsNumberLabel.text = "\(timestampDiff)"
            self.secondsTextLabel.text = R.string.localizable.flights_duration_seconds()
        }
    }
    
    private func setupDurationLabelText() {
        if let flight = flight, let duration = flight.duration {
            self.seconds = duration
            let (minutes, seconds) = DateProvider.secondsToMinutesSeconds(seconds: self.seconds)
            self.durationLabel.text = R.string.localizable.datails_flight_duration("\(minutes)", "\(seconds)")
        }
    }
    
    func getRandomMessage() {
        let url = ApiConstants.NUMBERS_BASE_URL + "\(self.seconds)?json"
        ApiProvider().commonRequest(entity: Numbers.self, url: url, method: .GET) { (numberData, error) in
            if let data = numberData, let text = data.text {
                DispatchQueue.main.async {
                    self.numberView.isHidden = false
                    self.numberLabel.text = String(format: R.string.localizable.detail_random_message_prefix("\(self.seconds)", text))
                }
            }
            else if error == true {
                print("Error")
            }
        }
    }
}
