//
//  RepoController.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/15/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
import Promises

class RepoController: UIViewController, NavigationHelper
, UITableViewDelegate, UITableViewDataSource
{
    
    public class var storyboardName: String { return "Repo" }
    public class var viewControllerID: String { return "RepoController" }
    
    var repos: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "repoCell")
        cell.textLabel?.text = repos[indexPath.row]
        return cell
    }
    
    public static func getInstance(passedInformation: [String]) -> UIViewController {
        guard let repoController = getInstance() as? RepoController else {
            return UIViewController()
        }
        repoController.repos = passedInformation
        return repoController
    }
}
