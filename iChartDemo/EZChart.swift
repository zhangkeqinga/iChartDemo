//
//  EZChart.swift
//  TYKoalaServiceNice
//
//  Created by mac on 16/7/22.
//  Copyright © 2016年 com.cn.koalaservice.ty. All rights reserved.
//绘制柱状图

import UIKit

class EZChart: UIView {
    
    var bgSV:UIScrollView?
    
    var headHeight:CGFloat = 50
    var leftWidth:CGFloat = 40
    var footHeight:CGFloat = 60  //变化之后直接影响 rightWidth 和 viewWidth
    var rightWidth:CGFloat = 40
    
    
    var viewBgHight:CGFloat = 1
    var viewBgWidth:CGFloat = 320
    
    var xLbDistance:CGFloat = 45  //最小值是 60
    var yLbDistance:CGFloat = 1   //
    
    var titleLb:UILabel!
    
    var dataArray:[EZChartModel] = []
    var model: EZChartModel?

    var clickedButtonAction:((model:EZChartModel)->(Void))?

    
    func test(){
        
        let model = EZChartModel()
        model.ez_ytitle = 1
        model.ez_xtitle = "aaaaaa"
        model.ez_type = "A"
        
        let model1 = EZChartModel()
        model1.ez_ytitle = 1
        model1.ez_xtitle = "bbbbb"
        model.ez_type = "B"
        
        let model2 = EZChartModel()
        model2.ez_ytitle = 25
        model2.ez_xtitle = "ccccccccc"
        model2.ez_type = "C"
        
        let model3 = EZChartModel()
        model3.ez_ytitle = 1
        model3.ez_xtitle = "ddddd"
        model3.ez_type = "D"
        
        dataArray.append(model)
        dataArray.append(model1)
        dataArray.append(model2)
        dataArray.append(model1)
        dataArray.append(model2)
        dataArray.append(model1)
        dataArray.append(model2)
        dataArray.append(model2)
        dataArray.append(model1)
        dataArray.append(model2)
        
        createNewChartView()
        
        //        print("lines =\(lines)")
        
    }
    
    
    //
    func createNewChartView(){
        
        self.createBgView()
        self.createTitle()    //创建标题
        self.createChartXY()  //创建图表
        
    }
    
    
    
    func createBgView(){
        
        bgSV = UIScrollView()
        bgSV?.frame = CGRectMake(0, 0, self.frame.size.width,  self.frame.size.height)
        self.addSubview(bgSV!)
        
        
    }
    
    
    func createTitle(){
        if titleLb != nil {
            titleLb.removeFromSuperview()
            titleLb=nil
        }
        titleLb = UILabel()
        titleLb!.frame = CGRectMake(0  , 0, CV.BaseWidth, headHeight-5)
        
        titleLb!.text = String("标题标题标题")
        titleLb!.textAlignment = .Center
        titleLb!.font = UIFont.systemFontOfSize(14)
        self.addSubview(titleLb!)
        
    }
    
    
//                    headHeight
//                     |
//                __ ____ ____ ____ ____
//                  |    |    |    |    |
//     leftWidth  __|____|____|____|____| __ rightWidth
//                  |    |    |    |    |
//                __|____|____|____|____|
//                  |    |    |    |    |
//                __|____|____|____|____|
//                  |    |    |    |    |
//                __|____|____|____|____|
//                  /    /    /    /    /
//                 /    /    /    /    /
//                     |
//                footHeight
 
    
    
