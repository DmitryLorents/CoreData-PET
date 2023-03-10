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
    typealias Clouser = (Book) -> ()
    var getBookClouser: Clouser?
    var imageIsVisible: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
        tableView.delegate = self
        tableView.dataSource = self
        fetchResultController.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SettingStorage.instance.setView(view: self.view, tableView: tableView, imageIsVisible: &imageIsVisible)
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
// MARK: - DataSource

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
        
        let book = fetchResultController.object(at: indexPath)
        cell.textLabel?.text = book.name
        cell.detailTextLabel?.text = book.author
        cell.imageView?.image = book.image
        cell.imageView?.isHidden = !imageIsVisible
        //cell.backgroundColor = view.backgroundColor
        
        return cell
    }
    //MARK: - Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let clouser = getBookClouser {
            let book = fetchResultController.object(at: indexPath)
            clouser(book)
            dismiss(animated: true)
        } else {
            let book = fetchResultController.object(at: indexPath)
            performSegue(withIdentifier: "addBook", sender: book)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let managedObject = fetchResultController.object(at: indexPath) as NSManagedObject
            CoreDataManager.instance.context.delete(managedObject)
            CoreDataManager.instance.saveContext()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBook" {
            let vc = segue.destination as? NewBookViewController
            vc?.book = sender as? Book
        }
    }
}
//MARK: -  NSFetchedResultsControllerDelegate

extension BooksViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let book = fetchResultController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = book.name
                cell?.detailTextLabel?.text = book.author
                cell?.imageView?.image = book.image
            }
        default: break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}
