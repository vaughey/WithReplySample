function captureConsoleLogs() {
    var oldLog = console.log;
    
    console.log = function() {
        var args = Array.from(arguments);
        window.webkit.messageHandlers.consoleHandler.postMessage(args.join(' '));
        oldLog.apply(console, args);
    };
}

captureConsoleLogs();
