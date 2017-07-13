//
//  FindLoverViewController.swift
//  TenThings
//
//  Created by kohler on 7/11/17.
//  Copyright © 2017 kohler. All rights reserved.
//

import UIKit

class FindLoverViewController: UIViewController {

    @IBOutlet weak var othersRequestsViewContainer: UIView!
    @IBOutlet weak var yourRequestsViewContainer: UIView!
    @IBOutlet weak var containerViewSegmenter: UISegmentedControl!
    
    @IBAction func containerViewSegmentTouch(_ sender: UISegmentedControl) {
        view.addSubview(getIndexedView(sender.selectedSegmentIndex))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getIndexedView(_ index:Int) -> UIView{
        switch index {
        case 0:
            return self.othersRequestsViewContainer
        case 1:
            return self.yourRequestsViewContainer
        default:
            return self.othersRequestsViewContainer
        }
    }

}
