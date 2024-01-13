//
//  TableViewCell.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/11.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var sectionData: Section = Section()
    
    @IBOutlet weak var toDoListTextLbl: UILabel!
    @IBOutlet weak var toDoListDoneSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func toDoListDoneSwitch(_ sender: UISwitch) {
        print(sender.isOn)
        if sender.isOn {
            toDoListTextLbl.attributedText = toDoListTextLbl.text?.strikeThrough()
        } else {
            toDoListTextLbl.attributedText = toDoListTextLbl.text?.removestrikeThrough()
        }
    }
}

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func removestrikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}
