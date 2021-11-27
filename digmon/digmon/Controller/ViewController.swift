//
//  ViewController.swift
//  digmon
//
//  Created by يوسف جابر المالكي on 22/04/1443 AH.
//

import UIKit
class ViewController: UIViewController {
 @IBOutlet weak var lmageDigimon: UIImageView!
 @IBOutlet weak var lableName: UILabel!
 @IBOutlet weak var lableLevel: UILabel!
 override func viewDidLoad() {
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
     print(decodedData[0])
 DispatchQueue.main.async {
 self.lableName.text = decodedData[0].name
 self.lableLevel.text = decodedData[0].level
 if let imageURL = URL(string: decodedData[0].img){
     let data = try? Data(contentsOf: imageURL)
     if let data = data {
     let image = UIImage(data: data)
     self.lmageDigimon.image = image}
             }
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
