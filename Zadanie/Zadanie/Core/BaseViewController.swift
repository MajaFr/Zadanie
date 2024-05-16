//
//  BaseViewController.swift
//  Zadanie
//
//  Created by Maja Frąk on 14/05/2024.
//

import UIKit

public class BaseViewController<BaseView: UIView>: UIViewController {
    var customView: BaseView {
        return view as! BaseView
    }
    public override func loadView() {
        view = BaseView()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
