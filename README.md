
<p align="center">
<img src="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/images/webviewx_plus.png" height="400" alt="webviewx" />
</p>



A feature-rich cross-platform webview using [webview_flutter](https://pub.dev/packages/webview_flutter) for mobile and [iframe](https://api.flutter.dev/flutter/dart-html/IFrameElement-class.html) for web. JS interop-ready.

## Getting started

- [Gallery](#gallery)
- [Basic usage](#basic-usage)
- [Features](#features)
  - [Widget properties](#widget-properties)
  - [Controller properties](#controller-properties)
- [Contribution](#contribution)
- [Credits](#credits)

---

## Gallery

<div style="text-align: center">
    <table>
        <tr>
        </td>
            <td style="text-align: center;font-size: 22px">
                <p> Mobile</p>
            </td>
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/iphone.gif">
                    <img src="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/iphone.gif" width="200"/>
                </a>
            </td>            
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/android.gif">
                    <img src="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/android.gif" width="200"/>
                </a>
            </td>
        </tr>
        <tr>
             <td style="text-align: center;font-size: 22px">
                <p> Web</p>
            </td>
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/chrome.gif">
                    <img src="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/chrome.gif" width="200"/>
                </a>
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/safari.gif">
                    <img src="https://raw.githubusercontent.com/Mahad61/webviewx_plus/main/doc/gif/safari.gif" width="200"/>
                </a>
            </td>
        </tr>
    </table>

</div>

---

## Basic usage

### **1.** Create a `WebViewXController` inside your stateful widget

```dart
late WebViewXController webviewController;
```

### **2.** Add the WebViewX widget inside the build method, and set the `onWebViewCreated` callback in order to retrieve the controller when the webview is initialized

```dart
WebViewX(
    initialContent: '<h2> Hello, world! </h2>',
    initialSourceType: SourceType.HTML,
    onWebViewCreated: (controller) => webviewController = controller,
    ...
    ... other options
);
```

## **Important !**

If you need to add other widgets on top of the webview (e.g. inside a Stack widget), you _**MUST**_ wrap those widgets with a **WebViewAware** widget.
This does nothing on mobile, but on web it allows widgets on top to intercept gestures. Otherwise, those widgets may not be clickable and/or the iframe will behave weird (unexpected refresh/reload - this is a well known issue).

Also, if you add widgets on top of the webview, wrap them and then you notice that the iframe still reloads unexpectedly, you should check if there are other widgets that sit on top without being noticed, or try to wrap InkWell, GestureRecognizer or Button widgets to see which one causes the problem.

### **3.** Interact with the controller (run the [example app](https://github.com/Mahad61/webviewx_plus/tree/main/example) to check out some use cases)

```dart
webviewController.loadContent(
    'https://flutter.dev',
    SourceType.url,
);
webviewController.goBack();

webviewController.goForward();
...
...
```

---

## Features

Note: For more detailed information about things such as `EmbeddedJsContent`, please visit each own's `.dart` file from the `utils` folder.

- ## Widget properties

| Feature                                                     | Details                                                                                                                                             |
| ----------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `String` initialContent                                     | Initial webview content                                                                                                                             |
| `SourceType` initialSourceType                              | Initial webview content type (`url, urlBypass or html`)                                                                                             |
| `String?` userAgent                                         | User agent                                                                                                                                          |
| `double` width                                              | Widget's width                                                                                                                                      |
| `double` height                                             | Widget's height                                                                                                                                     |
| `Function(WebViewXController controller)?` onWebViewCreated | Callback that gets executed when the webview has initialized                                                                                        |
| `Set<EmbeddedJsContent>` jsContent                          | A set of EmbeddedJsContent, which is an object that defines some javascript which will be embedded in the page, once loaded (check the example app) |
| `Set<DartCallback>` dartCallBacks                           | A set of DartCallback, which is an object that defines a dart callback function, which will be called from javascript (check the example app)       |
| `bool` ignoreAllGestures                                    | Boolean value that specifies if the widget should ignore all gestures right after it is initialized                                                 |
| `JavascriptMode` javascriptMode                             | This specifies if Javascript should be allowed to execute, or not (allowed by default, you must allow it in order to use above features)            |
| `AutoMediaPlaybackPolicy` initialMediaPlaybackPolicy        | This specifies if media content should be allowed to autoplay when initialized (i.e when the page is loaded)                                        |
| `void Function(String src)?` onPageStarted                  | Callback that gets executed when a page starts loading (e.g. after you change the content)                                                          |
| `void Function(String src)?` onPageFinished                 | Callback that gets executed when a page finishes loading                                                                                            |
| `NavigationDelegate?` navigationDelegate                    | Callback that, if not null, gets executed when the user clicks something in the webview (on Web it only works for `SourceType.urlBypass`, for now)  |
| `void Function(WebResourceError error)?` onWebResourceError | Callback that gets executed when there is an error when loading resources  issues on web                              |
| `WebSpecificParams` webSpecificParams                       | This is an object that contains web-specific options. Theese are not available on mobile (_yet_)                                                    |
| `MobileSpecificParams` mobileSpecificParams                 | This is an object that contains mobile-specific options. Theese are not available on web (_yet_)                                                    |

---

- ## Controller properties

| Feature                                                   | Usage                                                                                          |
| --------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| Load URL that allows iframe embedding                     | webviewController.`loadContent(URL, SourceType.URL)`                                           |
| Load URL that doesnt allow iframe embedding               | webviewController.`loadContent(URL, SourceType.URL_BYPASS)`                                    |
| Load URL that doesnt allow iframe embedding, with headers | webviewController.`loadContent(URL, SourceType.URL_BYPASS, headers: {'x-something': 'value'})` |
| Load HTML from string                                     | webviewController.`loadContent(HTML, SourceType.HTML)`                                         |
| Load HTML from assets                                     | webviewController.`loadContent(HTML, SourceType.HTML, fromAssets: true)`                       |
| Check if you can go back in history                       | webviewController.`canGoBack()`                                                                |
| Go back in history                                        | webviewController.`goBack()`                                                                   |
| Check if you can go forward in history                    | webviewController.`canGoForward()`                                                             |
| Go forward in history                                     | webviewController.`goForward()`                                                                |
| Reload current content                                    | webviewController.`reload()`                                                                   |
| Check if all gestures are ignored                         | webviewController.`ignoringAllGestures`                                                        |
| Set ignore all gestures                                   | webviewController.`setIgnoreAllGestures(value)`                                                |
| Evaluate "raw" javascript code                            | webviewController.`evalRawJavascript(JS)`                                                      |
| Evaluate "raw" javascript code in global context ("page") | webviewController.`evalRawJavascript(JS, inGlobalContext: true)`                               |
| Call a JS method                                          | webviewController.`callJsMethod(METHOD_NAME, PARAMS_LIST)`                                     |
| Retrieve webview's content                                | webviewController.`getContent()`                                                               |
| Get scroll position on X axis                             | webviewController.`getScrollX()`                                                               |
| Get scroll position on Y axis                             | webviewController.`getScrollY()`                                                               |
| Scrolls by `x` on X axis and by `y` on Y axis             | webviewController.`scrollBy(int x, int y)`                                                     |
| Scrolls exactly to the position `(x, y)`                  | webviewController.`scrollTo(int x, int y)`                                                     |
| Retrieves the inner page title                            | webviewController.`getTitle()`                                                                 |
| Clears cache                                              | webviewController.`clearCache()`                                                               |

## Contribution

Any help from the open-source community is always welcome and needed:

-   Found an issue?
    
    -   Please fill a bug report with details.
-   Wish a feature?
    
    -   Open a feature request with use cases.
-   Are you using and liking the project?
    
    -   Promote the project: create an article, do a post or make a donation.
-   Are you a developer?
    
    -   Fix a bug and send a pull request.
    -   Implement a new feature.
-   Have you already helped in any way?
    
    -   **Many thanks from me, the contributors and everybody that uses this project!**

 

## Credits

This package has updated the    [webviewx](https://github.com/adrianflutur/webviewx)  code and fixed a few issues as it isn't  remain updated.
