	var jsTimer = null;
		function showRequest(formData, jqForm, options) {   
        	var queryString = $.param(formData);   
         	//alert('queryString==' + queryString);   
        	return true;   
     	}  
     	function showResponse(responseText, statusText) {   
         	//alert('status: ' + statusText + '\n\nresponseText:'+responseText);  
         	var x = $(":input[name='"+responseText+"']");
         	//alert(x);
         	$(":input[name='"+responseText+"']").remove(); 
     	} 
     	var options = {
				beforeSubmit: showRequest,
				success: showResponse
			};   
     	//生成一个对象盒子,面向对象思想，封装我们的函数，强烈推荐这种方法
		var box = {};
		box.getFile = function(filenum){
		//行号是从1开始，最后一行是新增，删除保存，按钮行，故减去1
			var td1 = "<td class='file-row'>文件"+filenum+":</td>";
     		var td2 = "<td><input type='file'   name='uploadfile"+filenum+"' id='uploadfile"+filenum+"' class='file'><input type='text' readonly='' name='path"+filenum+"' class='txt'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' value='浏览文件' name='select' class='small-button sel'></td>";
     		var td3 = "<td class='form-button'></td>";
     		var td4 = "<td class='column-short form-button'><input type='button' value='上传' id='uploadbutton" +filenum+ "' name='up' class='uploadbutton small-button'></td>";
     		var td5 = "<td class='pic'></td>";
     		var tr1 = "<tr class='tab-row'>" + td1 + td2 + td3 + td4 + td5 + "</tr>";
     		var tr2 = "<tr class='tab-row'><td colspan='4'></td><td class='progressText'></td></tr>";
		 	return tr1+tr2;
		//返回任何你需要生成的新元素
		}
	
		box.getClick = function(target){
		//点击上传，找到当前uploadfile[a]中的文件名，看看是否有文件 
			//当前button的tr中的input file
			var file = $(target).closest("tr").find("input[name^='uploadfile']");
			var filename = file.val();
				if(filename=='')
				{
					alert("没有选择要上传的文件，请选择");
					return;
				}
				//当前“上传”按钮取消
				$(target).attr("disabled","true");
				var x = $(target).parent().prev().children("input");
				var y = $(target).parent().prev().prev().children("input[name='select']");
				$(target).parent().prev().children("input").attr("disabled","true");
				$(target).parent().prev().prev().children("input[name='select']").attr("disabled","true");
				
				//增加进度内容,当前button的tr中的td class="progressText"
				
				//alert('y:---------------------------' + y.html());
				
				$(target).closest("tr").next().find("td.progressText").html("<p class='activeProgress'></p>");
				
			
				//增加进度条图片
				$(target).closest("tr").find("td.pic").html("<div class='progressbar'></div>");
				
			
				$(".progressbar").progressbar({	
					value: 0,
					diabled: true
				});
				
				//上传
				$("#theForm").attr("action","fileupload");
				
				$("#theForm").ajaxSubmit(options);
				
				//开始计算得到进度
				setTimeout("jsTimer = setInterval(function(){getProgress();},1000)",1000);

				//清除当前input file文件
				//file.remove();
		
	}
     	
     	//客户端动态添加行
     	function formAddRow(){
     		var rownum=$("#theTable tr").length-3;
     		var filenum = rownum/2 + 1;
     		rownum+=1;
     		var x = $("#theTable tr:eq("+rownum+")");
     		$(box.getFile(filenum)).insertAfter($("#theTable tr:eq("+rownum+")"));
     		
     		//绑定click事件,其它change事件类似
			$("#uploadbutton"+filenum).click(function(){
				box.getClick(this);
			});
     	}
     	
     	var OldTime = 0;
     	
     	var times = 0;
     	
     	//use ajax jquery.get to get the progress situation
     	
     	function getProgress(){
     		
     		var percent = 0;
     		
     		var protr = $("div.progressbar").closest("tr");
     		
     		$.ajax({ url: "showProgress.do", type:"POST", dataType:"json",success: function(data){
   				  
     			var percent = parseInt(data.percent);
  
     			$("p.activeProgress").html("<span>已上传" + percent+"%</span>");
     			
     			$("p.activeProgress").append("<span>速度" + data.upRate+"</span>");
     			
     			$("p.activeProgress").append("<span>花费" + data.useTime+"秒 </span>");
     			
     			$("p.activeProgress").append("<span>共" + data.allSize+"byte</span>");
     			
     			$("div.progressbar").progressbar("value",percent);
     			
     			
     			if (percent == 100) {
     					
     					//上传完成，取消计算
     					window.clearInterval(jsTimer);
     					//去掉activeProgress元素

     					alert("上传完成！");
     				$("p.activeProgress").remove();
     				$("div.progressbar").remove();
     				$(":input[name^='uploadfile']").remove();
     				//上传文件完成后，将“添加”按钮设置为可用
     				$("#insertButton").attr("disabled",false);
     				
     				protr.find(":input.txt").css("top","0px");
     		        protr.find(":input.sel").css("top","0px");
     		        
     				}else{
     			if(data.useTime <= OldTime ){
     				
     				times = times +1 ;
     				 if(times > 40){
              			//上传完成，取消计算
         				window.clearInterval(jsTimer);
         				//去掉activeProgress元素
         				alert("上传过程出现停滞！");
         	
         			$("p.activeProgress").remove();
     				$("div.progressbar").remove();
     				//上传文件完成后，将“添加”按钮设置为可用
     				$("#insertButton").attr("disabled",false);
     				$(":input[name^='uploadfile']").remove();
     				 protr.find(":input.txt").css("top","0px");
     		        protr.find(":input.sel").css("top","0px");
          			}
     			}else{
     				OldTime = data.useTime;
     			}
     			   
     		}
     		 		
				}});

     	}
     	//验证资源名称 和 简称 
     	function checkValid(){
     		var wholename = $.trim($("input[name='wholename']").val());
     		var shortname = $.trim($("input[name='shortname']").val());
     		var flag = '';//用来记录返回的route验证 ，因为不能 想到更好的办法去return false
     		//是否写了名字 和 缩写 
     			if( wholename== "" || shortname == "" ){
     				$("#remind").html('<div class="input_tip_wrong">名称和缩写不能为空值<div>');
     				return false;
     			}
     			
     			
     		//是否有效的 名字和缩写(没有空格 ，缩写只能是字母和数字，)
     			//是否有空格 
     			if(wholename.indexOf(" ")>-1){
     				$("#remind").html('<div class="input_tip_wrong">名称 不能含有空值</div>');
     				return false;
     			}
     			if(shortname.indexOf(" ")>-1){
     				$("#remind").html('<div class="input_tip_wrong">缩写不能含有空值</div>');
     				return false;
     			}
     		    reg = /^[a-zA-Z0-9]{1,}$/;
     			if (!reg.test(shortname)){
     				$("#remind").html('<div class="input_tip_wrong">缩写只能使用英文字符和数字</div>');
      				return false;
     			}
     		
     		//是否缩写在数据库中已经有了    			
     			$.ajax({
     				url: "getUsedRoute.do",
     				type: "GET",
     				dataType: "text",
     				data: "userRoute="+shortname,
     				async: false,
     				success: function(data) {
						//alert(data);
						if(data == 'true'){
						$("#remind").html('<div class="input_tip_wrong">已有该简称的资源,请修改</div>');
						flag = 'false';
						}
					} 
     			});
     			if(flag == 'false'){return false;}
     			
     	}
		
	
		
     	$(document).ready(function(){
     		
     		//赋予select 时间选择项时间
     		var d = new Date();
     		var vYear = d.getFullYear();
     		var startYear = 1980;
     		
     		for(i = 0; i <40;i=i+1){
     			startYear = startYear+1;
     			$("select").append("<option value='"+startYear+"'>"+startYear+"</option>"); 
     			
     		}
     		$("select").val(vYear);    
     		//绑定input uploadfile ，每次改变文件，相应的input text也会改变
     		$("input[name^='uploadfile']").live('change',function(event){
     			$(event.target).next().val($(event.target).val());
     			
     		});
     	
			$("#insertButton").click(function(){
				
				if($("#cof").attr("checked")=="checked")
				{
					alert("已经勾选一个文件，不能添加更多的文件");
					return;
				}
				 formAddRow();
				//添加完了一个新的空file,将“添加”按钮设置成为不可用
				$(this).attr("disabled","disabled");
				
				//已经有了新的文件，那么勾选一个的checkbox设置为不可用
				$("#cof").attr("disabled","disabled");
			});
			
			$(".uploadbutton").click(function(){
				box.getClick(this);
			});
			//点击确定提交按钮，然后呢
			$("#finalConfirmButton").click(function(){
				
				//确认“名称”、“简称”、“路径”是不是都存在（确认可行）
				if(checkValid() == false){
					return;
				}
				var name = $("input[name='wholename']").val();
				var ab = $("input[name='shortname']").val();
				var route = ab;
				var tmpName = $("input[name='tmpName']").val();
				var year = $("select").val();   
				var cof = ($("#cof").attr("checked")=="checked")?"true":"false";
				var file1 = $("input[name='path1']").val();
				
				
				
				//增加这个资源到ResourceSummary表中  servlet : resourceUpload; bean: course
				//servlet新建一个course 由course自己把自己添加到数据库中
				//将已经传输的文件放到用户定义的新路径下
			   $.post("resourceUpload.do",{name:name,ab:ab,route:route,tmpName:tmpName,year:year,cof:cof,file1:file1},function(result){
				   alert(result);
    			});
			   
				//新建一个文件夹 /web/course/route
			});
			
			
     	});  

     	
	    function clearfile(a){
	    	
			//取消 ， 清空当前文件 
			//$("#uploadfile" +a ).remove();
			var t = $("#uploadfile" +a );
			//alert($("#uploadfile" + a).click());
			$("input[name='path"+a+"']").val(''); 
		}
		