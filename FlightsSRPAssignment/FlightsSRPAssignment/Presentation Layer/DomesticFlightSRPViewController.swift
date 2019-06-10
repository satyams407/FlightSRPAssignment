//
//  ViewController.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class DomesticFlightSRPViewController: UIViewController {
    let fetchFlightService = FetchFlightSearchService()
    var flightSRPDataSource = [DomesticFlightSRPCellModel]()
    var airlineMap: AirlineMap?
    var airportMap: AirportMap?
    var hasFetched = false
    
    typealias Sorting = AppConstants.SortCriteriaType
    
    // MARK: Views Outlets
    @IBOutlet weak var flightSRPResultTable: UITableView!
    @IBOutlet weak var flightOverViewHeaderView: UIView!
    @IBOutlet weak var sortTypeStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Sorting Criteria types buttons
    @IBOutlet weak var earlyFlightSortButton: UIButton!
    @IBOutlet weak var shortestFirstSortButton: UIButton!
    @IBOutlet weak var lateFlightSortButton: UIButton!
    @IBOutlet weak var cheapestFlightSortButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        screenSetup()
        fetchFlightsData()
    }
    
    private func screenSetup() {
        flightSRPResultTable.isHidden = true
        activityIndicator.startAnimating()
        flightSRPResultTable.rowHeight = UITableView.automaticDimension
        flightSRPResultTable.estimatedRowHeight = 150.0
        sortTypeStackView.isHidden = true
        
        earlyFlightSortButton.setTitle(Sorting.earlyDeparture.rawValue, for: .normal)
        lateFlightSortButton.setTitle(Sorting.lateDeparture.rawValue, for: .normal)
        shortestFirstSortButton.setTitle(Sorting.shortestFirst.rawValue, for: .normal)
        cheapestFlightSortButton.setTitle(Sorting.leastPrice.rawValue, for: .normal)
    }
    
    private func registerCell() {
        // cell identifier name same as nib name
        flightSRPResultTable.register(UINib(nibName: DomesticFlightSRPTableCell.identifier, bundle: nil), forCellReuseIdentifier: DomesticFlightSRPTableCell.identifier)
    }
    
    private func configureheaderView() {
        let triplabel = UILabel()
        triplabel.translatesAutoresizingMaskIntoConstraints = false
        flightOverViewHeaderView.addSubview(triplabel)
        triplabel.centerXAnchor.constraint(equalTo: flightOverViewHeaderView!.centerXAnchor, constant: 0).isActive = true
        triplabel.centerYAnchor.constraint(equalTo: flightOverViewHeaderView!.centerYAnchor, constant: 0).isActive = true
        triplabel.text = "\(airportMap?.del ?? "") - \(airportMap?.mum ?? "")"
        triplabel.textColor = .black
    }
    
    private func fetchFlightsData() {
        fetchFlightService.fetchFlightData(with: .fetchFlight, completionHandler: { [weak self] result in
            guard let sself = self else { return }
            switch result {
            case .failure(let error):
                sself.hasFetched = false
                Utility.showAlert(message: error.errorMessage, onController: sself)
            case .success(let responseModel):
                sself.airlineMap = responseModel.airlineMap
                sself.airportMap = responseModel.airportMap
                for flightDataObject in responseModel.flightsData {
                    let cellModel = DomesticFlightSRPCellModel.init(with: flightDataObject)
                    sself.flightSRPDataSource.append(cellModel)
                }
                sself.hasFetched = true
            }
            
            DispatchQueue.main.async {
                sself.flightSRPResultTable.reloadData()
                sself.sortTypeStackView.isHidden = sself.hasFetched ? false : true
                sself.configureheaderView()
                sself.flightSRPResultTable.isHidden = false
                sself.activityIndicator.isHidden = true
                sself.activityIndicator.stopAnimating()
            }
        })
    }
    
    // MARK: Sorting logic
    // Not taken criteria for Arrival time because it's not much important (As per Data metrics of all users base). Rather I have taken the Early Departure and Late Departure which make more sense
    @IBAction func sortButtonAction(_ sender: UIButton) {
        let sortingCriteria = sender.titleLabel?.text
        switch sortingCriteria {
        case Sorting.earlyDeparture.rawValue:
            flightSRPDataSource = flightSRPDataSource.sorted(by: {(model1, model2) -> Bool in
                let dept1 = Double(model1.takeoffTime) ?? 0.0
                let dept2 = Double(model2.takeoffTime) ?? 0.0
                return dept1 > dept2 ? false : true
            })
        case Sorting.lateDeparture.rawValue:
            flightSRPDataSource = flightSRPDataSource.sorted(by: {(model1, model2) -> Bool in
                let dept1 = Double(model1.takeoffTime) ?? 0.0
                let dept2 = Double(model2.takeoffTime) ?? 0.0
                return dept1 < dept2 ? false : true
            })
        case Sorting.leastPrice.rawValue:
            flightSRPDataSource = flightSRPDataSource.sorted(by: {(model1, model2) -> Bool in
                let price1 = Double(model1.price) ?? 0.0
                let price2 = Double(model2.price) ?? 0.0
                return price1 < price2 ? true : false
            })
        case Sorting.shortestFirst.rawValue:
            flightSRPDataSource = flightSRPDataSource.sorted(by: {(model1, model2) -> Bool in
                let duration1 = (Double(model1.landingTime) ?? 0.0) - (Double(model1.takeoffTime) ?? 0.0)
                let duration2 = (Double(model2.landingTime) ?? 0.0) - (Double(model2.takeoffTime) ?? 0.0)
                
                if duration1.isEqual(to: duration2) {
                    return (Double(model1.price) ?? 0.0) < (Double(model2.price) ?? 0.0)
                        ? true : false
                } else {
                    return duration1 < duration2 ? true : false
                }
            })
        default: print("")
        }
        changeUIAfterSorting(sortingCriteria)
        flightSRPResultTable.reloadData()
    }
    
    func changeUIAfterSorting(_ sortingCriteria: String?) {
        for view in sortTypeStackView.subviews {
            guard let button = view as? UIButton else { return }
            
            if button.titleLabel?.text?.isEqual(sortingCriteria) ?? false {
                button.backgroundColor = AppConstants.enableStateBgColor
                button.setTitleColor(AppConstants.enableTextColor, for: .normal)
            } else {
                button.backgroundColor = AppConstants.disableStateBgColor
                button.setTitleColor(AppConstants.disableTextColor, for: .normal)
            }
        }
    }
}

