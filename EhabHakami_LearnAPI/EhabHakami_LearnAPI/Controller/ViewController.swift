//
//  ViewController.swift
//  EhabHakami_LearnAPI
//
//  Created by Ehab Hakami on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var digmonInformation = [Digmon] ()
    
    @IBOutlet weak var imageDigimon: UIImageView!
    var imageDigiminview = UIImage(named: "")
    
    @IBOutlet weak var nameDigimon: UILabel!
    var nameDigimonView = ""
    @IBOutlet weak var LabelDigimon: UILabel!
    var LabelDigimonView = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
//        imageDigimon.image = imageDigiminview
//        nameDigimon.text = nameDigimonView
//        LabelDigimon.text = LabelDigimonView
        let url1 = URL(string: "https://digimon.shadowsmith.com/img/koromon.jpg")!
        
        let dataTask = URLSession.shared.dataTask(with: url1) { [weak self] (data, _, _)in
            if let data = data {
                DispatchQueue.main.async {
                    self?.imageDigimon.image = UIImage(data: data)
                }
            }
        }
        
        
        dataTask.resume()
        }
    


    //الي يتغير url و decoder الباقي م يتغير
    func getData(with endPoint:String){
        print("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        // 1. create url
        if let url = URL(string: baseURL + endPoint) {
            print("WAS THE URL IN CORRECT FORMAT")
            //2. create a URL Session--------------  (السيشن دايما ثابت في اي -> Api)
            let session = URLSession(configuration: .default)
            //3 create a task ----------------   (و التاسك ثابت في اي  -> Api)
            // task divenatin send data requset and response
            let task = session.dataTask(with: url) { data, response, error in
                /// decoder من هنا
                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else {
                    print("DO WE HAVE DATA",data)
                    
                    //حتى هنا ذا decoder
                    if let safeData = data {
//                        print(String(data: safeData, encoding: .utf8))
                       
                        
                        /// ths error handling
                        
                        do {   // JSONDecoder() ths is func assast تساعد على ربط السويفت و الجيسون
                            
                            let decoder = JSONDecoder()
                            
                            // decode nedd stracrt.self or [stract].self
                            
                            // ui alwas uptate  min thred solf prbleam error coler Purple الايرور البنفسجي
                            
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                           // print("DECODED DATA",decodedData[7].name)
                           
                           
                            // s تعريف المعلومات مع  المين بعد م سندنا القيم في دوجمن انفرميشن واستخدمنا معاها دالة دسبلي كويري
                            self.digmonInformation = decodedData
                            DispatchQueue.main.async {
                                self.nameDigimon.text = self.digmonInformation[0].name
                                self.LabelDigimon.text = self.digmonInformation[0].level
                               
                            }
                            
                            
                            
                            for ele in decodedData {
//                                print(ele.name)
//                                print(ele.level)
                                print(ele.img)
                            }
                            
                        } catch {
                            print("SOMETHING WENT WRONG",error.localizedDescription)
                        } //end error handling
                        
                    } //
                    
                    
                } //end else error handling
                
                
            }  // end task
            
            
            //4. start/resume the task
            task.resume()
            
            
        } // end url if
        
        
    } // end func getData
    
}




