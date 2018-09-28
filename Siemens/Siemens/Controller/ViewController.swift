//
//  ViewController.swift
//  Siemens
//
//  Created by Ahmet Erpulat on 3.09.2018.
//  Copyright © 2018 enqura. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore
import EnquraUIKit


class ViewController: UIViewController, WKScriptMessageHandler {

    var url: URL!
    var wKWebView: WKWebView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var selectedDateLabel: SpringLabel!
    fileprivate var dateList = [Date]()
    fileprivate let MONDAY = 2
    fileprivate let SUNDAY = 1
    fileprivate let myLocale = Locale(identifier: "TR")

    @IBOutlet weak var weekDaysCollectionView: UICollectionView!
    var selectedDay: Date = Date.init()
    

    fileprivate func configureDates() {
        //ilk tarih, gecen yil ve pazartesiye kadar geri git
        let lastYearChunk = TimeChunk.init(seconds: 0, minutes: 0, hours: 0, days: 0, weeks: 0, months: 0, years: -1)
        var startDate = Date.init().add(lastYearChunk).start(of: Component.day)
        let oneDayBefore = TimeChunk.init(seconds: 0, minutes: 0, hours: 0, days: -1, weeks: 0, months: 0, years: 0)
        while startDate.weekday != MONDAY {
            startDate = startDate.add(oneDayBefore).start(of: Component.day)
        }
        
        //son tarih bugun ve pazara kadar ileri git
        var endDate: Date = Date.init()
        let oneDayLater = TimeChunk.init(seconds: 0, minutes: 0, hours: 0, days: 1, weeks: 0, months: 0, years: 0)
        while endDate.weekday != SUNDAY {
            endDate = endDate.add(oneDayLater).start(of: Component.day)
        }
        
        //ilk tarih ile son tarih arasindaki tum tarihleri listeye ekle
        while startDate.isEarlierThanOrEqual(to: endDate) {
            dateList.append(startDate)
            startDate = startDate.add(oneDayLater).start(of: Component.day)
        }
        
        for item in dateList.enumerated() {
            print(item.element)
        }
    }
    
    fileprivate func showSelectedDate() {
        print("secilen tarih: \(selectedDay) weekday:\(selectedDay.weekday)")
        self.selectedDateLabel.text = self.selectedDay.format(with: DateFormatter.Style.full, locale: self.myLocale)
        selectedDateLabel.animation = "fadeIn"
        selectedDateLabel.curve = "easeIn"
        selectedDateLabel.duration = 2.0
        selectedDateLabel.animate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        weekDaysCollectionView.delegate = self
        weekDaysCollectionView.dataSource = self
        weekDaysCollectionView.showsHorizontalScrollIndicator = false
        weekDaysCollectionView.showsVerticalScrollIndicator = false
        configureDates()
        showSelectedDate()
        
        let contentController = WKUserContentController()
        contentController.add(self, name: "callbackHandler")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        wKWebView = WKWebView(frame: createWKWebViewFrame(size: view.frame.size), configuration: config)
        containerView.addSubview(wKWebView)
        wKWebView.navigationDelegate = self
        wKWebView.uiDelegate = self

        wKWebView.evaluateJavaScript("function getDataSet1() { return [10,12,13,15,17,19] }; function getDataSet2() { return [8,15,10,13,12,11] }; ")  { (result, error) in
            guard error == nil else {
                print("there was an error")
                return
            }
            
            print(result)
        }

        wKWebView.scrollView.bounces = false

        let url = Bundle.main.url(forResource: "chartjs", withExtension: "html", subdirectory: "")!
        wKWebView.loadFileURL(url, allowingReadAccessTo: url)
        let request = URLRequest(url: url)
        wKWebView.load(request)


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.selectedDay = self.selectedDay.start(of: Component.day)
        let format = self.selectedDay.format(with: DateFormatter.Style.short, timeZone: TimeZone.current, locale: myLocale)
        print("**self.selectedDay**")
        print(self.selectedDay)
        print("**format**")
        print(format)
        let inx = dateList.index(of: selectedDay) ?? dateList.count
        let scrollIndex: IndexPath = IndexPath(item: inx, section: 0)
        //if (// Check you are in range of UIcollectionView's count) {
            //Scroll collectionview according to your requirement i.e UICollectionViewScrollPositionCenteredHorizontally or UICollectionViewScrollPosition.Left
        self.weekDaysCollectionView.selectItem(at: scrollIndex, animated: true, scrollPosition: UICollectionViewScrollPosition.left)
        self.weekDaysCollectionView.layoutIfNeeded()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        wKWebView.frame = createWKWebViewFrame(size: size)
    }
    
    
    // MARK: - WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            self.myLabel.text = "Javascript is sending selected item index: \(message.body)"
            print("JavaScript is sending a message \(message.body)")
        }
    }
    
    
    @IBAction func onTappedGoBack(_ sender: Any) {
        wKWebView.goBack()
    }
    
    @IBAction func onTappedGoForward(_ sender: Any) {
        wKWebView.goForward()
    }
}

extension ViewController {
    fileprivate func createWKWebViewFrame(size: CGSize) -> CGRect {
        let navigationHeight: CGFloat = 60
        let toolbarHeight: CGFloat = 44
        let height = size.height - navigationHeight - toolbarHeight
        return CGRect(x: 0, y: 0, width: size.width, height: height)
    }
}

extension ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // show indicator
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // dismiss indicator
        
        // if url is not valid {
        //    decisionHandler(.cancel)
        // }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // dismiss indicator
        
        //goBackButton.isEnabled = webView.canGoBack
        //goForwardButton.isEnabled = webView.canGoForward
        navigationItem.title = webView.title
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // show error dialog
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dateList.count
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print("page = \(page)")
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = weekDaysCollectionView.dequeueReusableCell(withReuseIdentifier: "dayItemCell", for: indexPath) as! WeekDayCollectionCell
        let dateItem = self.dateList[indexPath.row]
        //cell.visualItem.recordId = visualItem.recordId
        
        if dateItem.equals(self.selectedDay) {
            cell.backCircle.backgroundColor = UIColor.green
            cell.backCircle.animation = "fadeIn"
            cell.backCircle.curve = "easeIn"
            cell.backCircle.duration = 1.2
            cell.backCircle.animate()
        } else {
            cell.backCircle.backgroundColor = UIColor.clear
        }

        
        cell.DayNumberLabel.text = String(dateItem.day)
        cell.DayNumberLabel.textColor = UIColor.black
        
        if dateItem.isToday {
            cell.DayNumberLabel.textColor = UIColor.blue
        }
        if dateItem.isWeekend {
            cell.DayNumberLabel.textColor = UIColor.brown
        }
        if dateItem.isLater(than: Date.init()) {
            cell.DayNumberLabel.textColor = UIColor.lightGray
        }
        
        //cell.visualItem.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (7 ) + 20
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 7
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDay = self.dateList[indexPath.row]
        
        showSelectedDate()

        weekDaysCollectionView.reloadData()
    }
}

class WeekDayCollectionCell: UICollectionViewCell {
    @IBOutlet weak var DayNumberLabel: UILabel!
    @IBOutlet weak var backCircle: SpringView!
    
}

