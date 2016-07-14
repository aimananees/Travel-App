//
//  DetaitViewController.swift
//  FlyDubai
//
//  Created by Aiman Abdullah Anees on 09/07/16.
//  Copyright © 2016 Aiman Abdullah Anees. All rights reserved.
//

import UIKit

class DetaitViewController: UIViewController {

    @IBOutlet var TextView: UITextView!
    
    var Description = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TextView.text = Description
        
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
