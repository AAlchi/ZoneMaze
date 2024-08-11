//
//  Manager.swift
//  ZoneMaze
//
//  Created by Ali AI on 8/9/24.
//

import Foundation
import FirebaseDatabase

struct MessageData: Hashable {
    var person: Int
    var message: String
    var time: Date
}

class Manager: ObservableObject {
    @Published var messages: [MessageData] = []
    @Published var isLoading = true
    @Published var chatId: String = ""
    
    var ref = Database.database().reference()
    
    init() {
        assignChatId()
    }
    
    
    func sendMessage(text: String) {
        
    }
    
    func createChat(id: String, data: [String: Any]) {
        var didCreate = false
         
        
        
        if !didCreate {
            self.ref.child(id).setValue(data) { error, _ in
                if let error = error {
                    print("An error happened")
                } else {
                    self.chatId = id
                    self.isLoading = false
                    didCreate = true
                }
            }
        }
    }
    
    func assignChatId() {
        print("ohg")
        ref.observeSingleEvent(of: .value) { snapshot in
            var didFind = false
            var datas: [String: Any] = [:]
            
            for i in snapshot.children {
                if let childSnapshot = i as? DataSnapshot,
                   let dictionary = childSnapshot.value as? [String: Any],
                   let numberOfPeople = dictionary["numberOfPeople"] as? Int,
                   let messages = dictionary["messages"] as? [String: Any],
                   numberOfPeople == 1 {
                    
                    datas = [
                        "numberOfPeople": 2,
                        "messages": [messages]
                    ]
                    self.chatId = childSnapshot.key
                    didFind = true
                    self.isLoading = false
                     
                }
            }
            
            if !didFind {
                
                datas = [
                    "numberOfPeople": 2,
                    "messages": []
                ]
                
            }
            
            self.createChat(id: UUID().uuidString, data: datas)
        } withCancel: { error in
            print("Error")
        }
    }
}
 
