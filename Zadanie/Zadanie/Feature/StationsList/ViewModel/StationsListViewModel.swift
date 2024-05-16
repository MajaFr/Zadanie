//
//  StationsListViewModel.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation
import CoreLocation

class StationsListViewModel: NSObject, StationsListViewModelProtocol {
    
    var onMakeStations: (() -> ())?
    var onStationSelected: ((DisplayableStation, CLLocation?) -> ())?
    
    lazy var adapter: StationsTableViewAdapter = {
        return StationsTableViewAdapter(items: [])
    }()
    
    private let stationsService: StationService
    private let locationManager: CLLocationManager
    
    private var statuses: [StationsStatus] = []
    private var infos: [StationInfo] = []
    private var currentLocation: CLLocation?
    
    init(serviceProvider: ServiceProviderProtocol) {
        self.stationsService = serviceProvider.stationsService
        self.locationManager = CLLocationManager()
    }
    
    func onAppear() {
        #if DEBUG
        currentLocation = .init(latitude: 54.406821, longitude: 18.591162)
        #else
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        #endif
        let group = DispatchGroup()
        group.enter() // for details
        group.enter() // for info
        
        fetchStationsDetails { _ in
            group.leave()
        }
        
        fetchStationsInfo { _ in
            group.leave()
        }
        
        group.notify(queue: .global()) { [weak self] in
            self?.makeDisplayableStations()
        }
    }
    
    private func fetchStationsInfo(completion: @escaping ((Error?) -> ())) {
        stationsService.getStationsInfo { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.infos = model.data.stations
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    private func fetchStationsDetails(completion: @escaping ((Error?) -> ())) {
        stationsService.getStationsStatus { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.statuses = model.data.stations
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    private func makeDisplayableStations() {
        guard let currentLocation else { return }
        adapter.items = infos.map { info in
            let status = statuses.first(where: { $0.stationId == info.stationId })
            let distance = CLLocation(latitude: info.lat, longitude: info.lon).distance(from: currentLocation).rounded()
            let numBikesAvailable = status?.numBikesAvailable ?? 0
            let numDocksAvailable = status?.numDocksAvailable ?? 0
            return DisplayableStation(
                name: info.name,
                distance: distance,
                address: info.address,
                bikesAvailable: numBikesAvailable,
                placesAvailable: numDocksAvailable,
                lat: info.lat,
                long: info.lon
            )
        }.sorted(by: { $0.distance < $1.distance })
        
        onMakeStations?()
    }

    func selectStation(for index: Int) {
        guard let item = adapter.items[safe: index] else { return }
        onStationSelected?(item, currentLocation)
    }
}

extension StationsListViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
        makeDisplayableStations()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Błąd pobierania lokalizacji: \(error.localizedDescription)")
    }
}
