//
//  ViewController.swift
//  JawaherAbuLahsah_NetWorking
//
//  Created by Jawaher Mohammad on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableDigimon: UITableView!
    //we have array in JSON , we need to create array with struct type to add data to it
    var digimons = [Digimon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
       
    }
    //here I create a function to get data
    func getData(){
        //we want the URL API data
        let url = URL(string: "https://digimon-api.vercel.app/api/digimon")
        //optional binding
        if let url = url {
            //create a session to make requests -> downloading data
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respon, error in
                
                       if let error = error {
                           //if something wrong
                           print("ERROR")
                       }else{
                           //use data
                           if let data = data {
                               
                               do {
                                   
                                   let decoder = JSONDecoder()
                                   let getDigimon = try decoder.decode([Digimon].self , from: data)
                                  
                                   //add data to digimons array
                                   self.digimons = getDigimon
                                   //main thread
                                  DispatchQueue.main.async {
                                       //to show data in table view
                                       self.tableDigimon.reloadData()
                                   }
                                
                               } catch  {
                                   //if something wrong
                                   print("ERROR")
                               }
                           }
                       }
                   }
            task.resume()
        }
       
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digimons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellCustomView
        cell.nameDigimon.text = digimons[indexPath.row].name
        cell.levelDigimon.text = digimons[indexPath.row].level
        
        cell.imageDigimon.image = nil
        
        
        
        //downloaded image
        let urlImage = URL(string: digimons[indexPath.row].img)
        
        if let urlImage = urlImage {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: urlImage){
                    DispatchQueue.main.async {
                        //Check if the current cell is displayed
                        if tableView.cellForRow(at: indexPath) != nil {
                            cell.imageDigimon.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
