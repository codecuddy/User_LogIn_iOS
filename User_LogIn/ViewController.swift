//
//  ViewController.swift
//  User_LogIn
//
//  Created by Charlie Cuddy on 1/15/18.
//  Copyright © 2018 Charlie Cuddy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var logInButton: UIButton!
    
    @IBAction func logIn(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newName = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newName.setValue(textField.text, forKey: "name")
        
        do {
            
            try context.save()
            
            textField.alpha = 0
            logInButton.alpha = 0
            label.alpha = 1
            homeButton.alpha = 1
            
            label.text = "Thanks for signing up, \(textField.text!)!"

        } catch {
            
            print("Failed to save new name!")
            
            
        }
    
    }
    
    @IBOutlet weak var homeButton: UIButton!
    
    @IBAction func home(_ sender: Any) {
        textField.alpha = 1
        logInButton.alpha = 1
        label.alpha = 0
        homeButton.alpha = 0
        
        textField.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject] {
                
                if let username = result.value(forKey: "name") as? String {
                    
                    textField.alpha = 0
                    logInButton.alpha = 0
                    label.alpha = 1
                    homeButton.alpha = 1

                    label.text = "Hey, hey, \(username)! Welcome Back!"

                }
                
            }
            
        } catch {
            
            print("Request failed")
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

