Menu.load("menu");

cf=Dom.$("contentFrame");
lp=Dom.$("sidebar");


function fixIframeHeight(){
	var RH=cf.contentWindow.document.body.scrollHeight;
	var tx1 = cf.contentWindow.document.body.clientHeight;
	var tx2 = cf.contentWindow.document.body.offsetHeight;
	if(document.all)RH=cf.contentWindow.document.body.clientHeight; //IE 太没道理了，居然用这个
	cf.style.height=(lp.offsetHeight>=RH?lp.offsetHeight:RH)+'px'; //判断左边菜单栏 和右边栏哪个比较长  ，哪个长，就赋值哪个
}

Menu.onclick=function(a,b,c){//菜单被点击时的动作
    cf.style.height="440px";
	cf.style.height=lp.offsetHeight;
	if(b==false&&(Dom.hasChild(a,"A"))) { //发现 菜单项 无子菜单， 是一个连接，正在被点击
		fixIframeHeight();
	}else if(b==false&&(a.id!="undefined"&&a.id!=null)){ //发现是id 跳转的菜单项被点击了
		chapterJump(a);			//隐藏和显示 iframe 中相关 div
		fixIframeHeight();		//调整  iframe 高度
	} else if(b==true){ //发现被点击的菜单项有子菜单
		if(c==true){ //发现子菜单正在展开
			a.style.backgroundImage= ""; 
		}else{//子菜单正在关闭
			a.style.backgroundImage= "url(image/plus_black.png) ";
			
		}
	}
	//fixHeight();//调整高度
}

function chapterJump(obj){
	var id,o;
	if(obj&&obj!=null){
		var list=Dom.childNodes(obj.parentNode,"DIV");
		for(i=0; i<list.length; i++){
			if(list[i]!=obj){
				if((id=list[i].id)!=null)
				if((o=cf.contentWindow.document.getElementById(id))!=null)
				if(o.style){
					o.style.display="none";
				}
			}else break;
		}
		for(;i<list.length; i++){
			if((id=list[i].id)!=null)
			if((o=cf.contentWindow.document.getElementById(id))!=null)
			if(o.style){
				o.style.display="";
			}
		}
	}
}

window.setInterval("fixIframeHeight()", 500);//为了 IE 用这个太可恶了, IE 纯粹一个大垃圾 

