//
//  ChainingPromises.swift
//  Promises-Demo
//
//  Created by Andrew on 8/29/20.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit
import PromiseKit

class ChainingPromises: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoId: UILabel!
    
    let networker = Networker()
    var todoList: [Todo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getSingleTodoUsingPromiseChainig()
    }
    // Chaining Promises
    func getSingleTodoUsingPromiseChainig(){
        networker.promiseFetchAllTodos().then { [weak self] todoArray -> Promise<Todo> in
            self?.todoList = todoArray
            
            guard let firstTodoId = todoArray.first?.id,
                  let fetchFiristTodo = self?.networker.promiseFetchFirstTodo(todoID: firstTodoId) else {fatalError()}
            print(fetchFiristTodo)
            return fetchFiristTodo
          }
          .done { todo in
            self.todoTitle.text = todo.title
            self.todoId.text = String(describing: todo.id)
          }
          .catch { error in

          }
          .finally {
            self.activityIndicator.stopAnimating()
          }
    }
}
