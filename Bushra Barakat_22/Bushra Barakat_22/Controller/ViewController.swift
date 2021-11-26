//
//  ViewController.swift
//  Bushra Barakat_22
//
//  Created by Bushra Barakat on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var digmons = [Digmon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
    }

    func getData(with endPoint: String){
        print ("is this work??")
        let baseURL = "https://digimon-api.vercel.app/api"
//        1- creat url
        if let url = URL(string: baseURL + endPoint) {
            print("was the URL in correct formate")
//        2- creat a URL Session
            let session = URLSession(configuration: .default)
//        3- creat a task
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("ERROR", error.localizedDescription)
                }else {
                    print("do we have data",data)
                    if let safeData = data {
                        print(String(data: safeData, encoding: .utf8))
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            
                            print("decoded data", decodedData[0])
                        }catch{
                            print("somthing went wrong", error.localizedDescription)
                        }
                    }
                }
            }
//          4 -
            task.resume()
        }
        
    }
      
    
}
extension ViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellViewController
        cell.digamonNameLabel.text = digmons[indexPath.row].name
        cell.digmonLevleLabel.text = digmons[indexPath.row].im
        
    return cell
    }
    
    
}
