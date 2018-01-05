//
//  ViewController.swift
//  DropDownMenu
//
//  Created by Venkatesh Aluri on 28/12/17.
//  Copyright © 2017 Venkatesh Aluri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dropDownText: UILabel!
    @IBOutlet weak var dropDownTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var behaviourCategories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitle("New Goal", subtitle: "Step 1 of 3")
        self.dropDownTableView.delegate = self
        self.dropDownTableView.dataSource = self
        self.dropDownTableView.isHidden = true
        
        // self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        self.textField.delegate = self
        
        
        let jsonUrlString = "http://eitepulsecheck.azurewebsites.net/api/Survey/getBehaviors"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, response, err) in
            
            guard let data = data else{ return }
            
            do {
                self.behaviourCategories = try JSONDecoder().decode([Categories].self, from: data)
                self.dropDownTableView.reloadData()
                print(self.behaviourCategories)
            } catch let jsonErr {
                print("json error : \(jsonErr)")
            }
            
            }.resume()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dropDownButtonClicked(_ sender: Any) {
        
        // print("button clicked")
        self.dropDownTableView.isHidden = !self.dropDownTableView.isHidden
        
    }
    
}
//
//var headerData = ["FORCEFUL","ENABLING","STRATEGIC"]
//var cellData = [["Taking Charge","Setting expectations","Making timely decisions","Taking a clear position","Being direct with critical feedback","Holding people accountable"],["Empoering people","Delegating authority","Listening","Being open to input","Include people in decisions","Coaching and mentoring people","Providing positive feedback"], ["Focusing on the big picture"]]



extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.behaviourCategories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.behaviourCategories[section].behaviors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DropDownTableCell
        
        cell.tittleLabel.text  = " \(self.behaviourCategories[indexPath.section].behaviors[indexPath.row].BehaviorText)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.behaviourCategories[section].category
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let vw = UIView()
    //        vw.backgroundColor = UIColor.blue
    //
    //        return vw
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)!
        let dropdowncell = currentCell as? DropDownTableCell
        guard let cellText = dropdowncell?.tittleLabel.text else{ return }
        self.dropDownText.text = cellText
        self.dropDownTableView.isHidden = true
    }
    
}

extension ViewController : UIGestureRecognizerDelegate, UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return true;
    }
}

