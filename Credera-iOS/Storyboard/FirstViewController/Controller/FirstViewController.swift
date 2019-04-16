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
        let navigationIntermediateScreen = NavigationIntermediateViewController.getInstance(passedInformation: passedAlongInformationBetweenVC, delegate: self)
        navigationController?.pushViewController(navigationIntermediateScreen, animated: true)
    }
    
    @IBOutlet weak var gitHubUsername: UITextField!
    
    @IBAction func getRepos(_ sender: UIButton) {
                let gitHubApi: GitHubApi = GitHubApi(caller: RequestCaller())
                gitHubApi.getPublicRepos(forUsername: gitHubUsername.text).then { values in
                    print(values.map {$0.name})
                    let repoScreen = RepoController.getInstance(passedInformation: values.map {$0.name})
                    self.navigationController?.pushViewController(repoScreen, animated: true)
                    }.catch {error in
                        print(error)
        }
    }
}

extension FirstViewController: NavigationCompletedProtocol {
    func showNavigationCompleted() {
        navigationStatusLabel.text = "Navigation to Final VC has been completed"
        navigationStatusLabel.textColor = UIColor.red
    }
}
