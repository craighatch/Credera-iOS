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
    var gitHubGiphyDetails: [GitHubAndGiphyData] = []
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
        
        if let repoCell = cell as? GiphyImage {
            let commitWord = gitHubGiphyDetails[indexPath.section].commmitGiphyDetails[indexPath.row].commit.word
            let commitOccurrnaces = gitHubGiphyDetails[indexPath.section].commmitGiphyDetails[indexPath.row].commit.occurrances
            
            repoCell.caption.text = "\(commitWord): \(commitOccurrnaces)"
            repoCell.imageView.image = UIImage(data: gitHubGiphyDetails[indexPath.section].commmitGiphyDetails[indexPath.row].imageData)
            return repoCell
        } else {
            return UICollectionViewCell()
        }
    }
    
    public static func getInstance(gitHubGiphyDetails: [GitHubAndGiphyData]) -> UIViewController {
        guard let commitController = getInstance() as? CommitController else {
            return UIViewController()
        }
        
        commitController.gitHubGiphyDetails = gitHubGiphyDetails
        
        return commitController
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderLabel.text = "Repo:  \(gitHubGiphyDetails[indexPath.section].repoName)"
            sectionHeader.sectionHeaderLabel.textColor = .white
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension CommitController: UICollectionViewDelegateFlowLayout {
    
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected image with commit: \(gitHubGiphyDetails[indexPath.section].commmitGiphyDetails[indexPath.row].commit)")
        
        let imageController = ImageViewController.getInstance(commitGiphyDetails: gitHubGiphyDetails[indexPath.section].commmitGiphyDetails[indexPath.row])
        
        navigationController?.pushViewController(imageController, animated: true)
        
    }
    
}
