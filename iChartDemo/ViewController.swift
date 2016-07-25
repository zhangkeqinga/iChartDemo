//
//  ViewController.swift
//  iChartDemo
//
//  Created by mac on 16/7/25.
//  Copyright © 2016年 com.cn.QZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIWebViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = EZChart()
        v.frame = CGRectMake(0, 0, 320, 400)
        v.test()
        
        self.view.addSubview(v)
        
        
        
//        let path = NSBundle.mainBundle().pathForResource("ColumnerWeb", ofType: "html")
//        
//        let url = NSURL.fileURLWithPath(path!)
//        let request = NSURLRequest(URL: url)
//        
//        let webView = UIWebView()
//        webView.frame = CGRectMake(20 , 10 , 320 , 217)
//        webView.loadRequest(request)
//        webView.backgroundColor = UIColor.redColor()
//        webView.scalesPageToFit = true
//        webView.delegate = self
//        self.view.addSubview(webView)
//        webView.scrollView.bounces=false
//        webView.scrollView.alwaysBounceVertical = true
        
        
    }
    
    
    //MARK:-- webViewDidFinishLoad评论的内容
    func webViewDidStartLoad(webView: UIWebView){
        //        currentVC!.showProgressV()
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        //        currentVC!.hideProgressV()
        
        let titleArray = ["1","2","3","4","5"]
        
        if titleArray.count > 0 {
            let string = String("columnar(\(titleArray))")
            webView.stringByEvaluatingJavaScriptFromString(string)
        }
        else{
        }
        
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let urlstr = request.URL?.absoluteString
        if  urlstr == nil {
            return true
        }
        
        let arry = urlstr!.componentsSeparatedByString("ios://jwzhangjie")
        if arry.count > 1 {
            print("包含  : \(arry[1])")
            let index = arry[1] as String
            let num  = Int(index)! + 1
            self.selectedInformationVC(num)
            
        } else {
            print("不包含: urlstr")
        }
        
        return true
    }
    
    
    internal func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        //        currentVC!.hideProgressV()
    }
    
    
    func selectedInformationVC(number:Int){
        
        print("number = \(number)")
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

