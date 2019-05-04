//
//  TweetViewController.swift
//  Twitter
//
//  Created by Armando Salcido on 5/2/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    let tweetIntroduction: String = "What's happening?"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetTextView.delegate = self
        self.tweetTextView.text = self.tweetIntroduction
        self.tweetTextView.textColor = UIColor.lightGray
        
        self.tweetTextView.selectedTextRange = self.tweetTextView.textRange(from: self.tweetTextView.beginningOfDocument, to: self.tweetTextView.beginningOfDocument)
    }
  
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = self.tweetIntroduction
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func tweet(_ sender: Any) {
        // Only run the function is text is not empty
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)}, failure: { (Error) in
                print("Error Posting Tweet! \(Error)")
            })
            
        } else {
            self.dismiss(animated: true, completion: nil)
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
