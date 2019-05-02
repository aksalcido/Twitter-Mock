//
//  url.swift
//  Twitter
//
//  Created by Armando Salcido on 4/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

enum Url: String {
    case TwitterAPI_url = "https://api.twitter.com"
    case HomeTimeline = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    case TokenRequest = "https://api.twitter.com/oauth/request_token"
    case StatusUpdate = "https://api.twitter.com/1.1/statuses/update.json"
    case TwitterCallBack = "alamoTwitter://oauth"
}
