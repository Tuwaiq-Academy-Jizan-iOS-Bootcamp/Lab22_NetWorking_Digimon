//
//  ViewController.swift
//  Bushra Barakat_22
//
//  Created by Bushra Barakat on 20/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {
    var digmons: [Digmon] = []
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData(with: "/digimon")
       tableView.dataSource = self
       tableView.delegate = self
       
        
        
        
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
                            DispatchQueue.main.async {
                                self.digmons = decodedData
                                self.tableView.reloadData()
                            }
                            print("decoded data", decodedData[0])
                        }catch{
                            print("somthing went wrong",String(describing: error))
                        }
                    }
                }
            }
//          4 -
            task.resume()
        }
        
    }
      
    
}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CellViewController
        cell.digamonNameLabel.text = digmons[indexPath.row].name
        cell.digmonLevleLabel.text = digmons[indexPath.row].level

        if
        let imageURL = URL(string: digmons[indexPath.row].img) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.digmonImageView.image = image
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
