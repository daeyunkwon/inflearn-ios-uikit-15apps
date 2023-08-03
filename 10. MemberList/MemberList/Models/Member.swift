//
//  Member.swift
//  MemberList
//
//  Created by 권대윤 on 2023/08/02.
//


import UIKit


protocol MemberDelegate: AnyObject {
    func addNewMember(_ member: Member)
    func update(index: Int, _ member: Member)
}


struct Member { //데이터와 관련된 모델
    
    //멤버의 절대적 순서를 위한 타입 저장 속성
    static var memberNumbers: Int = 0
    
    let memberId: Int
    var name: String?
    var age: Int?
    var phone: String?
    var address: String?
    
    lazy var memberImage: UIImage? = {
        guard let name = name else {return UIImage(systemName: "person")}
        
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "person")
    }()
    
    init(name: String? = nil, age: Int? = nil, phone: String? = nil, address: String? = nil) {
        self.memberId = Member.memberNumbers
        self.name = name
        self.age = age
        self.phone = phone
        self.address = address
        
        //멤버 생성하면 +1
        Member.memberNumbers += 1
    }
}


