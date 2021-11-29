//
//  ViewController.swift
//  networkingDemo
//
//  Created by user on 24/11/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableViewDigmon: UITableView!
    @IBOutlet weak var nameOfDigmon: UILabel!
    @IBOutlet weak var levelOfDigmon: UILabel!
    @IBOutlet weak var imageOfDigmon: UIImageView!
    
    
    var digmonAPI = [Digmon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        digmonData(with: "/digimon")
        tableViewDigmon.delegate = self
        tableViewDigmon.dataSource = self
    }
    func digmonData(with endPoint:String) {
        print("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        // 1. create url
        if let url = URL(string:baseURL + endPoint) {
            print("WAS THE URL IN CORRECT FORMAT")
            //2. create a URL Session
            let session = URLSession(configuration: .default)
            //3 create a task
            let task = session.dataTask(with: url) { data, response, error in

                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else {
                    if let safeData = data {
                        do {
                            let decoder = JSONDecoder()
                            let decodedDigmonData = try decoder.decode([Digmon].self, from: safeData)
                            self.digmonAPI = decodedDigmonData
                            DispatchQueue.main.async {
                                self.tableViewDigmon.reloadData()
//                                if let digmonImageData = URL(string: self.digmonAPI[0].img){
//                                    if let imageData = try? Data(contentsOf: digmonImageData){
//                                        self.imageOfDigmon.image = UIImage(data: imageData)
//                                    }
//                            }
//                                self.nameOfDigmon.text = self.digmonAPI[0].name
//                                self.levelOfDigmon.text = self.digmonAPI[0].level
//                            for ele in decodedData {
//                                print(ele.name)
//                                print(ele.img)
//                                print(ele.level)
                            }
                        } catch {
                            print("SOMETHING WENT WRONG",error.localizedDescription)
                        }
                    }
                }
            }
            //4. start/resume the task
            task.resume()
        }
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonAPI.count
    }
}
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let digmonCell = tableView.dequeueReusableCell(withIdentifier: "DigmonCell", for: indexPath)
        var digmonContent = digmonCell.defaultContentConfiguration()
        digmonContent.imageProperties.maximumSize = CGSize(width: 120, height: 120)
        digmonContent.text = digmonAPI[indexPath.row].name
        digmonContent.secondaryText = digmonAPI[indexPath.row].level
        if let imageDigmonURL = URL(string: self.digmonAPI[indexPath.row].img){
            DispatchQueue.global().async {
                if let digmonImageData = try? Data(contentsOf: imageDigmonURL) {
                    let digmonImage = UIImage(data: digmonImageData)
                    DispatchQueue.main.async {
                        digmonContent.image = digmonImage
                        digmonCell.contentConfiguration = digmonContent
                    }
                }
            }
        }
        return digmonCell
    }
}
