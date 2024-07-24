Working elaboration of the only close-to-working example of WkWebView's WKScriptMessageHandlerWithReply protocol instead of WKScriptMessageHandler.

Enables two-way communication between native Swift and javascript in a WkWebView. 

Credit to Jason at https://stackoverflow.com/users/135203/jason

https://stackoverflow.com/questions/65270083/how-does-the-ios-14-api-wkscriptmessagehandlerwithreply-work-for-communicating-w

Got it working, flipped it to Swiftui from UIKit, and added echoing of the javascript console to the calling html page.

Documentation for WKScriptMessageHandlerWithReply largely non-existent and for most people - like me - could request and retrieve a javscript message but couldn't successfully reply to the javascript message for two-way communication without getting a seemingly untraceable error:
"JavaScript evaluation error: Error Domain=WKErrorDomain Code=5 "JavaScript execution returned a result of an unsupported type" UserInfo={NSLocalizedDescription=JavaScript execution returned a result of an unsupported type}."

Years of thrashing about @Sendable data types and @MainActor and threading. Nope.

Signature for the undocumented Javascript function was the culprit.  



![WKScriptMessageHandlerWithReply-1](https://github.com/user-attachments/assets/a48f8133-84e0-4ecc-86f3-d96e84905d62)
