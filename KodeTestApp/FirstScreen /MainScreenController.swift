//
//  MainScreenController.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 06.02.2022.
//

import UIKit

protocol MainScreenView: AnyObject {
    
}



final class MainScreenController: UIViewController {

    var presenter: MainScreenPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }


}



extension MainScreenController: MainScreenView {
    
}
