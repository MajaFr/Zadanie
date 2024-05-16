//
//  StationCell.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

final class MainCell: UITableViewCell, Identifiable, Adaptable {
    
    struct Constants {
        static let baseMargin: CGFloat = 12.0
    }
    
    @UsesAutoLayout
    var stationDetailView = StationDetailView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16.0
        $0.clipsToBounds = true
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = AppColors.background
        addSubviews()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func adapt(model: DisplayableStation) {
        stationDetailView.titleLabel.text = model.name
        stationDetailView.firstSubTitleLabel.text = "\(model.distance) m"
        stationDetailView.placesAvailableValueLabel.text = String(model.placesAvailable)
        stationDetailView.bikesAvailableValueLabel.text = String(model.bikesAvailable)
        stationDetailView.secoundSubTitleLabel.text = model.address
    }
    
    private func addSubviews() {
        [stationDetailView].forEach {
            contentView.addSubview($0)
        }
    }
    
    private func setupSubviews() {
        viewSetup()
    }
    
    private func viewSetup() {
        NSLayoutConstraint.activate([
            stationDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.baseMargin),
            stationDetailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.baseMargin),
            stationDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.baseMargin),
            stationDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.baseMargin)
        ])
    }
}
