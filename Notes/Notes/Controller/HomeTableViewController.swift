//
//  HomeTableViewController.swift
//  Notes
//
//  Created by calum boustead on 12/07/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
    
    //var container: NSPersistentContainer!
    var notes: [NoteMO]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        setupUI()
        
        notes = CoreDataManager.shared.fetchNotes()
        
        
        
        
    }
    
    // MARK: UI
    private func setupUI(){
        // Add button to Toolbar
        self.navigationController?.isToolbarHidden = false
        var items = [UIBarButtonItem]()
        items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil) )
        items.append( UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewNoteSegue)) )
        self.toolbarItems = items
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isToolbarHidden = false
        notes = CoreDataManager.shared.fetchNotes()
        tableView.reloadData()
    }
    // MARK: - Buttons
    
    @objc func addNewNoteSegue() {
        performSegue(withIdentifier: "createNewNoteSegue", sender: self)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.notes?.count ?? 0
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteTableViewCell else {
            fatalError("Unable to create NoteTableViewCell")
        }
        
        cell.titleLabel.text = notes![indexPath.row].noteTitle!
        cell.dateLabel.text = notes![indexPath.row].dateCreated!.description
        cell.contentLabel.text = notes![indexPath.row].noteContent ?? ""
        
        //selection color
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = backgroundView

        return cell
    }
    


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath)
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showNoteDetailsSegue", sender: nil)

    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
          CoreDataManager.shared.deleteNote(note: notes![indexPath.row])
          notes = CoreDataManager.shared.fetchNotes()
          tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "showNoteDetailsSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! NewNoteViewController
                controller.note = notes![indexPath.row]
                controller.isNew = false
            }
        }
        else if segue.identifier == "createNewNoteSegue" {
            let controller = segue.destination as! NewNoteViewController
            controller.note = CoreDataManager.shared.createNote(title: "", content: "")
            controller.isNew = true
        }
        
        // Pass the selected object to the new view controller.
    }
    

}
