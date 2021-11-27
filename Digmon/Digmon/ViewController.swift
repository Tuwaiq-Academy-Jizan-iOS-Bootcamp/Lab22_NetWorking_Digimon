//
//  ViewController.swift
//  Digmon
//
//  Created by موسى مسملي on 24/11/2021.
//

import UIKit

 class ViewController: UIViewController {

     
     @IBOutlet weak var img: UIImageView!
     
     @IBOutlet weak var name: UILabel!
     
     @IBOutlet weak var level: UILabel!
     
     override func viewDidLoad() {
             super.viewDidLoad()
             getData(with: "/digimon")
         }
         func getData(with endPoint:String){
            
    let baseURL = "https://digimon-api.vercel.app/api"
    print("is thes colled??")
    if let url = URL(string: baseURL + endPoint){
    print("WAS THE URL IN CORRECT FORMAT")

    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: url) { data, response, error in
    if let error = error {
    print("ERROR",error.localizedDescription)
    }else{
    print("DOWE HAVE DATA",data)
    if let safeData = data {
    do {
    let decoder = JSONDecoder()
        let decodedData = try decoder.decode([Digmon].self, from: safeData)
    print("DECODED DATA",decodedData[0])

    DispatchQueue.main.async {
    self.name.text = decodedData[0].name
    self.level.text = decodedData[0].level

    if let imageURL = URL(string: decodedData[0].img){
    let data = try? Data(contentsOf: imageURL)
    if let data = data {
    let image = UIImage(data: data)
    self.img.image = image}
}
    }

} catch {
print("SOMETHING WENT WRONG", error.localizedDescription)

    }
    }
    }
    }
                 
    task.resume()
    }
    }
    }
