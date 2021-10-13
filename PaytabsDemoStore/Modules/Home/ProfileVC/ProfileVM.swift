//
//  PaymentVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 23/09/2021.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileVM: ViewModel{
    
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let profileList = ["About us", "Contact us", "Previous orders"]
    let profileImages = [#imageLiteral(resourceName: "aboutUS"),#imageLiteral(resourceName: "ContactUS"),#imageLiteral(resourceName: "previousOrders")]

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}

extension ProfileVM {

}
