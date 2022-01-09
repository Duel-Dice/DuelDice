//
//  RankViewController.swift
//  DuelDice
//
//  Created by Euimin Chung on 2021/12/31.
//

import UIKit

class RankViewController: UIViewController {

    

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = [
        User(userId: "suhshin", diceAmount: 256),
        User(userId: "ycha", diceAmount: 128),
        User(userId: "echung", diceAmount: 128),
        User(userId: "kyuhkim", diceAmount: 512)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: "RankCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    

    }

extension RankViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! RankCell
        users.sort(by: {$0.diceAmount ?? 0 > $1.diceAmount ?? 0})
        cell.userIdLabel.text = users[indexPath.row].userId
        cell.diceAmountLabel.text = "\(users[indexPath.row].diceAmount ?? 0)"
        cell.rankLabel.text = "\(indexPath.row+1)"

        return cell
    }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print(indexPath.row)
    }
}

