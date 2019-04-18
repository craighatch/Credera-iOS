//
//  CommitController.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit

class CommitController: UICollectionViewController, NavigationHelper {
    
    public class var storyboardName: String { return "CommitCollectionView" }
    public class var viewControllerID: String { return "CommitController" }
    
    private let reuseIdentifier = "commitCell"
    var gitHubGiphyDetails: [GitHubAndGiphyData]!
    private let itemsPerRow: CGFloat = 2
    
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return gitHubGiphyDetails.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return gitHubGiphyDetails[section].commmitGiphyDetails.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
        ) -> UICollectionViewCell {
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = .black
        // Configure the cell
        return cell
    }
    
    public static func getInstance(gitHubGiphyDetails: [GitHubAndGiphyData]) -> UIViewController {
        guard let commitController = getInstance() as? CommitController else {
            return UIViewController()
        }
        
        commitController.gitHubGiphyDetails = gitHubGiphyDetails
        
        return commitController
    }
    
}

extension CommitController : UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
