# MyChats

## What MyChats ?

This is chat application. You can register or login with  your account, then can chat orher users. 
There is only one chat room so you can see all messages other users sent. 

## Image gif

| Register | Login and Logout | Set Icon | Delete account |
| :-----: | :-----: | :-----: | :-----: |
| 
![MyChats_Register.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/6561acde-9233-eaf0-d45c-23dac5f23590.gif) | ![MyChats_LoginAndLogout.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/adcd1cf0-999d-501a-52c4-07128c1e9721.gif) | ![MyChats_SetIcon.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/63d001e8-5c17-a5ff-b7fc-84c0f437c643.gif) |
![MyChats_DeleteAccount.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/192876/8b645111-5fc7-e887-06c2-8d85367f707e.gif) |


## Function

* Splash animation
* Register function
* Login, Logout function
* Chat function
* Set your Icon function
* Delete account function

## FunctionEnviroment

* Xcode 12.1
* Swift 5.3
* CocoaPods 1.9.3
* Firebase
* FirebaseAuth
* CloudFirestore
* IQKeyboardManagerSwift 6.5.0
* platform iOS 13.0

## Note

* Only you can see other users Icon is same avatar.
* App is slow. There may be some reason, one is set Icon through Userdefault. 

So please give me time for a while, I will solve these problen. 


# Constants
```
struct K {
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
```
