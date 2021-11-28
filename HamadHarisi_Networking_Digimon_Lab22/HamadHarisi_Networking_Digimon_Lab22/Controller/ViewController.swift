//
//  ViewController.swift
//  HamadHarisi_Networking_Digimon_Lab22
//
//  Created by حمد الحريصي on 24/11/2021.
//

import UIKit

class ViewController: UIViewController
{
 // var contact = [Digmon]()
    var digmonData = [Digmon]()
    @IBOutlet var TableViewBokimon: UITableView!
//    @IBOutlet var imageInTableView: UIImageView!
//    @IBOutlet var nameInTableView: UILabel!
//    @IBOutlet var levelInTableView: UILabel!
    
//    @IBOutlet var nameLabel: UILabel!
//    @IBOutlet var imgImageView: UIImageView!
//    @IBOutlet var levelLabel: UILabel!

    
    
   // var digmonDataAPI = [Digmon]()
    
    override func viewDidLoad() {
        getdata(with: "/digimon")
        super.viewDidLoad()
        TableViewBokimon.delegate = self
        TableViewBokimon.dataSource = self
      }
      func getdata(with endPoint : String){
        print ("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
        if let url = URL (string: baseURL + endPoint) {
          print("WAS THE URL IN CORRECT FORMAT")
          let session = URLSession(configuration: .default)
          let task = session.dataTask(with: url) { data , response, error in
            if let error = error {
              print ("ERROR", error .localizedDescription)
            }else {
              print ("DO WE HAVE DATA", data!)
              if let safeData = data {
               //  print(String(data:safeData,encoding: utf8 ))
                do {
                  let decoder = JSONDecoder()
                  let decodeData = try decoder.decode([Digmon].self , from: safeData)
                  self.digmonData = decodeData
                 // imageDigimon.image = UIImage(data: data)
                  DispatchQueue.main.async {
                    self.TableViewBokimon.reloadData()
                  }}
                catch{
                  print("SOMETHING WENT WRONG",error.localizedDescription)
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
       return digmonData.count
      }
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for:indexPath) as! DigimonCell
       cell.nameInTableView.text = digmonData[indexPath.row].name
       cell.levelInTableView.text = digmonData[indexPath.row].level
       cell.imageInTableView.image = nil
       let urlImage = URL(string: digmonData[indexPath.row].img)
       if let urlImage = urlImage {
        DispatchQueue.global().async {
         if let data = try? Data(contentsOf: urlImage){
          DispatchQueue.main.async {
           if tableView.cellForRow(at: indexPath) != nil {
            cell.imageInTableView.image = UIImage(data: data)
           }
          }
         }
        }
       }
       return cell
      }
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
      }
     }
//       override func viewDidLoad() {
//
//           super.viewDidLoad()
//           digmonsData {
//               self.TableViewBokimon.reloadData()
//               if let digoImageData = URL(string: self.digmonDataAPI[0].img)
//               {
//                   if let imageData = try? Data(contentsOf: digoImageData)
//                   {
//                   self.imageInTableView.image = UIImage(data: imageData)
//                   }
//               }
//               self.nameInTableView.text  = self.digmonDataAPI[0].name
//               self.levelInTableView.text = self.digmonDataAPI[0].level
//           }
//           TableViewBokimon.delegate   = self
//           TableViewBokimon.dataSource = self
//       }
//       //download: @escaping () -> ())
//       func digmonsData(download: @escaping () -> ()) {
//           if let urlResponce = URL(string:"https://digimon-api.vercel.app/api/digimon") {
//               let urlSession = URLSession(configuration: .default)
//               let urlTask = urlSession.dataTask(with: urlResponce) { data, response, error in
//                   if let error = error {
//                       print("Error in the begening | The URL is bad",error.localizedDescription)
//                   }else {
//                       if let digmoData = data {
//                           do {
//                               let decorder = JSONDecoder()
//                               self.digmonDataAPI = try decorder.decode([Digmon].self, from: digmoData)
//                               DispatchQueue.main.async {
//                                   download()
//                               }
//                           } catch {
//                               print("Somthing wrong at end | The data not the same", error.localizedDescription)
//                           }
//                       }
//                   }
//               }
//               urlTask.resume()
//           }
//       }
//   }
//   extension ViewController: UITableViewDelegate {
//       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//           return digmonDataAPI.count
//       }
//   }
//   extension ViewController: UITableViewDataSource {
//       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//let digmonCell = TableViewBokimon.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//           var digmonCellContain = digmonCell.defaultContentConfiguration()
//           if let digoImageData = URL(string: self.digmonDataAPI[indexPath.row].img) {
//               if let imageData = try? Data(contentsOf: digoImageData) {
//                   digmonCellContain.image = UIImage(data: imageData)
//               }
//           }
//           digmonCellContain.imageProperties.maximumSize = CGSize(width: 100, height: 100)
//           digmonCellContain.text = digmonDataAPI[indexPath.row].name
//           digmonCellContain.secondaryText = digmonDataAPI[indexPath.row].level
//           digmonCell.contentConfiguration = digmonCellContain
//           return digmonCell
//       }
//   }
