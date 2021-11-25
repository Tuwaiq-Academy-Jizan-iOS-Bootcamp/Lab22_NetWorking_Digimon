//
//  ViewController.swift
//  workAPI
//
//  Created by NoON .. on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var digimonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(with: "/digimon")
    }
    func getData(with endPoint:String){
        // step 1 crreat a URL
        // يتغير
        let baseURL = "https://digimon-api.vercel.app/api"
        print("is thes colled??")
        if let url = URL(string: baseURL + endPoint){
            print("WAS THE URL IN CORRECT FORMAT")
            // step 2 create URLSession
            //ثابته
            let session = URLSession(configuration: .default)
            //step 3 give URLSession a task
            // لها خيارين ي url or url requst/ثابته الا فيها
            //كلوجر
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else{
                    print("DOWE HAVE DATA",data)
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Degimon].self, from: safeData)
                            print("DECODED DATA",decodedData[0])
                            
                            DispatchQueue.main.async {
                                self.nameLabel.text = decodedData[0].name
                                self.levelLabel.text = decodedData[0].level
                                
                                if let imageURL = URL(string: decodedData[0].img){
                                    let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        self.digimonImage.image = image}
                                    }
                                }
                            
                        } catch {
                            print("SOMETHING WENT WRONG", error.localizedDescription)
                            
                        }
                    }
                }
            }
            //4. start/resume the task
            // ثابته
            task.resume()
        }
    }
}
