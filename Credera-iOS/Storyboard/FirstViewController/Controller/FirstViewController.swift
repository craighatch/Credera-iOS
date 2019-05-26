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
    
    let salutations = ["1", "2", "3", "4"]
    @IBOutlet weak var numberOfRepos: UITextField!
    
    @IBOutlet weak var gitHubUsername: UITextField!
    
    @IBOutlet weak var wordsPerRepo: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = AppHeaderView()
        let repoPicker = IntegerPicker(
            textField: numberOfRepos,
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/4),
            selectionHandler: { _ in
                self.view.endEditing(true)
        })
        
        let wordPicker = IntegerPicker(
            textField: wordsPerRepo,
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/4),
            selectionHandler: { _ in
                self.view.endEditing(true)
                
        })
        self.numberOfRepos.inputView = repoPicker
        self.wordsPerRepo.inputView = wordPicker
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //close UIPicker when select outside
        self.view.endEditing(true)
    }
    
    @IBAction func getRepos(_ sender: UIButton) {
        
        guard let repos: Int = Int(numberOfRepos.text!) else {
            alertMissingField(title: "Did you enter \"Number Of Repos\"?")
            return
        }
        
        guard let commitWords: Int = Int(wordsPerRepo.text!) else {
            alertMissingField(title: "Did you enter \"Words Per Repo\"?")
            return
        }
        
        if (gitHubUsername.text  ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            alertMissingField(title: "Did you enter a username?")
        } else {
            self.loadDataAndGoToCommitPage(gitHubUsername: gitHubUsername.text!,
                                           numberOfCommitWords: commitWords,
                                           numberOfRepos: repos)
        }
    }
    
    func loadDataAndGoToCommitPage(gitHubUsername: String, numberOfCommitWords: Int, numberOfRepos: Int) {
        let giphyService: GitHubGiphyIntegrationService = GitHubGiphyIntegrationService()
        
        giphyService.getGiphyImageForMostCommonCommitWords(forUserName: gitHubUsername, numberOfRepos: numberOfRepos, numberofWords: numberOfCommitWords)
            .then { gitHubAndGiphyData in
                let fileService: FileService = FileService()
                fileService.saveToDevice(withData: gitHubAndGiphyData)
                self.goToCommitPage(gitHubAndGiphyData: gitHubAndGiphyData)
            }.catch { error in
                switch error {
                case is MissingApiKeyError:
                    self.alertError(errorMessage: "Giphy needs an API key. Ask Craig for his.")
                default:
                    self.alertError(errorMessage: error.localizedDescription)
                }
        }
    }
    
    func alertError(errorMessage: String) {
        let alert = UIAlertController(title: "We're sorry!", message: "\(errorMessage)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Well alright then", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func alertMissingField(title: String) {
        let alert = UIAlertController(title: title, message: "You should probably do that", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "My bad", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func goToCommitPage(gitHubAndGiphyData: [GitHubAndGiphyData]) {
        let commitControllerScreen = CommitController.getInstance(gitHubGiphyDetails: gitHubAndGiphyData)
        self.navigationController?.pushViewController(commitControllerScreen, animated: true)
    }
    
}
