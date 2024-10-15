//
//  RankSystem.swift
//  parSta_App_SwiftData_DetailView
//
//  Created by 장상경 on 10/8/24.
//

import Foundation
import SwiftUI

struct Rank: Hashable {
    var rankName: String
    var maxExp: Int
    var color: Color
}

enum CurrentRank {
    case bronze, silver, gold, platinum, diamond
}
