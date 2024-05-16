//
//  StationDetailsViewController.swift
//  Zadanie
//
//  Created by Maja Frąk on 16/05/2024.
//

import UIKit
import CoreLocation

final class StationDetailViewController: BaseViewController<StationDetailsView> {
    
    var viewModel: StationDetailsViewModelProtocol
    
    init(viewModel: StationDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentLocation = viewModel.currentLocation {
            let destinationCoordinate = viewModel.item.location
            customView.showRouteOnMap(pickupCoordinate: currentLocation.coordinate, destinationCoordinate: destinationCoordinate.coordinate)
        }
        customView.adapt(model: viewModel.item)
    }
}
