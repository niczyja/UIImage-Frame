//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class ImageFrameViewController : UIViewController {
    
    var container: UIView!
    var imageView: UIImageView!
    var control: UISegmentedControl!
    var modeButtons = [UIButton]()
    var imageViewLabel: UILabel!
    var imageLabel: UILabel!
    
    override func loadView() {
        super.loadView()
        
        container = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 400.0, height: 600.0))
        container.backgroundColor = .white

        imageView = UIImageView(frame: CGRect(x: 0.0, y: 220.0, width: 300.0, height: 250.0))
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "small-square")
        container.addSubview(imageView)

        control = UISegmentedControl(items: ["Small", "Big", "Horizontal", "Vertical"])
        control.frame = CGRect(origin: CGPoint(x: 0.0, y: 30.0), size: control.frame.size)
        control.addTarget(self, action: #selector(changeImage(sender:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        container.addSubview(control)
        
        var rawValue = 0
        for row in 1...4 {
            let stack = UIStackView(frame: CGRect(x: 0.0, y: 30.0 * Double(row) + 50.0, width: 330.0, height: 30.0))
            stack.axis = .horizontal
            stack.distribution = .fillEqually
            for _ in 1...3 {
                let mode = UIView.ContentMode(rawValue: rawValue)
                let button = UIButton(type: .system)
                button.setTitle(mode!.description, for: .normal)
                button.addTarget(self, action: #selector(changeContentMode(sender:)), for: .touchUpInside)
                button.isSelected = mode! == .scaleToFill
                button.tag = rawValue
                stack.addArrangedSubview(button)
                rawValue += rawValue == 2 ? 2 : 1
            }
            container.addSubview(stack)
        }
        
        imageViewLabel = UILabel(frame: CGRect(x: 0.0, y: 500.0, width: 400.0, height: 30.0))
        imageViewLabel.textAlignment = .center
        container.addSubview(imageViewLabel)

        imageLabel = UILabel(frame: CGRect(x: 0.0, y: 530.0, width: 400.0, height: 30.0))
        imageLabel.textAlignment = .center
        imageLabel.textColor = .red
        container.addSubview(imageLabel)

        view = container
        centerSubviews()

        imageViewLabel.text = "imageView.frame: \(imageView.frame.debugDescription)"
        imageLabel.text = "image.frame(in:): \(imageView.image!.frame(in: imageView))"
    }
    
    @objc func changeImage(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            imageView.image = UIImage(named: "small-square")
        case 1:
            imageView.image = UIImage(named: "big-square")
        case 2:
            imageView.image = UIImage(named: "horizontal")
        case 3:
            imageView.image = UIImage(named: "vertical")
        default:
            imageView.image = nil
        }
        imageLabel.text = "image.frame(in:): \(imageView.image!.frame(in: imageView))"
    }
    
    @objc func changeContentMode(sender: UIButton) {
        deselectButtons()
        sender.isSelected = true
        imageView.contentMode = UIView.ContentMode(rawValue: sender.tag)!
        imageLabel.text = "image.frame(in:): \(imageView.image!.frame(in: imageView))"
    }
    
    func deselectButtons() {
        for subview in view.subviews {
            for button in subview.subviews {
                (button as? UIButton)?.isSelected = false
            }
        }
    }
    
    func centerSubviews() {
        for subview in view.subviews {
            subview.frame.origin.x = view.bounds.width / 2 - subview.frame.width / 2
        }
    }
    
}

extension UIView.ContentMode: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .scaleToFill: return ".scaleToFill"
        case .scaleAspectFit: return ".scaleAspectFit"
        case .scaleAspectFill: return ".scaleAspectFill"
        case .redraw: return ".redraw"
        case .center: return ".center"
        case .top: return ".top"
        case .bottom: return ".bottom"
        case .left: return ".left"
        case .right: return ".right"
        case .topLeft: return ".topLeft"
        case .topRight: return ".topRight"
        case .bottomLeft: return ".bottomLeft"
        case .bottomRight: return ".bottomRight"
        }
    }

}

PlaygroundPage.current.liveView = ImageFrameViewController()
