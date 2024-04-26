//
//  WeatherData.swift
//  WeatherDataFetching--Mini-Project-  WeatherDataFetching--Mini-Project-
//
//  Created by Mac on 26/04/24.
//

import Foundation
struct WeatherData : Codable
{
    let location : LocationData
    let current : CurrentData
}

