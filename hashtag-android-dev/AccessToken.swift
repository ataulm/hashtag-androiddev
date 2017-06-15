struct AccessToken {
    
    let accessToken: String
}

extension AccessToken {
    
    init(rawAccessToken:String) {
        self.accessToken = rawAccessToken
    }
    
    init(json:[String:Any?]) {
        self.accessToken = json["access_token"] as! String
    }
}
