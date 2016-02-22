(function (L) {
    var _this = null;
    L.Topic = L.Topic || {};
    _this = L.Topic = {
        data: {
        	topic_id:0
        },
 
        init: function (topic_id) {
        	_this.data.topic_id = topic_id;

        	//获取文章
        	$.ajax({
	            url : '/topic/' + topic_id + '/query',
	            type : 'get',
	            data: {},
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
	                	var tpl = $("#topic-body-tpl").html();
	                	result.data.topic.content = result.data.topic.content || "";
	                	result.data.topic.content = marked(result.data.topic.content);

			            var html = juicer(tpl, result.data);
			            $("#topic-body").html(html).show();
			            $("#reply").show();

			            var tpl2 = $("#ops-area-tpl").html();
			            var html2 = juicer(tpl2, result.data);
			            $("#ops-area").html(html2);
			            

			            _this.loadComments();
        				_this.initEvents();

        				emojify.run(document.getElementById('article-content'));
	                }else{
	                    L.Common.showTipDialog("提示", result.msg);
	                }
	            },
	            error : function() {
	            	L.Common.showTipDialog("提示", "发送请求失败.");
	            }
	        });
        },

        initEvents: function(){
        	_this.initCollectEvent();
        	_this.initLikeEvent();
        	_this.initReplyEvent();
        	_this.initDeleteTopic();
        	_this.initDeleteComment();
        },

        initDeleteTopic: function(){
        	$(document).on("click", ".delete-topic", function(){
        		var topic_id = $(this).attr("data-id");
        		$.ajax({
                    url : '/topic/'+topic_id+'/delete',
                    type : 'get',
                    data : {},
                    dataType : 'json',
                    success : function(result) {
                        if(result.success){
                        	window.location.href="/";
                        }else{
                            L.Common.showTipDialog("提示", result.msg);
                        }
                    },
                    error : function() {
                        L.Common.showTipDialog("提示", "删除文章请求发生错误");
                    }
                });
        	});
        },

         initDeleteComment: function(){
            $(document).on("click", ".delete-comment", function(){
                var comment_id = $(this).attr("data-id");
                $.ajax({
                    url : '/comment/'+comment_id+'/delete',
                    type : 'get',
                    data : {},
                    dataType : 'json',
                    success : function(result) {
                        if(result.success){
                            $("#reply_"+comment_id).remove();
                            $(".total-comment-count").each(function(){
				            	var last_count = 0;
				            	try{
				            		last_count = parseInt($(this).text());
				            	}catch(e){}
				            	if(last_count>=1){
				            		$(this).text(last_count-1);
				            	}
							});
                        }else{
                            L.Common.showTipDialog("提示", result.msg);
                        }
                    },
                    error : function() {
                        L.Common.showTipDialog("提示", "删除评论请求发生错误");
                    }
                });
            });
        },



        initReplyEvent:function(){
			$("#reply-btn").click(function(){
        		var reply_content = $("#reply_content").val();
        		if(!reply_content){
        			return;
        		}

        		if(reply_content.length>2500){
        			L.Common.showTipDialog("提示", "评论内容长度不得超过2500字符，当前字符数" + reply_content.length + ".");
        			return;
        		}

				$.ajax({
		            url : '/comment/new',
		            type : 'post',
		            data: {
		            	topic_id: _this.data.topic_id,
		                content: reply_content
		            },
		            dataType : 'json',
		            success : function(result) {
		                if(result.success){
		                	var data = result.data || {};
		                	var tpl = $("#single-comment-item-tpl").html();
				            var comment = data.c || {};
					        comment.content = marked(comment.content);

							var html = juicer(tpl, data);
				            $("#comments-body").append(html);
				            emojify.run(document.getElementById('reply_'+comment.id));

				            $("#reply_content").val("");
				            var alert_div = $("#comments-body .alert");
				            alert_div.hide();

				            $("#replies").show();
				            $(".total-comment-count").each(function(){
				            	var last_count = 0;
				            	try{
				            		last_count = parseInt($(this).text());
				            	}catch(e){}
				            	 
								$(this).text(last_count+1);
							});
		                }else{
		                    L.Common.showTipDialog("提示", result.msg);
		                }
		            },
		            error : function() {
		            	L.Common.showTipDialog("提示", "发送请求失败.");
		            }
		        });

        	});
        },

        initCollectEvent:function(){
			$("#collect-btn").click(function(){
        		var op = $(this).attr("data-op");
        		var topic_id = $(this).attr('data-id');
        		var _self = $(this);

        		if(op=="collect"){
        			$.ajax({
			            url : '/topic/collect',
			            type : 'post',
			            data: {
			                topic_id: topic_id
			            },
			            dataType : 'json',
			            success : function(result) {
			                if(result.success){
			                	_self.attr("data-op", "cancel_collect");
			                	_self.addClass("active");
			                	$("#collect-num-text").text(parseInt($("#collect-num-text").text())+1);
			                }else{
			                    L.Common.showTipDialog("提示", result.msg);
			                }
			            },
			            error : function() {
			            	L.Common.showTipDialog("提示", "发送请求失败.");
			            }
			        });
        		}else if(op=="cancel_collect"){
        			$.ajax({
			            url : '/topic/cancel_collect',
			            type : 'post',
			            data: {
			                topic_id: topic_id
			            },
			            dataType : 'json',
			            success : function(result) {
			                if(result.success){
			                	_self.attr("data-op", "collect");
			                	_self.removeClass("active");
			                	$("#collect-num-text").text(parseInt($("#collect-num-text").text())-1);
			                }else{
			                    L.Common.showTipDialog("提示", result.msg);
			                }
			            },
			            error : function() {
			                L.Common.showTipDialog("提示", "发送请求失败.");
			            }
			        });
        		}
        	});
        },

        initLikeEvent:function(){
			$("#like-btn").click(function(){
        		var op = $(this).attr("data-op");
        		var topic_id = $(this).attr('data-id');
        		var _self = $(this);

        		if(op=="like"){
        			$.ajax({
			            url : '/topic/like',
			            type : 'post',
			            data: {
			                topic_id: topic_id
			            },
			            dataType : 'json',
			            success : function(result) {
			                if(result.success){
			                	_self.attr("data-op", "cancel_like");
			                	_self.addClass("active");
			                	$(".like-num-text").each(function(){
			                		$(this).text(parseInt($(this).text())+1);
			                	});
			                }else{
			                    L.Common.showTipDialog("提示", result.msg);
			                }
			            },
			            error : function() {
			            	L.Common.showTipDialog("提示", "发送请求失败.");
			            }
			        });
        		}else if(op=="cancel_like"){
        			L.Common.showTipDialog("提示", "已赞过的文章不允许取消赞.");
        			// $.ajax({
			        //     url : '/topic/cancel_like',
			        //     type : 'post',
			        //     data: {
			        //         topic_id: topic_id
			        //     },
			        //     dataType : 'json',
			        //     success : function(result) {
			        //         if(result.success){
			        //         	_self.attr("data-op", "like");
			        //         	_self.removeClass("active");
			        //         	$(".like-num-text").each(function(){
			        //         		$(this).text(parseInt($(this).text())-1);
			        //         	});
			        //         }else{
			        //             L.Common.showTipDialog("提示", result.msg);
			        //         }
			        //     },
			        //     error : function() {
			        //         L.Common.showTipDialog("提示", "发送请求失败.");
			        //     }
			        // });
        		}
        	});
        },

        loadComments: function(pageNo){
        	pageNo = pageNo || 1;
        	$.ajax({
	            url : '/comments/all',
	            type : 'get',
	            cache: false,
	            data: {
	                page_no: 1,
	                topic_id: _this.data.topic_id
	            },
	            dataType : 'json',
	            success : function(result) {
	                if(result.success){
	                	if(!result.data || (result.data && result.data.comments.length<=0)){
	                		$("#comments-body").html('<div class="alert alert-info" role="alert">没有任何评论内容</div>')
	                	}else{
	                		 _this.page(result, 1);
	                		 $("#replies").show();
	                	}
	                }else{
	                    $("#comments-body").html('<div class="alert alert-danger" role="alert">'+result.msg+'</div>');
	                }
	            },
	            error : function() {
	                $("#comments-body").html('<div class="alert alert-danger" role="alert">发送请求失败.</div>');
	            }
	        });
        },

        page: function(result, pageNo){
			var data = result.data || {};
			var $container = $("#comments-body");
			$container.empty();

			var tpl = $("#comment-item-tpl").html();
			var comments = data.comments || [];
			for(var i = 0; i<comments.length; i++){
	            comments[i].content = marked(comments[i].content);
			}
            var html = juicer(tpl, data);
            $container.html(html);
            for(var i = 0; i<comments.length; i++){
            	emojify.run(document.getElementById('reply_'+comments[i].id));
            }

			var currentPage = data.currentPage;
			var totalPage = data.totalPage;
			var totalCount = data.totalCount;
			$(".total-comment-count").each(function(){
				$(this).text(totalCount||0);
			});
			if (totalPage > 1) {
				$("#comment-pagebar").show();
				$.fn.jpagebar({
					renderTo : $("#comment-pagebar"),
					totalpage : totalPage,
					totalcount : totalCount,
					pagebarCssName : 'pagination2',
					currentPage : currentPage,
					onClickPage : function(pageNo) {
						$.fn.setCurrentPage(this, pageNo);
						$.ajax({
							url : '/comments/all',
				            type : 'get',
				            cache: false,
				            data: {
				                page_no: pageNo,
	                			topic_id: _this.data.topic_id
				            },
							dataType : 'json',
							success : function(result) {
								var data = result.data || {};
								var $container = $("#comments-body");
								$container.empty();

								var tpl = $("#comment-item-tpl").html();
								var comments = data.comments || [];
								for(var i = 0; i<comments.length; i++){
						            comments[i].content = marked(comments[i].content);
								}
					            var html = juicer(tpl, data);
					            $container.html(html);
					            for(var i = 0; i<comments.length; i++){
					            	emojify.run(document.getElementById('reply_'+comments[i].id));
					            }
							},
							error : function() {
								 $("#comments-body").html('<div class="alert alert-danger" role="alert">发送查找评论请求失败.</div>');
				            }
						});
					}
				});
			} else {
				$("#comment-pagebar").hide();
			}
        },
        
    };
}(APP));