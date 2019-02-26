;(function(lang){

    var IEversion = detectIE();
    // 브라우저 버전별로 분기처리..
    if (IEversion !== false) {
      if(IEversion==11){
           // 캔버스 사용
          defaultVersionImport();
          //lowVersionImport();
      } 
    } else {
        // 캔버스 사용
      defaultVersionImport();
      //lowVersionImport();
    }

    function defaultVersionImport() {

        var j = [   "../resources/test/three.min.js",
                    "../resources/test/CanvasRenderer.js",
                    "../resources/test/Projector.js",
                    "../resources/test/TweenMax.min.js",
                    "../resources/test/jquery-1.11.2.min.js",
                    "../resources/test/cmsPolygon.js",
                    "../resources/test/cmsMain.js"];

        for( var p in j ) {
            document.writeln("<script type='text/javascript' src='"+j[p]+"'><"+"/script>");
        }
    }

    function detectIE() {
      var ua = window.navigator.userAgent;
      var msie = ua.indexOf('MSIE ');
      if (msie > 0) {
        return parseInt(ua.substring(msie + 5, ua.indexOf('.', msie)), 10);
      }
      var trident = ua.indexOf('Trident/');
      if (trident > 0) {
        var rv = ua.indexOf('rv:');
        return parseInt(ua.substring(rv + 3, ua.indexOf('.', rv)), 10);
      }
      var edge = ua.indexOf('Edge/');
      if (edge > 0) {
        return parseInt(ua.substring(edge + 5, ua.indexOf('.', edge)), 10);
      }
      // other browser
      return false;
    }
})(this.language);
