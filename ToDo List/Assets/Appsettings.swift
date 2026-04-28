//
//  Appsettings.swift
//  ToDo List
//
//  Created by Diesperov Konstantin on 24.04.2026.
//

import Foundation

extension Bundle {
    var apiURL: String {
        return object(forInfoDictionaryKey: "APIUrl") as! String
    }
}
