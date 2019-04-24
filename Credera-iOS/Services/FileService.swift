//
//  FileService.swift
//  Credera-iOS
//
//  Created by Craig Hatch on 4/24/19.
//  Copyright © 2019 Credera. All rights reserved.
//

import Foundation
import os.log
class FileService {
    
    var documentsDirectory: URL
    var fileUrl: URL
    
    init() {
        self.documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileUrl = documentsDirectory.appendingPathComponent("gitGiphyIntegration")
    }
    
    func saveToDevice(withData inputData: [GitHubAndGiphyData]) {
        let encoder = JSONEncoder()
//        do {
//            let data = try encoder.encode(inputData)
//            if FileManager.default.fileExists(atPath: self.fileUrl.path) {
//                try FileManager.default.removeItem(at: self.fileUrl)
//            }
//            FileManager.default.createFile(atPath: self.fileUrl.path, contents: data, attributes: nil)
//        } catch {
//            fatalError(error.localizedDescription)
//        }
        do {
            let data = try encoder.encode(inputData)
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(data, toFile: fileUrl.path)
            if isSuccessfulSave {
                os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save meals...", log: OSLog.default, type: .error)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getData() -> [GitHubAndGiphyData]? {
        let decoder = JSONDecoder()
        let encoded = (NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path) as? Data)!
//        let encoded2 = (NSKeyedUnarchiver.unarchiveObject(withFile: fileUrl.path) as?[GitHubAndGiphyData])!

        return try? decoder.decode([GitHubAndGiphyData].self, from: encoded)
    }
    
}
