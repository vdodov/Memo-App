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
  
  var willShowToken: NSObjectProtocol?
  var willHideToken: NSObjectProtocol?
  
  deinit {
    if let token = willShowToken {
      NotificationCenter.default.removeObserver(token)
    }
    if let token = willHideToken {
      NotificationCenter.default.removeObserver(token)
    }
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
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.memoTextView.endEditing(true)
    print("Hi")
    
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
      
      willShowToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
        guard let strongSelf = self else { return }
        
        if let frame = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
          let height = frame.cgRectValue.height
          
          var inset = strongSelf.memoTextView.contentInset
          inset.bottom = height
          strongSelf.memoTextView.contentInset = inset
          
          inset = strongSelf.memoTextView.scrollIndicatorInsets
          inset.bottom = height
          strongSelf.memoTextView.scrollIndicatorInsets = inset
    
        }
      })
      
      
      willHideToken = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main, using: { [weak self] (noti) in
        guard let strongSelf = self else { return }
        
        var inset = strongSelf.memoTextView.contentInset
        inset.bottom = 0
        strongSelf.memoTextView.contentInset = inset
        
        inset = strongSelf.memoTextView.scrollIndicatorInsets
        inset.bottom = 0
        strongSelf.memoTextView.scrollIndicatorInsets = inset
        
      })
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    memoTextView.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    memoTextView.resignFirstResponder()
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
