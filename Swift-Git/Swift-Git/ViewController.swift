//
//  ViewController.swift
//  Swift-Git
//
//  Created by Rafael Silva on 27/05/20.
//  Copyright © 2020 Rafael Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let api: APIRepositoryProviderProtocol = API()
        api.repositories(language: "swift", sort: "stars") { response in 
             switch response {
             case .success(let value):
                print(value)
             case .failure(let error):
                switch error {
                case ApiError.conflict:
                    print("Conflict error")
                case ApiError.forbidden:
                    print("Forbidden error")
                case ApiError.notFound:
                    print("Not found error")
                default:
                    print("Unknown error:", error)
                }
            }
        }

    }


}

