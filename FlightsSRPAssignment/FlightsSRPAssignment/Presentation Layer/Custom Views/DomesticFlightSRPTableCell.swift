//
//  DomesticFlightSRPTableCell.swift
//  FlightsSRPAssignment
//
//  Created by Satyam Sehgal on 08/06/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

class DomesticFlightSRPTableCell: UITableViewCell {

    @IBOutlet weak var airlineLogoImageView: UIImageView!

    // MARK: Labels
    @IBOutlet weak var airlineNameLabel: UILabel!
    @IBOutlet weak var classType: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var arrivalTimeLabel: UILabel!
    @IBOutlet weak var departureIATACodeLabel: UILabel!
    @IBOutlet weak var arrivalIATACodeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var detailView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        screenSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func screenSetup() {
        airlineLogoImageView.layer.cornerRadius = airlineLogoImageView.frame.width/2
        if #available(iOS 11.0, *) {
            headerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            headerView.layer.cornerRadius = 6.0
            
            detailView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            detailView.layer.cornerRadius = 6.0
        }
    }
    
    func configureCell(with cellModel: DomesticFlightSRPCellModel) {
        arrivalIATACodeLabel.text = cellModel.destinationCode
        departureIATACodeLabel.text = cellModel.originCode
        classType.text = cellModel.classType
        airlineNameLabel.text = cellModel.airlineCode
        priceLabel.text = "₹\(cellModel.price)"
        airlineLogoImageView.image = setAirlineLogo(from: cellModel.airlineCode)
        arrivalTimeLabel.text = DomesticFlightSRPCellModel.formatDate(from: cellModel.landingTime)
        departureTimeLabel.text = DomesticFlightSRPCellModel.formatDate(from: cellModel.takeoffTime)
        durationLabel.text = DomesticFlightSRPCellModel.getTripDuration(from: cellModel.takeoffTime, arrivalTime: cellModel.landingTime)
    }
    
    func setAirlineLogo(from airlineCode: String) -> UIImage? {
        switch airlineCode {
        case "SJ": return AirlineLogoManager.spiceJet
        case "AI": return AirlineLogoManager.airIndia
        case "IN": return AirlineLogoManager.indigo
        case "JA": return AirlineLogoManager.jetAirways
        case "G8": return AirlineLogoManager.goAir
        default: return nil
        }
    }
    
    func setAirlineName(from airlineMap: AirlineMap?, airlineCode: String) {
        guard let airlineMap = airlineMap else { return }
        var airlineName = StringConstants.emptyString
        switch airlineCode {
        case "SJ": airlineName = airlineMap.sj
        case "AI": airlineName = airlineMap.ai
        case "IN": airlineName = airlineMap.indigo
        case "JA": airlineName = airlineMap.ja
        case "G8": airlineName = airlineMap.g8
        default: airlineName = ""
        }
        airlineNameLabel.text = airlineName
    }
    
    func mapAirportCode(from airportMap: AirportMap?, _ originCode: String, _ destinationCode: String) {
        guard let airportMap = airportMap else { return }
        if originCode.caseInsensitiveCompare(airportMap.del) == .orderedSame {
            departureIATACodeLabel.text = airportMap.del
        }
        if destinationCode.caseInsensitiveCompare(airportMap.mum) == .orderedSame {
            arrivalIATACodeLabel.text = airportMap.mum
        }
    }
    
    static var identifier: String {
        return String.init(describing: self)
    }
}

