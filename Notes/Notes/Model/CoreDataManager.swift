//
//  CoreDataManager.swift
//  Notes
//
//  Created by calum boustead on 13/07/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import Foundation
import CoreData

// Singleton to manage CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    init () {}
    
    
    // Creation of persistentContiner
    
    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Notes")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    //MARK: Functions
    
    // Save CoreData to Context
    func save(){
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch let saveError {
                fatalError("Unable to save context. error: \(saveError)")
            }
        }
    }
    
    // Fetch notes
    func fetchNotes() -> [NoteMO]? {
        
        let context = persistentContainer.viewContext
        
        //build fetch request for all of the notes
        let fetchRequest = NSFetchRequest<NoteMO>(entityName: "NoteItem")
        
        // add sorting
        
        let sort = [NSSortDescriptor(key: "dateCreated", ascending: true)]
        fetchRequest.sortDescriptors = sort
        
        do {
            // call fetch request
            let notes = try context.fetch(fetchRequest)
            return notes
        } catch let fetchError {
            fatalError("Failed to fetch note from context \(fetchError)")
        }
    }
    
    // Add new note
    func addNote(title: String!, content: String?) {
        
        let context = persistentContainer.viewContext
        
        //create new NoteMO in context
        guard let note = NSEntityDescription.insertNewObject(forEntityName: "NoteItem", into: context) as? NoteMO else {
            fatalError("insertNewObject did not return NoteMO")
        }
        
        //set its values
        note.dateCreated = Date()
        note.noteContent = content ?? "default"
        note.noteTitle = title
        
        // Save context
        do {
            try context.save()
        } catch let saveError {
            fatalError("Unable to save context. error: \(saveError)")
        }
        
    }
    
    func createNote(title: String!, content: String?) -> NoteMO {
        let context = persistentContainer.viewContext
        
        //create new NoteMO in context
        guard let note = NSEntityDescription.insertNewObject(forEntityName: "NoteItem", into: context) as? NoteMO else {
            fatalError("insertNewObject did not return NoteMO")
        }
        
        //set its values
        note.dateCreated = Date()
        note.noteContent = content ?? "default"
        note.noteTitle = title
        
        return note
    }
    
    func deleteNote(note: NoteMO){
        let context = persistentContainer.viewContext
        context.delete(note)
    }
    
}
