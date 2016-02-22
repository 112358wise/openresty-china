(function (L) {
    var _this = null;
    L.Common = L.Common || {};
    _this = L.Common = {
        data: {},
 
        init: function () {
            marked.setOptions({
              highlight: function (code) {
                return hljs.highlightAuto(code).value;
              }
            });
            

            emojify.setConfig({
                img_dir: '/static/libs/emojify/images/basic',  // Directory for emoji images
            });

        },

        showTipDialog: function (title, content) {
            if (!content) {
                content = title;
                title = "Tips";
            }
            var d = dialog({
                title: title || 'Tips',
                content: content,
                width: 350,
                cancel: false,
                ok: function () {
                }
            });
            d.show();
        },
        
        resetNav: function(select){
            $("#main-nav-menu li").each(function(){
                $(this).removeClass("active")
            });

            if(select){
                $("#main-nav-menu li#"+select).addClass("active");
            }
        },
 
        formatDate: function (now) {
            var year = now.getFullYear();
            var month = now.getMonth() + 1;
            var date = now.getDate();
            var hour = now.getHours();
            var minute = now.getMinutes();
            var second = now.getSeconds();
            if (second < 10) second = "0" + second;
            return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
        }
    };
}(APP));