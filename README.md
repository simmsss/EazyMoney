# EazyMoney
by The Thunderbolts ⚡

## About EazyMoney

### Video Walkthrough

For a detailed video explanation with voice-over, click [here](https://youtu.be/dtqgcpZs0FE).

![Screenshot](https://github.com/simmsss/EazyMoney/blob/main/Screenshots/Overview.png?raw=true)

### INSPIRATION 
The COVID-19 pandemic has created a liquidity crunch coupled with altered investment pathways for people. With such an unstable economy and uncertainty engulfing the markets, people want to play safe, making micro-investing a superior alternative to investing nothing at all.
Do you want to start your day with a latte and invest some money in your future at the same time? Our platform - EazyMoney does exactly that for you. An application that is a digital-age equivalent of taking all the spare change from your purchases and saving it in a jar until the jar is full, and then taking the full jar of change to the bank.

### TECHNICAL IMPLEMEMTATION 
*Key Tools, Frameworks and APIs: Xcode, Swift, Python, Flask, Alpaca, Plaid, Sketch*

EazyMoney uses Swift for the native iOS application. All UI elements were created in Sketch and exported as png ﬁles. We use several APIs to boost user security, app efﬁciency and speed. Plaid was used for bank account and wealth management, whereas Alpaca was used for Stocks and ETF investment and trading. Several cocoapods like Alamoﬁre were used to aid the development process. There is also a companion iPadOS app and macOS Native Application, which will be useful given the Apple Silicon transition.

To enhance user security, instead of using Cloud-based Database services like Firebase, we utilise the native CoreData framework for persistent storage.
For Machine-learning based recommendation, we use a custom-developed Flask API deployed on Heroku that utilises real Stock Data and key ﬁnancial indicators, used by analysts, to develop a real-time cluster of stocks in the exchanges. 

![Screenshot](https://github.com/simmsss/EazyMoney/blob/main/Screenshots/Secure%20and%20Elegant.png?raw=true)

Educational content was pulled from the internet using web scraping and rendered natively.

We used Final Cut Pro X and Screen Recording from an iPhone for the demo video.

Supporting clips were either shot by camera to use with permission from free stock gallery. The mobile app is responsive and conforms to the Apple Human Interface Guidelines. All screen sizes supported by iOS 14.0+ are also supported by EazyMoney.

### FINANCIAL INCLUSION 
Majority of the population around the world is not connected to any financial services due to lack of financial literacy. We provide relevant information to beginners so as to bring clarity on basic concepts which, in turn, will help them in managing their financials efficiently and make appropriate decisions. 

![Screenshot](https://github.com/simmsss/EazyMoney/blob/main/Screenshots/Accessiblity%20and%20Portfolio%20Tracking.png?raw=true)

### MARKET FIT 
EazyMoney is a simple, low-cost way of getting into the world of investment. 

#### Why choose EazyMoney and not traditional form of investment?
We make investment possible for any figure of money, there is no threshold amount required for you to start investing. 

#### Who will benefit from micro-investing?
Everyone can reap benefits from our platform but it intends to target young investors in particular as they believe they do not have sufficient money to get started. More than 50% of India’s population is below 25, making our target audience wide. 

### FUTUTRE ROADMAP 
We plan on adding more ETF options to our platform and provide a more diversified set of investment options to our users. 

## Requirements

#### Hardware

* MacBook, Mac Mini, iMac, Mac Pro or any other variant running macOS 10.15.4 (Catalina) or later.
* Atleast 4GB of RAM recommended (For running on Simulator)
* An iPhone or iPad running iOS/iPadOS 14.0 or later. (For running on physical device)
* An Apple Watch running watchOS 7.0 or later. (For running on physical device)

#### Software

* Xcode version 12.0
* Xcode Command Line Tools
* CocoaPods

#### Instructions

Clone the GitHub repo on your local machine. Navigate to the project folder in the terminal and run `pod install` to install dependencies. Open the workspace in Xcode, configure the profiles and hit run for the simulator to load up. For testing the Watch Tracker, change the target to the Pink+ Tracker and hit run.

Made with ⚡ by [Simran](https://simmsss.github.io/) and [Utkarsh](https://skhiearth.github.io/)
