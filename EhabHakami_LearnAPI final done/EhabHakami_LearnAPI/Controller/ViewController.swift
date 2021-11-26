//
//  ViewController.swift
//  EhabHakami_LearnAPI
//
//  Created by Ehab Hakami on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var digmonInformation = [Digmon] ()
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData(with: "/digimon")
        
        
         // ذا اول استخدمتو عشان انقل شيئ واحد واغلب الي في التاق هنا عشانو الشئ الواحد ذا الي هو الصورة والاسم والليفل حق الديقمون في ليبل فيو وامج فيو بس مسحت الماين حاطه هنا عشان يمكن في يوم من الايام احتاجو
        //        imageDigimon.image = imageDigiminview
        //        nameDigimon.text = nameDigimonView
        //        LabelDigimon.text = LabelDigimonView
        
        
        
       // let url1 = URL(string: "https://digimon.shadowsmith.com/img/koromon.jpg")!
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        //        let dataTask = URLSession.shared.dataTask(with: url1) { [weak self] (data, _, _)in
        //            if let data = data {
        //                DispatchQueue.main.async {
        //                    self?..image = UIImage(data: data)
        //                }
        //            }
        //        }
        //
        //
        //        dataTask.resume()
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
                    
                    
                    if let safeData = data {
                        
        // print(String(data: safeData, encoding: .utf8))
                        
                        /// ths error handling
                        
                        do {
                            
                            // JSONDecoder() ths is func assast تساعد على ربط السويفت و الجيسون
                            let decoder = JSONDecoder()
                            
                            // decode nedd stracrt.self or [stract].self
                            
                            // ui alwas uptate  min thred solf prbleam error coler Purple الايرور البنفسجي
                            
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            
                            // print("DECODED DATA",decodedData[7].name)
                            
                            
                            
                            // aa change value decodedData cuse used out scop and add value in exstantion table view
                            self.digmonInformation = decodedData
                            
                            // func show in data in min
                            DispatchQueue.main.async {
                                
                                // conected with table view
                                self.myTableView.reloadData()
                                
                            }
                            
                            
                            // a عشان اتاكد من المعلومات انها موجودة وكلو تمام
//                        for ele in decodedData {
//                            print(ele.name)
//                            print(ele.level)
//                            print(ele.img)
//                        }
                            
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

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = digmonInformation[indexPath.row].name
        content.secondaryText = digmonInformation[indexPath.row].level
        
        
        
        //used show image dowen
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        
        
        if let digmonImageURl = URL(string: self.digmonInformation[indexPath.row].img){
            DispatchQueue.global().async {
                if let digmoImageData = try? Data(contentsOf: digmonImageURl) {
                    let digmoImage = UIImage(data: digmoImageData)
                    DispatchQueue.main.async {
                        content.image = digmoImage
                        
                        cell.contentConfiguration = content
                        
                    } // end DispatchQueue.main.async
                    
                } // end if let digmoImageData
                
            } //end DispatchQueue.global().async
            
        } //end if let digmonImageURl
        
        return cell
    }  // end fanc cellForRow
    
    
}
