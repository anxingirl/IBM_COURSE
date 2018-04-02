/**
 * @author: 一只拖鞋 (Email: joknm12@163.com)
 * 
 * 基于jQuery的类似Google搜索的提示列表
 * 调用方式：$(input).tips(options);
 * options: 参数选项
 *		url  JOSN 获取URL地址
 *		param  获取JOSN数据时提交的参数名			
 *		leftText  提示列表左边显示文字的JSON字段
 *		rightText  提示列表右边显示文字的JSON字段
 *		inputText  点击提示列表后显示在输入框内容的JSON字段
 *		rightTextLength: 50, // 右边数字最长的长度
 *		leftTextLength:50, // 左边数字最长的长度
 *		
 *		hiddenId  隐藏域id 可选
 *		hiddenText  隐藏域值 可选
 *		width  提示列表宽度，可选(超宽时自动加宽, 默认为300)
 *		selectClass 选中样式
 *
 * 要求返回的JSON数据格式为：
 *		[{key:value,key:value...},{key:value,key:value...},...]
 *
 * 支持：IE, Firefox
 * @version: 1.0
 *		初始版本
 *
 * @version: 2.0
 *		修复问题：1、禁止浏览器自动完成功能
 *				  2、修复与其它JS兼容问题
 *				  3、鼠标经过时显示手状图
 * @version: 2.1
 *		修复问题：按回车无效，已修改
 *		添加功能：左边及右边字数显示的限制,默认为20个字/字符
 */
		function selectChange(id){

				// 去getMetaData中，验证Rsource表中是否有当前ID的字符
				$.ajax({
					url:'getMetaData.do',
					type:'POST',
					data:{ID:id},
					dataType:'json',
					error:function(){alert('can not get metadata');},
					success:function(result){
					$("#newFlag").val(result.newMetaData);
					if(result.newMetaData == 'Y')
						$("#theForm").clearForm();			
					else if(result.newMetaData == 'N')
						{
							$("input[name='schoolName']").val(result.SchoolName);
							$("input[name='users']").val(result.UserRole);
							$("input[name='teacher']").val(result.Teacher);
							$("input[name='knowPoints']").val(result.KeyPoints);
							$("input[name='keyPoints']").val(result.Keywords);
							$("textarea[name='suggest']").text(result.Suggestion);
							$("textarea[name='material']").text(result.Material);
							$("input[name='conExam'][value=" + result.TestContain + "]").attr("checked",true);
							$("input[name='conCase'][value=" + result.CaseContain + "]").attr("checked",true);
							$("input[name='conTest'][value=" + result.Experiment + "]").attr("checked",true);
					}
					}
				});
					
}
(function($){
	$.tips = function(input, options){
		var $input = $(input);
		var $tipsList = $("#tips-list-div-" + $input.attr("id"));
		var $hiddenTips = $("#tips-list-hidden-div-" + $input.attr("id"));
		
		$input.attr({"autocomplete":"off"}); // 禁止浏览器自动完成功能
		$input.focus(function(e){
			getData(e);
		});

		$input.blur(function(){

			setTimeout("jQuery('#tips-list-div-" + $input.attr("id")+"').slideUp('slow')", 100);
			
		});
		


		$input.keydown(processKey);

		$input.keyup(getData);
		
		function processKey(e) {
			if (testSpeKey(e) && ($tipsList.is(':visible') || getCurrentSelect())) {	            
	            if (e.preventDefault)
	                e.preventDefault();

				if (e.stopPropagation)
	                e.stopPropagation();
			    e.cancelBubble = true;
		        e.returnValue = false;
			
				switch(e.keyCode) {	
					case 38: // up
						prevSelect();
						break;			
					case 40: // down 
						nextSelect();
						break;
					case 13: // 回车
						selectCurrent();
						break;
				}
			}
		}
		//将选中的数值放到select中
		function setSelect(){
			
		}

		// 当前选中的li
		function getCurrentSelect() {			
			if (!$tipsList.is(':visible'))
				return false;
			
			var $currentSelect = $tipsList.children('ul').children('li.'+options.selectClass);
			if (!$currentSelect.length)
				$currentSelect = false;
					
			return $currentSelect;
		}
		
		// 将当前选中li返回到 input 中
		function selectCurrent() {		
			$currentSelect = getCurrentSelect();
		
			if ($currentSelect) {				
		
				$input.val($currentSelect.attr("inputText"));
				
				if($currentSelect.attr("hidenId")!=undefined && $currentSelect.attr("hidenId")!=null && $currentSelect.attr("hidenId")!=""){
					
					$("#"+$currentSelect.attr("hidenId")).val($currentSelect.attr("hiddenText"));
					
					$("#abbText").text($currentSelect.children(".right").text());
					
					selectChange($currentSelect.attr("hiddenText"));
					
				}
				
				hiddenTips();
				
				$input.blur();
				
			}		
		}
		
		// 向下选择
		function nextSelect() {		
			$currentSelect = getCurrentSelect();	
			if ($currentSelect)
				$currentSelect.removeClass(options.selectClass).next().addClass(options.selectClass);
			else
				$tipsList.children('ul').children('li:first-child').addClass(options.selectClass);		
		}
		
		// 向上选择
		function prevSelect() {		
			$currentResult = getCurrentSelect();
		
			if ($currentResult)
				$currentResult.removeClass(options.selectClass).prev().addClass(options.selectClass);
			else{
				$tipsList.children('ul').children('li:last-child').addClass(options.selectClass);			
			}

		}

		// 测试是否 特殊键
		function testSpeKey(e){			
			// handling up/down/escape requires results to be visible
			// handling enter/tab requires that AND a result to be selected
			if (/27$|38$|40$/.test(e.keyCode) || /^13$|^9$/.test(e.keyCode)) {	            
	            return true;
			}
		}

		// 通过AJAX获取json数据
		function getData(e){
			if(testSpeKey(e)){
				return;
			}
			if($input.val()!=""){
				var param = options.param;
				
				var pattern = new RegExp("^"+$input.val());
				//构建data 格式： "[{Ab:"IT",ID:25,ResourceName:"SOA"}]"
				var data = ''
				$.grep(options.value,function(key,val){
				//第一个是元素索引，第二个为当前值
					
					if(pattern.test(key[1])){
						
						var term = '{Ab:"'+key[2]+'",';
						term = term + 'ID:'+key[0]+',';
						term = term + 'ResourceName:'+'"' + key[1]+'"},';
						data = data+term;
					}
					
				});
				if(data!=''){
					
					data=data.substring(0,data.length-1);
	
				}
					data='['+data+']';
					displayDiv(eval(data));
					/*
				$.ajax({
					type: "POST",
					url: options.url,
					data: options.param+"="+$input.val(),
					success: function(data){
						displayDiv(eval(data));
					}
				}); 
				*/
			}else{
				hiddenTips();
			}
		}
		
		// 初始化提示列表 每次AJAX获取数据后调用
		function initTips(){
			$tipsList.find("ul").find("li").each(function(){
				$(this).mouseover(function(){
					$(this).addClass(options.selectClass);
				});
				$(this).mouseout(function(){
					$(this).removeClass(options.selectClass);
				});
				$(this).click(selectCurrent)
			});
		}

		// 清除样式
		function cleanClass(){
			$tipsList.find("ul").find("li").each(function(){
				$(this).removeClass(options.selectClass);
			});
		}
		
		// 显示提示列表
		function showTips(html){
			$tipsList.html(html);
			$hiddenTips.html(html);
			var offset = $input.offset();
			var height = $input.outerHeight();
			$tipsList.css("top", offset.top + height);
			$tipsList.css("left", offset.left);			
			var width = options.width
			initTips();	
			$hiddenTips.css("display", "block");
			$hiddenTips.find("li").each(function(){
				var span = $(this).find("span");
				var width1 = $(span[0]).width() +  $(span[1]).width() + 20;
				var width2 = $(this).width() + 20;
				var maxWidth = width1>width2?width1:width2;
				width = width>maxWidth?width:maxWidth;
			});
			$hiddenTips.css("display", "none");
			$tipsList.width(width);
			$tipsList.slideDown("slow");			
		}

		// 隐藏提示列表
		function hiddenTips(){
			$tipsList.slideUp("slow");
		}
		
		// 将JOSN数据生成DIV
		function displayDiv(json){
			var div = "<ul>";
			if(json.length<=0){
				div += "<li hidenId='' hiddenText='' inputText=''><span class='left'>无数据！</span><span class='right'></span></li>";
			}
			for(var i=0;i<json.length;i++){
				div += "<li ";
				if(options.hiddenId!=null){
					div += " hidenId='"+options.hiddenId+"' hiddenText='"+eval("json[i]."+options.hiddenText)+"' ";
				}
				div += "inputText='"+eval("json[i]."+options.inputText)+"'>";

				var lText = eval("json[i]."+options.leftText);
				if(lText!=undefined && lText!=null && lText.length>options.leftTextLength){
					lText = lText.substring(0, options.leftTextLength) + "...";
				}
				div += "<span class='left'>" + (lText==null?"":lText) + "</span>";

				var rText = eval("json[i]."+options.rightText);
				if(rText!=undefined && rText!=null && rText.length>options.rightTextLength){
					rText = rText.substring(0, options.rightTextLength) + "...";
				}
				div += "<span class='right'>"+(rText==null?"":rText)+"</span>";
				div += "</span></li>";
			}
			div += "</ul>";	
			showTips(div);
		}
	}

	$.fn.tips = function(options){
		options = options || {};
		options.url = options.url || ""; // 获取JSON数据的url地址
		options.value = options.value || ""; //获取value
		options.param = options.param || this.id; // 获取JOSN数据时提交的参数名
		options.width = options.width || 300; 
		options.rightTextLength = options.rightTextLength || 20;
		options.leftTextLength = options.leftTextLength || 20;

		options.leftText = options.leftText || "leftText"; // 提示列表左边显示文字的JSON字段
		options.rightText = options.rightText || "rightText"; // 提示列表右边显示文字的JSON字段
		options.inputText = options.inputText || "inputText"; // 点击提示列表后显示在输入框内容的JSON字段

		options.hiddenId = options.hiddenId || null; // 如有需要在隐藏域添加隐藏表单信息时，请填写隐藏域的 id
		options.hiddenText = options.hiddenText || "hiddenText"; // 如有需要在隐藏域添加隐藏表单信息时，隐藏域内容对应的JOSN字段
		options.selectClass = options.selectClass || "tips-div-hover"; // 选中样式

		if($("#tips-list-div-" + this.attr("id")).attr("class")==undefined){
			$(document.body).append("<div id='tips-list-div-"+this.attr("id")+"' class='tips-div'>1</div>");
		}
		if($("#tips-list-hidden-div-" + this.attr("id")).attr("class")==undefined){
			$(document.body).append("<div id='tips-list-hidden-div-"+this.attr("id")+"' style='width:20px;visibility:hidden;display:none;'>1</div>");
		}

		this.each(function(){
			new $.tips(this, options);
		});
	
		return this;
	}
})(jQuery)


/*

# 调用示例：  
# <input type="text" height="20px" id="myinput1" name="myinput1" value=""/>  
#   
# $("#myinput1").tips({  
#             url: "json.html", // JOSN 获取URL地址  
#             param: "myinput1", // 获取JOSN数据时提交的参数名             
#             leftText: "text",// 提示列表左边显示文字的JSON字段  
#             rightText: "text2", // 提示列表右边显示文字的JSON字段  
#             inputText: "text", // 点击提示列表后显示在输入框内容的JSON字段  
#			  rightTextLength: 20, // 右边数字最长的长度
#			  leftTextLength:20, // 左边数字最长的长度
#
#             hiddenId: "hid", // 隐藏域id 可选  
#             hiddenText: "id", // 隐藏域值 可选  
#             width: 100 // 提示列表宽度，可选  
#         });  
*/
