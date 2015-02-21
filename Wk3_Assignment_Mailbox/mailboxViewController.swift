//
//  mailboxViewController.swift
//  Wk3_Assignment_Mailbox
//
//  Created by Bryan Leung on 2/21/15.
//  Copyright (c) 2015 Bryan Leung. All rights reserved.
//

import UIKit

class mailboxViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var singleMessage: UIImageView!
    @IBOutlet weak var listFeed: UIImageView!
    @IBOutlet weak var rightIcon: UIImageView!
    @IBOutlet weak var leftIcon: UIImageView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var rescheduleView: UIView!
    @IBOutlet weak var listView: UIView!
    
    
    var iconList = UIImage(named: "list_icon")
    var iconArchive = UIImage(named: "archive_icon")
    var iconDelete = UIImage(named: "delete_icon")
    var iconLater = UIImage(named: "later_icon")
    
    var colorYellow = UIColor(red: 254/255, green: 221/255, blue: 86/255, alpha: 1)
    var colorBrown = UIColor(red: 216/255, green: 166/255, blue: 117/255, alpha: 1)
    var colorGreen = UIColor(red: 98/255, green: 271/255, blue: 98/255, alpha: 1)
    var colorRed = UIColor(red: 234/255, green: 84/255, blue: 12/255, alpha: 1)
    var colorGrey = UIColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)

    var originalListFeedCenter: CGPoint!
    var originalmessageContainerCenter: CGPoint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width:320, height:1356)
        singleMessage.userInteractionEnabled = true
        originalmessageContainerCenter = messageContainer.center
        originalListFeedCenter = listFeed.center

        
        rescheduleView.alpha = 0
        rescheduleView.hidden = true
        listView.alpha = 0
        listView.hidden = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        var location = sender.locationInView(view)
        
        if (sender.state == UIGestureRecognizerState.Began){
            resetMessagePosition()
            resetLeftRightIcons()

            
        } else if (sender.state == UIGestureRecognizerState.Changed) {
            
            singleMessage.center.x = 160 + translation.x
            
            rightIcon.alpha = -1 * translation.x / 60
            leftIcon.alpha = translation.x / 60
            
            if (singleMessage.center.x < 100 && singleMessage.center.x > -50){
                rightIcon.center.x = 350 + translation.x
                rightIcon.image = iconLater
                messageContainer.backgroundColor = colorYellow
            }
            else if(singleMessage.center.x < -50){
                rightIcon.center.x = 350 + translation.x
                rightIcon.image = iconList
                 messageContainer.backgroundColor = colorBrown
            }
            else if(singleMessage.center.x > 220 && singleMessage.center.x < 370){
                leftIcon.center.x = -30 + translation.x
                leftIcon.image = iconArchive
                messageContainer.backgroundColor = colorGreen
            }
            else if(singleMessage.center.x > 370){
                leftIcon.center.x = -30 + translation.x
                leftIcon.image = iconDelete
                messageContainer.backgroundColor = colorRed
            }
            else{
                messageContainer.backgroundColor = colorGrey
            }
            
            println(singleMessage.center.x)
            
        } else if (sender.state == UIGestureRecognizerState.Ended){
            resetLeftRightIcons()
            
            if (singleMessage.center.x < 100 && singleMessage.center.x > -50){
                rescheduleView.hidden = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = -160
                    self.rescheduleView.alpha = 1
                })
            }
            else if(singleMessage.center.x < -50){
                listView.hidden = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = -160
                    self.listView.alpha = 1
                })
            }
            else if(singleMessage.center.x > 220){
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.singleMessage.center.x = 480
                    self.hidesMessage()
                })
            }
            else{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.singleMessage.center.x = 160
            })
            }
            
        }
    }
    
    func resetLeftRightIcons(){
        rightIcon.center.x = 290
        rightIcon.image = iconLater
        leftIcon.center.x = 30
        leftIcon.image = iconArchive
        rightIcon.alpha = 0
        leftIcon.alpha = 0
    }
    
    func resetMessagePosition(){
        singleMessage.center.x = 160
        listFeed.center.y = originalListFeedCenter.y
        messageContainer.center.y = originalmessageContainerCenter.y

    }
    
    func hidesMessage(){
        self.listFeed.center.y -= self.singleMessage.frame.height
        self.messageContainer.center.y -= self.singleMessage.frame.height
    }
    
    @IBAction func didPressRescheduleButton(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.rescheduleView.alpha = 0
            self.hidesMessage()
        })
        rescheduleView.hidden = true
    }
    
    @IBAction func didPressListButton(sender: AnyObject) {
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.listView.alpha = 0
           self.hidesMessage()
        })
        listView.hidden = true
        
    }
    
    
    

}
