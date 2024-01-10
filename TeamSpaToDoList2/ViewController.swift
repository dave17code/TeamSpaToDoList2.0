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
        let title = "섹션 추가"
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .default)
        let ok = UIAlertAction(title: "추가하기", style: .default) { [self] _ in
            
            if let text = alert.textFields?[0].text {
                sectionData.sectionTitle.append(text)

                toDoListTableView.reloadData()
            } else {}
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField() { (txField) in
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

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(35)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData.sectionItem[section].count
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
