KISSY.add("page/mods/main", function(a, b, c) {
    function d() {
        var a = this;
        a.init()
    }
    var e = a.Node.all;
    return d.prototype = {
        slider: null,
        lazyload: null,
        initSlider: function() {
            var c = this;
            a.use("utils/tool", function(a, d) {
                var f = {
                    contentClass: "slider-pannels",
                    pannelClass: "slider-pannel",
                    eventype: "mouseenter",
                    effect: "fade",
                    autoSlide: !0,
                    timeout: 5e3,
                    speed: 600,
                    hoverStop: !0
                };
                d.isMobile && a.mix(f, {
                    effect: "hSlide",
                    touchmove: !0,
                    carousel: !0
                }), c.slider = new b("#J_Slider", f);
                var g = e("#J_SliderPre"),
                    h = e("#J_SliderNext");
                g.length ? g.on("click", function() {
                    c.slider.previous()
                }) : "", h.length ? h.on("click", function() {
                    c.slider.next()
                }) : ""
            })
        },
        loadAnim: function(b) {
            var c = 300,
                d = b.parent(".post-thumb"),
                e = d.siblings(".slide-bg"),
                f = Math.abs(100 - Math.round(100 * Math.random())),
                g = (new Date).getTime() + f;
            a.later(function() {
                new a.Anim(e, {
                    height: "150px"
                }, {
                    duration: .6,
                    easing: "linear",
                    useTransition: !0
                }).run()
            }, f);
            var h = new Image;
            h.onload = function() {
                var b = (new Date).getTime(),
                    e = b - g,
                    f = 0;
                c >= e && (f = c - e), a.later(function() {
                    new a.Anim(d, {
                        height: "150px"
                    }, {
                        duration: .8,
                        easing: "linear",
                        useTransition: !0
                    }).run()
                }, f)
            }, h.onerror = function() {
                d.css("height", 150), b.hide()
            }, h.src = b.attr("src")
        },
        initLazyLoad: function() {
            var b = this;
            b.lazyload = new c({
                container: "#content",
                diff: {
                    top: 0,
                    right: 0,
                    bottom: -10,
                    left: 0
                }
            }), a.each(e(".wp-post-image"), function(a) {
                var c = e(a);
                b.lazyload.addCallback(c, function() {
                    b.loadAnim(c)
                })
            })
        },
        init: function() {
            var a = this;
            a.initLazyLoad(), e("body").hasClass("home") && a.initSlider()
        }
    }, d
}, {
    requires: ["gallery/slide/1.2/", "gallery/datalazyload/1.0.1/", "core"]
}), KISSY.add("page/init", function(a, b) {
    a.ready(function() {
        new b
    })
}, {
    requires: ["./mods/main"]
}), KISSY.config({
    combine: !0
}), KISSY.use("page/init");