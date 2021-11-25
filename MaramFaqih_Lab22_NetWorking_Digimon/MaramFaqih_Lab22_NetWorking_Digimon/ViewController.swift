//
//  ViewController.swift
//  MaramFaqih_Lab22_NetWorking_Digimon
//
//  Created by meme f on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var levelLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //pass end point as argument to function that will get data
        getaData(with:"/digimon")
         
    }
    //req Method
    //1.get:
    func getaData(with endPoint:String){
        //1.1 Create url req
        let baseURL = "https://digimon-api.vercel.app/api"
       if let url = URL(string: baseURL+endPoint) {
        //1.2 Create session req
        let session = URLSession(configuration: .default)
        //1.3 creat task
        //task create to get data from url and call closuer "completion Handler"
        let task = session.dataTask(with: url){ data, respons, error in
            if let error = error {
                print("error",error.localizedDescription)
            }else{
                if let safeData = data {
                    do{
                        //-Object decode data type from jeson-
                        let decoder = JSONDecoder()
                        //-decode() return value from jeson object as type "decoder"
                        let decoderData = try decoder.decode([Digmon].self, from: safeData)
                        //print the firest json object from json array
                        print("decode data:",decoderData[0])
//                        self.imageView1.image =  try UIImage(data: Data(contentsOf: URL(string: decoderData[0].img )!))
                            DispatchQueue.main.async {

                                // Do all your UI stuff here

                        self.nameLabel.text = decoderData[0].name
                        self.levelLabel.text = decoderData[0].level
                             
//                                self.imageView1.image =  UIImage(data:  decoderData[0].img )!
                              ////////////
                                  if let imageURL = URL(string: decoderData[0].img){
                                DispatchQueue.global().async {
                                   let data = try? Data(contentsOf: imageURL)
                                    if let data = data {
                                        let image = UIImage(data: data)
                                        DispatchQueue.main.async {
                                            self.imageView1.image = image
                                    }
                                }
                                }}
                                
                                ///
                            
                            }
                         
                        
                    }
                    
                    catch{
                        print("error",error.localizedDescription)
                        
                    }
                }
                
            }
            
        }
           //call task if task
            task.resume()
        }
        
        
        
        
    }
    

}

