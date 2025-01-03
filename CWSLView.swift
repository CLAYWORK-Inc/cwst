import Foundation
import UIKit

class CWSLView: UIView {
  weak var parentViewController: CWSLViewController?

  let wrapper = UIView()
  var margin: CGSize = CGSize(width: 20, height: 20) {
    didSet {
      self.setNeedsLayout()
    }
  }
  var isWithinSafeArea: Bool = true {
    didSet {
      self.setNeedsLayout()
    }
  }

  init(parentViewController: CWSLViewController? = nil,
       margin: CGSize = CGSize(width: 20, height: 20),
       isWithinSafeArea: Bool = true) {
    super.init(frame: .zero)

    self.parentViewController = parentViewController
    self.margin = margin
    self.isWithinSafeArea = isWithinSafeArea
    
    self.addSubview(self.wrapper)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    var wrapperFrame = CGRect(x: self.margin.width, y: self.margin.height,
                              width: self.bounds.width - margin.width * 2,
                              height: self.bounds.height - margin.height * 2)

    if self.isWithinSafeArea {
      wrapperFrame.origin.x += self.parentViewController?.view.safeAreaInsets.left ?? 0
      wrapperFrame.origin.y += self.parentViewController?.view.safeAreaInsets.top ?? 0
      wrapperFrame.size.width -= (self.parentViewController?.view.safeAreaInsets.left ?? 0) +
                                 (self.parentViewController?.view.safeAreaInsets.right ?? 0)
      wrapperFrame.size.height -= (self.parentViewController?.view.safeAreaInsets.top ?? 0)
                                + (self.parentViewController?.view.safeAreaInsets.bottom ?? 0)
    }
    self.wrapper.frame = wrapperFrame
  }
}
