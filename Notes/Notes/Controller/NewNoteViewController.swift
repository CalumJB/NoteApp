//
//  NewNoteViewController.swift
//  Notes
//
//  Created by calum boustead on 12/07/2020.
//  Copyright © 2020 Boustead. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController, UITextViewDelegate {
    
    var note: NoteMO!
    var isNew: Bool!
    
    @IBOutlet weak var noteTitleTextView: UITextView!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    

    var intialNote:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.delegate = self

        // Do any additional setup after loading the view.
        self.navigationController?.isToolbarHidden = true
        
        
        
        noteTextView.becomeFirstResponder()
        
        noteTitleTextView.text = note.noteTitle
        noteTextView.text = note.noteContent ?? ""
        
    }
    

    //MARK: Buttons
    @IBAction func doneButton(_ sender: Any) {
        // Editing complete
        noteTextView.resignFirstResponder()
        doneButton.isEnabled=false
    }
    
    //MARK: TextViewDelegate
    
//    func textViewDidBeginEditing(_ textView: UITextView) -> Bool {
//        doneButton.isEnabled = true
//        noteTextView.becomeFirstResponder()
//        return true
//    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        doneButton.isEnabled=true
    }
    
    //MARK: Navigation
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            note.noteContent=noteTextView.text
            note.noteTitle=noteTitleTextView.text
            CoreDataManager.shared.save()
        }
    }
    
    
    
    
    
    

}
