//
//  BooksViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit
import CoreData

class BooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var fetchResultController: NSFetchedResultsController<Book>!
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func performFetch() {
        let fetchRequeest = Book.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequeest.sortDescriptors = [sortDescriptor]
        fetchResultController = NSFetchedResultsController<Book>(fetchRequest: fetchRequeest, managedObjectContext: CoreDataManager.instance.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension BooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchResultController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell") else {
            return UITableViewCell()
        }
        
        if let book = fetchResultController.object(at: indexPath) as? Book {
            cell.textLabel?.text = book.name
            cell.detailTextLabel?.text = book.author
            cell.imageView?.image = book.image
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let book = fetchResultController.object(at: indexPath) as? Book {
            performSegue(withIdentifier: "addBook", sender: book)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBook" {
            let vc = segue.destination as? NewBookViewController
            vc?.book = sender as? Book
        }
    }
}
