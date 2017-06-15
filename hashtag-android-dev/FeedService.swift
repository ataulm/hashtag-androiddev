import Foundation

class FeedService {
    
    // TODO: these dependencies can be passed via init
    private let accessTokenRepo = AccessTokenRepository()
    private let newAccessTokenFetcher = NewAccessTokenFetcher()
    private let feedItemsFetcher = FeedItemsFetcher()

    public func fetchFeed(onComplete:@escaping ([FeedItem]) -> ()) {
        if let accessToken = getCachedAccessToken() {
            feedItemsFetcher.fetchFeed(accessToken: accessToken) { feedItems in
                print("fetched feedItems, count: " + String(feedItems.count))
                onComplete(feedItems)
            }
        } else {
            newAccessTokenFetcher.fetchNewAccessToken() { accessToken in
                print("using new accessToken to fetch feedItems")
                self.feedItemsFetcher.fetchFeed(accessToken: accessToken) { feedItems in
                    print("fetched feedItems, count: " + String(feedItems.count))
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
    
    func fetchFeed(accessToken: AccessToken, onComplete:@escaping ([FeedItem]) -> ()) {
        onComplete([])
    }
}

private class NewAccessTokenFetcher {
    
    func fetchNewAccessToken(onComplete:@escaping (AccessToken) -> ()) {
        let accessToken = AccessToken(rawAccessToken: "TODO fetch this from the network")
        onComplete(accessToken)
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
