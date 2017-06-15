import Foundation

class FeedService {

    private func fetchNewAccessToken() {
        
    }
    
    private func getCachedAccessToken() -> AccessToken? {
        return nil
    }
    
    private func cacheAccessToken(accessToken: AccessToken) {
        
    }
}

struct AccessToken {
    
    let accessToken: String
}

extension AccessToken {
    
    init(json:[String:Any]) {
        // QUESTION: what if the access_token is not present, can I throw an exception?
        self.accessToken = json["access_token"] as! String
    }
}

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
