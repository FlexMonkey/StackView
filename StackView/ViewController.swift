//
//  ViewController.swift
//  StackView
//
//  Created by Simon Gladman on 10/06/2015.
//  Copyright © 2015 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let mainStackView = UIStackView()
    let stackView = UIStackView()
    let subStackView = UIStackView()
    
    let purpleBox = UIView()
    let redBox = UIView()
    let blueBox = UIView()
    
    let grayBox = UIView()
    let yellowBox = UIView()
    let greenBox = UIView()
    
    let segmentedControl = UISegmentedControl(items: ["purple", "red", "blue", "grey", "yellow", "green"])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        view.addSubview(mainStackView)
        
        purpleBox.backgroundColor = UIColor.purpleColor()
        redBox.backgroundColor = UIColor.redColor()
        blueBox.backgroundColor = UIColor.blueColor()
        grayBox.backgroundColor = UIColor.grayColor()
        yellowBox.backgroundColor = UIColor.yellowColor()
        greenBox.backgroundColor = UIColor.greenColor()
        
        stackView.addArrangedSubview(purpleBox)
        stackView.addArrangedSubview(redBox)
        stackView.addArrangedSubview(blueBox)

        subStackView.addArrangedSubview(grayBox)
        subStackView.addArrangedSubview(yellowBox)
        subStackView.addArrangedSubview(greenBox)
        
        mainStackView.addArrangedSubview(stackView)
        stackView.addArrangedSubview(subStackView)
        
        segmentedControl.addTarget(self, action: "segmentedControlChangeHandler", forControlEvents: UIControlEvents.ValueChanged)
        segmentedControl.momentary = true
        
        mainStackView.axis = UILayoutConstraintAxis.Vertical
        mainStackView.addArrangedSubview(segmentedControl)
        
        mainStackView.distribution = UIStackViewDistribution.Fill
        stackView.distribution = UIStackViewDistribution.FillEqually
        subStackView.distribution = UIStackViewDistribution.FillEqually
    }
    
    func segmentedControlChangeHandler()
    {
        let index = segmentedControl.selectedSegmentIndex
        
        let togglingView = index <= 3 ? stackView.arrangedSubviews[index] : subStackView.arrangedSubviews[index - 3]
        
        UIView.animateWithDuration(0.25){ togglingView.hidden = !togglingView.hidden }
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        
        let top = topLayoutGuide.length
        let bottom = bottomLayoutGuide.length
        
        mainStackView.frame = CGRect(x: 0, y: top, width: view.frame.width, height: view.frame.height - top - bottom).rectByInsetting(dx: 10, dy: 10)
        
        dispatch_async(dispatch_get_main_queue())
        {
            if self.view.frame.height > self.view.frame.width
            {
                self.stackView.axis = UILayoutConstraintAxis.Vertical
                self.subStackView.axis = UILayoutConstraintAxis.Horizontal
            }
            else
            {
                self.stackView.axis = UILayoutConstraintAxis.Horizontal
                self.subStackView.axis = UILayoutConstraintAxis.Vertical
            }
        }
    }

}

