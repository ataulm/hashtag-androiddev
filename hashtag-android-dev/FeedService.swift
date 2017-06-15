class FeedService {
    
    let accessTokenRepo = AccessTokenRepository()
    let newAccessTokenFetcher = NewAccessTokenFetcher()

    private func fetchNewAccessToken() {
        newAccessTokenFetcher.fetchNewAccessToken()
    }
    
    private func getCachedAccessToken() -> AccessToken? {
        return accessTokenRepo.getCachedAccessToken()
    }
    
    private func cacheAccessToken(accessToken: AccessToken) {
        accessTokenRepo.cache(accessToken: accessToken)
    }
}

class NewAccessTokenFetcher {
    
    func fetchNewAccessToken() -> Void {
        
    }
}

class AccessTokenRepository {
    
    func getCachedAccessToken() -> AccessToken? {
        return nil
    }
    
    func cache(accessToken: AccessToken) {
        
    }
}
