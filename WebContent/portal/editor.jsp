<%@ page pageEncoding="UTF-8" %>
<table width="100%"  border="0" cellpadding="0" cellspacing="0" background="images/bg.gif" style="border:1px solid #c5c5c5; ">
  <tr>
    <td height="31" style="padding-left:5px; "><table border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td class="ico">
		<div class="icons icoCut" ><img border="0" width="100%" height="100%" src="images/place.gif" onclick="format('Cut')" title="剪切"
onmousedown="fSetBorderMouseDown(this)"   
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>			</td>
        <td class="ico">
		<div class="icons icoCpy" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Copy')" title="复制"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoPse" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Paste')" title="粘贴"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico" style="width:12px"><img src="images/line.gif" width="4" height="20" style="margin-left:2px "  /></td>
        <td class="ico2">
		<div class="icons icoFfm" style="width:25px"  ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)"  id="imgFontface" title="字体" onClick="fGetEv(event);fDisplayElement('fontface','')"  
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico2">
		<div class="icons icoFsz" style="width:25px" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" id="imgFontsize" title="字号" onClick="fGetEv(event);fDisplayElement('fontsize','')"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoWgt" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Bold');" title="加粗"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoIta" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Italic');" title="斜体"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoUln" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Underline')" title="下划线"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)" ></div>		</td>
		
        <td class="ico3">
		<div class="icons icoFcl"  ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" title="字体颜色"
            onmouseover="fSetBorderMouseOver(this)"  onclick="foreColor(event)" id="imgFontColor"
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico2">
		<div class="icons icoBcl"  ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" title="背景颜色"
            onmouseover="fSetBorderMouseOver(this)"  onclick="backColor(event)" id="imgBackColor"
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>		
        <td class="ico">
		<div class="icons icoAgn"><img border="0" width="100%" height="100%"  onmousedown="fSetBorderMouseDown(this)" id="imgAlign" onClick="fGetEv(event);fDisplayElement('divAlign','')" title="对齐"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)" src="images/place.gif"></div>		</td>
        <td class="ico">
		<div class="icons icoLst" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" id="imgList" onClick="fGetEv(event);fDisplayElement('divList','')"title="编号"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoOdt" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Outdent')" title="减少缩进"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico">
		<div class="icons icoIdt" ><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="format('Indent')" title="增加缩进"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
        <td class="ico" style="width:12px"><img src="images/line.gif" width="4" height="20" style="margin-left:2px "  /></td>

        <td class="ico">
		<div class="icons icoUrl"><img border="0" width="100%" height="100%" src="images/place.gif" onmousedown="fSetBorderMouseDown(this)" onclick="createLink()" title="超链接"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>		</td>
		
       <td class="ico">
		<div class="icons icoImg"><img border="0" width="100%" height="100%" src="images/place.gif"  onmousedown="fSetBorderMouseDown(this)" onclick="createImg()" title="增加图片" 
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)"></div>
		</td>
		
        <td class="ico3">
		<div class="icons icoMfc"><img border="0" width="100%" height="100%" src="images/place.gif"  onmousedown="fSetBorderMouseDown(this)" onclick="addPortrait(event)" title="魔法表情" id="imgFace"
            onmouseover="fSetBorderMouseOver(this)" 
            onmouseout="fSetBorderMouseOut(this)" /></div>		</td>
		<td class="ico4"><img src="images/line.gif" width="4" height="20" style="margin-left:5px "  /></td>
		<td style="font-size:12px"> <input type=checkbox name="switchMode" LANGUAGE="javascript" onclick="setMode(this.checked)" onmouseout="fHideTip()" onmouseover="fSetModeTip(this)"></td>
        </tr>
    </table></td>
  </tr>
</table>
<div style="width:100px;height:100px;position:absolute;display:none;top:-500px;left:-500px" ID="dvForeColor">
<TABLE CELLPADDING=0 CELLSPACING=0 style="border:1px #888888 solid" width="218" height="25">
</TABLE>
</div>
<div style="width:100px;height:100px;position:absolute;display:none;top:-500px;left:-500px" ID="dvPortrait"></div>
<div id="fontface" style="z-index:99; padding:1px; display:none; position:absolute; top:35px; left:2px; background:#FFFFFF; border:1px solid #838383; width:110px; height:270px;"><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px '宋体';">宋体</a><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px '黑体';">黑体</a><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px '楷体';">楷体</a><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px '隶书';">隶书</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px '幼圆';">幼圆</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px Arial;">Arial</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px 'Arial Narrow';">Arial Narrow</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px 'Arial Black';">Arial Black</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px 'Comic Sans MS';">Comic Sans MS</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px Courier;">Courier</a><a href="###" onClick="fontname(this)" class="n" style="font:normal 12px System;">System</a><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px 'Times New Roman';">Times New Roman</a><a href="javascript:void(0)" onClick="fontname(this)" class="n" style="font:normal 12px Verdana;">Verdana</a></div>
<div id="fontsize" style="padding:1px; display:none; position:absolute; top:35px; left:26px; background:#FFFFFF; border:1px solid #838383; width:115px; height:160px;"><a href="javascript:void(0)" onClick="fontsize(1,this)" class="n" style="font-size:xx-small;line-height:120%;">极小</a><a href="javascript:void(0)" onClick="fontsize(2,this)" class="n" style="font-size:x-small;line-height:120%;">特小</a><a href="javascript:void(0)" onClick="fontsize(3,this)" class="n" style="font-size:small;line-height:120%;">小</a><a href="#" onClick="fontsize(4,this)" class="n" style="font-size:medium;line-height:120%;">中</a><a href="javascript:void(0)" onClick="fontsize(5,this)" class="n" style="font-size:large;line-height:120%;">大</a><a href="javascript:void(0)" onClick="fontsize(6,this)" class="n" style="font-size:x-large;line-height:120%;">特大</a><a href="javascript:void(0)" onClick="fontsize(7,this)" class="n" style="font-size:xx-large;line-height:140%;">极大</a></div>
<div id="divList" style="padding:1px; display:none; position:absolute; top:35px; left:26px; background:#FFFFFF; border:1px solid #838383; width:60px; height:40px;"><a href="javascript:void(0)" onClick="format('Insertorderedlist');fHide(this.parentNode)" class="n">数字列表</a><a href="javascript:void(0)" onClick="format('Insertunorderedlist');fHide(this.parentNode)" class="n">符号列表</a></div>	
<div id="divAlign" style="padding:1px; display:none; position:absolute; top:35px; left:26px; background:#FFFFFF; border:1px solid #838383; width:60px; height:60px;"><a href="javascript:void(0)" onClick="format('Justifyleft');fHide(this.parentNode)" class="n">左对齐</a><a href="javascript:void(0)" onClick="format('Justifycenter');fHide(this.parentNode)" class="n">居中对齐</a><a href="javascript:void(0)" onClick="format('Justifyright');fHide(this.parentNode)" class="n">右对齐</a></div>	
<div id="divEditor">
<IFRAME class="HtmlEditor" ID="HtmlEditor" name="HtmlEditor" style="width:100%;margin-left:1px;margin-bottom:1px;" frameBorder="0" marginHeight=0 marginWidth=0 src=""></IFRAME>
</div>
<textarea ID="sourceEditor" style="height:280px;width:100%;display:none"></textarea>
