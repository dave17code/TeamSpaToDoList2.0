//
//  DeleteChapterModal.swift
//  TeamSpaToDoList2
//
//  Created by woonKim on 2024/01/13.
//

import UIKit

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
    
    private lazy var canvasBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var chapterTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DeleteChapterModalCell.self, forCellReuseIdentifier: DeleteChapterModalCell.identifier)
        return tableView
    }()
    
    private lazy var completionBtn: UIButton = {
        let completionBtn = UIButton()
        completionBtn.translatesAutoresizingMaskIntoConstraints = false
        completionBtn.setTitle("완료", for: .normal)
        completionBtn.setTitleColor(.white, for: .normal)
        completionBtn.layer.cornerRadius = 8
        completionBtn.backgroundColor = .systemGreen
        return completionBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(canvas)
        NSLayoutConstraint.activate([
            self.canvas.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.canvas.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.canvas.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.7),
            self.canvas.heightAnchor.constraint(equalToConstant: self.view.bounds.height * 0.35),
        ])
        self.view.backgroundColor = .clear
        
        canvas.addSubview(canvasBottomView)
        NSLayoutConstraint.activate([
            canvasBottomView.widthAnchor.constraint(equalTo: canvas.widthAnchor),
            canvasBottomView.heightAnchor.constraint(equalToConstant: 45),
            canvasBottomView.bottomAnchor.constraint(equalTo: canvas.bottomAnchor)
        ])
        
        canvasBottomView.addSubview(completionBtn)
        NSLayoutConstraint.activate([
            completionBtn.widthAnchor.constraint(equalToConstant: 50),
            completionBtn.heightAnchor.constraint(equalToConstant: 25),
            completionBtn.centerXAnchor.constraint(equalTo: canvasBottomView.centerXAnchor),
            completionBtn.centerYAnchor.constraint(equalTo: canvasBottomView.centerYAnchor)
        ])
        completionBtn.addTarget(self, action: #selector(completionBtnInCell(_:)), for: .touchUpInside)
        
        chapterTableView.delegate = self
        chapterTableView.dataSource = self
        chapterTableView.separatorInset = UIEdgeInsets(top: .zero, left: 0, bottom: .zero, right: 0)
        chapterTableView.allowsSelection = false
        
        canvas.addSubview(chapterTableView)
        NSLayoutConstraint.activate([
            chapterTableView.topAnchor.constraint(equalTo: canvas.topAnchor),
            chapterTableView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor),
            chapterTableView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor),
            chapterTableView.bottomAnchor.constraint(equalTo: completionBtn.topAnchor, constant: -20)
        ])
    }
    
    @objc func deleteBtnInCell(_ sender: UIButton) {
        print(sender.tag)
        print("deleteBtnClicked")
        
        sectionData.sectionTitle.remove(at: sender.tag)
        sectionData.sectionItem.remove(at: sender.tag)
        sectionData.sectionItemDoneSwitchIsOn.remove(at: sender.tag)
        
        chapterTableView.reloadData()
        
        print(sectionData.sectionTitle)
        print(sectionData.sectionItem)
        print(sectionData.sectionItemDoneSwitchIsOn)
    }
    
    @objc func completionBtnInCell(_ sender: UIButton) {
        let preVC = self.presentingViewController
        
        guard let vc = preVC as? ViewController else { return }
        vc.sectionData = self.sectionData
        vc.toDoListTableView.reloadData()
        vc.emptyToDoList.isHidden = false
        
        self.presentingViewController?.dismiss(animated: true)
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
        deleteBtn.tag = indexPath.section * 1000 + indexPath.row
        deleteBtn.addTarget(self, action: #selector(deleteBtnInCell(_:)), for: .touchUpInside)
        
        cell.label.text = sectionData.sectionTitle[indexPath.row]
        cell.accessoryView = deleteBtn
        cell.backgroundColor = .systemGray5

        return cell
    }
}
