# 🚀 APIClient (Swift)


### Network Layer

* **Network Architecture**

![image](https://github.com/Ericji1989114/APIClient-Swift/blob/master/ScreenShot/Network%20Architecture.png)

* **APIProtocol** (Get the idea from Moya)

	* Response Type: Because we always use object to render the view in app rathan than directly using json data/Dictionary. I created it as an associated type for an API. It will ensure that one API must has its own corresponding object.

	🌟In app side. Each API must conform to this prototol. and then can use **APISession** to finish the network communication.
	
* **APISession**

	* Wrap **URLSession** class to implement network communication.
	* Only accepting api instance which conform to **APIProtocol**


### Advantage

* One API should be written in one swift file. It is more convenient to maintain and read.
* One API must hold a `Response Type`. It's easier to made other developers to know the result type and use. 
* `APIProtocol` has defined all things which will be used when send urlrequest finally. 

### What can be improved

* `CustomDebugStringConvertible` which can print all information in one api. It is really helpful in debug. but how to make it be in common.

	
















