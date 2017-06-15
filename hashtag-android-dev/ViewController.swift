import UIKit

class ViewController: UIViewController {
    
    let feedService = FeedService()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("feedService.fetchFeed() should fetch an access token and fetch the feed")
        feedService.fetchFeed() { feedItems in
            print("feedItems fetched, count: " + String(feedItems.count))
            
            print("feedService.fetchFeed() should re-use the access token now")
            self.feedService.fetchFeed() { feedItems in
                print("feedItems fetched, count: " + String(feedItems.count))
            }
        }
    }
}

