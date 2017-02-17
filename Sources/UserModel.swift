//
//  UserModel.swift
//  CRM
//
//  Created by 徐非 on 16/12/1.
//  Copyright © 2016年 翼点网络. All rights reserved.
//

import Foundation
import PerfectLib
import PerfectHTTP
import JWT
import StORM
import MySQLStORM

//用户模型
class UserModel:MySQLStORM, NSCoding, JSONProtocol {

    public func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.sID, forKey: "sID")
//        
//        aCoder.encode(self.account, forKey: "account")
//        aCoder.encode(self.trueName, forKey: "trueName")
//        aCoder.encode(self.nickname, forKey: "nickname")
//        
//        aCoder.encode(self.companyID, forKey: "companyID")
//        aCoder.encode(self.teamID, forKey: "teamID")
//        
//        aCoder.encode(self.gender, forKey: "gender")
//        aCoder.encode(self.mobile, forKey: "mobile")
//        aCoder.encode(self.eMail, forKey: "eMail")
    }
    
    required init?(coder aDecoder: NSCoder) {
//        sID = aDecoder.decodeObject(forKey: "sID") as? String
//        
//        account = aDecoder.decodeObject(forKey: "account") as? String
//        trueName = aDecoder.decodeObject(forKey: "trueName") as? String
//        nickname = aDecoder.decodeObject(forKey: "nickname") as? String
//        
//        companyID = aDecoder.decodeObject(forKey: "companyID") as? String
//        teamID = aDecoder.decodeObject(forKey: "teamID") as? String
//        
//        gender = aDecoder.decodeObject(forKey: "gender") as? Int
//        mobile = aDecoder.decodeObject(forKey: "mobile") as? String
//        eMail = aDecoder.decodeObject(forKey: "eMail") as? String
    }
    
    override init(){
        super.init()
    }

    var sID: String?                    //user_id int
    var companyID: String?              //company_id int
    var teamID: String?                 //team_id 10
    var account: String?                //account String 20
    var nickname: String?               //user_nick String 45
    var trueName: String?               //true_name String 45
    var password: String?               //password 32
    var password1: String?
    
    var portraitURLString: String?      //
    var gender: NSNumber?                    //sex int
    var birthday: Date?
    var mobile: String?                 //mobile String 11
    var eMail: String?                  //e_mail String 45
    var address: AddressModel?
    

    
    //MARK: 第三方ID
    var thirdType: String?
    var thirdPartyID: String?           //第三方登录ID
    var openID: String?                 //client_id: String
    var wechatID: String?               //wechat: String
    var facebookID: String?             //facebook: String
    var twitterID: String?              //twitter: String
   
    
//    var job: String?
//    var income: NSNumber?
//    
//    var cardID: String?
//    var passportID: String?
//    var passportCountry: String?
//    var validity: Date?
//    
//    var families: [UserModel]?
//    var relation: String?
//
//    var isSign: Bool?
//    var isExperience: Bool?
//    var flightDate: Date?
//    var flightNum: String?
    var addTime: Date?                  //add_time int
    var addIP: String?                  //add_ip string
    var addAdmin: String?               //add_admin string
    var status: Bool?                   //status bool
    //MARK: CurrentUser
    class var currentUser: UserModel? {
        get{
            let userData: Data? = UserDefaults.standard.object(forKey: "CurrentUser") as? Data
            guard let data = userData else{
                return nil
            }
            
            let user: UserModel? = NSKeyedUnarchiver.unarchiveObject(with: data) as? UserModel
            return user
        }
    }
    
    func save() -> Bool{
        let userData: Data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(userData, forKey: "CurrentUser")
        return true
    }

