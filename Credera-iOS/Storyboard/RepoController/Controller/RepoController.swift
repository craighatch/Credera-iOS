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

class RepoController: UIViewController, NavigationHelper, UITableViewDelegate, UITableViewDataSource {
    
    public class var storyboardName: String { return "Repo" }
    public class var viewControllerID: String { return "RepoController" }
    
    var repos: [String] = []
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if let repoCell = cell as? RepoCellController {
            repoCell.label?.text = repos[indexPath.row]
            return repoCell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        let gitHubApi: GitHubApi = GitHubApi(caller: RequestCaller())
        gitHubApi.getCommits(witUserName: "craighatch", withRepoName: "funcation-programming-scala").then { values in
           
            let wordCount: [String: Int] = self.createWordCountMap(gitHubRepoResponses: values)
    
            print(wordCount)
            }.catch {error in
                print(error)
        }
    }
    
    public static func getInstance(passedInformation: [String]) -> UIViewController {
        guard let repoController = getInstance() as? RepoController else {
            return UIViewController()
        }
        repoController.repos = passedInformation
        return repoController
    }
    
    func createWordCountMap(gitHubRepoResponses: [GitHubRepoResponse]) -> [String: Int] {
        let words = gitHubRepoResponses.flatMap {$0.commit.message.split(separator: " ")}.map { String($0)}
        
        var wordCount: [String: Int] = [:]
        words.forEach { word in
            if let occurances = wordCount[word] {
                wordCount[word] = occurances + 1
            } else {
                wordCount[word] = 1
            }
        }
        return wordCount
    }
}
