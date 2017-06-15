struct AccessToken {
    
    let raw: String
}

extension AccessToken {
    
    init(rawAccessToken:String) {
        self.raw = rawAccessToken
    }
    
    init(json:[String:Any?]) {
        self.raw = json["access_token"] as! String
    }
}
