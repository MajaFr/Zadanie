//
//  StationsTableViewAdapter.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

protocol StationsTableViewAdapterDelegate: AnyObject {
    func didSelect(at index: IndexPath)
}

typealias TableAdapterType = NSObject & UITableViewDataSource & UITableViewDelegate

class StationsTableViewAdapter: TableAdapterType {
    
    weak var delegate: StationsTableViewAdapterDelegate?
    
    var items: [DisplayableStation] = []
    
    public init(items: [DisplayableStation]) {
        self.items = items
        super.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let mainCell = tableView.dequeueReusableCell() as MainCell
        guard let model = items[safe: indexPath.row] else { return UITableViewCell () }
        mainCell.adapt(model: model)

        return mainCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelect(at: indexPath)
    }
}
