import UIKit

extension UIImageView {
    
    public func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }
    
    public func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
