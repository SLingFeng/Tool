//
//  SWViewController.swift
//  Tool
//
//  Created by mac on 2021/8/3.
//

import UIKit

class SWViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let v = LFLoginInputView(leftImage: UIImage(), pl: "qwer", nil)
        v.frame = .init(x: 10, y: 100, width: 300, height: 50)
        view.addSubview(v)
        
        let rv = UIView(frame: .init(x: 0, y: 0, width: 100, height: 30))
        rv.backgroundColor = .red
        let v1 = LFLoginInputView(leftImage: UIImage(), pl: "qwer", rv)
        v1.frame = .init(x: 10, y: 160, width: 300, height: 50)
        view.addSubview(v1)
        
        let b = LFLoginMentView(titles: ["qwer", "asdf"])
        view.addSubview(b)
        b.frame = .init(x: 10, y: 210, width: 300, height: 50)
        
        // Do any additional setup after loading the view.
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
