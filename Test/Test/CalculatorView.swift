// CalculatorView.swift
// as seen in http://nshipster.com/ibinspectable-ibdesignable/
//
// (c) 2015 Nate Cook, licensed under the MIT license

import UIKit

/// The alignment for drawing an String inside a bounding rectangle.
enum NCStringAlignment {
    case LeftTop
    case CenterTop
    case RightTop
    case LeftCenter
    case Center
    case RightCenter
    case LeftBottom
    case CenterBottom
    case RightBottom
}

extension String {
    /// Draw the `String` inside the bounding rectangle with a given alignment.
    func drawAtPointInRect(rect: CGRect, withAttributes attributes: [String: AnyObject]?, andAlignment alignment: NCStringAlignment) {
        let size = self.size(attributes: attributes)
        let x, y: CGFloat
        
        switch alignment {
        case .LeftTop, .LeftCenter, .LeftBottom:
            x = rect.minX
        case .CenterTop, .Center, .CenterBottom:
            x = rect.midX - size.width / 2
        case .RightTop, .RightCenter, .RightBottom:
            x = rect.maxX - size.width
        }
        
        switch alignment {
        case .LeftTop, .CenterTop, .RightTop:
            y = rect.minY
        case .LeftCenter, .Center, .RightCenter:
            y = rect.midY - size.height / 2
        case .LeftBottom, .CenterBottom, .RightBottom:
            y = rect.maxY - size.height
        }
        
        self.draw(at: CGPoint(x: x, y: y), withAttributes: attributes)
    }
}

extension CGRect {
    /// Convert a rect to a pixel-aligned version, rounding position and size
    func pixelAligned() -> CGRect {
        return CGRect(x: round(origin.x), y: round(origin.y),
                      width: round(size.width), height: round(size.height))
    }
}

@IBDesignable
class CalculatorView: UIView {
    
    let (columns, rows) = (4, 6) as (CGFloat, CGFloat)
    
    // basic buttons: all 1x1 unit
    let buttonRows = [ ["C", "=", "/", "*"], ["7", "8", "9", "-"], ["4", "5", "6", "+"], ["1", "2", "3"] ]
    
    // special cases: non-square or out of position
    let specialButtons = [("=", CGPoint(x: 3, y: 4), CGSize(width: 1, height: 2)),
                          ("0", CGPoint(x: 0, y: 5), CGSize(width: 2, height: 1)),
                          (".", CGPoint(x: 2, y: 5), CGSize(width: 1, height: 1))]
    
    // MARK: - IBInspectable
    
    @IBInspectable var faceColor: UIColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
    
    @IBInspectable var textColor: UIColor = UIColor.black
    @IBInspectable var textSize: CGFloat = 12
    
    @IBInspectable var buttonColor: UIColor = UIColor.white
    @IBInspectable var edgeColor: UIColor = UIColor.black
    @IBInspectable var edgeWidth: CGFloat = 1
    
    @IBInspectable var shadowColor: UIColor = UIColor.black
    @IBInspectable var shadowOffset: CGFloat = 2
    
    @IBInspectable var cornerRadius: CGFloat = 7
    
    @IBInspectable var paddingX: CGFloat = 7
    @IBInspectable var paddingY: CGFloat = 8
    @IBInspectable var spacingX: CGFloat = 3
    @IBInspectable var spacingY: CGFloat = 5
    
    @IBInspectable var titleHeight: CGFloat = 20
    @IBInspectable var titleColor: UIColor = UIColor.white
    @IBInspectable var titleBarColor: UIColor = UIColor.black
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        
        // initial drawing setup
        
        // determine unit height/width from view size, padding and button spacing
        let unitHeight = (bounds.height - 2 * paddingY - (rows - 1) * spacingY - titleHeight) / rows
        let unitWidth = (bounds.width - 2 * paddingX - (columns - 1) * spacingX) / columns
        
