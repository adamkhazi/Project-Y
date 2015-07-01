//
//  FirstViewController.swift
//  Project Y
//
//  Created by Adam Khazi on 16/05/2015.
//  Copyright (c) 2015 Adam Khazi. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate {

    // BEMSimpleLineGraph reference
    @IBOutlet weak var simpleLineGraph: BEMSimpleLineGraphView!
    
    // Line graph test points
    var points: [CGFloat] = [1.0,2.0,3.0,4.0,5.0,6.0,2.0,8.0,9.0,10.0,2.0,7.0]
    
    // Line graph test x axis labels
    var xAxis: [String] = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.simpleLineGraph.enableBezierCurve = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: BEMSimpleLineGraph delegate methods
    func numberOfPointsInLineGraph(graph: BEMSimpleLineGraphView) -> Int {
        return 12
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, valueForPointAtIndex index: Int) -> CGFloat {
        return points[index]
    }
    
    func lineGraph(graph: BEMSimpleLineGraphView, labelOnXAxisForIndex index: Int) -> String {
        return xAxis[index]
    }
}

