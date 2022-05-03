//
//  FlightsViewController.swift
//  iss-tracker
//
//  Created by Yaser El Dabete Arribas on 29/4/22.
//

import UIKit
import CoreLocation

class FlightsViewController: UIViewController {

    @IBOutlet weak var flightsTableView: UITableView!
    
    private var flights: [Flights] = []
    
    private let flightCellIdentifier    = "flightCell"
    private let flightTableViewCell     = "FlightTableViewCell"
    private let flightHeaderIdentifier  = "flightHeader"
    private let flightTableViewHeader   = "FlightTableViewHeader"
    private let flightCellHeight        = 80.0
    private let flightHeaderHeight      = 60.0
    
    private var locationProvider    = LocationProvider()
    var currentLocation:    CLLocationCoordinate2D?
    
    private var address: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationTitle()
        self.setupFlightsTableView()
        self.locationProvider.delegate = self
        let isEnabled = self.locationProvider.enableLocation(accuracy: .nearest, viewController: self)
        if !isEnabled {
            self.locationProvider.disableLocation()
        }
    }
    
    private func setupNavigationTitle() {
        self.title = R.string.localizable.flight_list_navigation_title()
    }
    
    private func setupFlightsTableView() {
        self.flightsTableView.register(UINib(nibName: self.flightTableViewCell, bundle: nil), forCellReuseIdentifier: self.flightCellIdentifier)
        self.flightsTableView.register(UINib(nibName: self.flightTableViewHeader, bundle: nil), forCellReuseIdentifier: self.flightHeaderIdentifier)
        self.flightsTableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        self.flightsTableView.dataSource     = self
        self.flightsTableView.delegate       = self
    }
    
    private func getFlights() {
        if let latitude = self.currentLocation?.latitude, let longitude = self.currentLocation?.longitude {
            let url = "\(ApiConstants.ISS_BASE_URL)?lat=\(latitude)&lon=\(longitude)&alt=1650&n=\(ApiConstants.ISS_FLIGHTS_NUMBER)"
            ApiProvider().commonRequest(entity: ISSResponse.self, url: url, method: .GET) { (issData, error) in
                if let data = issData {
                    DispatchQueue.main.async {
                        self.flights = data.response!
                        self.flightsTableView.reloadData()
                    }
                }
                else if error == true {
                    print("Error")
                }
            }
        }
    }
    
    private func manageDate(splitedDate: [String]) -> String {
        let locale = NSLocale.current.languageCode
        if let languageCode = locale {
            switch languageCode {
            case "es": return "\(splitedDate[0].capitalizingFirstLetter()) \(splitedDate[1]) \(R.string.localizable.flights_date_of()) \(splitedDate[2]) \(R.string.localizable.flights_date_of()) \(splitedDate[3]) \(R.string.localizable.flights_date_at()) \(splitedDate[4])"
            case "en": return "\(splitedDate[0].capitalizingFirstLetter()) \(splitedDate[1]) \(splitedDate[2]) \(splitedDate[3]) \(R.string.localizable.flights_date_at()) \(splitedDate[4])"
            default: return "\(splitedDate[0].capitalizingFirstLetter()) \(splitedDate[1]) \(splitedDate[2]) \(splitedDate[3]) \(R.string.localizable.flights_date_at()) \(splitedDate[4])"
            }
        }
        return "\(splitedDate[0].capitalizingFirstLetter()) \(splitedDate[1]) \(splitedDate[2]) \(splitedDate[3]) \(R.string.localizable.flights_date_at()) \(splitedDate[4])"
    }
    
    private func manageTime(minutes: Int, seconds: Int) -> String {
        return R.string.localizable.flights_duration("\(minutes)", "\(seconds)")
    }
}

extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? self.flightHeaderHeight : self.flightCellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flights.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = self.flightsTableView.dequeueReusableCell(withIdentifier: self.flightHeaderIdentifier, for: indexPath) as! FlightTableViewHeader
            cell.locationLabel.text = self.address
            return cell
        }
        
        let cell = self.flightsTableView.dequeueReusableCell(withIdentifier: self.flightCellIdentifier, for: indexPath) as! FlightTableViewCell
        let splitedDate = DateProvider.timestampToSplitedDate(timestamp: Double(flights[indexPath.row].risetime!))
        let (minutes, seconds) = DateProvider.secondsToMinutesSeconds(seconds: flights[indexPath.row].duration!)
        cell.dateLabel.text = self.manageDate(splitedDate: splitedDate)
        cell.timeLabel.text = self.manageTime(minutes: minutes, seconds: seconds)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard.init(name: "Details", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        viewController.flight   = self.flights[indexPath.row]
        viewController.location = self.address
        self.show(viewController, sender: self)
    }
}

extension FlightsViewController: LocationProviderDelegate {
    func currentCoordinates(coordinates: CLLocationCoordinate2D?) {
        if let coordinates = coordinates {
            self.currentLocation = coordinates
        }
        else {
            self.currentLocation = CLLocationCoordinate2D(latitude: ApiConstants.DEFAULT_LATITUDE, longitude: ApiConstants.DEFAULT_LONGITUDE)
        }
        self.getFlights()
    }
    
    func reverseLocation(address: String) {
        self.address = address != "" ? address : ApiConstants.DEFAULT_ADDRESS
        self.flightsTableView.reloadData()
    }
}
