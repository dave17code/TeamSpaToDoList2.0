//
//  ViewController.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/09.
//

import UIKit

class ViewController: UIViewController {
    
    var sectionData: Section = Section()
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var toDoListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoImageView.image = UIImage(named: "TeamSpaLogo")
        toDoListTableView.delegate = self
        toDoListTableView.dataSource = self
        toDoListTableView.sectionHeaderTopPadding = 25
    }
    
    @IBAction func addSection(_ sender: Any) {
        let title = "할일 챕터 추가"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "추가하기", style: .default) { [self] _ in
            
            if let text = alert.textFields?[0].text {
                sectionData.sectionTitle.append(text)
                print(sectionData.sectionItem.count)
            } else {}
            
            if let text = alert.textFields?[1].text {
                sectionData.sectionItem.append([text])
                print(sectionData.sectionItem.count)
            } else {}
            
            toDoListTableView.reloadData()
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField() { (txField) in
            txField.placeholder = "챕터 제목을 적어주세요"
        }
        alert.addTextField() { (txField) in
            txField.placeholder = "처음 할일을 적어주세요"
        }
        
        self.present(alert, animated: true)
    }
    
    @objc func addToDoListCell(_ sender: UIButton) {
        print("add")
        print(sender.tag)
        
        let title = "할일 추가"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "추가하기", style: .default) { [self] _ in
            
            if let text = alert.textFields?[0].text {
                sectionData.sectionItem[sender.tag].append(text)
            } else {}
            
            sectionData.sectionItemDoneSwitchIsOn[sender.tag].append(false)
            
            toDoListTableView.reloadData()
            print(sectionData.sectionItemDoneSwitchIsOn[sender.tag])
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField() { (txField) in
            txField.placeholder = "할일을 적어주세요"
        }
        
        self.present(alert, animated: true)
    }
    
    @objc func doneSwitchIsOn(_ sender: UISwitch) {
        let section = sender.tag / 1000
        let row = sender.tag % 1000
        
        print(section)
        print(row)
        print(sender.isOn)
        
        sectionData.sectionItemDoneSwitchIsOn[section][row] = sender.isOn
        toDoListTableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = sectionData.sectionTitle[section]
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.frame = CGRect(x: 15, y: 2.8, width: 200, height: 35)
        view.addSubview(label)
        
        let button = UIButton(type: .system)
        button.setTitle("할일 추가", for: .normal)
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.frame = CGRect(x: toDoListTableView.frame.width - 90, y: 11, width: 84, height: 20)
        button.tag = sectionData.sectionTitle.firstIndex(of: sectionData.sectionTitle[section])!
        button.addTarget(self, action: #selector(addToDoListCell), for: .touchUpInside)
        view.addSubview(button)

        return view
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(25)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData.sectionItem[section].count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completion = UIContextualAction(style: .normal, title: "삭제") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            sectionData.sectionItem[indexPath.section].remove(at: indexPath.row)
            sectionData.sectionItemDoneSwitchIsOn[indexPath.section].remove(at: indexPath.row)
            
            toDoListTableView.reloadData()
        }
        
        completion.backgroundColor = .systemPink
        
        let config = UISwipeActionsConfiguration(actions:[completion])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.toDoListTextLbl.text = sectionData.sectionItem[indexPath.section][indexPath.row]
        
        
        if sectionData.sectionItemDoneSwitchIsOn[indexPath.section][indexPath.row] == true {
            cell.toDoListTextLbl.attributedText = cell.toDoListTextLbl.text?.strikeThrough()
        } else {
            cell.toDoListTextLbl.attributedText = cell.toDoListTextLbl.text?.removestrikeThrough()
        }
        
        cell.selectionStyle = .none
        
        let doneSwitch = UISwitch()
        doneSwitch.isOn = sectionData.sectionItemDoneSwitchIsOn[indexPath.section][indexPath.row]
        doneSwitch.tag = indexPath.section * 1000 + indexPath.row
        doneSwitch.addTarget(self, action: #selector(doneSwitchIsOn(_:)), for: .valueChanged)
        cell.accessoryView = doneSwitch

        return cell
    }
}