    //只负责绘制图表
    func createChartXY()
    {
        //        self.backgroundColor = UIColor.grayColor()
        
        // 参数
        
        let nm =  self.maxNumber(dataArray)    // dataArray 数组中最大的数据
        let yMax = self.yNumberMax(nm)         // y坐标系最大的数
        let ylines = self.yNumberLines(yMax)   // y行数
        let xlines = dataArray.count           // x行数
        
        viewBgWidth = CV.BaseWidth - leftWidth - rightWidth
        var xLbDis = CGFloat(viewBgWidth)/CGFloat(xlines)        // x间距
        if xLbDis < xLbDistance {
            xLbDis = xLbDistance
            viewBgWidth = CGFloat(xLbDistance)*CGFloat(xlines)   // viewBgWidth
            
            bgSV!.contentSize = CGSizeMake(leftWidth + viewBgWidth + rightWidth, self.frame.height)
        }
        
        viewBgHight = self.frame.height - headHeight - footHeight
        yLbDistance = CGFloat(viewBgHight)/CGFloat(ylines)       // y间距
        
        // 参数
        
        //坐标 Y
        for index in 0...ylines {
            
            let lineImg = UIImageView()
            lineImg.frame = CGRectMake(leftWidth, headHeight + CGFloat(yLbDistance)*CGFloat(index) , viewBgWidth, 1)
            lineImg.backgroundColor = UIColor.lightGrayColor()
            bgSV!.addSubview(lineImg)
            
            let yTitleLb = UILabel()
            yTitleLb.frame = CGRectMake(0  ,yLbDistance/2 + headHeight + CGFloat(ylines)*CGFloat(yLbDistance) - yLbDistance*CGFloat(index+1) , leftWidth-5, yLbDistance)
            
            yTitleLb.text = String("\((index)*yMax/ylines)")
            yTitleLb.textAlignment = .Right
            yTitleLb.font = UIFont.systemFontOfSize(9)
            self.addSubview(yTitleLb)
            
        }
        
        //内容 坐标 X
        for (index,iteam) in dataArray.enumerate() {
            
            self.titleLb.text = iteam.ez_type
            
            let xTitleLb = UILabel()
            xTitleLb.frame = CGRectMake(leftWidth - xLbDistance/3 + (xLbDis - xLbDistance)/2 + CGFloat(xLbDis)*CGFloat(index) ,15 +  headHeight + CGFloat(ylines)*CGFloat(yLbDistance) , xLbDistance, 30)
            xTitleLb.text = iteam.ez_xtitle
            xTitleLb.numberOfLines = 2
            xTitleLb.textAlignment = .Right
            xTitleLb.font = UIFont.systemFontOfSize(9)
            xTitleLb.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI/4))
            bgSV!.addSubview(xTitleLb)
            
            let btn = UIButton()
            
            btn.frame = CGRectMake( //
                leftWidth + xLbDis/6  + CGFloat(xLbDis)*CGFloat(index) ,
                headHeight + CGFloat(ylines)*CGFloat(yLbDistance) - (CGFloat(viewBgHight)/CGFloat(yMax))*CGFloat(iteam.ez_ytitle),
                xLbDis - xLbDis/3,
                CGFloat(CGFloat(viewBgHight)/CGFloat(yMax))*CGFloat(iteam.ez_ytitle))
            
            btn.backgroundColor = UIColor.EZChartColor()[index]
            bgSV!.addSubview(btn)
            
            btn.addTarget(self, action: #selector(EZChart.onClickChartInfomation(_:)), forControlEvents: .TouchUpInside)
            
            
            let chartNumLb = UILabel()
            
            chartNumLb.frame = CGRectMake(
                leftWidth + CGFloat(xLbDis)*CGFloat(index) ,
                headHeight + CGFloat(ylines)*CGFloat(yLbDistance) - (CGFloat(viewBgHight)/CGFloat(yMax))*CGFloat(iteam.ez_ytitle) - 30 ,
                xLbDis, 30)
            
            chartNumLb.text = String(iteam.ez_ytitle)
            
            chartNumLb.numberOfLines = 2
            chartNumLb.textAlignment = .Center
            chartNumLb.font = UIFont.systemFontOfSize(9)
            bgSV!.addSubview(chartNumLb)
            
            
        }
    }
    
    func onClickChartInfomation(sender:UIButton){
        
        if sender.tag - 1000 >= 0 {
            model = self.dataArray[sender.tag - 1000]
            clickedButtonAction!(model:model!)
        }
        
    }

    
    
    /**
     获取数组中的最大值
     - parameter array: 需要绘制的参数
     - returns: 返回一个最大值
     */
    //MARK:  maxNumber
    func maxNumber(array:[EZChartModel]) -> Int{
        
        if array.count <= 0 {
            return 1
        }
        
        var maxnumber = 1
        for iteam in array {
            if maxnumber < iteam.ez_ytitle {
                maxnumber = iteam.ez_ytitle
            }
        }
        return maxnumber
    }
    
    
    /**
     y坐标系的最大值  Y_T_Max
     - parameter number: y轴上显示的最大值
     - returns: 返回 y轴坐标最大值
     */
    func yNumberMax (number:Int) -> Int {
        
        let str = String(number)
        let num = str.characters.count
        let mn = pow(10, Double(num-1))
        let yMax = Int(number/Int(mn) + 1)*Int(mn)
        
        return yMax
    }
    
    /**
     求行数
     - parameter yNumberMax: y坐标系最大值
     - returns: 行数
     */
    func yNumberLines (yNumberMax:Int) -> Int {
        var yMax = 1
        if yNumberMax <= 10 {
            yMax = yNumberMax
        }else{
            yMax = 10
        }
        return yMax
    }
    
    
    
}