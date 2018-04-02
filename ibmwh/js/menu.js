///////////////////////////////////////////////
//	作者: Chen Minqiang<ptpt52@gmail.com>
//	时间: Monday, July 13 2009
//////////////////////////////////////////////


///////////////////////////////////////////////
//
//	用法，页面加载完成后调用 Menu.load(id) 即可, id 为菜单最外层的 div 的 id
//
//	下面是用户定义函数说明
//
//	注意: 以下的用户定义函数一般在 Menu.load(id) 被调用之前
//
////////////////////////////////////////////////

////////////////////////////////////////////////
//
//	定义如下函数，将在菜单项被鼠标点击时候运行
//	你可以这样定义
//
//	Menu.onclick=function(arg0,arg1,arg2){
//		//TO DO
//	}
//
//	参数约定:
//@:	arg0	被点击的菜单项对应的 div 对象
//@:	arg1	值为: true/false  true 表示该菜单项可展开或有子菜单项; false 表示该菜单项不可展开或无子菜单项
//@:	arg2	值为: true/false  true 表示该菜单项正在展开; false 表示子项处于关闭状态
//	说明:	arg2 存在的前提是 arg1==true
//
////////////////////////////////////////////////

////////////////////////////////////////////////
//
//	定义如下函数，将在菜单项被鼠标飘浮在上面的时候运行
//	你可以这样定义
//
//	Menu.onmouseover=function(arg0,arg1,arg2){
//		//TO DO
//	}
//
//	参数约定:
//@:	arg0	菜单项对应的 div 对象
//@:	arg1	值为: true/false  true 表示该菜单项可展开或有子菜单项; false 表示该菜单项不可展开或无子菜单项
//@:	arg2	值为: true/false  true 表示子项处于展开状态; false 表示该菜单项正在关闭
//	说明:	arg2 存在的前提是 arg1==true
//
////////////////////////////////////////////////

////////////////////////////////////////////////
//
//	定义如下函数，将在鼠标离开菜单项的时候运行
//	你可以这样定义
//
//	Menu.onmouseout=function(arg0,arg1,arg2){
//		//TO DO
//	}
//
//	参数约定:
//@:	arg0	菜单项对应的 div 对象
//@:	arg1	值为: true/false  true 表示该菜单项可展开或有子菜单项; false 表示该菜单项不可展开或无子菜单项
//@:	arg2	值为: true/false  true 表示子项处于展开状态; false 表示该菜单项正在关闭
//	说明:	arg2 存在的前提是 arg1==true
//
////////////////////////////////////////////////



///////////////////////////////////////////////////////
Dom={
	$:function(a){
		if(document.getElementById){
			return eval('document.getElementById("' + a + '")');
		}else if(document.layers){
			return eval("document.layers['" + a +"']");
		}else{
			return eval('document.all.' + a);
		}
	},
	attachEvent:function(a,b,d){
		if(a&&a!=null){
			if (a.addEventListener) {
				return a.addEventListener(b, d, false)
			}
			if (a.attachEvent) {
				return a.attachEvent("on" + b, d)
			}
		}
	},
	nextSibling:function(a,tag){
		if(a&&a!=null){
			if(tag){
				var b=a.nextSibling;
				while(b!=null){
					if(b.nodeName.toUpperCase()==tag.toUpperCase())
						return b;
					b=b.nextSibling;
				}
			}else{
				var b=a.nextSibling;
				while(b!=null){
					if(b.nodeType==1)return b;
					b=b.nextSibling;
				}
			}
		}
		return null;
	},
	previousSibling:function(a,tag){
		if(a&&a!=null){
			if(tag){
				var b=a.previousSibling;
				while(b!=null){
					if(b.nodeName.toUpperCase()==tag.toUpperCase())
						return b;
					b=b.previousSibling;
				}
			}else{
				var b=a.previousSibling;
				while(b!=null){
					if(b.nodeType==1)return b;
					b=b.previousSibling;
				}
			}
		}
		return null;
	},
	firstChild:function(a,tag){
		if(a&&a!=null){
			if(tag){
				var b=a.firstChild;
				while(b!=null){
					if(b.nodeName.toUpperCase()==tag.toUpperCase())
						return b;
					b=b.nextSibling;
				}
			}else{
				var b=a.firstChild;
				while(b!=null){
					if(b.nodeType==1)return b;
					b=b.nextSibling;
				}
			}
		}
		return null;
	},
	lastChild:function(a,tag){
		if(a&&a!=null){
			if(tag){
				var b=a.lastChild;
				while(b!=null){
					if(b.nodeName.toUpperCase()==tag.toUpperCase())
						return b;
					b=b.previousSibling;
				}
			}else{
				var b=a.lastChild;
				while(b!=null){
					if(b.nodeType==1)return b;
					b=b.previousSibling;
				}
			}
		}
		return null;
	},
	childNodes:function(a,tag){
		var c=new Array();
		if(a&&a!=null){
			if(tag){
				var b=a.childNodes;
				var p=0;
				for(var i=0; i<b.length; i++){
					if(b[i].nodeName.toUpperCase()==tag.toUpperCase())
						c[p++]=b[i];
				}
			}else{
				var b=a.childNodes;
				var p=0;
				for(var i=0; i<b.length; i++){
					if(b[i].nodeType==1)c[p++]=b[i];
				}
			}
		}
		return c;
	},
	hasChild:function(a,tag){
		if(a&&a!=null){
			if(tag){
				var b=a.childNodes;
				for(var i=0; i<b.length; i++){
					if(b[i].nodeName.toUpperCase()==tag.toUpperCase())
						return true;
				}
			}else{
				var b=a.childNodes;
				var p=0;
				for(var i=0; i<b.length; i++){
					if(b[i].nodeType==1)return true;
				}
			}
		}
		return false;
	}
};

