//
//  BooksViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit
import CoreData

class BooksViewController: UIViewController {
    
    //let fetchResultController: NSFetchedResultsController<Book>?

    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()

        // Do any additional setup after loading the view.
    }
    func performFetch() {
        let fetchRequeest = Book.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
