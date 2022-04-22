//
//  CoreDataService.swift
//  zksync-example
//
//  Created by J on 2022-04-16.
//

import Foundation
import CoreData

class LocalDatabase {
    lazy var container: NSPersistentCloudKitContainer = NSPersistentCloudKitContainer(name: "Model")
    private lazy var mainContext = self.container.viewContext
    
    init() {
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
    }
    
    func getWallet() -> KeyWalletModel? {
        let requestWallet: NSFetchRequest<KeyWallet> = KeyWallet.fetchRequest()
        
        do {
            // fetch results in exec bad access
            let results = try mainContext.fetch(requestWallet)
            guard let result = results.first else { return nil }
            return KeyWalletModel.fromCoreData(crModel: result)
        } catch {
            print(error)
            return nil
        }
    }
    
    func saveWallet(isRegistered: Bool, wallet: KeyWalletModel, completion: @escaping (Errors?) -> Void) {
        container.performBackgroundTask { [weak self](context) in
            
            self?.deleteWallet { (error) in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
                
                guard let entity = NSEntityDescription.insertNewObject(forEntityName: "KeyWallet", into: context) as? KeyWallet else { return }
                entity.address = wallet.address
                entity.data = wallet.data
                
                do {
                    try context.save()
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.generalError("Could not save wallet"))
                    }
                }
            }
        }
    }
    
    func deleteWallet(completion: @escaping (Errors?) -> Void) {
        let requestWallet: NSFetchRequest<KeyWallet> = KeyWallet.fetchRequest()
        
        do {
            let result = try mainContext.fetch(requestWallet)
            for item in result {
                mainContext.delete(item)
            }
            
            try mainContext.save()
            
            
            completion(nil)
        } catch {
            DispatchQueue.main.async {
                completion(.generalError("Could not delete the wallet"))
            }
        }
    }
}
