KISSY.add("page/mods/main", function(a) {
    function b() {
        var a = this;
        a.init()
    }
    var c = a.Node.all;
    return b.prototype = {
        windowChangeCB: function() {
            var a = document.documentElement && document.documentElement.scrollTop || document.body.scrollTop,
                b = c(".post"),
                d = c(".post-op"),
                e = b.outerHeight() + b.offset().top,
                f = (d.outerHeight(), c(window).height());
            f > e - a ? d.removeClass("fixed") : d.addClass("fixed")
        },
        watchWindow: function() {
            var a = this;
            c(window).on("scroll resize", function() {
                a.windowChangeCB()
            }), a.windowChangeCB()
        },
        scrollToNode: function(b) {
            var c = b.offset().top - 100;
            return new a.Anim(window, {
                scrollTop: c
            }, {
                duration: .3,
                queue: "scrollTopAnim"
            }).run(), !1
        },
        addEvent: function() {
            var b = this;
            c(".J_CommentInput").on("valuechange", function() {
                var b = c(this),
                    d = a.trim(b.val()),
                    e = b.parent(".J_CommentForm"),
                    f = e.one(".J_SubmitComment");
                d ? f.addClass("active") : f.removeClass("active")
            }), c(".J_Reply").on("click", function() {
                var a = c(this),
                    d = a.parent(".comment"),
                    e = c("#respond"),
                    f = e.one(".J_CommentInput"),
                    g = d.attr("data-id"),
                    h = d.attr("data-username");
                e.one(".J_ParentId").val(g), e.one(".J_UserToReply").html("@" + h), e.one(".J_UserReply").show(), f.attr("placeholder", f.attr("data-reply")+ " " + h + " :"), b.scrollToNode(e), f.fire("focus")
            }), c(".J_DelUser").on("click", function() {
                var a = c(this),
                    b = a.parent("#respond"),
                    d = b.one(".J_CommentInput");
                b.one(".J_ParentId").val(0), b.one(".J_UserReply").fadeOut(.3, function() {
                    b.one(".J_UserToReply").html("")
                }, "easeOut"), d.attr("placeholder", d.attr("data-default"))
            }), c(".J_CommentForm").on("submit", function() {
                var b = c(this),
                    d = b.one(".J_CommentInput"),
                    e = a.trim(d.val());
                return e ? !0 : (new a.Anim(d, {
                    borderColor: "#ff5f3e"
                }, {
                    duration: .5,
                    complete: function() {
                        new a.Anim(d, {
                            borderColor: "#ddd"
                        }, {
                            duration: .4
                        }).run()
                    }
                }).run(), d.fire("focus"), !1)
            })
        },
        init: function() {
            var b = this;
            b.addEvent(), a.use("utils/tool", function(a, c) {
                c.isMobile || b.watchWindow()
            })
        }
    }, b
}, {
    requires: ["core"]
}), KISSY.add("page/init", function(a, b) {
    a.ready(function() {
        new b
    })
}, {
    requires: ["./mods/main"]
}), KISSY.config({
    combine: !0
}), KISSY.use("page/init");