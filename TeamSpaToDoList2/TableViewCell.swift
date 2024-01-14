//
//  TableViewCell.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/11.
//

import UIKit

class TableViewCell: UITableViewCell {
        
    @IBOutlet weak var toDoListTextLbl: UILabel!
    @IBOutlet weak var toDoListDoneSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


