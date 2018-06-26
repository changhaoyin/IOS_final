//
//  ConceptViewController.swift
//  FinalProject
//
//  Created by user_18 on 2017/6/17.
//  Copyright © 2017年 com.alverson_22. All rights reserved.
//

import UIKit

class ConceptViewController: UIViewController {
    
    var paidList = [[String:String]]()
    var maxPaid = [String:String]()
    

   
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var avgLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewDidLoad()
    }
    
    func getAddProductNoti(noti:Notification) {
        let m_paidList = noti.userInfo as? [String:String]
        
        paidList.insert(m_paidList!, at: 0)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("paidList.txt")
        (paidList as NSArray).write(to: url!, atomically: true)
        
        
        //tableView.reloadData()
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var total = 0,count = 0
        var avg = 0,max = 0,index = 0
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("paidList.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            paidList = array as! [[String:String]]
        }
        
        let notiName = Notification.Name("AddPaidList")
        NotificationCenter.default.addObserver(self, selector: #selector(AccountTableViewController.getAddProductNoti(noti:)), name: notiName, object: nil)
        // Do any additional setup after loading the view.
        for paid in paidList {
            if Int(paid["paid"]!) != nil {
                total += Int(paid["paid"]!)!
            }
            count += 1
            if Int(paid["paid"]!)! > max {
                index = count
                index = index - 1
                max = Int(paid["paid"]!)!
            }
        }
        if count != 0 {
        avg = total/count
      //totalLabel.text = String(total) + "$"
        avgLabel.text = String(avg) + "年"
        countLabel.text = String(count)
        let url2 = docUrl?.appendingPathComponent(paidList[index]["photo"]!)
        print(index)
        maxPaid = paidList[index]
        productImage.image = UIImage(contentsOfFile: url2!.path)
        dateLabel.text = maxPaid["date"];
        productLabel.text = maxPaid["product"]
        paidLabel.text = maxPaid["paid"]! + "年"
        }
        else{
            //totalLabel.text = "0$"
            avgLabel.text = "0"
            productImage.image = UIImage(named: "nothing")
            dateLabel.text = "查無資料";
            dateLabel.textColor=UIColor(displayP3Red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
            dateLabel.font=UIFont.systemFont(ofSize:20)
            productLabel.text = ""
            paidLabel.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
