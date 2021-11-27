//
//  ViewController.swift
//  digmon
//
//  Created by يوسف جابر المالكي on 22/04/1443 AH.
//

import UIKit
class ViewController: UIViewController {
    
    @IBOutlet weak var digimonTableView: UITableView!
    var digimons = [Digimon]()
    
    override func viewDidLoad() {
        digimonTableView.dataSource = self
        digimonTableView.delegate = self
     super.viewDidLoad()
  getData(with: "/digimon")
 }
 func getData(with endPoint:String){
         // Step 1 Crreat a URL
     let basedURL = "https://digimon-api.vercel.app/api"
     print("is thes colled??")
         if let url = URL(string: basedURL + endPoint){
         // Step 2 create URLSession
     let session = URLSession(configuration: .default)
            // Step 3 Create URLSession a Task
 let task = session.dataTask(with: url) { data, response,error in
     if let error = error {
     print(error.localizedDescription)
 }else{
     print(data)
     if let safeDate = data {
         do {
     let decoder = JSONDecoder()
     let decodedData = try decoder.decode([Digimon].self,from: safeDate)
     self .digimons = decodedData
 DispatchQueue.main.async {
     self .digimonTableView.reloadData()
         }
         }catch{
         print(error.localizedDescription)
         }
     }
         }
     }
 // 4.Start/resume the task
     task.resume()
     }
 }
 }
extension ViewController:UITableViewDelegate,UITableViewDataSource{
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return digimons.count
     }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! costemCell
         cell.lableName.text = digimons[indexPath.row].name
         cell.lableLevel.text = digimons[indexPath.row].level
         cell.lmageDigimon.image = nil
         let urlImage = URL(string: digimons[indexPath.row].img)
         if let urlImage = urlImage {
             DispatchQueue.global().async {
                 if let data = try? Data(contentsOf: urlImage){
                     DispatchQueue.main.async {
                         //Check if the current cell is displayed
                         if tableView.cellForRow(at: indexPath) != nil {
                             cell.lmageDigimon.image = UIImage(data: data)
                         }
                     }
                 }
             }
         }
         return cell
     }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 100
     }
 }
