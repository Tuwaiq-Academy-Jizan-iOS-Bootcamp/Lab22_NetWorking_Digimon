//
//  ViewController.swift
//  FatanLabe22
//
//  Created by Faten Abdullh salem on 22/04/1443 AH.
//

import UIKit
class ViewController: UIViewController {
@IBOutlet weak var lmageDigimon: UIImageView!
@IBOutlet weak var nameDigimon: UILabel!
@IBOutlet weak var levelDigimon: UILabel!
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
    print("DECODED DATA",decodedData[0])
                        
DispatchQueue.main.async {
    
self.nameDigimon.text = decodedData[0].name
self.levelDigimon.text = decodedData[0].level
    
if let imageURL = URL(string: decodedData[0].img){
    let data = try? Data(contentsOf: imageURL)
            
    if let data = data {
    let image = UIImage(data: data)
    self.lmageDigimon.image = image}
            }
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
