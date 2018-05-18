//
//  DriverStandings.swift
//  F1Project
//
//  Created by T1aluno09 on 16/05/18.
//  Copyright © 2018 T1aluno09. All rights reserved.
//

struct StandingsList: Codable {
    let season: String?
    let round:String?
    let DriverStandings: [DriverStanding]?
}
