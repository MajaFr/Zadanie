//
//  StationDetailView.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

class StationDetailView: UIView {
    
    struct Constants {
        static let titleFontSize: CGFloat = 24.0
        static let subTitleFontSize: CGFloat = 12.0
        static let baseMargin: CGFloat = 12.0
        static let baseStackViewSpacing: CGFloat = 12.0
        static let smallStackViewSpacing: CGFloat = 4.0
        static let availableValueSize: CGFloat = 44.0
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Bold(size: Constants.titleFontSize).font
        $0.numberOfLines = 0
    }
    
    lazy var firstSubTitleLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Bold(size: Constants.subTitleFontSize).font
    }
    
    private lazy var separatorSubTitleLabel = UILabel().then {
        $0.font = AppFonts.Manrope_SemiBold(size: Constants.subTitleFontSize).font
        $0.text = "·"
    }
    
    lazy var secoundSubTitleLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Medium(size: Constants.subTitleFontSize).font
    }
    
    private lazy var bikesAvailableLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Medium(size: Constants.subTitleFontSize).font
        $0.text = "Bikes available"
    }
    
    private lazy var placesAvailableLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Medium(size: Constants.subTitleFontSize).font
        $0.text = "Places available"
    }
    
    lazy var bikesAvailableValueLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Bold(size: Constants.availableValueSize).font
        $0.textColor = AppColors.positiveGreen
    }
    
    lazy var placesAvailableValueLabel = UILabel().then {
        $0.font = AppFonts.Manrope_Bold(size: Constants.availableValueSize).font
    }
    
    private lazy var bikesAvailableImageView = UIImageView().then {
        $0.image = AppImages.bike
    }
    
    private lazy var placesAvailableImageView = UIImageView().then {
        $0.image = AppImages.lock
    }
    
    @UsesAutoLayout
    private var topStackView = UIStackView().then {
        $0.spacing = Constants.baseStackViewSpacing
        $0.axis = .vertical
    }
    
    @UsesAutoLayout
    private var availableStackView = UIStackView().then {
        $0.spacing = Constants.baseStackViewSpacing
        $0.distribution = .fillEqually
        $0.axis = .horizontal
    }
    
    @UsesAutoLayout
    private var bikesAvailableStackView = UIStackView().then {
        $0.spacing = Constants.smallStackViewSpacing
        $0.alignment = .center
        $0.axis = .vertical
    }
    @UsesAutoLayout
    private var placesAvailableStackView = UIStackView().then {
        $0.spacing = Constants.smallStackViewSpacing
        $0.alignment = .center
        $0.axis = .vertical
    }
    
    private lazy var subTitlesStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        [topStackView, availableStackView].forEach {
            addSubview($0)
        }
        
        [titleLabel, subTitlesStackView].forEach {
            topStackView.addArrangedSubview($0)
        }
        
        [firstSubTitleLabel, separatorSubTitleLabel, secoundSubTitleLabel].forEach {
            subTitlesStackView.addArrangedSubview($0)
        }
        
        [bikesAvailableStackView, placesAvailableStackView].forEach {
            availableStackView.addArrangedSubview($0)
        }
        
        [bikesAvailableImageView, bikesAvailableValueLabel, bikesAvailableLabel].forEach {
            bikesAvailableStackView.addArrangedSubview($0)
        }
        
        [placesAvailableImageView, placesAvailableValueLabel, placesAvailableLabel].forEach {
            placesAvailableStackView.addArrangedSubview($0)
        }
    }
    
    private func buildUI() {
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.baseMargin),
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.baseMargin),
            topStackView.bottomAnchor.constraint(equalTo: availableStackView.topAnchor, constant: -Constants.baseMargin*2),
            
            availableStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.baseMargin),
            availableStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.baseMargin),
            availableStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.baseMargin),
            
            bikesAvailableImageView.widthAnchor.constraint(equalToConstant: 24),
            bikesAvailableImageView.heightAnchor.constraint(equalToConstant: 24),
            
            placesAvailableImageView.widthAnchor.constraint(equalToConstant: 24),
            placesAvailableImageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}


