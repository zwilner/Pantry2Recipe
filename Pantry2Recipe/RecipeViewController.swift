//
//  RecipeViewController.swift
//  Pantry2Recipe
//
//  Created by Zach Wilner on 11/28/17.
//  Copyright © 2017 Zach Wilner. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var activityIndicator = UIActivityIndicatorView()
    var recipes = Recipes()
    var ingrOne = ""
    var ingrTwo = ""
    var ingrThree = ""
    var ingrFour = ""
    var ingrFive = ""
    var pageNum = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setUpActivityIndicator()
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        recipes.getRecipes(ingr1: ingrOne, ingr2: ingrTwo, ingr3: ingrThree, ingr4: ingrFour, ingr5: ingrFive, pageNum: pageNum) {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if self.recipes.numberOfResults < 1 {
                self.showAlertWithOkButton(title: "No Recipes Available", message: "Sorry, no recipes were found with the ingredients you selected")
            }
        }
    }
    
    
    func showAlertWithOkButton(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {action in self.returnToHome()})
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.red
        view.addSubview(activityIndicator)
    }
    
    
    func returnToHome(){
        performSegue(withIdentifier: "ReturnHome", sender: nil)
    }
  

}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.recipeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.update(with: recipes.recipeArray[indexPath.row])
        if indexPath.row == recipes.recipeArray.count - 1 && recipes.moreResults{
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            pageNum += 1
            recipes.getRecipes(ingr1: ingrOne, ingr2: ingrTwo, ingr3: ingrThree, ingr4: ingrFour, ingr5: ingrFive, pageNum: pageNum) {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
            }

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = recipes.recipeArray[indexPath.row].URL
        UIApplication.shared.open(NSURL(string: url)! as URL, options: [:], completionHandler: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
