163.net
//产生n个1-33的随机数,要求不能重复
function getRandom(num){
  var rm = {},ret = [],i=0;
	var rdm = "";
	while(i<num){
		rdm = (Math.floor(Math.random()*33)+1)+"";
		if(!rm[rdm]){
			ret.push(rdm);
			i++
		}
	}
	return ret;
}

//闭包
var obj={m1:'visited',m2:'changed'}
var rm={};
for (var m in obj){
    rm[m] = function(){
		alert(obj[m]);
	}
}
rm.m1()
rm.m2()

var obj={m1:'visited',m2:'changed'}
var rm={};
for (var m in obj){
    rm[m] = (function(m){
		return function(){
			alert(obj[m]);
		}
	})(m);
}
rm.m1()
rm.m2()

//格式化查询参数
function getStringParam(string,param){
    var rg = new RegExp("(?:^|&)"+param"=([^&]|$)*","gi");
	if(rg.test(string)) return rg.exec(string)[1];
}

//过滤输入框字符为数字
$.fn.bindNumCheck=function(min,max){
	if (arguments.length ==0) return;
	if (arguments.length ==1) {
		max=Infinity;
	}
	if (arguments.length=2){
		min = Number(min);
		max = Number(max);
	}
	var keyChar = "";
	$(this).keydown(function(event){
		console.log(this.value);
		if(this.value.length>2 && event.keyCode>=32) return false;
		keyChar+=String.fromCharCode(event.keyCode).toLowerCase();
		return;
	});
	
	$(this).keyup(function(event){
		var val = this.value;
		var re = /\d/;
		if (!re.test(keyChar)){ 
			val = val.substring(0,val.length-keyChar.length);
		}
		val = (val<min&&val!="") ? min : val>max?max:val;
		this.value = val;
		keyChar = "";
		return false;
	});
};
$("#num").bindNumCheck(0,200);
