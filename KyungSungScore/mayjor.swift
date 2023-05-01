//
//  mayjor.swift
//  KyungSungScore
//
//  Created by 김건호 on 2023/04/12.
//

import Foundation

struct University{
    let mayjors=[
        Mayjor(college:"문과대학",mayjor:["인문문화학부","문헌정보학과","글로컬문화학부","유아교육과","영어영문학과","윤리교육과","중국학과","심리학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"사회과학대학",mayjor:["법학과","광고홍보학과","경찰행정학과","사회복지학과","미디어커뮤니케이션학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"상경대학",mayjor:["경제금융물류학부","국제무역통상학과","호텔관광외식경영학부(호텔관광)","회계학과","호텔관광외식경영학부(외식서비스)","빅데이터응용통계학과","경영학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"공과대학",mayjor:["기계자동차공학과","산업경영공학과","메카트로닉스공학과","신소재공학과","환경공학과","전기공학과","토목공학과","전자공학과","도시공학과","컴퓨터공학과","건축학과","소프트웨어학과","실내건축학과","정보통신공학과","응용화학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"약학대학",mayjor:["약학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"예술종합대학",mayjor:["음악학부","미디어콘텐츠학과","디자인학부(시각디자인)","스포츠건강학과","디자인학부(산업디자인)","현대미술학과","연극여화학부(연극)","공예디자인학과","연극여화학부(영화)","사진학과","연극영화학부(뮤지컬)","패션디자인학과","영상애니메이션학부"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"생명보건대학",mayjor:["간호학과","반려생물학과","물리치료학과","화장품학과","식품생명공학과","스마트바이오학과","식품영양학과","제약공학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0]),
        Mayjor(college:"산학혁신융합대학",mayjor:["AI미디어학과","에너지과학과","AI수리학과"],schoolScore: [1.0,1.0,1.0,1.0,1.0,1.0,1.0],satScore:[1.0,1.0,1.0,1.0,1.0,1.0,1.0])
    ]
    
}

struct Mayjor{
    let college: String
    let mayjor : [String]
    let schoolScore: [Double]
    let satScore:[Double]
}



