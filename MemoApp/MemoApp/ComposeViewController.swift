//
//  ComposeViewController.swift
//  MemoApp
//
//  Created by 차수연 on 07/09/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
  
  
  @IBOutlet weak var memoTextView: UITextView!
  
  @IBAction func close(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func save(_ sender: Any) {
    let memo = memoTextView.text
    
    let newMemo = Memo(content: memo ?? "")
    Memo.dummyMemoList.append(newMemo)
    
    dismiss(animated: true, completion: nil)
  }
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

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
