import Foundation

class FeedService {
    
    // TODO: these dependencies can be passed via init
    private let apiKey = Secrets.TWITTER_API_KEY
    private let apiSecret = Secrets.TWITTER_API_SECRET
    private let accessTokenRepo = AccessTokenRepository()
    private let newAccessTokenFetcher = NewAccessTokenFetcher()
    private let feedItemsFetcher = FeedItemsFetcher()

    public func fetchFeed(onComplete:@escaping ([FeedItem]) -> ()) {
        if let accessToken = getCachedAccessToken() {
            print("...using cached access token")
            feedItemsFetcher.fetchFeed(accessToken: accessToken) { feedItems in
                onComplete(feedItems)
            }
        } else {
            newAccessTokenFetcher.fetchNewAccessToken(apiKey: apiKey, apiSecret: apiSecret) { accessToken in
                print("...fetched new access token")
                self.cacheAccessToken(accessToken: accessToken)
                self.feedItemsFetcher.fetchFeed(accessToken: accessToken) { feedItems in
                    onComplete(feedItems)
                }
            }
        }
    }
    
    private func getCachedAccessToken() -> AccessToken? {
        return accessTokenRepo.getCachedAccessToken()
    }
    
    private func cacheAccessToken(accessToken: AccessToken) {
        accessTokenRepo.cache(accessToken: accessToken)
    }
}



private class FeedItemsFetcher {
    
    private static let ENDPOINT = URL(string: "https://api.twitter.com/statuses/user_timeline?screen_name=androiddevrtbot&include_rts=true")!
    
    func fetchFeed(accessToken: AccessToken, onComplete:@escaping ([FeedItem]) -> ()) {
        URLSession.shared.dataTask(with: createRequest(accessToken: accessToken)) {data, response, err in
            print("0")
            if data != nil {
                print("1")
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [Any] {
                    print("hello")
                    print(json)
                    print("goodbye")
                    onComplete([])
                }
            }
            print("2")
            }.resume()
    }
    
    private func createRequest(accessToken: AccessToken) -> URLRequest {
        var request = URLRequest(url: FeedItemsFetcher.ENDPOINT)
        request.httpMethod = "GET"
        request.addValue("Bearer " + accessToken.raw, forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        return request
    }
}

private class NewAccessTokenFetcher {
    
    private static let ENDPOINT = URL(string: "https://api.twitter.com/oauth2/token")!
    
    func fetchNewAccessToken(apiKey: String, apiSecret: String, onComplete:@escaping (AccessToken) -> ()) {
        URLSession.shared.dataTask(with: createRequest(apiKey: apiKey, apiSecret: apiSecret)) {data, response, err in
            if data != nil {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any?] {
                    let accessToken = AccessToken(json: json)
                    onComplete(accessToken)
                }
            }
        }.resume()
    }
    
    private func createRequest(apiKey: String, apiSecret: String) -> URLRequest {
        let urlEncodedApiKey = apiKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let urlEncodedApiSecret = apiSecret.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bearerToken = urlEncodedApiKey + ":" + urlEncodedApiSecret
        let bearerTokenCredentials = bearerToken.data(using: .utf8)!.base64EncodedString()
        
        var request = URLRequest(url: NewAccessTokenFetcher.ENDPOINT)
        request.httpMethod = "POST"
        request.addValue("Basic " + bearerTokenCredentials, forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)
        return request
    }
    
}

private class AccessTokenRepository {
    
    private var accessToken: AccessToken?
    
    func getCachedAccessToken() -> AccessToken? {
        return accessToken
    }
    
    func cache(accessToken: AccessToken) {
        self.accessToken = accessToken
    }
}
