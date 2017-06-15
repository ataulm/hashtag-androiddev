struct FeedItem {
    
    let avatarUrl: String
    let displayName: String
    let time: String
    let body: String
}

extension FeedItem {
    
    init(json:[String:Any]) {
        self.avatarUrl = ""
        self.displayName = ""
        self.time = ""
        self.body = ""
    }
}