        // set up text attributes
        let textFont = UIFont.systemFont(ofSize: textSize)
        let textAttributes = [NSFontAttributeName: textFont, NSForegroundColorAttributeName: textColor] as [String : Any]
        
        // get the graphics context
        let context = UIGraphicsGetCurrentContext()
        
        
        // helper functions
        
        // maps a point and size (in units) to an actual rect in the view's coordinates for drawing
        func rectForPosition(position: CGPoint, andSize size: CGSize) -> CGRect {
            let x       = paddingX + unitWidth * position.x + spacingX * position.x
            let y       = titleHeight + paddingY + unitHeight * position.y + spacingY * position.y
            let width   = size.width * unitWidth + (size.width - 1) * spacingX
            let height  = size.height * unitHeight + (size.height - 1) * spacingY
            
            return CGRect(x: x, y: y, width: width, height: height).pixelAligned()
        }
        
        // draw a button in the specified rect
        func drawButtonInRect(rect: CGRect, withText text: String) {
            shadowColor.setFill()
            UIRectFill(rect.offsetBy(dx: shadowOffset, dy: shadowOffset))
            
            buttonColor.setFill()
            edgeColor.setStroke()
            context!.setLineWidth(edgeWidth)
            UIRectFill(rect)
            UIRectFrame(rect)
            
            var textRect = rect
            if textRect.width != unitWidth {
                textRect.size.width = unitWidth
            }
            if textRect.height != unitHeight {
                textRect.origin.y = textRect.maxY - unitHeight
                textRect.size.height = unitHeight
            }
            text.drawAtPointInRect(rect: textRect, withAttributes: textAttributes as [String : AnyObject]?, andAlignment: .Center)
        }
        
        // draw the display
        func drawDisplayInRect(rect: CGRect, withText text: String) {
            buttonColor.setFill()
            edgeColor.setStroke()
            context!.setLineWidth(edgeWidth)
            UIRectFill(rect)
            UIRectFrame(rect)
            
            text.drawAtPointInRect(rect: rect.offsetBy(dx: unitWidth / -3, dy: 0), withAttributes: textAttributes as [String : AnyObject]?, andAlignment: .RightCenter)
        }
        
        
        // calculator "window" - paint the color of the title bar
        let window = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        titleBarColor.setFill()
        window.fill()
        
        // center the title in the title bar
        let title = "Calculator"
        let (titleRect, _) = bounds.divided(atDistance: titleHeight, from: CGRectEdge.minYEdge)
        let titleAttributes = [NSFontAttributeName: UIFont.boldSystemFont(ofSize: textSize + 2), NSForegroundColorAttributeName: titleColor] as [String : Any]
        title.drawAtPointInRect(rect: titleRect, withAttributes: titleAttributes as [String : AnyObject]?, andAlignment: .Center)
        
        // calculator "face" - covers most of the window
        let face = UIBezierPath(roundedRect: bounds.insetBy(dx: 0, dy: titleHeight / 2).offsetBy(dx: 0, dy: titleHeight / 2), cornerRadius: cornerRadius)
        faceColor.setFill()
        face.fill()
        
        // draw the display
        let displayRect = rectForPosition(position: CGPoint(x: 0, y: 0), andSize: CGSize(width: 4, height: 1))
        drawDisplayInRect(rect: displayRect, withText: "3")
        
        // draw basic buttons
        for (rowNumber, row) in buttonRows.enumerated() {
            for (columnNumber, text) in row.enumerated() {
                drawButtonInRect(rect: rectForPosition(position: CGPoint(x: columnNumber, y: rowNumber + 1), andSize: CGSize(width: 1, height: 1)), withText: text)
            }
        }
        
        // draw special buttons
        for buttonInfo in specialButtons {
            drawButtonInRect(rect: rectForPosition(position: buttonInfo.1, andSize: buttonInfo.2), withText: buttonInfo.0)
        }
    }
}
