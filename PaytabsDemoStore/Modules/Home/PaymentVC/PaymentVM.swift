//
//  PaymentVM.swift
//  PaytabsDemoStore
//
//  Created by Ahmed Mostafa on 19/09/2021.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift
import PaymentSDK
import PassKit

class PaymentVM: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    var dataManager: DataManager
    var disposeBag: DisposeBag = .init()
    var refreshView = PublishSubject<Bool>()
    let profileID = "*profile id*"
    let serverKey = "*server key*"
    let clientKey = "*client key*"
    private var amount: Double = 0
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
}

extension PaymentVM {
    
    func setAmount(amount: Double) {
        self.amount = amount
    }
    
    var configuration: PaymentSDKConfiguration! {
        let theme = PaymentSDKTheme.default
        theme.logoImage = UIImage(named: "PayTabsLogo")
        
        let  billingDetails = PaymentSDKBillingDetails(name: "Jon Smith",
                                                       email: "smith@paytabs.com",
                                                       phone: "+201113655936",
                                                       addressLine: "Flat 1,Building 123, Road 2345",
                                                       city: "Dubai",
                                                       state: "Dubai",
                                                       countryCode: "AE",
                                                       zip: "")
        
        let shippingDetails = PaymentSDKShippingDetails(name: "Jon Smith",
                                                        email: "smith@paytabs.com",
                                                        phone: "+201113655936",
                                                        addressLine: "Flat 1,Building 123, Road 2345",
                                                        city: "Dubai",
                                                        state: "Dubai",
                                                        countryCode: "AE",
                                                        zip: "")
        
        
        return PaymentSDKConfiguration(
            profileID: profileID,
            serverKey: serverKey,
            clientKey: clientKey,
            currency: "USD",
            amount: amount,
            merchantCountryCode: "AE"
        )
        .cartDescription("Clothes")
        .cartID("1234")
        .showBillingInfo(true)
        .screenTitle("Pay with card")
        .showShippingInfo(true)
        .billingDetails(billingDetails)
        .shippingDetails(shippingDetails)
        .theme(theme)
    }
}



