//
//  ViewController.swift
//  TayseerCompanyProject
//
//  Created by mohammed aqhil ahmed  on 10/04/23.
//

import UIKit

struct ApiPoint{
    static let apidata = "https://devapi.paysii.com:4095/orm/lookups/getsendingcountries"
    static let sendData = "https://devapi.paysii.com:4095/orm/lookups/getsendingcountryconfig"
}

class ViewController: UIViewController {

    @IBOutlet weak var checkRateButton: UIButton!
    
    var results: [Result] = [Result]()
    var payload : Payload?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func checkRateButtonAction(_ sender: UIButton) {
        getApiData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)  {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryDisplayVC") as? CountryDisplayVC
            vc?.results = self.results
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func getApiData(){
        var urlRequest = URLRequest(url: URL(string :ApiPoint.apidata)!)
        urlRequest.httpMethod = "POST"
        let dict = ["payload":["systemId":19]]
        do {
            let jsonData = try? JSONSerialization.data(withJSONObject: dict)
            urlRequest.httpBody = jsonData
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { datas, response, error in
            debugPrint(datas!)
            
            guard let data = datas else {
                print(String(describing: error))
                return
            }
            
            if (data != nil && data.count != 0){
                let response = String(data: data, encoding: .utf8)
                debugPrint(response!)
                do {
                    let vehicleRes = try JSONDecoder().decode(DataClass.self, from: data)
                    debugPrint("res", vehicleRes)
                    self.results = vehicleRes.payload.result
                    
//                    DispatchQueue.main.asyncAfter(deadline: 2.0, execute: .) {
//                        self.countryListTV.reloadData()
//                    }
                    
                }
                catch {
                    debugPrint("error", error)
                }
            }
            
        }.resume()
    }

}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
