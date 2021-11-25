//
//  ViewController.swift
//  Api
//
//  Created by layla hakami on 20/04/1443 AH.
//

import UIKit
class ViewController: UIViewController {
@IBOutlet weak var imageViewApi: UIImageView!
@IBOutlet weak var firdtDigimonLabel: UILabel!
@IBOutlet weak var secendDigimon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call func getData
        getData(with: "/digimon")
    }

    func getData(with endPoint:String){
        print("Is this called")
      let baseURl = "https://digimon-api.vercel.app/api"
        
        //step 1
        if let url1 = URL(string: baseURl + endPoint) {
            print("step1")
        //step 2
            let session = URLSession(configuration: .default)
        //step 3
    let task = session.dataTask(with: url1){ data, response, error in
       if let error = error {
           print("step3",error.localizedDescription)
                }else{
                   // print("....." ,data)
                    if let safeData = data {
    //1 do ....// decode => thrawine
                        do {
        let decord = JSONDecoder()
     //2 try
let decordededData = try decord.decode([Didimon].self, from: safeData)
print("DECODE DATA", decordededData[0])
DispatchQueue.main.async {
self.firdtDigimonLabel.text = decordededData[0].name
self.secendDigimon.text = decordededData[0].level
    if let imageURL = URL(string: decordededData[0].img){
        let data = try? Data(contentsOf:imageURL)
        if let data = data {
        let image = UIImage(data: data)
        self.imageViewApi.image = image
                                    }
                                                        
                                }
    }
                        
       //3 catch
        }catch {
        print ("error", error.localizedDescription)
                        }
                    }
                  }
                }
        
        task.resume()
       
    }
}
    
    }

