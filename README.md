# MyChats

## What MyChats ?

This is chat application. You can register or login with  your account, then can chat orher users. 
There is only one chat room so you can see all messages other users sent. 

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
