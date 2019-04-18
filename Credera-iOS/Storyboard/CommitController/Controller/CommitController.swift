//
//  CommitController.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/17/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import UIKit

class CommitController: UICollectionViewController {
    private let reuseIdentifier = "commitCell"
    
    
    let data: [GitHubData] = []
    
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    //2
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //3
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
    
    
    
    
}
