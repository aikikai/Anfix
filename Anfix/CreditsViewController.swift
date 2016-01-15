//
//  CreditsViewController.swift
//  Anfix
//
//  Created by LUCIANO WEHRLI on 12/1/16.
//  Copyright © 2016 LUCIANO WEHRLI. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    @IBOutlet var close: UIButton!

    @IBOutlet weak var creditsFooter: UILabel!
    @IBOutlet weak var creditsContent: UITextView!
    @IBOutlet weak var creditsTitle: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        creditsTitle.text = NSLocalizedString("credits_title", comment: "")
        creditsFooter.text = NSLocalizedString("credits_footer", comment: "")
        creditsContent.text = NSLocalizedString("credits_content", comment: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closeController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
