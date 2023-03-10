//
//  NewViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit

class NewUserViewController: UIViewController {
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var bookNameTF: UITextField!
    var user: User?
    var book: Book?
    var imageIsVisible: Bool!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()

       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        SettingStorage.instance.setView(view: self.view, tableView: nil, imageIsVisible: &imageIsVisible)
    }
    
    fileprivate func setOutlets() {
        if let user = user {
            userNameTF.text = user.name
            bookNameTF.text = user.book?.name
        } else {
            user = User(context: CoreDataManager.instance.context)
        }
    }
    
    func saveUser() -> Bool {
        if (userNameTF.text?.isEmpty) ?? true || (bookNameTF.text?.isEmpty) ?? true {
            let alertController = UIAlertController(title: "Warninig", message: "Please enter user name, or get its book", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alertController, animated: true)
            return false
        } else {
            user?.name = userNameTF.text
            user?.book = book
            CoreDataManager.instance.saveContext()
        }
       return true
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if saveUser() {
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getBook" {
            let vc  = segue.destination as? BooksViewController
            vc?.getBookClouser = { [unowned self] catchedBook in
                self.book = catchedBook
                self.bookNameTF.text = catchedBook.name
            }
        }
            
    }
    

}
