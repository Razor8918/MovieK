//
//  MainScreenAssembly.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 06.02.2022.
//

final class MainScreenAssembly {
    func assembly() -> MainScreenController {
        let controller = MainScreenController()
        let presenter = MainScreenPresenterImp()
        
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}
