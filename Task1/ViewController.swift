//
//  ViewController.swift
//  Task1
//
//  Created by shahrukh on 8/22/17.
//  Copyright © 2017 shahrukh. All rights reserved.
//

import UIKit
import SwiftyJSON
import ImageLoader

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countries = [String]()
    var populations = [String]()
    var flags = [String]()
    var num = Int()
    
    @IBOutlet weak var myTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = Bundle.main.path(forResource: "JSONData", ofType: "json")
        let content = NSData.init(contentsOfFile: filePath!)
        
        let dict = try? JSONSerialization.jsonObject(with: content! as Data, options: .mutableContainers)
        
        print("content = ",content!)
        print("dict = ",dict!)
        
        let json = JSON(data: content! as Data)
        print("json = ",json)
        
        let jsonArr = json["worldpopulation"].array
        num = (jsonArr?.count)!
        
        for i in 0..<num {
            
            let country = json["worldpopulation"][i]["country"].stringValue
            print("country",country)
            self.countries.append(country)
            
            let population = json["worldpopulation"][i]["population"].stringValue
            print("population",population)
            self.populations.append(population)
            
            let flag = json["worldpopulation"][i]["flag"].stringValue
            print("flag",flag)
            self.flags.append(flag)
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CountryViewCell = myTable.dequeueReusableCell(withIdentifier: "country") as! CountryViewCell
        
        let url = flags[indexPath.row]
        
        cell.countryLabel.text = countries[indexPath.row]
        cell.populationLabel.text = populations[indexPath.row]
        cell.flagImage.image = UIImage(named: "black.jpg")
        cell.flagImage.load.request(with: url, onCompletion: { image, error, operation in
            
            if operation == .network {
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionFade
                cell.flagImage.layer.add(transition, forKey: nil)
                cell.flagImage.image = image
            }
        
        })
        
        return cell
    }


}

