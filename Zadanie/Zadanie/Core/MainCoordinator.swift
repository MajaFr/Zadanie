//
//  MainCoordinator.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit
import CoreLocation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var serviceProvider: ServiceProviderProtocol { get }
    
    func goToMainView()
}

class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    let serviceProvider: ServiceProviderProtocol
    
    init(navigationController: UINavigationController, serviceProvider: ServiceProviderProtocol) {
        self.navigationController = navigationController
        self.serviceProvider = serviceProvider
    }
    
    func goToMainView() {
        let viewModel = StationsListViewModel(serviceProvider: serviceProvider)
        viewModel.onStationSelected = { [weak self] item, currentLocation in
            self?.goToDetail(with: item, currentLocation: currentLocation)
        }
        let viewController = StationsListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
    
    private func goToDetail(with item: DisplayableStation, currentLocation: CLLocation?) {
        let viewModel = StationDetailsViewModel(item: item, currentLocation: currentLocation)
        let viewController = StationDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
