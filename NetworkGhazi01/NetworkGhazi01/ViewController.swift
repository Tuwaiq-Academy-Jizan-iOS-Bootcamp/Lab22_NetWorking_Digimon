//
//  ViewController.swift
//  NetworkGhazi01
//
//  Created by ماك بوك on 20/04/1443 AH.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var digmonLevel: UILabel!
    @IBOutlet weak var digmonName: UILabel!
    @IBOutlet weak var digmonImage: UIImageView!
    @IBOutlet weak var digmonTabel: UITableView!
    var digmonDataAPI = [Digmon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        digmonsData {
            self.digmonTabel.reloadData()
            if let digoImageData = URL(string: self.digmonDataAPI[0].img) {
                if let imageData = try? Data(contentsOf: digoImageData) {
                    self.digmonImage.image = UIImage(data: imageData)
                }
            }
            self.digmonName.text = self.digmonDataAPI[0].name
            self.digmonLevel.text = self.digmonDataAPI[0].level
        }
        digmonTabel.delegate = self
        digmonTabel.dataSource = self
    }
    //func to download data by @escaping
    func digmonsData(download: @escaping () -> ()) {
        if let urlResponce = URL(string:"https://digimon-api.vercel.app/api/digimon") {
            let urlSession = URLSession(configuration: .default)
            let urlTask = urlSession.dataTask(with: urlResponce) { data, response, error in
                if let error = error {
                    print("Error in the begening | The URL is bad",error.localizedDescription)
                }else {
                    if let digmoData = data {
                        // first do
                        do {
                            let decorder = JSONDecoder()
                            self.digmonDataAPI = try decorder.decode([Digmon].self, from: digmoData)
                            DispatchQueue.main.async {
                                download()
                            }
                            //catch if the is something
                        } catch {
                            print("Somthing wrong at end | The data not the same", error.localizedDescription)
                        }
                    }
                }
            }
            urlTask.resume()
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return digmonDataAPI.count
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let digmonCell = digmonTabel.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var digmonCellContain = digmonCell.defaultContentConfiguration()
        //        digmonCellContain.image = UIImage(data: digmonDataAPI[indexPath.row].img)
        if let digoImageData = URL(string: self.digmonDataAPI[indexPath.row].img) {
            if let imageData = try? Data(contentsOf: digoImageData) {
                digmonCellContain.image = UIImage(data: imageData)
            }
        }
        digmonCellContain.imageProperties.maximumSize = CGSize(width: 90, height: 80)
        digmonCellContain.text = digmonDataAPI[indexPath.row].name
        digmonCellContain.secondaryText = digmonDataAPI[indexPath.row].level
        digmonCell.contentConfiguration = digmonCellContain
        return digmonCell
    }
}

