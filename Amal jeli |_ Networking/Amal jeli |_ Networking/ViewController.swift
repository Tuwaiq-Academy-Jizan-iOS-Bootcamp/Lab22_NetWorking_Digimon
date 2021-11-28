//
//  ViewController.swift
//  Amal jeli |_ Networking
//
//  Created by Amal Jeli on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var digmonInformation = [Digmon] ()
    
    @IBOutlet weak var TableView: UITableView!
   

//    @IBOutlet var image: UIImageView!
//
//    @IBOutlet weak var levell: UILabel!
//
//    @IBOutlet weak var namelabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
        TableView.delegate = self
        TableView.dataSource = self
    }

    
    
    
    func getData (with endPoint:String ){
   print ("")
        
        let link = "https://digimon-api.vercel.app/api"
//    1step :
       if let url = URL(string: link + endPoint){
//    srep2 : URL Session
           let session = URLSession(configuration: .default)
//    step3 : URL session task
           let task = session.dataTask(with: url) { data, response, error in
          if let error = error {
         print("Error",error.localizedDescription)
                                 
         }else{
         print("DO WE HAVE DATA",data)
         if let storeddata = data {
         let decoder = JSONDecoder()
              //                      used do becuse the error
         do {
                                
         let getCodeData = try decoder.decode([Digmon].self, from: storeddata)
        self.digmonInformation = getCodeData
        DispatchQueue.main.async {
                                             
        self.TableView.reloadData()
//
//                                             self.namelabel.text = getCodeData [0].name
//                                             self.levell.text = getCodeData [0].level
        if let imgeDesplay = URL(string: getCodeData[0].img){
        let data = try? Data(contentsOf: imgeDesplay)
        if let data = data {
        let image1 = UIImage(data: data)
//                                                     self.image.image = image1
        }
        }
                                             
        }
        print("Decoded data" , getCodeData[0])
                                         
        } catch {
        print("somthing went wrong" , error.localizedDescription)
                                     }
                                 
                             }
                         }
           }
               task.resume()
    
}

    }
    }
   extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = digmonInformation[indexPath.row].name
        content.secondaryText = digmonInformation [indexPath.row].level
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        
        if let digmonImage = URL (string: self.digmonInformation[indexPath.row].img){
            DispatchQueue.global().async {
                if let digmoImageData = try? Data(contentsOf: digmonImage) {
                    let digmoImage = UIImage(data: digmoImageData)
                    DispatchQueue.main.async {
                        content.image = digmoImage
                        cell.contentConfiguration = content
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
