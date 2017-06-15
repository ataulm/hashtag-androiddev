struct FeedItem {
    
    let avatarUrl: String
    let displayName: String
    let time: String
    let body: String
}

extension FeedItem {
    
    init(json:[String:Any?]) {
        self.avatarUrl = (json["user"] as! [String:Any?])["profile_image_url_https"] as! String
        self.displayName = (json["user"] as! [String:Any?])["name"] as! String
        self.time = ""
        self.body = json["text"] as! String
    }
}
