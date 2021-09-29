//
//  ViewController.swift
//  moveLayerDemo
//
//  Created by Andy on 2021/9/29.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myView: UIView!
    
    @IBAction func didTapAddView(_ sender: UIButton) {
        let view = ShapedView(frame: myView.bounds)
        self.myView.addSubview(view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

