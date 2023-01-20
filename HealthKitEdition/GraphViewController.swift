//
//  GraphViewController.swift
//  HealthKitEdition
//
//  Created by Airi Furukawa on 2022/11/04.
//

import UIKit
import HealthKit
import Charts

class GraphViewController: UIViewController {
    
    
    lazy var lineChartView: LineChartView = {
            let charView = LineChartView()
                charView.backgroundColor = .white
                charView.animate(yAxisDuration: 1.5)
                return charView
    }()
    @IBOutlet weak var queryStatusLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var healthStore = UserDefaults.standard.HKHealthStore(forKey: "store")
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
                
        view.addSubview(lineChartView)
//        lineChartView.centerInSuperview()
//        lineChartView.width(to: view)
//        lineChartView.heightToWidth(of: view)
        lineChartView.translatesAutoresizingMaskIntoConstraints = true
        setData()
    }
    func setData() {
            let start = Calendar.current.date(byAdding: .month, value: -48, to: Date())
            let end = Date()
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
            let sampleType = HKQuantityType.quantityType(forIdentifier: .bodyMass)!
            
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil) {
                (query, results, error) in
                
                let samples = results as! [HKQuantitySample]
                    
                var yValues: [ChartDataEntry] = []
                var xValues: [String] = []
                var x = 0.0
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yy/M/d"
                    
                for sample in samples {
                    let y = sample.quantity.doubleValue(for: .gram()) / 1000
                    let ds = ChartDataEntry(x: x, y: y)
                    yValues.append(ds)
                    xValues.append(formatter.string(from: sample.startDate))
                    x += 1
                }
                
                DispatchQueue.main.async {
                    let set1 = LineChartDataSet(entries: yValues, label: "BodyMass")
                    let data = LineChartData(dataSet: set1)
                    self.lineChartView.data = data
                    self.lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
                }
            }
            self.healthStore?.execute(query)
        
        }
    @IBAction func getData(_ sender: Any) {
            let start = Calendar.current.date(byAdding: .month, value: -48, to: Date())
            let end = Date()
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end)
            let sampleType = HKQuantityType.quantityType(forIdentifier: .basalBodyTemperature)!
            
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil) {
                (query, results, error) in
                
                let samples = results as! [HKQuantitySample]
                    
                var buf = ""
                for sample in samples {
                    // Process each sample here.
                    let s = sample.quantity
                    print("\(String(describing: sample))")
                    
                    buf.append("\(sample.startDate) \(String(describing: s))\n")
                }
                
                DispatchQueue.main.async {
                    self.queryStatusLabel.text = "\(buf)"
                }
            }
        }
    @IBAction func onDismiss(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
}