Menu={
	attachEvent:function(o){
		Dom.attachEvent(o,"click",Menu.click);
		//Dom.attachEvent(o,"mouseover",Menu.mouseover);
		//Dom.attachEvent(o,"mouseout",Menu.mouseout);
	},
	hideBrother:function(a){
		var p=a.parentNode;
		while((p=Dom.previousSibling(p,"DIV"))!=null){
			Menu.hideUnder(p);
		}
		p=a.parentNode;
		while((p=Dom.nextSibling(p,"DIV"))!=null){
			Menu.hideUnder(p);
		}
	},
	hideUnder:function(a){
		var childs=Menu.getChildItems(a);
		if(childs!=null){
			if(childs.length==2){
				if(Menu.hasChildItem(childs[0])){
					Menu.hideUnder(childs[0]);
					Menu.hideUnder(childs[1]);
					return;
				}else{
					if(Menu.hasChildItem(childs[1])){
						Menu.hide(childs[0]);
						Menu.hideUnder(childs[1]);
						return;
					}
				}
			}else
			for(var i=0; i<childs.length; i++){
				if(Menu.hasChildItem(childs[i])){
					Menu.hideUnder(childs[i]);
				}
			}
		}
	},
	hide:function(a){
		Dom.nextSibling(a,"DIV").style.display="none";
	},
	show:function(a){
		Dom.nextSibling(a,"DIV").style.display="";
	},
	getChildItems:function(a){
		return Dom.childNodes(a,"DIV");
	},
	hasChildItem:function(a){
		return Dom.hasChild(a,"DIV");
	},
	getstatus:function(a){
		var childs;
		if((childs=Menu.getChildItems(a.parentNode)).length==2){
			if(Menu.hasChildItem(childs[1])){
				if(childs[1].style.display!="none")//这个地方要改改
					return 1;
				else
					return 2;
			}else{
				return 3;
			}
		}else{
			return 3;
		}
	},
	init:function(root){
		var childs=Menu.getChildItems(root);
		if(childs!=null){
			if(childs.length==2){
				if(Menu.hasChildItem(childs[0])){
					Menu.init(childs[0]);
					Menu.init(childs[1]);
					return;
				}else{
					Menu.attachEvent(childs[0]);
					if(Menu.hasChildItem(childs[1])){
						Menu.hide(childs[0]);
						Menu.init(childs[1]);
						return;
					}else{
						Menu.attachEvent(childs[1]);
					}
				}
			}else
			for(var i=0; i<childs.length; i++){
				if(Menu.hasChildItem(childs[i])){
					Menu.init(childs[i]);
				}else{
					Menu.attachEvent(childs[i]);
				}
			}
		}
	},
	load:function(id){
		var root=Dom.$(id);
		if(root!=null){
			Menu.init(root);
		}
	},
	click:function(){
		var o=window.event?window.event.srcElement:this;//获得被点击对象
		if(o.nodeName.toUpperCase()=="A")o=o.parentNode; //是连接
		switch(Menu.getstatus(o)){
			case 1:
				Menu.hide(o);
				//Menu.hideUnder(Dom.nextSibling(o,"DIV"));
				if(typeof Menu.onclick == "function"){//调用用户函数
					Menu.onclick(o,true,false);//被点击，有子项，正在关闭
				}
			break;
			case 2:
				Menu.show(o);
				//Menu.hideBrother(o);  //隐藏其他的项
				if(typeof Menu.onclick == "function"){//调用用户函数
					Menu.onclick(o,true,true);//被点击，有子项，正在展开
				}
			break;
			case 3:
				Menu.hideBrother(o.childNodes[0]); //隐藏其他的项 
				if(typeof Menu.onclick == "function"){//调用用户函数
					Menu.onclick(o,false);//被点击，无子项
				}
			break;
		}
	},
	mouseover:function(){
		var o=window.event?window.event.srcElement:this;//获得对象 
		switch(Menu.getstatus(o)){
			case 1:
				if(typeof Menu.onmouseover == "function"){//调用用户函数
					Menu.onmouseover(o,true,false);//鼠标飘过，有子项，子项处于关闭状态
				}
			break;
			case 2:
				if(typeof Menu.onmouseover == "function"){//调用用户函数
					Menu.onmouseover(o,true,true);//鼠标飘过，有子项，子项处于展开状态
				}
			break;
			case 3:
				if(typeof Menu.onmouseover == "function"){//调用用户函数
					Menu.onmouseover(o,false);//鼠标飘过，无子项
				}
			break;
		}
	},
	mouseout:function(){
		var o=window.event?window.event.srcElement:this;//获得对象 
		switch(Menu.getstatus(o)){
			case 1:
				if(typeof Menu.onmouseout == "function"){//调用用户函数
					Menu.onmouseout(o,true,false);//鼠标离开，有子项，子项处于关闭状态
				}
			break;
			case 2:
				if(typeof Menu.onmouseout == "function"){//调用用户函数
					Menu.onmouseout(o,true,true);//鼠标离开，有子项，子项处于展开状态
				}
			break;
			case 3:
				if(typeof Menu.onmouseout == "function"){//调用用户函数
					Menu.onmouseout(o,false);//鼠标离开，无子项
				}
			break;
		}
	}
};

