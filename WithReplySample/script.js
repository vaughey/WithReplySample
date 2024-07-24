function sampleMethodTheHTMLCanCall( inputInfo, successFunc, errorFunc ) {
    
    var promise = window.webkit.messageHandlers.namespaceWithinTheInjectedJSCode.postMessage( inputInfo );
    
    promise.then(
      function(result) {
        console.log(result); // "Stuff worked!"
        successFunc( result )
      },
      function(err) {
        console.log(err); // Error: "It broke"
        errorFunc( err )
      });
}
