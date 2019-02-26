;(function( $ ){
	
    var POLY;
    //var loginURL    = "cms_k_p91";
    $(document).ready(init);
    $(window).on("load resize",resizeHandler);
    
    function init() {

        //POLY = new cmsLowVersion(this);

        if(window.WebGLRenderingContext){
            POLY = new CMSPolygon(this);
        } else {
            POLY = new cmsLowVersion(this);
        }
        POLY.init();
       /**
        * 등장모션
        */
        TweenMax.fromTo($("#nav"),1, {alpha:0},{alpha:1});
        TweenMax.fromTo($("#logo"),0.7,{y:100,alpha:0},{delay:0.2, y:0,alpha:1 ,ease:Power4.easeOut,onComplete:function() {
            POLY.start();
        }});
    }

    /**
     * window resize
     */
    function resizeHandler(e) {

        var w = $(window).innerWidth();
        var h = $(window).innerHeight();
        if( POLY ) {
            POLY.resize(e);
        }
    }
   
    function fromTo(tar, dur, obj1, obj2) {
        TweenMax.fromTo(tar, dur, obj1, obj2);
    }

})( jQuery );