//    //MARK: 返回名字trueName的拼音
//    func getPinyin() -> String? {
//        guard let name = self.trueName else {
//            return nil
//        }
//        let format = HanyuPinyinOutputFormat()
//        let pinyin = PinyinHelper.toHanyuPinyinString(with: name, with: format, with: " ")
//        return pinyin
//    }
    
    /*
    //MARK: - 验证
    class func confirmAccount(_ inputString: String?) -> Bool {
        guard let account = inputString else {
            return false
        }
        
        //非符号开头的6-18位字符
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9._]{6,18}$", options: .caseInsensitive)
        
        guard  let reg = regex else {
            return false
        }
        
        let matches = reg.matches(in: account, options: .reportCompletion, range: NSMakeRange(0, account.characters.count))
        if matches.count == 0{
            return false
        }
        return true
    }
    
    class func confirmPassword(_ password: String?) -> Bool {
        guard let pwd = password else {
            return false
        }
        
        //非符号开头的6-18位字符
        let regex = try? NSRegularExpression(pattern: "[a-zA-Z0-9]{6,18}$", options: .caseInsensitive)
        
        guard  let reg = regex else {
            return false
        }
        
        let matches = reg.matches(in: pwd, options: .reportCompletion, range: NSMakeRange(0, pwd.characters.count))
        if matches.count == 0{
            return false
        }
        return true
    }
    
    class func confirmMobile(_ mobile: String) -> Bool{
        if mobile.characters.count == 0{
            return false
        }
        let regex = try? NSRegularExpression(pattern: "[0-9]", options: .caseInsensitive)
        guard let _ = regex else{
            return false
        }
        
        let matches = regex!.matches(in: mobile, options: .reportCompletion, range: NSMakeRange(0, mobile.characters.count))
        if matches.count == 0{
            return false
        }
        
        return true
    }
    

    
    class func confirmEmail(_ email: String) -> Bool{
        if email.characters.count == 0{
            return false
        }
        let regex = try? NSRegularExpression(pattern: "\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*", options: .caseInsensitive)
        guard let _ = regex else{
            return false
        }
        
        let matches = regex!.matches(in: email, options: .reportCompletion, range: NSMakeRange(0, email.characters.count))
        if matches.count == 0{
            return false
        }
        
        return true
    }
 */
    
    //MARK: - Parse
    class func parseJSON(_ json: [String: Any]?) -> UserModel?{
        guard let dic = json else{
            return nil
        }
        
        let model = UserModel()
        model.sID = (dic["id"] as? NSNumber)?.stringValue
        model.companyID = (dic["company_id"] as? NSNumber)?.stringValue
        model.teamID = (dic["team_id"] as? NSNumber)?.stringValue
        model.account = dic["account"] as? String
        model.nickname = dic["user_nick"] as? String
        model.trueName = dic["true_name"] as? String
        model.password = dic["password"] as? String
        
        model.gender = dic["sex"] as? NSNumber
        model.mobile = dic["mobile"] as? String
        model.eMail = dic["e_mail"] as? String
        
        model.openID = dic["client_id"] as? String
        model.wechatID = dic["wechat"] as? String
        model.facebookID = dic["facebook"] as? String
        model.twitterID = dic["twitter"] as? String

        return model
    }
    
    //MARK: - API    
    var json: Any {
        get {
            var modelDic = [String: Any]()
            if let sID = self.sID {
                modelDic["id"] = sID
            }
            if let companyID = self.companyID {
                modelDic["company_id"] = companyID
            }
            if let teamID = self.teamID {
                modelDic["team_id"] = teamID
            }
            if let account = self.account {
                modelDic["account"] = account
            }
            if let nickname = self.nickname {
                modelDic["user_nick"] = nickname
            }
            if let trueName = self.trueName {
                modelDic["true_name"] = trueName
            }
            if let password = self.password {
                modelDic["password"] = password
            }
            if let gender = self.gender {
                modelDic["sex"] = gender
            }
            if let mobile = self.mobile {
                modelDic["mobile"] = mobile
            }
            if let eMail = self.eMail {
                modelDic["e_mail"] = eMail
            }
            if let openID = self.openID {
                modelDic["client_id"] = openID
            }
            if let wechatID = self.wechatID {
                modelDic["wechat"] = wechatID
            }
            if let facebookID = self.facebookID {
                modelDic["facebook"] = facebookID
            }
            if let twitterID = self.twitterID {
                modelDic["twitter"] = twitterID
            }
            
            
            return modelDic
        }
    }
    
    
    //MARK: 用户详情
    static let detail: RequestHandler = { req, res in
        let userID: String? = req.urlVariables["id"]
        guard let id = userID else{
            res.outputError("\(req.path) need 'id'")
            res.completed()
            return
        }
        let user = UserModel()
        user.sID = id
        res.output(user)

        res.completed()
    }
    
    //MARK: 用户列表
    static let list: RequestHandler = { req, res in
        var page: String = req.param(name: "page", defaultValue: "0")!
        let pageSize = req.param(name: "pageSize", defaultValue: "30")!
        page = "\(page.intValue * pageSize.intValue)"
        
        let user = UserModel()
        do {
            let results = try user.sqlRows("SELECT * FROM jrk_user limit ?,?", params: [page, pageSize])
            try user.sql("SELECT * FROM jrk_user", params: [])
            let models = results.map{
                UserModel.parseJSON($0.data)
            }
            let testUser = models[0]
            res.output(["datas":models, "total": user.results.foundSetCount])
        }catch{
            res.outputError("\(error)")
        }

        res.completed()
    }
    
    //MARK: Login
    static let login: RequestHandler = { req, res in
        guard let account = req.param(name: "account") else{
            res.outputError("account can not be null")
            return
        }
        guard let password = req.param(name: "password") else{
            res.outputError("password can not be null")
            return
        }
        
//        if !UserModel.confirmAccount(account) || !UserModel.confirmPassword(password){
//            res.outputError("account or password error")
//        }
        
        //登入成功授权
        let user1 = UserModel()
        user1.sID = "1"
        user1.trueName = "leon"
        user1.mobile = "13917051234"
        
        var claims = ClaimSet()
        claims.issuer = user1.sID
        claims.issuedAt = Date()
        
        let tokenValue = JWT.encode(claims: claims, algorithm: .hs256(JWTSecret.data(using: .utf8)!))
        var cookie = HTTPCookie(name: "token",  value: tokenValue, domain: nil, expires: nil, path: nil, secure: nil, httpOnly: nil, sameSite: nil)
        res.addCookie(cookie)
        
        res.output("success")
    }
    
    //MARK: Regist
    static let regist: RequestHandler = { req, res in
        guard let account = req.param(name: "account") else{
            res.outputError("account can not be null")
            return
        }
        
        guard let password = req.param(name: "password") else{
            res.outputError("password can not be null")
            return
        }
        
        let user = UserModel()
        user.account = account
        user.password = password
        
    }
}
