//
//  Page2SwiftUIViewController.swift
//  CSV
//
//  Created by Cristina Richter on 12.01.2023.
//

import UIKit
import SwiftUI

class Page2SwiftUIViewController: UIViewController {
    
    @IBOutlet weak var theContainer : UIView!

    override func viewDidLoad() { //constructor
        super.viewDidLoad()

        let childView = UIHostingController(rootView: Page2SwiftUIView())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)
        
        //https://www.youtube.com/watch?v=NubKNnuMFio
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
