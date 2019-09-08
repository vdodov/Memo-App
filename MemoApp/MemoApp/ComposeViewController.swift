//
//  ComposeViewController.swift
//  MemoApp
//
//  Created by 차수연 on 07/09/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
  
  
  //editTarget이 있다면 편집모드, 없다면 새메모
  var editTarget: Memo?
  
  
  @IBOutlet weak var memoTextView: UITextView!
  
  @IBAction func close(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func save(_ sender: Any) {
    let memo = memoTextView.text
    
    if let editTarget = editTarget {
      editTarget.content = memo
      DataManager.shared.saveContext()
    } else {
      DataManager.shared.addNewMemo(memo)
    }
    
    
    dismiss(animated: true, completion: nil)
  }
  
  

    override func viewDidLoad() {
        super.viewDidLoad()

      if let memo = editTarget {
        navigationItem.title = "메모 편집"
        memoTextView.text = memo.content
      } else {
        navigationItem.title = "새 메모"
        memoTextView.text = ""
      }
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
