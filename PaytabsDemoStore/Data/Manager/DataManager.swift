//
//  DataManager.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Foundation

public class DataManager {
    
    public static func create() -> DataManager { DataManager() }
    
    
    public lazy var storeRepo: StoreRepo = {
        StoreRepo.create()
    }()
}
