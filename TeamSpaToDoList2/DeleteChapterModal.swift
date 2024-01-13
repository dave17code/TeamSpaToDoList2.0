//
//  DeleteChapterModal.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/13.
//

import UIKit

public protocol PopUpModalDelegate: AnyObject {
}

class DeleteChapterModal: UIViewController {
    
    var sectionData: Section = Section()
    
    private lazy var canvas: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var chapterTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DeleteChapterModalCell.self, forCellReuseIdentifier: DeleteChapterModalCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(canvas)
        NSLayoutConstraint.activate([
            self.canvas.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.canvas.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.canvas.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.7),
            self.canvas.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.45),
        ])
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        
        chapterTableView.delegate = self
        chapterTableView.dataSource = self
        chapterTableView.separatorInset = UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0)
        chapterTableView.allowsSelection = false
        canvas.addSubview(chapterTableView)
        NSLayoutConstraint.activate([
            chapterTableView.topAnchor.constraint(equalTo: canvas.topAnchor),
            chapterTableView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            chapterTableView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            chapterTableView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)
        ])
    }
    
    @objc func deleteBtnInCell(_ sender: UIButton) {
        print(sender.tag)
        print("deleteBtnClicked")
    }
}

extension DeleteChapterModal: UITableViewDelegate {
    
}

extension DeleteChapterModal: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DeleteChapterModalCell = tableView.dequeueReusableCell(withIdentifier: DeleteChapterModalCell.identifier, for: indexPath) as! DeleteChapterModalCell
        
        let deleteBtn = UIButton(type: .roundedRect)
        deleteBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 25)
        deleteBtn.setTitle("삭제", for: .normal)
        deleteBtn.setTitleColor(.white, for: .normal)
        deleteBtn.layer.cornerRadius = 8
        deleteBtn.backgroundColor = .systemPink
        deleteBtn.tag = indexPath.row
        deleteBtn.addTarget(self, action: #selector(deleteBtnInCell(_:)), for: .touchUpInside)
        
        cell.label.text = sectionData.sectionTitle[indexPath.row]
        cell.accessoryView = deleteBtn

        return cell
    }
}
