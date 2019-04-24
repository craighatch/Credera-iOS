//
//  FirstViewController.swift
//  Credera-iOS
//
//  Created by Zachary Slayter on 1/2/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit
import Promises

public protocol NavigationCompletedProtocol: class {
    func showNavigationCompleted()
}

class FirstViewController: UIViewController {
    
    let passedAlongInformationBetweenVC: String = "This is an example of passing information from one VC to another"
    
    @IBOutlet weak var navigationStatusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = AppHeaderView()
        
        // TODO: These can be set up through dependency injection instead...
        let userApi: UserApi = UserApiImpl(caller: RequestCaller())
        let userService: UserService = UserServiceImpl(userApi: userApi)
        
        userService.getAllUsers().then { (users) in
            print(users)
            }.catch { (error) in
                // Handle error...
        }
    }
    
    @IBAction func navigationExampleButtonClicked(_ sender: Any) {
        let navigationIntermediateScreen = NavigationIntermediateViewController.getInstance(passedInformation: passedAlongInformationBetweenVC, delegate: self as NavigationCompletedProtocol)
        navigationController?.pushViewController(navigationIntermediateScreen, animated: true)
    }
    
    @IBOutlet weak var gitHubUsername: UITextField!
    
    @IBAction func loadFromFile(_ sender: UIButton) {
        let fileService: FileService = FileService()
        let data = fileService.getData()!
        self.goToCommitPage(gitHubAndGiphyData: data)
    }
 
    @IBAction func getRepos(_ sender: UIButton) {
        let userName: String = "craighatch"
        let gitHubService: GitHubService = GitHubService()
        let giphyService: GitHubGiphyIntegrationService = GitHubGiphyIntegrationService()
        
        gitHubService.getRepos(forUsername: userName, numberOfRepos: 1)
            .then { repos in
                gitHubService.populateCommonCommitWords(limitedTo: 2, withRepos: repos)
                    .then { reposAndCommits in
                        giphyService.getImagesForAllReposAndCommits(withGitHubData: reposAndCommits)
                            .then { gitHubAndGiphyData in
                                let fileService: FileService = FileService()
                                fileService.saveToDevice(withData: gitHubAndGiphyData)
                                self.goToCommitPage(gitHubAndGiphyData: gitHubAndGiphyData)
                            }.catch { error in
                                print(error)
//                                let gitGphyData =  reposAndCommits.map { GitHubAndGiphyData(withUserName: $0.userName, withRepoName: $0.repoName, withCommmitGiphyDetails: $0.commits.map { CommitGiphyDetails(commit: $0, imageLink: "https://www.keycdn.com/img/support/429-too-many-requests-lg@2x.webp") }) }
//                                self.goToCommitPage(gitHubAndGiphyData: gitGphyData)
                        }
                    }.catch { error in
                        print(error)
                }
            }.catch { error in
                print(error)
        }
    }
    
    func goToCommitPage(gitHubAndGiphyData: [GitHubAndGiphyData]) {
        let commitControllerScreen = CommitController.getInstance(gitHubGiphyDetails: gitHubAndGiphyData)
        self.navigationController?.pushViewController(commitControllerScreen, animated: true)
    }
    
}

extension FirstViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {
        navigationStatusLabel.text = "Navigation to Final VC has been completed"
        navigationStatusLabel.textColor = UIColor.red
    }
}
