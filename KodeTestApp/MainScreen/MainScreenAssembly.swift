//
//  MainScreenAssembly.swift
//  KodeTestApp
//
//  Created by Георгий Попандопуло on 06.02.2022.
//

final class MainScreenAssembly {
    func assembly() -> MainScreenViewController {
        let controller = MainScreenViewController()
        let homeGateway = HomeGatewayImp()
        let presenter = MainScreenPresenterImp(homeGateway: homeGateway)
        
        controller.presenter = presenter
        presenter.view = controller
        
        return controller
    }
}
