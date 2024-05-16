//
//  StationsListViewModelProtocol.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import Foundation

protocol StationsListViewModelProtocol {
    var adapter: StationsTableViewAdapter { get }
    var onMakeStations: (() -> ())? { get set }
    
    func onAppear()
    func selectStation(for index: Int)
}
