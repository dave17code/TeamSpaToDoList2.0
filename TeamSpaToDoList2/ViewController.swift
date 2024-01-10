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
//        toDoListTableView.dataSource = self
    }

    
}

extension ViewController: UITableViewDelegate {
    
}



extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionData.section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
