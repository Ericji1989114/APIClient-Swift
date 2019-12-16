//
//  ViewController.swift
//  APIClient-Swift
//
//  Created by Eric on 2019/12/16.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // api client
    let apiClient = APIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.apiClient.requestGetAllUsers { (result) in
                        
            switch result {
            case .success(let info):
                // view logic
                print(info)
                
            case .failure(let error):
                // error handling
                print(error)
            }
        }
        
        
    }


}

