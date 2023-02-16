//
//  NewBookViewController.swift
//  CoreData-PET
//
//  Created by Mac on 15.02.2023.
//

import UIKit
import CoreData

class NewBookViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var authorTF: UITextField!
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlets()
        imageViewAddGesture()
    }
    
    fileprivate func imageViewAddGesture() {
        imageView.image = UIImage(named: "0")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(randomImage))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func randomImage() {
        let imageName = Int.random(in: 1...10)
        imageView.image = UIImage(named: "\(imageName)")
        
    }
    
    func setOutlets() {
        if book != nil {
            nameTF.text = book?.name
            authorTF.text = book?.author
            imageView.image = book?.image
        } else {
            book = Book(context: CoreDataManager.instance.context)
        }
    }
    
    fileprivate func saveBook() -> Bool {
        if nameTF.text?.isEmpty ?? true {
            let alertController = UIAlertController(title: "Warning", message: "Please enter book name", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alertController, animated: true)
            return false
        } else {
            book?.name = nameTF.text
            book?.author =  authorTF.text
            book?.image = imageView.image
        }
        CoreDataManager.instance.saveContext()
        return true
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        if saveBook() {
            dismiss(animated: true)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
