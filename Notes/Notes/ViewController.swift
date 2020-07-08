//
//  ViewController.swift
//  Notes
//
//  Created by calum boustead on 07/07/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    var container: NSPersistentContainer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //check that persistentContainer was passed from SceneDelegate
        guard container != nil else {
            fatalError("This view needs a persistent container.")
        }
        
        
        
        
        
    }

    @IBAction func submitButton(_ sender: UIButton) {
        
        //validation checks
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        guard let content = contentTextField.text, !content.isEmpty else {
            return
        }
        
        let context = container.viewContext
        
        // Create a new object in context
        guard let note = NSEntityDescription.insertNewObject(forEntityName: "NoteItem", into: context) as? NoteMO else {
            fatalError("insertNewObject did not return NoteMO")
        }
        
        //set its values
        note.dateCreated = Date()
        note.noteContent = content
        note.noteTitle = title
        
        //save the contents
        do {
            try context.save()
            print("Saved")
        } catch let createError {
            print("failed to create \(createError)")
        }
        
        
    }
    
    
    @IBAction func fetchButton(_ sender: UIButton) {
        
        let context = container.viewContext
        
        //build fetch request for all of the notes
        let fetchRequest = NSFetchRequest<NoteMO>(entityName: "NoteItem")
        
        do {
            // call fetch request
            let notes = try context.fetch(fetchRequest)
            print("fetch succeeded")
            //print all notes
            for note in notes {
                let str = noteToString(note: note)
                print(str ?? "unable to print note")
            }
        } catch let fetchError {
            print("Failed to fetch \(fetchError)")
        }
        
    }
    
    
    // returns note as a string for printing
    func noteToString(note: NoteMO!) -> String! {
        return "Note(title:\"\(note.noteTitle!)\", content:\"\(note.noteContent!)\", created:\" \(String(describing: note.dateCreated))\""
    }
    
}

