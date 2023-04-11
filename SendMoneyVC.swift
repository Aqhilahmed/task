//
//  SendMoneyVC.swift
//  TayseerCompanyProject
//
//  Created by Macbook pro on 11/04/23.
//

import UIKit

//{"payload":{"pCountryId":244,"sCountryId":245,"systemId":19}}
//API: https://devapi.paysii.com:4095/orm/lookups/getsendingcountryconfig

class SendMoneyVC: UIViewController {

    @IBOutlet weak var sendCountryTxt: UITextField!
    @IBOutlet weak var payimgCountryTxt: UITextField!
    @IBOutlet weak var sendingAmountTxt: UITextField!
    @IBOutlet weak var receivableAmountTxt: UITextField!
    @IBOutlet weak var AmountToReceiveTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func sendMoneyAction(_ sender: UIButton) {
        
    }
    
}
