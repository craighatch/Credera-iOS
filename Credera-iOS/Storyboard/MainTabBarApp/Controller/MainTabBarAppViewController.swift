//
//  MainTabBarAppViewController.swift
//  Credera-iOS
//
//  Created by Zachary Slayter on 1/2/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarAppViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var viewControllerArray: [UIViewController] = []
        
        // Initialize the Tab Bar controllers via their respective storyboards
        // The TabBarItems with titles & icons are in each Storyboard's first scene
        
        if let firstVC: UIViewController = UIStoryboard(name: "First", bundle: Bundle.main).instantiateInitialViewController() {
            viewControllerArray.append(firstVC)
        }
    
        
        if let commitVC: UIViewController = UIStoryboard(name: "CommitCollectionView", bundle: Bundle.main).instantiateInitialViewController() {
            
            let fileService: FileService = FileService()
            let gitHubGiphyDetails = fileService.getData()!
            
            if !(gitHubGiphyDetails.isEmpty) {
                let commit = CommitController.getInstance(gitHubGiphyDetails: gitHubGiphyDetails)
                commitVC.addChild(commit)
                viewControllerArray.append(commitVC)
            }
        }
        
        self.setViewControllers(viewControllerArray, animated: false)
        
        // Default to the Home Tab
        self.setSelectedTab(Constants.TabBarScreens.first)
        
    }
    
    func setSelectedTab(_ tabBarScreen: Constants.TabBarScreens) {
        self.selectedIndex = tabBarScreen.rawValue
    }
    
}
