
import UIKit

extension UIImage {
    
    public func frame(in view: UIImageView) -> CGRect {
        guard view.image == self else {
            return CGRect.zero
        }
        
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        switch view.contentMode {
        case .scaleToFill, .redraw:
            return view.bounds
        case .scaleAspectFit, .scaleAspectFill:
            guard size.width != viewWidth, size.height != viewHeight else {
                return view.bounds
            }
            
            let aspectFit = fmin(viewHeight / size.height, viewWidth / size.width)
            let aspectFill = fmax(viewHeight / size.height, viewWidth / size.width)
            let aspectRatio = view.contentMode == .scaleAspectFit ? aspectFit : aspectFill
            
            let scaledSize = CGSize(width: size.width * aspectRatio, height: size.height * aspectRatio)
            let scaledOrigin = CGPoint(x: (viewWidth - scaledSize.width) / 2, y: (viewHeight - scaledSize.height) / 2)
            
            return CGRect(origin: scaledOrigin, size: scaledSize)
        case .center:
            return CGRect(origin: CGPoint(x: (viewWidth - size.width) / 2, y: (viewHeight - size.height) / 2), size: size)
        case .top:
            return CGRect(origin: CGPoint(x: (viewWidth - size.width) / 2, y: 0.0), size: size)
        case .bottom:
            return CGRect(origin: CGPoint(x: (viewWidth - size.width) / 2, y: viewHeight - size.height), size: size)
        case .left:
            return CGRect(origin: CGPoint(x: 0.0, y: (viewHeight - size.height) / 2), size: size)
        case .right:
            return CGRect(origin: CGPoint(x: viewWidth - size.width, y: (viewHeight - size.height) / 2), size: size)
        case .topLeft:
            return CGRect(origin: CGPoint.zero, size: size)
        case .topRight:
            return CGRect(origin: CGPoint(x: viewWidth - size.width, y: 0.0), size: size)
        case .bottomLeft:
            return CGRect(origin: CGPoint(x: 0.0, y: viewHeight - size.height), size: size)
        case .bottomRight:
            return CGRect(origin: CGPoint(x: viewWidth - size.width, y: viewHeight - size.height), size: size)
        @unknown default:
            return CGRect.zero
        }
    }
    
}
