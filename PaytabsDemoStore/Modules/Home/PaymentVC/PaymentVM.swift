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
    var profileID = "*profile id*"
    var serverKey = "*server key*"
    var clientKey = "*client key*"
    var currency = "AED"
    var countryCode = "AE"
    
    private var amount: Double = 0
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        getLocalConfiguration()
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
            currency: currency,
            amount: amount,
            merchantCountryCode: countryCode
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
    
    private func getLocalConfiguration() {
        UserDefaults.standard.register(defaults: [String: Any]())
        if let localClientKey = UserDefaults.standard.string(forKey: "client_key") {
            self.clientKey = localClientKey
        }
        if let localServerKey = UserDefaults.standard.string(forKey: "server_key") {
            self.serverKey = localServerKey
        }
        if let localProfileId = UserDefaults.standard.string(forKey: "profile_id") {
            self.profileID = localProfileId
        }
        
        if let localCurrency = UserDefaults.standard.string(forKey: "user_currency") {
            self.currency = localCurrency
        }
        
        if let localCountryCode = UserDefaults.standard.string(forKey: "user_country") {
            self.countryCode = localCountryCode
        }
    }
}



