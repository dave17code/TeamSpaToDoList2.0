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
            txField.placeholder = "할일 챕터를 적어주세요"
        }
        alert.addTextField() { (txField) in
            txField.placeholder = "처음 할일을 적어주세요"
        }
        
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionData.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .systemBlue
        
        let button = UIButton(type: .system)
        button.setTitle("할일 추가", for: .normal)
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.frame = CGRect(x: toDoListTableView.frame.width - 93.5, y: 0, width: 84, height: 26)
    
        view.addSubview(button)

        return view
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(35)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData.sectionItem[section].count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completion = UIContextualAction(style: .normal, title: "삭제") { [self] (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            
            sectionData.sectionItem[indexPath.section].remove(at: indexPath.row)
            toDoListTableView.reloadData()
        }
        
        completion.backgroundColor = .systemPink
        
        let config = UISwipeActionsConfiguration(actions:[completion])
        config.performsFirstActionWithFullSwipe = false
        
        return config
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        let group = sectionData.sectionItem[indexPath.section]
//        let cellText = group[indexPath.row]
//        cell.textLabel?.text = cellText
        
        cell.textLabel?.text = sectionData.sectionItem[indexPath.section][indexPath.row]

        return cell
    }
}
