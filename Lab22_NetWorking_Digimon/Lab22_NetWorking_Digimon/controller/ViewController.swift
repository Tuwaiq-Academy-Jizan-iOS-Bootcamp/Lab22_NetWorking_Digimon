//
//  ViewController.swift
//  Lab22_NetWorking_Digimon
//
//  Created by Ahmad Barqi on 19/04/1443 AH.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getData(with: "/digimon")
    }

    func getData(with endPoint:String){
        print("Is this called??")
        let baseURL = "https://digimon-api.vercel.app/api"
//1. create url  اول شيء اضافة رابط
        if let url = URL(string: baseURL + endPoint) {
            print("WAS THE URL IN CORRECT FORMAT")
            //2. create a URL Session  اضافة المستوى
            let session = URLSession(configuration: .default)
            //3 create a task الخطوة التي اضيف فيها
            let task = session.dataTask(with: url) { data, response, error in
                
                if let error = error {
                    print("ERROR",error.localizedDescription)
                }else {
                    print("DO WE HAVE DATA",data)
                    if let safeData = data {
//                        print(String(data: safeData, encoding: .utf8))
                        do {
                            let decoder = JSONDecoder()
                            let decodedData = try decoder.decode([Digmon].self, from: safeData)
                            print("DECODED DATA",decodedData[0])
                        } catch {
                            print("SOMETHING WENT WRONG",error.localizedDescription)
                        }
                        
                    }
                }
            }
//4. start/resume the task الخطوة الاهم
            task.resume()
        }
    }
//    5. تاكد ان الطباعة تعمل في كل خطوة تخطيها
}
