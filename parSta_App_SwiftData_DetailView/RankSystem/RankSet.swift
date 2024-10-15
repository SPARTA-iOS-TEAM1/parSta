//
//  RankSet.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import Foundation
import SwiftUI

let bronze: Rank = Rank(rankName: "Bronze", maxExp: 100000, color: Color.bronze)

let silver: Rank = Rank(rankName: "Silver", maxExp: 200000, color: Color.silver)

let gold: Rank = Rank(rankName: "Gold", maxExp: 300000, color: Color.gold)

let platinum: Rank = Rank(rankName: "Platinum", maxExp: 400000, color: Color.platinum)

let diamond: Rank = Rank(rankName: "Diamond", maxExp: 500000, color: Color.diamond)

let rankSet: [Rank] = [bronze, silver, gold, platinum, diamond]
