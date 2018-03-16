//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Kohei Arai on 2018/03/08.
//  Copyright © 2018年 Kohei Arai. All rights reserved.
//

import UIKit

import CoreData

extension FriendsViewController {
    
    func clearData() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            do {
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames {
                    
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
                    
                    let objects = try context.fetch(fetchRequest) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                }
                try context.save()
                
            } catch let err {
                print(err)
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {

            createSteveMessagesWithContext(context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            
            FriendsViewController.createMessage(with: "You're fired", friend: donald, minutesAgo: 5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            FriendsViewController.createMessage(with: "Love, Peace, and Joy", friend: gandhi, minutesAgo: 60 * 24, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            FriendsViewController.createMessage(with: "Please vote for me, you did for Billy!", friend: hillary, minutesAgo: 8 * 60 * 24, context: context)

            do {
                try context.save()
            } catch let err {
                print(err)
            }
        }

       
    }
    
    private func createSteveMessagesWithContext(_ context: NSManagedObjectContext) {
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        FriendsViewController.createMessage(with: "Good Morning", friend: steve,minutesAgo: 3, context: context)
        FriendsViewController.createMessage(with: "Hello How are you? Hope you are having a good morning!", friend: steve,minutesAgo: 2, context: context)
        FriendsViewController.createMessage(with: "Are you interested in buying an Apple device? We have a variety of Apple devices that will suit your needs Please make your purchase with us.", friend: steve,minutesAgo: 1, context: context)
        
        //response message
        FriendsViewController.createMessage(with: "Yes, totally looking to buy an iPhone 7.", friend: steve,minutesAgo: 1, context: context, isSender: true)
        
        FriendsViewController.createMessage(with: "Totally understand that you want the new iPhone7, but you'll have to wait until September for the new release. Sorry but thats just how apple likes to do things.", friend: steve,minutesAgo: 1, context: context)

        FriendsViewController.createMessage(with: "Absolutely, I'll just use my gigantic iPhone 6 Plus until then!!", friend: steve,minutesAgo: 1, context: context, isSender: true)

    }
    
    static func createMessage(with text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) -> Message {
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60)
        message.isSender = isSender
        
        friend.lastMessage = message
        
        return message
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        if let context = delegate?.persistentContainer.viewContext {
            let request : NSFetchRequest<NSFetchRequestResult> = Friend.fetchRequest()
            
            do {
                return try context.fetch(request) as? [Friend]
            } catch let err {
                print(err)
            }
        }
        return nil
    }
    
}








