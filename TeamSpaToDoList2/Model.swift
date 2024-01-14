//
//  Model.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/10.
//

import Foundation
import UIKit

class Section {
    var sectionTitle: [String] = ["Work", "Life"]
    var sectionItem: [[String]] = [["Swift 공식 문서 읽기", "UIKit 공식 문서 읽기"], ["밥 먹기", "고양이 산책시키기", "강아지 산책시키기"]]
    var sectionItemDoneSwitchIsOn: [[Bool]] = [[false, false], [false, false, false]]
}
