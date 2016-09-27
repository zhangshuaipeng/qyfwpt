﻿/*
*######################################
* eWebEditor v8.0 - Advanced online web based WYSIWYG HTML editor.
* Copyright (c) 2003-2012 eWebSoft.com
*
* For further information go to http://www.ewebeditor.net/
* This copyright notice MUST stay intact for use.
*######################################
*/


if(!window.EWEBEDITOR){window.EWEBEDITOR=(function(){var EWEBEDITOR={Version:'8.0',ReplaceByClassName:'ewebeditor',ReplaceByClassEnabled:true,Config:{style:'coolblue',width:'100%',height:'350'},BasePath:(function(){var J=window.EWEBEDITOR_BASEPATH||'';if(!J){var bO=document.getElementsByTagName('script');for(var i=0;i<bO.length;i++){var m=bO[i].src.match(/(^|.*[\\\/])ewebeditor.js$/i);if(m){J=m[1];break;}}}if(J.indexOf(':/')== -1){if(J.indexOf('/')===0){J=location.href.match(/^.*?:\/\/[^\/]*/)[0]+J;}else{J=location.href.match(/^[^\?]*\/(?:)/)[0]+J;}}return J;})(),Instances:{},Create:function(G,K,k){return this.aV(G,K,'create',k);},Append:function(G,K,k){return this.aV(G,K,'append',k);},Replace:function(G,K){return this.aV(G,K,'replace');},ReplaceAll:function(){var bb=document.getElementsByTagName('textarea');for(var i=0;i<bb.length;i++){var K=null;var ab=bb[i];var G=ab.name||ab.id;if(!G){continue;}if(typeof arguments[0]=='string'){var bM=new RegExp('(?:^|\\s)'+arguments[0]+'(?:$|\\s)');if(!bM.test(ab.className)){continue;}}else if(typeof arguments[0]=='function'){K=this.an(this.Config);if(arguments[0](ab,K)===false){continue;}}this.Replace(G,K);}},bC:function(editor){this.Instances[editor.id]=editor;},aj:function(editor){delete this.Instances[editor.id];},aV:function(G,K,l,k){if(this.Instances[G]){alert('[EWEBEDITOR] The instance "'+G+'" already exists.');return;}var editor=new this.editor(G,K,l,k);this.bC(editor);return editor;},EVENT:function(F){var editor=this.Instances[F.id];if(!editor){editor=this.aV(F.id,null,"exist");}switch(F.flag){case 'LoadComplete':editor.Loaded=true;editor.win=F.win;editor.doc=F.doc;editor.getHTML=F.win.getHTML;editor.setHTML=F.win.setHTML;editor.insertHTML=F.win.insertHTML;editor.appendHTML=F.win.appendHTML;editor.getCount=F.win.getCount;editor.setMode=F.win.setMode;editor.openUploadDialog=F.win.openUploadDialog;editor.focus=F.win.focus;editor.setReadOnly=F.win.setReadOnly;editor.localUpload=F.win.localUpload;editor.remoteUpload=F.win.remoteUpload;editor.exec=F.win.exec;break;default:}},an:function(aS){var am=new Object();for(H in aS){am[H]=aS[H];}return am;}};return EWEBEDITOR;})();(function(){var ak=function(){if(EWEBEDITOR.ReplaceByClassEnabled){EWEBEDITOR.ReplaceAll(EWEBEDITOR.ReplaceByClassName);}};if(window.addEventListener){window.addEventListener('load',ak,false);}else if(window.attachEvent){window.attachEvent('onload',ak);}})();}if(!EWEBEDITOR.editor){(function(){var bm=function(bV,G){var ad=document.getElementsByTagName(bV);for(var i=0;i<ad.length;i++){var H=ad[i].getAttribute('name');var n=H.lastIndexOf('$');if(n<0){n=H.lastIndexOf(':');}if(n>=0){H=H.substr(n+1);if(H==G){return ad[i];}}}return null;};var aI=0;var aA=function(bA){var H='ewebeditor_auto_'+bA+'_'+(++aI);return(EWEBEDITOR.Instances&&EWEBEDITOR.Instances[H]&& !document.getElementById(H)&& !document.getElementsByName(H))?aA():H;};var ah=function(k){k=k.replace(/&/g,"&amp;").replace(/\"/g,"&quot;").replace(/</g,"&lt;").replace(/>/g,"&gt;");return k;};var bv=function(k,L){if(L.insertAdjacentHTML){L.insertAdjacentHTML('beforeBegin',k);}else{var oRange=document.createRange();oRange.setStartBefore(L);var bS=oRange.createContextualFragment(k);L.parentNode.insertBefore(bS,L);}};var aa=function(G){if(document.getElementById(G)||document.getElementsByName(G)[0]){alert('[EWEBEDITOR.editor] The element with id or name "'+G+'" already exists.');}};var ac=function(G){var L=document.getElementById(G);if(!L){L=document.getElementsByName(G)[0];}if(!L){L=bm('input',G);}if(!L){L=bm('textarea',G);}if(!L){alert('[EWEBEDITOR.editor] The element with id or name "'+G+'" was not found.');}return L;};var bd=function(t,K){var R;var bz=document.getElementsByTagName("iframe");for(var i=0;i<bz.length;i++){var T=bz[i];var j=aC(T,"src");var bM=new RegExp('/ewebeditor\.[a-z]{3}\?.*?id='+t.replace('$','\$')+'(?:$|\\s|&)','gi');if(bM.test(j)){R=aC(T,"id");if(!R){R=aA('iframe');ar(T,"id",R);}j=j.substring(j.indexOf('?')+1);j=j.replace('&amp;','&');var bp=j.split('&');for(var i=0;i<bp.length;i++){var bU=bp[i].split('=');K[bU[0]]=bU[1];}K.width=aC(T,"width");K.height=aC(T,"height");K.display=T.style.display;break;}}return R;};var aC=function(L,h){var bE=L.attributes[h];if(bE==null|| !bE.specified){return "";}var az=L.getAttribute(h,2);if(az==null){az=bE.nodeValue;}return(az==null?"":az);};var ar=function(L,h,bI){if(bI==null||bI.length==0){L.removeAttribute(h,0);}else{L.setAttribute(h,bI,0);}};EWEBEDITOR.editor=function(G,K,l,k){this.Loaded=false;this.id=G;var V;var bg='input';var t;var O;k=k||'';K=K||EWEBEDITOR.an(EWEBEDITOR.Config);K.style=K.style||EWEBEDITOR.Config.style;K.width=K.width||EWEBEDITOR.Config.width;K.height=K.height||EWEBEDITOR.Config.height;if(l=='replace'){V=ac(G);if(V.tagName!="TEXTAREA"&&V.tagName.substring(0,5)!="INPUT"){bg="other";}this.OriginalDisplay=V.style.display;V.style.display='none';t=G;O=V;}else if(l=='append'){V=document.getElementById(G);if(!V){alert('[EWEBEDITOR.editor] The element with id or name "'+G+'" was not found.');}if(K.linkid){t=K.linkid;aa(t);}else{t=aA('text');}var C=document.createElement('textarea');C.setAttribute('id',t);C.style.display='none';C.value=k;V.appendChild(C);O=C;}else if(l=='create'){t=G;aa(t);var by='<textarea id="'+t+'" style="display:none">'+ah(k)+'</textarea>';document.write(by);O=document.getElementById(t);}var R;if(l=="exist"){t=G;O=ac(t);R=bd(t,K);}else{R=aA('iframe');var v='<iframe id="'+R+'"'+' src="'+EWEBEDITOR.BasePath+'ewebeditor.htm'+'?id='+t+'&instanceid='+G+'&style='+K.style;for(var H in K){if(!(H in{width:1,height:1,style:1,linkid:1,display:1})){v+='&'+H+'='+K[H];}}if(K.display){v+='" style="display:'+K.display;}v+='" width="'+K.width+'" height="'+K.height+'" frameborder="0" scrolling="no"></iframe>';if(l=='create'){document.write(v);}else{bv(v,O);}}this.Mode=l;this.LinkType=bg;this.LinkId=t;this.LinkElement=O;this.InstanceElement=V;this.IframeId=R;this.Config=K;};EWEBEDITOR.editor.prototype.Remove=function(ae){if(!this.Loaded){return;}if(!ae){this.Update();}this.win.Remove();EWEBEDITOR.aj(this);var T=document.getElementById(this.IframeId);T.parentNode.removeChild(T);if(this.Mode=='replace'){this.LinkElement.style.display=this.OriginalDisplay;}else{var C=this.LinkElement;C.parentNode.removeChild(C);}try{EWEBEDITOR_EVENT({flag:'remove',id:this.id});}catch(e){}};EWEBEDITOR.editor.prototype.Hide=function(bq){if(!this.Loaded){return;}var T=document.getElementById(this.IframeId);if(bq){T.style.display='none';}else{T.style.display='';}};EWEBEDITOR.editor.prototype.Update=function(){if(!this.Loaded){return;}if(this.Mode=='replace'){var k=this.getHTML();if(this.LinkType=='input'){this.InstanceElement.value=k;}else{this.InstanceElement.innerHTML=k;}}};})();} 