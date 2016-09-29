//
//  ContentViewController.swift
//  outletbox
//
//  Created by angelito on 9/6/15.
//  Copyright (c) 2015 Angelito. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var pageIndex = 0
    var titleText: String!
    var subtitleText: String!
    var imageFile: String!
  
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: self.imageFile)
        titleLabel.text = self.titleText
        subtitleLabel.sizeToFit()
        subtitleLabel.text = self.subtitleText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
