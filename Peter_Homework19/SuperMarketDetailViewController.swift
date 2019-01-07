//
//  SuperMarketDetailViewController.swift
//  Peter_Homework19
//
//  Created by 陳庭楷 on 2019/1/2.
//  Copyright © 2019 TingKai. All rights reserved.
//

import UIKit

class SuperMarketDetailViewController: UIViewController {

    var superMarket: Results?
    
    @IBOutlet var marketTitle: UILabel!
    
    @IBOutlet var marketAddress: UILabel!
    
    @IBOutlet var marketDescription: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.marketTitle.text = self.superMarket?.stitle
        
        self.marketAddress.text = self.superMarket?.xAddress
        
        self.marketDescription.text = self.superMarket?.xbody
        
    }

}
