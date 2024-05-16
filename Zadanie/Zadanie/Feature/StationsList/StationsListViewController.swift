//
//  StationsListViewController.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

final class StationsListViewController: BaseViewController<StationsListView> {
    
    var viewModel: StationsListViewModelProtocol
    
    init(viewModel: StationsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.adapter.delegate = self
        customView.tableView.setAdapter(viewModel.adapter)
        viewModel.onAppear()
        viewModel.onMakeStations = { [weak self] in
            DispatchQueue.main.async {
                self?.customView.reload()
            }
        }
    }
}

// MARK: - StationsTableViewAdapterDelegate
extension StationsListViewController: StationsTableViewAdapterDelegate {
    func didSelect(at index: IndexPath) {
        viewModel.selectStation(for: index.row)
    }
}

