//
//  FileManagerPersistent.swift
//  NotesApp
//
//  Created by Darina Kovtun on 13.05.2024.
//
import Foundation
import UIKit

final class FileManagerPersistent {
    
    static func save(_ image: UIImage, with name: String) -> URL? {
        let data = image.jpegData(compressionQuality: 1)
        let url = getDocumentDirectory().appendingPathComponent(name)
                                            
        do {
            try data?.write(to: url)
            print("image was saved")
            return url
        } catch {
            print("saving image is error: \(error)")
            return nil
        }
    }
    
    static func read(from url: URL) -> UIImage? {
         UIImage(contentsOfFile: url.path)
    }
    
    static func delete(from url: URL) {
        do {
            try FileManager.default.removeItem(at: url)
            print("Image was deleted")
        } catch {
            print("deleting image is error: \(error)")
        }
    }
    
    private static func getDocumentDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask)[0]
    }
}
