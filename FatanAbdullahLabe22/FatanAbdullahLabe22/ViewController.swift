//
//  ViewController.swift
//  FatanAbdullahLabe22
//
//  Created by Faten Abdullh salem on 22/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
@IBOutlet weak var ImageDigimon: UIImageView!
@IBOutlet weak var nameDigimon: UILabel!
@IBOutlet weak var levelDigimon: UILabel!
    
@IBOutlet weak var digimonTableView: UITableView!{
    didSet{
        
digimonTableView.delegate = self
digimonTableView.dataSource = self
}
}
var digimonArray:[Digimon] = []
 
override func viewDidLoad() {
super.viewDidLoad()
    
getData(with: "/digimon")
   }

   func getData(with endPoint:String){
           // Step 1 Crreat a URL
       let basedURL = "https://digimon-api.vercel.app/api"
       print("is thes colled??")
           if let url = URL(string: basedURL + endPoint){
               print("WAS THE URL IN CORRECT FORMAT")
           // Step 2 create URLSession
               
       let session = URLSession(configuration: .default)
               
              // Step 3 Create URLSession a Task
               
   let task = session.dataTask(with: url) { data, response,error in
           
       if let error = error {
       print("ERROR",error.localizedDescription)
           
}else{
       print("DOWE HAVE DATA",data)
           
       if let safeDate = data {
           do {
               
       let decoder = JSONDecoder()
       let decodedData = try decoder.decode([Digimon].self,from: safeDate)
   DispatchQueue.main.async {
    self.digimonArray = decodedData
    self.digimonTableView.reloadData()
   }
       print("DECODED DATA",decodedData[0])
    DispatchQueue.main.async {
   self.nameDigimon.text = decodedData[0].name
   self.levelDigimon.text = decodedData[0].level
    }
   if let imageURL = URL(string: decodedData[0].img){
       let data = try? Data(contentsOf: imageURL)
       if let data = data {
       let image = UIImage(data: data)
       self.ImageDigimon.image = image}
               }
           }catch{
           print("SOMETHING WENT WRONG", error.localizedDescription)
           }
       }
           }
       }
   // 4.Start/resume the task
       task.resume()
       }
   }
   }
    
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digimonArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier:"cell", for: indexPath) as! digimonDetailCell
        
    cell.digimonName.text = digimonArray[indexPath.row].name
    cell.digimonLevel.text = digimonArray[indexPath.row].level
    if let image = URL(string: digimonArray[indexPath.row].img)
        {
        DispatchQueue.global().async {
    let data = try? Data(contentsOf: image)
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    cell.digimonImage.image = image
                }
            }
        }
    }
return cell
        
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    }

