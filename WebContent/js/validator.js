
function Validator() {
	var self = this;
	this.checkMasks = new Array();
	this.masksTips = new Array();
	this.tags = new Array();
	
	this.init = function() {
		self.checkMasks['EMAIL'] = /\b[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/gi;	// Email
		self.checkMasks['NUMERIC'] = /^[0-9]+$/gi;	// 数字
		self.checkMasks['INTEGER'] = /^-?\d+$/gi;	// 整数
		self.checkMasks['DOUBLE'] = /^(-?\d+)(\.\d+)?$/gi;	// 浮点数
		self.checkMasks['ALPHA'] = /^[a-zA-Z]+$/gi;	// 字母
		self.checkMasks['CODE'] = /^[a-zA-Z][a-zA-Z0-9_-]/gi;	// 编码
		self.checkMasks['ZIP'] = /^[0-9]{5}\-[0-9]{4}$/gi;	// Numeric
		self.checkMasks['NOSPACE'] = /\s/g;       	// 无空格
		
		self.masksTips['EMAIL'] = '电子邮件';
		self.masksTips['NUMERIC'] = '数字';
		self.masksTips['INTEGER'] = '整数';
		self.masksTips['DOUBLE'] = '小数';
		self.masksTips['ALPHA'] = '字母';
		self.masksTips['CODE'] = '编码格式（首字符为字母）';
		self.masksTips['NOSPACE'] = '无空格';
		
		var inputs = self.getTagsObject();
		if (!inputs) return;

		for(var no=0;no<inputs.length;no++){
			var required = inputs[no].getAttribute('required');
			if(!required)required = inputs[no].required;		
			
			var mask = inputs[no].getAttribute('mask');
			if(!mask)mask = inputs[no].mask;
			
			var freemask = inputs[no].getAttribute('freemask');
			if(!freemask)freemask = inputs[no].freemask;
			
			var regexpPattern = inputs[no].getAttribute('regexp');
			if(!regexpPattern)regexpPattern = inputs[no].regexpPattern;

			var maxlength = inputs[no].getAttribute('maxlength');
			var maxValue = inputs[no].getAttribute('max');
			var minValue = inputs[no].getAttribute('min');
			// 判断hidden/radio/checkbox
			if (inputs[no].type!='radio' && inputs[no].type!='checkbox' && inputs[no].type!='hidden') { 
				//inputs[no].onblur = validateFieldValue;
				addEvent(inputs[no],"onfocus",self.focusTag);
			} else {
				if (inputs[no].type!='hidden') {
					addEvent(inputs[no],"onblur",self.validateField);
					// inputs[no].onfocus = validateFieldValue;
				}
			}
			self.tags[inputs[no].name] = new Array();
			self.tags[inputs[no].name]['mask'] = mask;
			self.tags[inputs[no].name]['freemask'] = freemask;
			self.tags[inputs[no].name]['required'] = required;
			self.tags[inputs[no].name]['regexp'] = regexpPattern;
			self.tags[inputs[no].name]['maxlength'] = maxlength;
			self.tags[inputs[no].name]['max'] = maxValue;
			self.tags[inputs[no].name]['min'] = minValue;
		}	
	}

	this.getTagsObject = function () {
		var inputFields = document.getElementsByTagName('INPUT');
		var selectBoxes = document.getElementsByTagName('SELECT');
		var textArea = document.getElementsByTagName('TEXTAREA');
		
		var inputs = new Array();
		
		for(var no=0;no<inputFields.length;no++){
			if (inputFields[no].type=='button' || inputFields[no].type=='submit' || inputFields[no].type=='image')
				continue;
			inputs[inputs.length] = inputFields[no];
		}	
		for(var no=0;no<selectBoxes.length;no++){
			inputs[inputs.length] = selectBoxes[no];
		}
		for (var no=0;no<textArea.length ;no++ ) {
			inputs[inputs.length] = textArea[no];
		}
		
		return inputs;
	}

	this.validateField = function (e,inputObj) {
		if(!inputObj)inputObj = this;		

		var inputValidates = true;

		inputValidates = self.validateTag(inputObj);
		if (inputObj.type=='hidden')
			return;
		
		if(inputValidates) {
			eformValidObject = null;
			self.setMessage(inputObj,'');
		}

		var Objs = document.getElementsByName(inputObj.name);
		if (!Objs || Objs.length<1)
			return;
		for (var no=0;no<Objs.length ;no++ )	{
			if(inputValidates) 
				Objs[no].style.background='#FFFFFF';
			else {
				Objs[no].style.background='#FF0000';
			}
		}
	}

	this.validateTag = function (inputObj) {
		var fieldname = inputObj.getAttribute('title');
		if (!fieldname)	
			fieldname = inputObj.name;

		if(!self.tags[inputObj.name]) return true;
		inputObj.value = self.trim(inputObj.value);
		if(self.tags[inputObj.name]['required'] && inputObj.tagName=='SELECT' && inputObj.value=='') {
			self.setMessage(inputObj,'[' + fieldname + ']没有选择');
			return false;
		}
		if (self.tags[inputObj.name]['required'] && inputObj.tagName=='INPUT' && (inputObj.type=='radio' || inputObj.type=='checkbox'))	{
			var select = false;
			var objOptions = document.getElementsByName(inputObj.name);
			for (i=0;i<objOptions.length;i++ )	{
				if (objOptions[i].checked)	{
					select = true;
					break;
				}
			}
			if(!select) {
				self.setMessage(inputObj,'[' + fieldname + ']没有选择');
				return false;
			}
		}
		if(self.tags[inputObj.name]['required'] && (inputObj.tagName=='INPUT' || inputObj.tagName=='TEXTAREA')&& inputObj.value.length==0) {
			self.setMessage(inputObj,'[' + fieldname + ']不能为空');
			return false;
		}
		// 非必填域，如果为空，则不进行后续校验
		if (!inputObj.value)
			return true;
		
		if (self.tags[inputObj.name]['mask']=="NOSPACE" && inputObj.value.match(self.checkMasks[self.tags[inputObj.name]['mask']])==" ") {
			self.setMessage(inputObj,'[' + fieldname + ']应该是' + self.masksTips[self.tags[inputObj.name]['mask']] + '格式');
			return false;
		}
		if(self.tags[inputObj.name]['mask'] && self.tags[inputObj.name]['mask']!="NOSPACE" && !inputObj.value.match(self.checkMasks[self.tags[inputObj.name]['mask']])) {
			self.setMessage(inputObj,'[' + fieldname + ']应该是' + self.masksTips[self.tags[inputObj.name]['mask']] + '格式');
			return false;
		}
		if(self.tags[inputObj.name]['maxlength'] && inputObj.value.length>0 && inputObj.value.replace(/[^\x00-\xff]/g,"**").length>self.tags[inputObj.name]['maxlength']) {
			self.setMessage(inputObj,'[' + fieldname + ']长度超过' + self.tags[inputObj.name]['maxlength']);
			return false;
		}

		if(self.tags[inputObj.name]['freemask']){
			var tmpMask = self.tags[inputObj.name]['freemask'];
			tmpMask = tmpMask.replace(/-/g,'\\-');
			tmpMask = tmpMask.replace(/S/g,'[A-Z]');
			tmpMask = tmpMask.replace(/N/g,'[0-9]');
			tmpMask = eval("/^" + tmpMask + "$/gi");
			if(!inputObj.value.match(tmpMask)) {
				self.setMessage(inputObj,'[' + fieldname + ']错误格式' + self.tags[inputObj.name]['freemask']);
				return false;
			}
		}	
		
		if(self.tags[inputObj.name]['regexp']){
			var tmpMask = eval(self.tags[inputObj.name]['regexp']);
			if(!inputObj.value.match(tmpMask)) {
				self.setMessage(inputObj,'[' + fieldname + ']错误格式' + self.tags[inputObj.name]['regexp']);
				return false;
			}
		}

		if(inputObj.value && self.tags[inputObj.name]['max']){
			if (!isNaN(inputObj.value) && Math.ceil(inputObj.value)>Math.ceil(self.tags[inputObj.name]['max'])) {
				self.setMessage(inputObj,'[' + fieldname + ']超过最大值' + self.tags[inputObj.name]['max']);
				return false;
			}
		}

		if(inputObj.value && self.tags[inputObj.name]['min']){
			if (Math.ceil(inputObj.value)<Math.ceil(self.tags[inputObj.name]['min'])) {
				self.setMessage(inputObj,'[' + fieldname + ']小于最小值' + self.tags[inputObj.name]['min']);
				return false;
			}
		}

		return true;
	}

	this.focusTag = function (e,inputObj) {
		if(!inputObj)inputObj = this;	
	//	inputObj.style.background='#FFFFFF';
		self.setMessage(inputObj,'');
		if(!inputObj.tagName) return;
		var Objs = document.getElementsByName(inputObj.name);
		if (!Objs || Objs.length<1)
			return;
		for (var no=0;no<Objs.length ;no++ )	{
	//		Objs[no].style.background='#FFFFFF';
		}
	}


	this.setMessage = function (inputObj,message) {
		if (!message)
			return;

		labelObj = document.getElementById('$MESSAGE');
		if (labelObj && labelObj.type!="hidden") {
			labelObj.innerHTML = message;
			return;
		}
	}
	// 校验内容
	this.isValid = function () {
		var labelObj = document.getElementById('$MESSAGE');
		if (labelObj && labelObj.type!="hidden") 
			labelObj.innerHTML = '';
		
		var inputs = self.getTagsObject();
		var b = true;	
		for(var no=0;no<inputs.length;no++){
			if (!self.validateTag(inputs[no])) {
				b = false;
				break;
			}
		}
		if (!b) {
			alert('内容校验不通过，请检查！' + labelObj.innerHTML);
		}

		return b;
	}
	//删除左右两端的空格
	this.trim = function (str){ 
		return str.replace(/(^\s*)|(\s*$)/g, "");  
	}  
	//删除左边的空格
	this.ltrim = function (str){   
		return str.replace(/(^\s*)/g,"");  
	}  
	//删除右边的空格
	this.rtrim = function (str){   
		return str.replace(/(\s*$)/g,"");  
	}  
}


var objValidator = new Validator();

