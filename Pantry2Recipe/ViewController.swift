//
//  ViewController.swift
//  Pantry2Recipe
//
//  Created by Zach Wilner on 11/28/17.
//  Copyright © 2017 Zach Wilner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ingredientOne: UITextField!
    @IBOutlet weak var ingredientTwo: UITextField!
    @IBOutlet weak var ingredientThree: UITextField!
    @IBOutlet weak var ingredientFour: UITextField!
    @IBOutlet weak var ingredientFive: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var ingrOne = ""
    var ingrTwo = ""
    var ingrThree = ""
    var ingrFour = ""
    var ingrFive = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        searchButton.isEnabled = false
    
    }
    
    @IBAction func DoneKeyPressed(_ sender: UITextField) {
        self.view.endEditing(true)
        
    }
    

    @IBAction func ingrOneTextEntered(_ sender: UITextField) {
        ingrOne = ingredientOne.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        searchButton.isEnabled = true
    }
    
    @IBAction func ingrTwoTextEntered(_ sender: UITextField) {
        ingrTwo = ingredientTwo.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        searchButton.isEnabled = true
    }
    
    
    @IBAction func ingThreeTextEntered(_ sender: UITextField) {
        ingrThree = ingredientThree.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        searchButton.isEnabled = true
    }
    
    @IBAction func ingrFourTextEntered(_ sender: UITextField) {
        ingrFour = ingredientFour.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        searchButton.isEnabled = true
    }
    
    
    @IBAction func ingrFiveTextEntered(_ sender: UITextField) {
        ingrFive = ingredientFive.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        searchButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RecipeSegue" {
            let destination = segue.destination as! RecipeViewController
            destination.ingrOne = ingrOne
            destination.ingrTwo = ingrTwo
            destination.ingrThree = ingrThree
            destination.ingrFour = ingrFour
            destination.ingrFive = ingrFive
        }

    }
    
    


}

