/*
 Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or https://ckeditor.com/legal/ckeditor-oss-license
*/

(function(){function b(a,b,c){var h=n[this.id];if(h)for(var f=this instanceof CKEDITOR.ui.dialog.checkbox,e=0;e<h.length;e++){var d=h[e];switch(d.type){case 1:if(!a)continue;if(null!==a.getAttribute(d.name)){a=a.getAttribute(d.name);f?this.setValue("true"==a.toLowerCase()):this.setValue(a);return}f&&this.setValue(!!d["default"]);break;case 2:if(!a)continue;if(d.name in c){a=c[d.name];f?this.setValue("true"==a.toLowerCase()):this.setValue(a);return}f&&this.setValue(!!d["default"]);break;case 4:if(!b)continue;
if(b.getAttribute(d.name)){a=b.getAttribute(d.name);f?this.setValue("true"==a.toLowerCase()):this.setValue(a);return}f&&this.setValue(!!d["default"])}}}function c(a,b,c){var h=n[this.id];if(h)for(var f=""===this.getValue(),e=this instanceof CKEDITOR.ui.dialog.checkbox,d=0;d<h.length;d++){var g=h[d];switch(g.type){case 1:if(!a||"data"==g.name&&b&&!a.hasAttribute("data"))continue;var m=this.getValue();f||e&&m===g["default"]?a.removeAttribute(g.name):a.setAttribute(g.name,m);break;case 2:if(!a)continue;
m=this.getValue();if(f||e&&m===g["default"])g.name in c&&c[g.name].remove();else if(g.name in c)c[g.name].setAttribute("value",m);else{var p=CKEDITOR.dom.element.createFromHtml("\x3ccke:param\x3e\x3c/cke:param\x3e",a.getDocument());p.setAttributes({name:g.name,value:m});1>a.getChildCount()?p.appendTo(a):p.insertBefore(a.getFirst())}break;case 4:if(!b)continue;m=this.getValue();f||e&&m===g["default"]?b.removeAttribute(g.name):b.setAttribute(g.name,m)}}}for(var n={id:[{type:1,name:"id"}],classid:[{type:1,
name:"classid"}],codebase:[{type:1,name:"codebase"}],pluginspage:[{type:4,name:"pluginspage"}],src:[{type:2,name:"movie"},{type:4,name:"src"},{type:1,name:"data"}],name:[{type:4,name:"name"}],align:[{type:1,name:"align"}],"class":[{type:1,name:"class"},{type:4,name:"class"}],width:[{type:1,name:"width"},{type:4,name:"width"}],height:[{type:1,name:"height"},{type:4,name:"height"}],hSpace:[{type:1,name:"hSpace"},{type:4,name:"hSpace"}],vSpace:[{type:1,name:"vSpace"},{type:4,name:"vSpace"}],style:[{type:1,
name:"style"},{type:4,name:"style"}],type:[{type:4,name:"type"}]},k="play loop menu quality scale salign wmode bgcolor base flashvars allowScriptAccess allowFullScreen".split(" "),l=0;l<k.length;l++)n[k[l]]=[{type:4,name:k[l]},{type:2,name:k[l]}];k=["play","loop","menu"];for(l=0;l<k.length;l++)n[k[l]][0]["default"]=n[k[l]][1]["default"]=!0;CKEDITOR.dialog.add("flash",function(a){var l=!a.config.flashEmbedTagOnly,k=a.config.flashAddEmbedTag||a.config.flashEmbedTagOnly,h,f="\x3cdiv\x3e"+CKEDITOR.tools.htmlEncode(a.lang.common.preview)+
'\x3cbr\x3e\x3cdiv id\x3d"cke_FlashPreviewLoader'+CKEDITOR.tools.getNextNumber()+'" style\x3d"display:none"\x3e\x3cdiv class\x3d"loading"\x3e\x26nbsp;\x3c/div\x3e\x3c/div\x3e\x3cdiv id\x3d"cke_FlashPreviewBox'+CKEDITOR.tools.getNextNumber()+'" class\x3d"FlashPreviewBox"\x3e\x3c/div\x3e\x3c/div\x3e';return{title:a.lang.flash.title,minWidth:420,minHeight:310,onShow:function(){this.fakeImage=this.objectNode=this.embedNode=null;h=new CKEDITOR.dom.element("embed",a.document);var e=this.getSelectedElement();
if(e&&e.data("cke-real-element-type")&&"flash"==e.data("cke-real-element-type")){this.fakeImage=e;var d=a.restoreRealElement(e),g=null,b=null,c={};if("cke:object"==d.getName()){g=d;d=g.getElementsByTag("embed","cke");0<d.count()&&(b=d.getItem(0));for(var d=g.getElementsByTag("param","cke"),f=0,l=d.count();f<l;f++){var k=d.getItem(f),n=k.getAttribute("name"),k=k.getAttribute("value");c[n]=k}}else"cke:embed"==d.getName()&&(b=d);this.objectNode=g;this.embedNode=b;this.setupContent(g,b,c,e)}},onOk:function(){var e=
null,d=null,b=null;this.fakeImage?(e=this.objectNode,d=this.embedNode):(l&&(e=CKEDITOR.dom.element.createFromHtml("\x3ccke:object\x3e\x3c/cke:object\x3e",a.document),e.setAttributes({classid:"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000",codebase:"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version\x3d6,0,40,0"})),k&&(d=CKEDITOR.dom.element.createFromHtml("\x3ccke:embed\x3e\x3c/cke:embed\x3e",a.document),d.setAttributes({type:"application/x-shockwave-flash",pluginspage:"http://www.macromedia.com/go/getflashplayer"}),
e&&d.appendTo(e)));if(e)for(var b={},c=e.getElementsByTag("param","cke"),f=0,h=c.count();f<h;f++)b[c.getItem(f).getAttribute("name")]=c.getItem(f);c={};f={};this.commitContent(e,d,b,c,f);e=a.createFakeElement(e||d,"cke_flash","flash",!0);e.setAttributes(f);e.setStyles(c);this.fakeImage?(e.replace(this.fakeImage),a.getSelection().selectElement(e)):a.insertElement(e)},onHide:function(){this.preview&&this.preview.setHtml("")},contents:[{id:"info",label:a.lang.common.generalTab,accessKey:"I",elements:[{type:"vbox",
padding:0,children:[{type:"hbox",widths:["280px","110px"],align:"right",className:"cke_dialog_flash_url",children:[{id:"src",type:"text",label:a.lang.common.url,required:!0,validate:CKEDITOR.dialog.validate.notEmpty(a.lang.flash.validateSrc),setup:b,commit:c,onLoad:function(){var a=this.getDialog(),b=function(b){h.setAttribute("src",b);a.preview.setHtml('\x3cembed height\x3d"100%" width\x3d"100%" src\x3d"'+CKEDITOR.tools.htmlEncode(h.getAttribute("src"))+'" type\x3d"application/x-shockwave-flash"\x3e\x3c/embed\x3e')};
a.preview=a.getContentElement("info","preview").getElement().getChild(3);this.on("change",function(a){a.data&&a.data.value&&b(a.data.value)});this.getInputElement().on("change",function(){b(this.getValue())},this)}},{type:"button",id:"browse",filebrowser:"info:src",hidden:!0,style:"display:inline-block;margin-top:14px;",label:a.lang.common.browseServer}]}]},{type:"hbox",widths:["25%","25%","25%","25%","25%"],children:[{type:"text",id:"width",requiredContent:"embed[width]",style:"width:95px",label:a.lang.common.width,
validate:CKEDITOR.dialog.validate.htmlLength(a.lang.common.invalidHtmlLength.replace("%1",a.lang.common.width)),setup:b,commit:c},{type:"text",id:"height",requiredContent:"embed[height]",style:"width:95px",label:a.lang.common.height,validate:CKEDITOR.dialog.validate.htmlLength(a.lang.common.invalidHtmlLength.replace("%1",a.lang.common.height)),setup:b,commit:c},{type:"text",id:"hSpace",requiredContent:"embed[hspace]",style:"width:95px",label:a.lang.flash.hSpace,validate:CKEDITOR.dialog.validate.integer(a.lang.flash.validateHSpace),
setup:b,commit:c},{type:"text",id:"vSpace",requiredContent:"embed[vspace]",style:"width:95px",label:a.lang.flash.vSpace,validate:CKEDITOR.dialog.validate.integer(a.lang.flash.validateVSpace),setup:b,commit:c}]},{type:"vbox",children:[{type:"html",id:"preview",style:"width:95%;",html:f}]}]},{id:"Upload",hidden:!0,filebrowser:"uploadButton",label:a.lang.common.upload,elements:[{type:"file",id:"upload",label:a.lang.common.upload,size:38},{type:"fileButton",id:"uploadButton",label:a.lang.common.uploadSubmit,
filebrowser:"info:src","for":["Upload","upload"]}]},{id:"properties",label:a.lang.flash.propertiesTab,elements:[{type:"hbox",widths:["50%","50%"],children:[{id:"scale",type:"select",requiredContent:"embed[scale]",label:a.lang.flash.scale,"default":"",style:"width : 100%;",items:[[a.lang.common.notSet,""],[a.lang.flash.scaleAll,"showall"],[a.lang.flash.scaleNoBorder,"noborder"],[a.lang.flash.scaleFit,"exactfit"]],setup:b,commit:c},{id:"allowScriptAccess",type:"select",requiredContent:"embed[allowscriptaccess]",
label:a.lang.flash.access,"default":"",style:"width : 100%;",items:[[a.lang.common.notSet,""],[a.lang.flash.accessAlways,"always"],[a.lang.flash.accessSameDomain,"samedomain"],[a.lang.flash.accessNever,"never"]],setup:b,commit:c}]},{type:"hbox",widths:["50%","50%"],children:[{id:"wmode",type:"select",requiredContent:"embed[wmode]",label:a.lang.flash.windowMode,"default":"",style:"width : 100%;",items:[[a.lang.common.notSet,""],[a.lang.flash.windowModeWindow,"window"],[a.lang.flash.windowModeOpaque,
"opaque"],[a.lang.flash.windowModeTransparent,"transparent"]],setup:b,commit:c},{id:"quality",type:"select",requiredContent:"embed[quality]",label:a.lang.flash.quality,"default":"high",style:"width : 100%;",items:[[a.lang.common.notSet,""],[a.lang.flash.qualityBest,"best"],[a.lang.flash.qualityHigh,"high"],[a.lang.flash.qualityAutoHigh,"autohigh"],[a.lang.flash.qualityMedium,"medium"],[a.lang.flash.qualityAutoLow,"autolow"],[a.lang.flash.qualityLow,"low"]],setup:b,commit:c}]},{type:"hbox",widths:["50%",
"50%"],children:[{id:"align",type:"select",requiredContent:"object[align]",label:a.lang.common.align,"default":"",style:"width : 100%;",items:[[a.lang.common.notSet,""],[a.lang.common.alignLeft,"left"],[a.lang.flash.alignAbsBottom,"absBottom"],[a.lang.flash.alignAbsMiddle,"absMiddle"],[a.lang.flash.alignBaseline,"baseline"],[a.lang.common.alignBottom,"bottom"],[a.lang.common.alignMiddle,"middle"],[a.lang.common.alignRight,"right"],[a.lang.flash.alignTextTop,"textTop"],[a.lang.common.alignTop,"top"]],
setup:b,commit:function(a,b,f,k,l){var h=this.getValue();c.apply(this,arguments);h&&(l.align=h)}},{type:"html",html:"\x3cdiv\x3e\x3c/div\x3e"}]},{type:"fieldset",label:CKEDITOR.tools.htmlEncode(a.lang.flash.flashvars),children:[{type:"vbox",padding:0,children:[{type:"checkbox",id:"menu",label:a.lang.flash.chkMenu,"default":!0,setup:b,commit:c},{type:"checkbox",id:"play",label:a.lang.flash.chkPlay,"default":!0,setup:b,commit:c},{type:"checkbox",id:"loop",label:a.lang.flash.chkLoop,"default":!0,setup:b,
commit:c},{type:"checkbox",id:"allowFullScreen",label:a.lang.flash.chkFull,"default":!0,setup:b,commit:c}]}]}]},{id:"advanced",label:a.lang.common.advancedTab,elements:[{type:"hbox",children:[{type:"text",id:"id",requiredContent:"object[id]",label:a.lang.common.id,setup:b,commit:c}]},{type:"hbox",widths:["45%","55%"],children:[{type:"text",id:"bgcolor",requiredContent:"embed[bgcolor]",label:a.lang.flash.bgcolor,setup:b,commit:c},{type:"text",id:"class",requiredContent:"embed(cke-xyz)",label:a.lang.common.cssClass,
setup:b,commit:c}]},{type:"text",id:"style",requiredContent:"embed{cke-xyz}",validate:CKEDITOR.dialog.validate.inlineStyle(a.lang.common.invalidInlineStyle),label:a.lang.common.cssStyle,setup:b,commit:c}]}]}})})();