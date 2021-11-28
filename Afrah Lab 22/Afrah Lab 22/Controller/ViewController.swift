//
//  ViewController.swift
//  Afrah Lab 22
//
//  Created by Afrah Omar on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    var digimons = [Digimon]()
    

    @IBOutlet weak var tabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                getData()
        
    }
    // 1. create url
    func getData(){
        let url = URL(string: "https://digimon-api.vercel.app/api/digimon")
        if let url = url {
            //2. create a URL Session
            let session = URLSession(configuration: .default)
            //3 create a task
            let task = session.dataTask(with: url) { data, respon, error in
                       if let error = error {
                           print("ERROR")
                       }else{
                           if let data = data {
                               do {
                                   let decoder = JSONDecoder()
                                   let getDigimon = try decoder.decode([Digimon].self , from: data)
                                   self.digimons = getDigimon
                                  DispatchQueue.main.async {
                                       self.tabelView.reloadData()
                                   }
                               } catch  {
                                   print("ERROR")
                               }
                           }
                       }
                   }
            //4. start/resume the task
            task.resume()
        }

    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digimons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellTableView
        cell.nameDigmonLabel.text = digimons[indexPath.row].name
        cell.levelDigmonLabel.text = digimons[indexPath.row].level
        let imgURL = URL(string: self.digimons[indexPath.row].img)!
                        DispatchQueue.global().async {
                            if  let dataa = try? Data(contentsOf: imgURL){
                                DispatchQueue.main.async {
                                    cell.imgDigmon.image = UIImage(data: dataa)

                                }
                            }
                        }
        return cell
            }

            func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 150
            }
}
                
