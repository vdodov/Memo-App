//
//  DataManager.swift
//  MemoApp
//
//  Created by 차수연 on 08/09/2019.
//  Copyright © 2019 차수연. All rights reserved.
//

import Foundation
import CoreData


class DataManager {
  static let shared = DataManager()
  private init() { }
  
  //CoreData에서 실행하는 대부분의 작업은 Context가 담당함
  var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  //데이터를 읽어오기
  var memoList = [Memo]()
  
  func fetchMemo() {
    let request: NSFetchRequest<Memo> = Memo.fetchRequest()
    
    let sortByDataDesc = NSSortDescriptor(key: "insertDate", ascending: false)
    request.sortDescriptors = [sortByDataDesc]
    
    do {
      memoList = try mainContext.fetch(request)
    } catch {
      print(error)
    }
  }
  
  //데이터 추가하기
  func addNewMemo(_ memo: String?) {
    let newMemo = Memo(context: mainContext)
    newMemo.content = memo
    newMemo.insertDate = Date()
    
    saveContext()
  }
  
  //데이터 삭제하기
  func deleteMemo(_ memo: Memo?) {
    if let memo = memo {
      mainContext.delete(memo)
      saveContext()
    }
  }
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "MemoApp")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
