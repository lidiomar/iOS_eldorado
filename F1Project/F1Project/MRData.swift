//
//  MrData.swift
//  F1Project
//
//  Created by T1aluno09 on 16/05/18.
//  Copyright © 2018 T1aluno09. All rights reserved.
//

import Foundation

 struct MRData: Codable {
    let xmlns: String
    let series:String
    let url:String
    let limit:String
    let offset:String
    let total:String
    let StandingsTable:StandingsTable
    
    /*
     enum CodingKeys : String, CodingKey {
        case xmlns = "xmlns"
        case series = "series"
        case url = "url"
        case limit = "limit"
        case offset = "offset"
        case total = "total"
        case standingsTable = "StandingsTable"
    }


    init(from decoder: Decoder) throws {
        
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        xmlns = try values.decode(String.self, forKey: .xmlns)
        series = try values.decode(String.self, forKey: .series)
        
        url = try values.decode(String.self, forKey: .url)
        limit = try values.decode(String.self, forKey: .limit)
        offset = try values.decode(String.self, forKey: .offset)
        total = try values.decode(String.self, forKey: .total)
        standingsTable = try values.decode(StandingsTable.self, forKey: .standingsTable)
    }
 */
}
