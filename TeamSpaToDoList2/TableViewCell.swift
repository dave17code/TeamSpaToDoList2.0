//
//  TableViewCell.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/11.
//

import UIKit

protocol ButtonTappedDelegate {
    func cellButtonTapped()
}


class TableViewCell: UITableViewCell {
    
    weak var delegate: ButtonTappedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
