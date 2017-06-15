struct AccessToken {
    
    let accessToken: String
}

extension AccessToken {
    
    init(rawAccessToken:String) {
        self.accessToken = rawAccessToken
    }
    
    init(json:[String:Any]) {
        // QUESTION: what if the access_token is not present, can I throw an exception?
        self.accessToken = json["access_token"] as! String
    }
}
