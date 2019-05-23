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
    
    //    @IBOutlet weak var repoPicker: UIPickerView!
    
    let salutations = ["1", "2", "3", "4"]
    @IBOutlet weak var numberOfRepos: UITextField!
    
    @IBOutlet weak var gitHubUsername: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = AppHeaderView()
        let repoPicker = IntegerPicker(
            textField: numberOfRepos,
            frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/4),
            selectionHandler: { string in
                print("qwer: \(string)")
                print("repos: \(self.numberOfRepos.text)")
        })
        self.numberOfRepos.inputView = repoPicker
        
//        banner.translatesAutoresizingMaskIntoConstraints = false
//        banner.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
//        banner.widthAnchor.constraint(equalToConstant: 300)
//        banner.heightAnchor.constraint(equalToConstant: 50)

        
        //        let pickerView = UIPickerView()
        //        pickerView.delegate = self
        //        numberOfRepos.inputView = pickerView
    }
    
    @IBAction func navigationExampleButtonClicked(_ sender: Any) {
        let navigationIntermediateScreen = NavigationIntermediateViewController.getInstance(passedInformation: passedAlongInformationBetweenVC, delegate: self as NavigationCompletedProtocol)
        navigationController?.pushViewController(navigationIntermediateScreen, animated: true)
    }
    
    @IBAction func loadFromFile(_ sender: UIButton) {
        let fileService: FileService = FileService()
        let data = fileService.getData()!
        self.goToCommitPage(gitHubAndGiphyData: data)
    }
    
    @IBAction func getRepos(_ sender: UIButton) {
        
        if((gitHubUsername.text  ?? "").trimmingCharacters(in: .whitespaces).isEmpty) {
            let alert = UIAlertController(title: "Did you enter a username?", message: "You should probably do that", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "My bad", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            self.loadDataAndGoToCommitPage(gitHubUsername: gitHubUsername.text!)
        }
    }
    
    func loadDataAndGoToCommitPage(gitHubUsername: String) {
        let gitHubService: GitHubService = GitHubService()
        let giphyService: GitHubGiphyIntegrationService = GitHubGiphyIntegrationService()
        
        gitHubService.getRepos(forUsername: gitHubUsername, numberOfRepos: 1)
            .then { repos in
                gitHubService.populateCommonCommitWords(limitedTo: 2, withRepos: repos)
                    .then { reposAndCommits in
                        try giphyService.getImagesForAllReposAndCommits(withGitHubData: reposAndCommits)
                            .then { gitHubAndGiphyData in
                                let fileService: FileService = FileService()
                                fileService.saveToDevice(withData: gitHubAndGiphyData)
                                self.goToCommitPage(gitHubAndGiphyData: gitHubAndGiphyData)
                            }.catch { error in
                                print(error)
                                if let httpError = error as? HttpError {
                                    self.alertError(service: "Giphy", message: HttpError.getMessage(value: httpError))
                                } else {
                                    self.alertError(service: "Giphy", message: "unknown error")
                                }
                        }
                }
            }.catch { error in
                print(error)
                if let httpError = error as? HttpError {
                    self.alertError(service: "GitHub", message: HttpError.getMessage(value: httpError))
                } else {
                    self.alertError(service: "GitHub", message: "unknown error")
                }
        }
    }
    
    func alertError(service: String, message: String) {
        let alert = UIAlertController(title: "We're sorry!", message: "\(message) from \(service)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Well alright then", style: .default, handler: nil))
        self.present(alert, animated: true)
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

//extension FirstViewController: UIPickerViewDataSource, UIPickerViewDelegate{
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    // Sets number of columns in picker view
//    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    // Sets the number of rows in the picker view
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return salutations.count
//    }
//
//    // This function sets the text of the picker view to the content of the "salutations" array
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return salutations[row]
//    }
//
//    // When user selects an option, this function will set the text of the text field to reflect
//    // the selected option.
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        numberOfRepos.text = salutations[row]
//    }
//}
