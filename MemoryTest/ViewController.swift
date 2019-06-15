//
//  ViewController.swift
//  MemoryTest
//
//  Created by Hanyu on 2019/6/12.
//  Copyright © 2019 Hanyu. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let helloTesting = Notification.Name(rawValue: "helloTesting")
}

class ViewController: UIViewController {

    let tableView = UITableView(frame: .zero)
    let data = ["first row", "second row"]
    
    deinit {
        print("\(#file): \(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(TableViewCell.classForCoder(), forCellReuseIdentifier: "TableViewCell")
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//傳入 viewController 就不會 leak 了
		func addObserver(viewController: ViewController) {
            var observer: NSObjectProtocol? = nil
            observer = NotificationCenter.default.addObserver(forName: Notification.Name.helloTesting, object: nil, queue: nil, using: { [weak viewController] (_) in
                guard let obs = observer, let viewController = viewController else { return }
                NotificationCenter.default.removeObserver(obs)
				observer = nil
				print(viewController.data)
            })
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.textLabel?.text = self.data[indexPath.row]
        cell.didSelected = { [weak self] in
            guard let self = self else { return nil }
			addObserver(viewController: self)
            return self.data[indexPath.row]
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
}
