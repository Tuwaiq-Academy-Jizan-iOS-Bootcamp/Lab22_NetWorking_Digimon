//
//  Model.swift
//  HamadHarisi_Networking_Digimon_Lab22
//
//  Created by حمد الحريصي on 25/11/2021.
//

import Foundation
struct Digmon: Codable
{
    var name:String
    var img:String
    var level:String
}










//struct Img: Codable {
//
//    @ObservedObject private var imageLoader: DataLoader
//
//    public init(imageURL: URL?) {
//        imageLoader = DataLoader(resourseURL: imageURL)
//    }
//
//    public var body: some View {
//        if let uiImage = UIImage(data: self.imageLoader.data) {
//            return AnyView(Image(uiImage: uiImage)
//                            .resizable()
//                            .aspectRatio(contentMode: ContentMode.fit))
//        } else {
//            return AnyView(Image(systemName: "ellipsis")
//                            .onAppear(perform: { self.imageLoader.loadImage() }))
//        }
//    }
//}
//struct Person:Codable
//{
//    var id:Int
//    var name:String
//    var username:String
//    var email:String
//    var phone:String
//    var website:String
//    var company:Company
//    var address:Address
//}
//    struct Address:Codable
//    {
//    var street:String
//    var suite:String
//    var city:String
//    var geo:Geo
//    }
//    struct Geo:Codable
//    {
//    var lat:String
//    var lan:String
//    }
//    struct Company:Codable
//    {
//    var name:String
//    var catchPhrase:String
//    var bs:String
//    }
