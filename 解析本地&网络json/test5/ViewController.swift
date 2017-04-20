//
//  ViewController.swift
//  hangge_756
//
//  Created by hangge on 2016/11/21.
//  Copyright © 2016年 hangge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getForcastWeatherData()
    }
    
    //获取未来天气数据
    func getForcastWeatherData(){
        
// --------------------------------------------- 分界线 ---------------------------------------------
        
        // MARK: 本地 main.json 文件
        
        // 1、获取沙盒 json 路径
        let doc = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let mainPath = (doc as NSString).appending("main.json")
        
        // 2、加载 data
        var mainData = NSData(contentsOfFile: mainPath)
        
        // 3、判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if mainData == nil {
            // 从 Bundle 加载 data
            let mainPath = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            mainData = NSData(contentsOfFile: mainPath!)
        }
       
        let mainJson = JSON(data: mainData as! Data)
        print("🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏🍏")
        print("mainJson = \(mainJson)")
        print("🍏")
        
        
        print("🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇🍇")
        print(mainJson["1"]["title"].string ?? "")
        print(mainJson["1"]["key"].string ?? "")
        print(mainJson["7"]["title"].string ?? "")
        print(mainJson["4"]["key"].string ?? "")
        print("🍇")
        
// --------------------------------------------- 分界线 ---------------------------------------------
        
        // MARK: 本地 test.json 文件
        
        // 0. 获取沙盒 json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("test.json")
        
        // 1、加载 data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 2、判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            // 从 Bundle 加载 data
            let path = Bundle.main.path(forResource: "test.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        
//        print("🍇")
//        print("data = \(data)")
//        print("🍇")
        

        //将获取到的数据转为json对象
        let testWeatherJson = JSON(data: data as! Data)
        print("🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒🍒")
        print("testWeatherJson = \(testWeatherJson)")
        print("🍒")
        
// --------------------------------------------- 分界线 ---------------------------------------------
        
        // "http://app.thacg.cn/weather.json" 链接的 weather.json 文件和 这里目录的 test.json 文件是一样的
        
        let urlStr = "http://app.thacg.cn/weather.json"
        let url = NSURL(string: urlStr)!
//        print("🍉")
//        print("url = \(url)")
//        print("🍉")
        guard let weatherData = NSData(contentsOf: url as URL) else { return }
//        print("🍌")
//        print("weatherData = \(weatherData)")
//        print("🍌")
        
        //将获取到的数据转为json对象
        let weatherJson = JSON(data: weatherData as Data)
        print("🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍🍍")
        print("weatherJson = \(weatherJson)")
        print("🍍")
        
        print("城市：\(weatherJson["city"]["name"].string!)")
        
        let lon = weatherJson["city"]["coord"]["lon"].number!
        let lat = weatherJson["city"]["coord"]["lat"].number!
        print("坐标：[\(lon),\(lat)]")
        
        //日期格式化输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        
        //遍历数据
        for (_,jsonData):(String, JSON) in weatherJson["list"] {
            let timeInterval = TimeInterval(jsonData["dt"].number!)
            let date = NSDate(timeIntervalSince1970: timeInterval)
            print("--- 时间：\(dformatter.string(from: date as Date)) ---")
            
            let weather = jsonData["weather"][0]["main"].string!
            print("天气：\(weather)")
            let weatherDes = jsonData["weather"][0]["description"].string!
            print("详细天气：\(weatherDes)")
            
            let temp = jsonData["main"]["temp"].number!
            print("温度：\(temp)°C")
            
            let humidity = jsonData["main"]["humidity"].number!
            print("湿度：\(humidity)%")
            
            let pressure = jsonData["main"]["pressure"].number!
            print("气压：\(pressure)hpa")
            
            let windSpeed = jsonData["wind"]["speed"].number!
            print("风速：\(windSpeed)m/s")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}















