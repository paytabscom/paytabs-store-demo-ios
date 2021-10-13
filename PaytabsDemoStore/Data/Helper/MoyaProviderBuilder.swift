//
//  MoyaProviderBuilder.swift
//  PaytabsDemoStore
//
//  Created by PayTabs on 02/09/2021.
//

import Moya
import SwiftyJSON

class MoyaProviderBuilder {
    
    static func makeProvider<T: TargetType> () -> MoyaProvider<T> {
        var config = NetworkLoggerPlugin.Configuration()
        //Log option
        var logOptions = NetworkLoggerPlugin.Configuration.LogOptions()
        logOptions.insert(.verbose)
        config.logOptions = logOptions
        //Formatter
        config.formatter = NetworkLoggerPlugin.Configuration.Formatter(responseData: jsonResponseDataFormatter)
        let logger = NetworkLoggerPlugin(configuration: config)
        return MoyaProvider<T>(plugins: [logger])
    }
}

private func jsonResponseDataFormatter(_ data: Data) -> String {
    return JSON(data).string ?? String(decoding: data, as: UTF8.self)
}