// MARK: TableView Datasource and Delegate Methods
extension DomesticFlightSRPViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flightSRPDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: DomesticFlightSRPTableCell.identifier, for: indexPath)
        if let cell = tableCell as? DomesticFlightSRPTableCell {
            let cellData = flightSRPDataSource[indexPath.row]
            cell.configureCell(with: cellData)
            cell.setAirlineName(from: self.airlineMap, airlineCode: cellData.airlineCode)
            cell.mapAirportCode(from: airportMap, cellData.originCode, cellData.destinationCode)
        }
        return tableCell
    }
}

// MARK: ScrollView Delegate Method
extension DomesticFlightSRPViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            //scrolling down
            animateButton(animated: true, hidden: true)
        } else {
            //scrolling up
            animateButton(animated: true, hidden: false)
        }
    }
    
    func animateButton(animated: Bool, hidden: Bool){
        let offset = hidden ? UIScreen.main.bounds.size.height : (UIScreen.main.bounds.size.height - view.safeAreaInsets.bottom - sortTypeStackView.frame.size.height)
        if offset == sortTypeStackView.frame.origin.y { return }
        let duration: TimeInterval = (animated ? 0.4 : 0.0)
        UIView.animate(withDuration: duration, animations: {
            self.sortTypeStackView.frame.origin.y = offset
        }, completion:nil)
    }
}
