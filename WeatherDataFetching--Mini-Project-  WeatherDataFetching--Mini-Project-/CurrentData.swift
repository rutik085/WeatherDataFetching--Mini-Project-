//
//  CurrentData.swift
//  WeatherDataFetching--Mini-Project-  WeatherDataFetching--Mini-Project-
//
//  Created by Mac on 26/04/24.
//

import Foundation
struct CurrentData: Codable
{
    let last_updated : String
    let temp_c : Float
    let wind_kph : Float
    let humidity : Int
}
