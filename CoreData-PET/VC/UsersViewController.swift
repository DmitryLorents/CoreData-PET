//
//  ViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit
import CoreData

class UsersViewController: UIViewController {
    
    @IBOutlet weak var usersTableView: UITableView!
    var fetchResultController: NSFetchedResultsController<User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        performFetch()
        
    }
    fileprivate func performFetch() {
        let fetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchResultController = NSFetchedResultsController<User>(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchResultController.performFetch()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") else {return UITableViewCell()}
        let user = fetchResultController.object(at: indexPath) as? User
        cell.textLabel?.text = user?.name
        cell.detailTextLabel?.text =  "----"
        cell.imageView?.image = UIImage(named: "0")
        return cell
    }
    
}
