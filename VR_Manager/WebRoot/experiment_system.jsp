<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"   pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">





<!--
  $Id: ports.html,v 1.77 2011-10-29 07:52:49 gaudenz Exp $
  Copyright (c) 2006-2010, JGraph Ltd
  
  Ports example for mxGraph. This example demonstrates implementing
  ports as child vertices with relative positions and drag and drop
  as well as the use of images and HTML in cells.
-->
<html>
<html lang="en">
<head>
	<title>试验床</title>
	<!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
       background-color:transparent;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">

	<!-- Sets the basepath for the library if not in same directory -->
	<script type="text/javascript">
		mxBasePath = 'topology/src';
	</script>
	<script type="text/javascript" src="topology/src/js/mxClient.js"></script>

	<!-- Example code -->
	<script type="text/javascript">
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		
		var highNum=0;
		var lowNum=0;
		var highID=100;
		var lowID=1000;
		var XML;
		var editor;
		var onloadflag=0;
		//for config action
		var configIndex=0;
		var IDArray = new Array();
		var configArray = new Array();
		var portArray = new Array();
		//for apply action,send back the code id
		var highCodeID = new Array();
		var highCodeIndex = 0;
		var  lowCodeID = new Array();
		var  lowCodeIndex = 0;
		function main(container, outline, toolbar, sidebar, status)
		{
			// Checks if the browser is supported
			if (!mxClient.isBrowserSupported())
			{
				// Displays an error message if the browser is not supported.
				mxUtils.error('Browser is not supported!', 200, false);
			}
			else
			{
				// Assigns some global constants for general behaviour, eg. minimum
				// size (in pixels) of the active region for triggering creation of
				// new connections, the portion (100%) of the cell area to be used
				// for triggering new connections, as well as some fading options for
				// windows and the rubberband selection.
				mxConstants.MIN_HOTSPOT_SIZE = 16;
				mxConstants.DEFAULT_HOTSPOT = 1;
				
				// Enables guides
				mxGraphHandler.prototype.guidesEnabled = true;

			    // Alt disables guides
			    mxGuide.prototype.isEnabledForEvent = function(evt)
				{
					return !mxEvent.isAltDown(evt);
				};

				// Enables snapping waypoints to terminals
				mxEdgeHandler.prototype.snapToTerminals = true;

				// Workaround for Internet Explorer ignoring certain CSS directives
				if (mxClient.IS_IE)
				{
					new mxDivResizer(container);
					new mxDivResizer(outline);
					new mxDivResizer(toolbar);
					new mxDivResizer(sidebar);
					new mxDivResizer(status);
				}
				
				// Creates a wrapper editor with a graph inside the given container.
				// The editor is used to create certain functionality for the
				// graph, such as the rubberband selection, but most parts
				// of the UI are custom in this example.
				editor = new mxEditor();
				var graph = editor.graph;
				var model = graph.getModel();

				// Disable highlight of cells when dragging from toolbar
				graph.setDropEnabled(false);

				// Uses the port icon while connections are previewed
				graph.connectionHandler.getConnectImage = function(state)
				{	//##
					//return new mxImage(state.style[mxConstants.STYLE_IMAGE], 16, 16);
				};

				// Centers the port icon on the target port
				graph.connectionHandler.targetConnectImage = true;

				// Does not allow dangling edges
				graph.setAllowDanglingEdges(false);

				// Sets the graph container and configures the editor
				editor.setGraphContainer(container);
				var config = mxUtils.load(
					'topology/editors/config/keyhandler-commons.xml').
						getDocumentElement();
				editor.configure(config);
				
				// Defines the default group to be used for grouping. The
				// default group is a field in the mxEditor instance that
				// is supposed to be a cell which is cloned for new cells.
				// The groupBorderSize is used to define the spacing between
				// the children of a group and the group bounds.
				/*var group = new mxCell('Physical Machine 0', new mxGeometry(), 'group');
				group.setVertex(true);
				group.setConnectable(false);
				editor.defaultGroup = group;
				editor.groupBorderSize = 20;*/
				
				// Disables drag-and-drop into non-swimlanes.
				graph.isValidDropTarget = function(cell, cells, evt)
				{
					return this.isSwimlane(cell);
				};
				
				// Disables drilling into non-swimlanes.
				graph.isValidRoot = function(cell)
				{
					return this.isValidDropTarget(cell);
				}

				// Does not allow selection of locked cells
				graph.isCellSelectable = function(cell)
				{
					return !this.isCellLocked(cell);
				};

				// Returns a shorter label if the cell is collapsed and no
				// label for expanded groups
				graph.getLabel = function(cell)
				{
					var tmp = mxGraph.prototype.getLabel.apply(this, arguments); // "supercall"
					
					if (this.isCellLocked(cell))
					{
						// Returns an empty label but makes sure an HTML
						// element is created for the label (for event
						// processing wrt the parent label)
						return '';
					}
					else if (this.isCellCollapsed(cell))
					{
						var index = tmp.indexOf('</h1>');
						
						if (index > 0)
						{
							tmp = tmp.substring(0, index+5);
						}
					} 
					
					return tmp;
				}

				// Disables HTML labels for swimlanes to avoid conflICT
				// for the event processing on the child cells. HTML
				// labels consume events before underlying cells get the
				// chance to process those events.
				//
				// NOTE: Use of HTML labels is only recommended if the specific
				// features of such labels are required, such as special label
				// styles or interactive form fields. Otherwise non-HTML labels
				// should be used by not overidding the following function.
				// See also: configureStylesheet.
				graph.isHtmlLabel = function(cell)
				{
					return !this.isSwimlane(cell);
				}

				// To disable the folding icon, use the following code:
				/*graph.isCellFoldable = function(cell)
				{
					return false;
				}*/

				// Shows a "modal" window when double clicking a vertex.
				graph.dblClick = function(evt, cell)
				{
					// Do not fire a DOUBLE_CLICK event here as mxEditor will
					// consume the event and start the in-place editor.
					if (this.isEnabled() &&
						!mxEvent.isConsumed(evt) &&
						cell != null &&
						this.isCellEditable(cell))
					{
						if (this.model.isEdge(cell) ||
							!this.isHtmlLabel(cell))
						{
							this.startEditingAtCell(cell);
						}
						else
						{
							var content = document.createElement('div');
							content.innerHTML = this.convertValueToString(cell);
							showModalWindow(this, 'Properties', content, 400, 300);
						}
					}

					// Disables any default behaviour for the double click
					mxEvent.consume(evt);
				};

				// Enables new connections
				graph.setConnectable(true);

				// Adds all required styles to the graph (see below)
				configureStylesheet(graph);

				// Adds sidebar icons.
				//
				// NOTE: For non-HTML labels a simple string as the third argument
				// and the alternative style as shown in configureStylesheet should
				// be used. For example, the first call to addSidebar icon would
				// be as follows:<p style="margin:0px;font-size:4px;">
				// addSidebarIcon(graph, sidebar, 'Website', 'images/icons48/earth.png');
				addSidebarIcon(graph, sidebar,
					'<h4>HighRouter</h4><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" onclick="testMessageBox(event)">配置</a>'
					+'<a href="#none" onclick="testMessageBox(event)">查看</a>',
					'topology/images/icons48/Router.png','0');
				addSidebarIcon(graph, sidebar,
					'<h4>LowRouter</h4><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" onclick="testMessageBox(event)">配置</a>'
					+'<a href="#none" onclick="testMessageBox(event)">查看</a>',
					'topology/images/icons48/Router.png','1');
				/*addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Process</h1><br>'+
					'<img src="topology/images/icons48/gear.png" width="48" height="48">'+
					'<br><select><option>Value1</option><option>Value2</option></select><br>',
					'topology/images/icons48/gear.png');
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Keys</h1><br>'+
					'<img src="topology/images/icons48/gear.png" width="48" height="48">'+
					'<br>'+
					'<button onclick="mxUtils.//alert(\'generate\');">Generate</button>',
					'topology/images/icons48/mail_new.png');
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">New Mail</h1><br>'+
					'<img src="topology/images/icons48/mail_new.png" width="48" height="48">'+
					'<br><input type="checkbox"/>CC Archive',
					'topology/images/icons48/mail_new.png');
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Server</h1><br>'+
					'<img src="topology/images/icons48/server.png" width="48" height="48">'+
					'<br>'+
					'<a href="http://www.mxgraph.blogspot.com" target="_blank">Ping</a>',
					'topology/images/icons48/server.png');
				*/
				// Displays useful hints in a small semi-transparent box.
				/*var hints = document.createElement('div');
				hints.style.position = 'absolute';
				hints.style.overflow = 'hidden';
				hints.style.width = '230px';
				hints.style.bottom = '56px';
				hints.style.height = '106px';
				hints.style.right = '20px';
				
				hints.style.background = 'black';
				hints.style.color = 'white';
				hints.style.fontFamily = 'Arial';
				hints.style.fontSize = '10px';
				hints.style.padding = '4px';

				mxUtils.setOpacity(hints, 50);
				
				mxUtils.writeln(hints, '- Drag an image from the sidebar to the graph');
				mxUtils.writeln(hints, '- Doubleclick on a vertex or edge to edit');
				mxUtils.writeln(hints, '- Shift- or Rightclick and drag for panning');
				mxUtils.writeln(hints, '- Move the mouse over a cell to see a tooltip');
				mxUtils.writeln(hints, '- Click and drag a vertex to move and connect');
				document.body.appendChild(hints);
				*/
				// Creates a new DIV that is used as a toolbar and adds
				// toolbar buttons.
				var spacer = document.createElement('div');
				spacer.style.display = 'inline';
				spacer.style.padding = '8px';
				
				addToolbarButton(editor, toolbar, 'groupOrUngroup', '成组(拆组)', 'topology/images/group.png');
				
				// Defines a new action for deleting or ungrouping
				editor.addAction('groupOrUngroup', function(editor, cell)
				{
					cell = cell || editor.graph.getSelectionCell();
					if (cell != null && editor.graph.isSwimlane(cell))
					{
						editor.execute('ungroup', cell);
					}
					else
					{
						editor.execute('group');
					}
				});
				
				addToolbarButton(editor, toolbar, 'delete', '删除', 'topology/images/delete2.png');
				
				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'cut', '剪切', 'topology/images/cut.png');
				addToolbarButton(editor, toolbar, 'copy', '赋值', 'topology/images/copy.png');
				addToolbarButton(editor, toolbar, 'paste', '黏贴', 'topology/images/paste.png');

				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'undo', '撤销', 'topology/images/undo.png');
				addToolbarButton(editor, toolbar, 'redo', '重做', 'topology/images/redo.png');
				
				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'show', '演示', 'topology/images/camera.png');
				addToolbarButton(editor, toolbar, 'print', '打印', 'topology/images/printer.png');
				
				toolbar.appendChild(spacer.cloneNode(true));

				// Defines a new export action
				var xml;
				editor.addAction('export', function(editor, cell)
				{
					var textarea = document.createElement('textarea');
					textarea.style.width = '400px';
					textarea.style.height = '400px';
					var enc = new mxCodec(mxUtils.createXmlDocument());
					var node = enc.encode(editor.graph.getModel());
					//editor.save("D:\success.xml",mxUtils.getXml(node));
					var xml1 = mxUtils.getPrettyXml(node);
					textarea.value = xml1;
					showModalWindow(graph, 'XML', textarea, 410, 440);	
					
                    //xml = encodeURIComponent(xml1);//这就是要提交到后台的xml代码
                    XML=editor.writeGraphModel();
                    ////alert(XML);
               
                    
				});

				addToolbarButton(editor, toolbar, 'export', '导出', 'topology/images/export1.png');
				
				editor.addAction('saveExp', function(editor, cell)
				{
                    XML=editor.writeGraphModel();
					saveXML();
				});
				addToolbarButton(editor, toolbar, 'saveExp', '提交实验申请', 'topology/images/export1.png');
				
				editor.addAction('configure', function(editor, cell)
				{
					
					sendConfig();
				});
				addToolbarButton(editor, toolbar, 'configure', '提交路由器配置', 'topology/images/export1.png');
				editor.addAction('loadxml', function(editor, cell)
				{
					loadXML();
				});
				addToolbarButton(editor, toolbar, 'loadxml', '装载XML', 'topology/images/export1.png');
				
				// ---
				
				// Adds toolbar buttons into the status bar at the bottom
				// of the window.
				addToolbarButton(editor, status, 'collapseAll', '关闭全部', 'topology/images/navigate_minus.png', true);
				addToolbarButton(editor, status, 'expandAll', '展开全部', 'topology/images/navigate_plus.png', true);

				status.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, status, 'enterGroup', '进入', 'topology/images/view_next.png', true);
				addToolbarButton(editor, status, 'exitGroup', '退出', 'topology/images/view_previous.png', true);

				status.appendChild(spacer.cloneNode(true));

				addToolbarButton(editor, status, 'zoomIn', '', 'topology/images/zoom_in.png', true);
				addToolbarButton(editor, status, 'zoomOut', '', 'topology/images/zoom_out.png', true);
				addToolbarButton(editor, status, 'actualSize', '', 'topology/images/view_1_1.png', true);
				addToolbarButton(editor, status, 'fit', '', 'topology/images/fit_to_size.png', true);
				
				// Creates the outline (navigator, overview) for moving
				// around the graph in the top, right corner of the window.
				var outln = new mxOutline(graph, outline);

				// To show the images in the outline, uncomment the following code
				//outln.outline.labelsVisible = true;
				//outln.outline.setHtmlLabels(true);
				
				// Fades-out the splash screen after the UI has been loaded.
				var splash = document.getElementById('splash');
				if (splash != null)
				{
					try
					{
						mxEvent.release(splash);
						mxEffects.fadeOut(splash, 100, true);
					}
					catch (e)
					{
					
						// mxUtils is not available (library not loaded)
						splash.parentNode.removeChild(splash);
					}
				}
			}
			
			/*for (i = 0; i < jsonContent.topology.length; i++) {
			
				//'<a href="phyMachine.action?pid=' + jsonContent.topology[i].pmId + '" target="_blank">' + jsonContent.topology[i].pmName + '</a>'
				var group = new mxCell(jsonContent.topology[i].pmName, new mxGeometry(), 'group');
				group.setVertex(true);
				group.setConnectable(false);
				editor.defaultGroup = group;
				editor.groupBorderSize = 20;			
				
				for (var j = 0; j < jsonContent.topology[i].routers.length; j++)
				{
					addRouter(graph,'<h1 style="margin:0px;">Router</h1><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="router.action?pid=' + jsonContent.topology[i].pmId +'&vid=' +
					  jsonContent.topology[i].routers[j].vrId +'" target="_blank">' + jsonContent.topology[i].routers[j].vrName + '</a>',120+i*300,120+j*200,jsonContent.topology[i].routers[j].ports, jsonContent.topology[i].routers[j].portsName, j);
					var cell = editor.graph.getSelectionCell();	
				}
				editor.execute('group',cell);				
			}*/
	
			
		};
		
		function addToolbarButton(editor, toolbar, action, label, image, isTransparent)
		{
			var button = document.createElement('button');
			button.style.fontSize = '10';
			if (image != null)
			{
				var img = document.createElement('img');
				img.setAttribute('src', image);
				img.style.width = '16px';
				img.style.height = '16px';
				img.style.verticalAlign = 'middle';
				img.style.marginRight = '2px';
				button.appendChild(img);
			}
			if (isTransparent)
			{
				button.style.background = 'transparent';
				button.style.color = '#FFFFFF';
				button.style.border = 'none';
			}
			mxEvent.addListener(button, 'click', function(evt)
			{
				//var cell = editor.graph.getSelectionCell();
				////alert(cell.getId());这里不能用ID判断，所以用了value，待改正
				
				editor.execute(action);
			});
			mxUtils.write(button, label);
			toolbar.appendChild(button);
		};

		function showModalWindow(graph, title, content, width, height)
		{
			var background = document.createElement('div');
			background.style.position = 'absolute';
			background.style.left = '0px';
			background.style.top = '0px';
			background.style.right = '0px';
			background.style.bottom = '0px';
			background.style.background = 'black';
			mxUtils.setOpacity(background, 50);
			document.body.appendChild(background);
			
			if (mxClient.IS_IE)
			{
				new mxDivResizer(background);
			}
			
			var x = Math.max(0, document.body.scrollWidth/2-width/2);
			var y = Math.max(10, (document.body.scrollHeight ||
						document.documentElement.scrollHeight)/2-height*2/3);
			var wnd = new mxWindow(title, content, x, y, width, height, false, true);
			wnd.setClosable(true);
			
			// Fades the background out after after the window has been closed
			wnd.addListener(mxEvent.DESTROY, function(evt)
			{
				graph.setEnabled(true);
				mxEffects.fadeOut(background, 50, true, 
					10, 30, true);
			});

			graph.setEnabled(false);
			graph.tooltipHandler.hide();
			wnd.setVisible(true);
		};
		
		function addRouter(graph,label,x,y,ports, portsName,id)
		{
			var parent = graph.getDefaultParent();
			var model = graph.getModel();
				
			//var v1 = null;
				
			model.beginUpdate();
				try
				{
					// NOTE: For non-HTML labels the image must be displayed via the style
					// rather than the label markup, so use 'image=' + image for the style.
					// as follows: v1 = graph.insertVertex(parent, null, label,
					// pt.x, pt.y, 120, 120, 'image=' + image);
					v1 = graph.insertVertex(parent, id, label, x, y, 120, 120);
					v1.setConnectable(false);
					
					// Presets the collapsed size
					v1.geometry.alternateBounds = new mxRectangle(0, 0, 120, 40);
					var sides = [0,0,1,1];
					var bias = [0.25, 0.75, 0.25, 0.75];
					var point_x = [-6, -6, -8, -8];
					var point_y = [-8, -4, -8, -4];
					for (var i = 0; i < ports.length; i++)
					{
						var port = graph.insertVertex(v1, null, portsName[i] + ":" + ports[i], sides[i],  bias[i], 16, 16,
							'port;image=topology/editors/images/overlays/flash.png;align=right;imageAlign=right;spacingRight=18');
						port.geometry.offset = new mxPoint(point_x[i], point_y[i]);
						port.geometry.relative = true;
						
					}
					/*
					// Adds the ports at various relative locations
					var port = graph.insertVertex(v1, null, 'Port1', 0, 0.25, 16, 16,
							'port;image=topology/editors/images/overlays/flash.png;align=right;imageAlign=right;spacingRight=18');
					port.geometry.offset = new mxPoint(-6, -8);
					port.geometry.relative = true;
		
					var port = graph.insertVertex(v1, null, 'Port2', 0, 0.75, 16, 16,
							'port;image=topology/editors/images/overlays/check.png;align=right;imageAlign=right;spacingRight=18');
					port.geometry.offset = new mxPoint(-6, -4);
					port.geometry.relative = true;
					
					var port = graph.insertVertex(v1, null, 'Port3', 1, 0.25, 16, 16,
							'port;image=topology/editors/images/overlays/error.png;spacingLeft=18');
					port.geometry.offset = new mxPoint(-8, -8);
					port.geometry.relative = true;

					var port = graph.insertVertex(v1, null, 'Port4', 1, 0.75, 16, 16,
							'port;image=topology/editors/images/overlays/information.png;spacingLeft=18');
					port.geometry.offset = new mxPoint(-8, -4);
					port.geometry.relative = true;
					*/
				}
				finally
				{
					model.endUpdate();
				}
				
				if (id == 0)
				{
					graph.setSelectionCell(v1);
				}
				else
				{
					graph.addSelectionCell(v1);
				}
				
		};
	
		function addSidebarIcon(graph, sidebar, label, image, type)
		{
			// Function that is executed when the image is dropped on
			// the graph. The cell argument points to the cell under
			// the mousepointer if there is one.
			var funct = function(graph, evt, cell, x, y)
			{
				var parent = graph.getDefaultParent();
				var model = graph.getModel();
				
				var v1 = null;
				
				if (type=='0')
				{
				highID++;
				}
				else
				{
				lowID++;
				}
				
				model.beginUpdate();
				try
				{
					//判断添加的路由器类型，用于统计路由器个数
					
					// NOTE: For non-HTML labels the image must be displayed via the style
					// rather than the label markup, so use 'image=' + image for the style.
					// as follows: v1 = graph.insertVertex(parent, null, label,
					// pt.x, pt.y, 120, 120, 'image=' + image);
					v1 = graph.insertVertex(parent, null, label, x, y, 120, 120);
					v1.setConnectable(false);
					
					// Presets the collapsed size
					v1.geometry.alternateBounds = new mxRectangle(0, 0, 120, 40);
										
					// Adds the ports at various relative locations
					var port = graph.insertVertex(v1, null, 'eth0', 0, 0.25, 16, 16,
							'port;image=editors/images/overlays/flash.png;align=right;imageAlign=right;spacingRight=18');
					port.geometry.offset = new mxPoint(-6, -8);
					port.geometry.relative = true;
		
					var port = graph.insertVertex(v1, null, 'eth1', 0, 0.75, 16, 16,
							'port;image=editors/images/overlays/check.png;align=right;imageAlign=right;spacingRight=18');
					port.geometry.offset = new mxPoint(-6, -4);
					port.geometry.relative = true;
					
					var port = graph.insertVertex(v1, null, 'eth2', 1, 0.25, 16, 16,
							'port;image=editors/images/overlays/error.png;spacingLeft=18');
					port.geometry.offset = new mxPoint(-8, -8);
					port.geometry.relative = true;

					var port = graph.insertVertex(v1, null, 'eth3', 1, 0.75, 16, 16,
							'port;image=editors/images/overlays/information.png;spacingLeft=18');
					port.geometry.offset = new mxPoint(-8, -4);
					port.geometry.relative = true;
					if (type=='0')
					{
						
						v1.setId(highID+"");
						v1.setValue('<h4>HighRouter'+highID+
					'</h4><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" id="configvr'+highID+'" name='+highID+
					' onclick="testMessageBox(event,this)">配置   </a>'+
					'<a href="#none" id="showvr'+highID+'" name='+highID+' onclick="testMessageBox(event,this)">查看</a>');
					}
					else
					{
						v1.setId(lowID+"");
						v1.setValue('<h4>LowRouter'+lowID+
					'</h4><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" id="configvr'+lowID+'" name='+lowID+
					' onclick="testMessageBox(event,this)">配置</a>'+
					'<a href="#none" id="showvr'+lowID+'" name='+lowID+' onclick="testMessageBox(event,this)">查看</a>');
					}
					
					
					
				}
				finally
				{
					model.endUpdate();
				}
				
				
				graph.setSelectionCell(v1);
				
					
				
				getVRNum(graph);
				
			};
			
			// Creates the image which is used as the sidebar icon (drag source)
			var img = document.createElement('img');
			img.setAttribute('src', image);
			img.style.width = '48px';
			img.style.height = '48px';
			img.title = 'Drag this to the diagram to create a new vertex';
			sidebar.appendChild(img);
			
			var dragElt = document.createElement('div');
			dragElt.style.border = 'dashed black 1px';
			dragElt.style.width = '120px';
			dragElt.style.height = '120px';
			  					
			// Creates the image which is used as the drag icon (preview)
			var ds = mxUtils.makeDraggable(img, graph, funct, dragElt, 0, 0, true, true);
			ds.setGuidesEnabled(true);
		};
		
		function configureStylesheet(graph)
		{
			var style = new Object();
			style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_RECTANGLE;
			style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
			style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
			style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
			style[mxConstants.STYLE_GRADIENTCOLOR] = '#41B9F5';
			style[mxConstants.STYLE_FILLCOLOR] = '#8CCDF5';
			style[mxConstants.STYLE_STROKECOLOR] = '#1B78C8';
			style[mxConstants.STYLE_FONTCOLOR] = '#000000';
			style[mxConstants.STYLE_ROUNDED] = true;
			style[mxConstants.STYLE_OPACITY] = '80';
			style[mxConstants.STYLE_FONTSIZE] = '12';
			style[mxConstants.STYLE_FONTSTYLE] = 0;
			style[mxConstants.STYLE_IMAGE_WIDTH] = '48';
			style[mxConstants.STYLE_IMAGE_HEIGHT] = '48';
			graph.getStylesheet().putDefaultVertexStyle(style);

			// NOTE: Alternative vertex style for non-HTML labels should be as
			// follows. This repaces the above style for HTML labels.
			/*var style = new Object();
			style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_LABEL;
			style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
			style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_TOP;
			style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
			style[mxConstants.STYLE_IMAGE_ALIGN] = mxConstants.ALIGN_CENTER;
			style[mxConstants.STYLE_IMAGE_VERTICAL_ALIGN] = mxConstants.ALIGN_TOP;
			style[mxConstants.STYLE_SPACING_TOP] = '56';
			style[mxConstants.STYLE_GRADIENTCOLOR] = '#7d85df';
			style[mxConstants.STYLE_STROKECOLOR] = '#5d65df';
			style[mxConstants.STYLE_FILLCOLOR] = '#adc5ff';
			style[mxConstants.STYLE_FONTCOLOR] = '#1d258f';
			style[mxConstants.STYLE_FONTFAMILY] = 'Verdana';
			style[mxConstants.STYLE_FONTSIZE] = '12';
			style[mxConstants.STYLE_FONTSTYLE] = '1';
			style[mxConstants.STYLE_ROUNDED] = '1';
			style[mxConstants.STYLE_IMAGE_WIDTH] = '48';
			style[mxConstants.STYLE_IMAGE_HEIGHT] = '48';
			style[mxConstants.STYLE_OPACITY] = '80';
			graph.getStylesheet().putDefaultVertexStyle(style);*/

			style = new Object();
			style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_SWIMLANE;
			style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
			style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_CENTER;
			style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_TOP;
			style[mxConstants.STYLE_FILLCOLOR] = '#FF9103';
			style[mxConstants.STYLE_GRADIENTCOLOR] = '#F8C48B';
			style[mxConstants.STYLE_STROKECOLOR] = '#E86A00';
			style[mxConstants.STYLE_FONTCOLOR] = '#000000';
			style[mxConstants.STYLE_ROUNDED] = true;
			style[mxConstants.STYLE_OPACITY] = '80';
			style[mxConstants.STYLE_STARTSIZE] = '30';
			style[mxConstants.STYLE_FONTSIZE] = '16';
			style[mxConstants.STYLE_FONTSTYLE] = 1;
			graph.getStylesheet().putCellStyle('group', style);
			
			style = new Object();
			style[mxConstants.STYLE_SHAPE] = mxConstants.SHAPE_IMAGE;
			style[mxConstants.STYLE_FONTCOLOR] = '#774400';
			style[mxConstants.STYLE_PERIMETER] = mxPerimeter.RectanglePerimeter;
			style[mxConstants.STYLE_PERIMETER_SPACING] = '6';
			style[mxConstants.STYLE_ALIGN] = mxConstants.ALIGN_LEFT;
			style[mxConstants.STYLE_VERTICAL_ALIGN] = mxConstants.ALIGN_MIDDLE;
			style[mxConstants.STYLE_FONTSIZE] = '10';
			style[mxConstants.STYLE_FONTSTYLE] = 2;
			style[mxConstants.STYLE_IMAGE_WIDTH] = '16';
			style[mxConstants.STYLE_IMAGE_HEIGHT] = '16';
			//graph.getStylesheet().putCellStyle('port', style);
			
			style = graph.getStylesheet().getDefaultEdgeStyle();
			style[mxConstants.STYLE_LABEL_BACKGROUNDCOLOR] = '#FFFFFF';
			style[mxConstants.STYLE_STROKEWIDTH] = '2';
			style[mxConstants.STYLE_ROUNDED] = true;
			style[mxConstants.STYLE_EDGE] = mxEdgeStyle.EntityRelation;
		};
		
		function getVRNum(graph){
				var parent = editor.graph.getDefaultParent();
				graph.selectAll();
				highNum=0;
				lowNum=0;
				highCodeIndex=0;
				lowCodeIndex = 0;
				var cellArray=new Array();
				var cellNum=0;
				
				//cellArray=graph.getCells(0,0,'10000px','10000px',graph,cellArray);
				graph.selectAll(graph);
				cellArray=graph.getSelectionCells();
				cellNum=graph.getSelectionCount();
				////alert(cellNum);
				for (var i = 0;i<cellArray.length;i++)
				{
					////alert(cellArray[i].getValue());
					if (cellArray[i].getId()<1000 && cellArray[i].getId()>100)
					{
						highNum++;
						highCodeID[highCodeIndex++] = cellArray[i].getId();
					}					
					else if (cellArray[i].getId() > 1000)
					{
						lowNum++;
						lowCodeID[lowCodeIndex++] = cellArray[i].getId();
					}
				}	
				
				////alert('highrouter'+highNum);
				////alert('lowrouter'+lowNum);
				
				
		
		}
		
	var xmlhttp;
	var jsonContent;
  	//创建XMLHttpRequest对象
	function createXmlHttp(){
		// 判断游览器
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
		  	xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
		  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}	
	}
				
	//主调函数,以当前页作为参数
	function ajax() {
		createXmlHttp();
		xmlhttp.open("post","topology.action?method=get",true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
	}
	
	//回调函数
	function callback(){
	

		if (xmlhttp.readyState == 4)
		{
		if (xmlhttp.status == 200)
			{
				var rs = xmlhttp.responseText;
				//使用eval方法将服务器上的json字符传转换成json对象
				jsonContent = eval('('+rs+')');
				
				
				

			}
		}
	}
	
	function start()
	{
		main(document.getElementById('graphContainer'),
					document.getElementById('outlineContainer'),
				 	document.getElementById('toolbarContainer'),
					document.getElementById('sidebarContainer'),
					document.getElementById('statusContainer'));
		var exp = '<s:property value="expID"/>';
		if (exp!='create'){
		loadXML();
		}
		
	}
	
	function ajax_storeXML(data) {
		createXmlHttp();
		var name=document.getElementById('expName').innerHTML;
		var des=document.getElementById('expDescription').innerHTML;
		////alert(des);
		////alert(name);
		//更新路由器数量和ID
		getVRNum(editor.graph);
		
		xmlhttp.open("post","ApplyExperiment.action?expName="+name+"&expDescription="+des+"&highNum="+highNum+"&lowNum="+lowNum+"&highCodeID="+highCodeID+"&lowCodeID="+lowCodeID,true);
		//xmlhttp.onreadystatechange = my_alert;
		xmlhttp.send(data);
		//alert("ajax_store");
	}
	
	function ajax_loadXML()
	{
	
		createXmlHttp();
		////alert("xmlHTTP");
		xmlhttp.open("post","OpenExperimentAction.action?method=xml",true);
		xmlhttp.onreadystatechange = showXML;
		xmlhttp.send(null);
		
	}
	function showXML(){
		////alert("show xml");
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		jsonContent = eval('('+rs+')');
		XML = jsonContent["XML"];
		////alert(XML);
		editor.graph.getModel().beginUpdate();
		var doc = mxUtils.parseXml(XML);
		var root = doc.documentElement;
		var dec = new mxCodec(doc);   
		dec.decode(root, editor.graph.getModel()); 
		editor.graph.getModel().endUpdate();
		
		
	}
	
	//config router page
	
	var isIe=(document.all)?true:false;
	//设置select的可见状态
	function setSelectState(state)
	{
		var objl=document.getElementsByTagName('select');
		for(var i=0;i<objl.length;i++)
		{
		objl[i].style.visibility=state;
		}
		}
		function mousePosition(ev)
		{
		if(ev.pageX || ev.pageY)
		{
		return {x:ev.pageX, y:ev.pageY};
		}
		return {
		x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,y:ev.clientY + document.body.scrollTop - document.body.clientTop
		};
	}
	//弹出方法
	function showMessageBox(wTitle,content,pos,wWidth,id,type)
	{
		closeWindow();
		var bWidth=parseInt(document.documentElement.scrollWidth);
		var bHeight=parseInt(document.documentElement.scrollHeight);
		if(isIe){
		setSelectState('hidden');}
		var back=document.createElement("div");
		back.id="back";
		var styleStr="top:0px;left:0px;position:absolute;background:#666;width:"+bWidth+"px;height:"+bHeight+"px;";
		styleStr+=(isIe)?"filter:alpha(opacity=0);":"opacity:0;";
		back.style.cssText=styleStr;
		document.body.appendChild(back);
		showBackground(back,50);
		/*var mesW=document.createElement("div");
		mesW.id="mesWindow";
		mesW.className="mesWindow";
		mesW.innerHTML="<div class='mesWindowTop'><table width='100%' height='100%'><tr><td>"+wTitle+"</td><td style='width:1px;'><input type='button' onclick='closeWindow();' title='关闭窗口' class='close' value='关闭' /></td></tr></table></div><div class='mesWindowContent' id='mesWindowContent'>"+content+"</div><div class='mesWindowBottom'></div>";
		styleStr="left:"+(((pos.x-wWidth)>0)?(pos.x-wWidth):pos.x)+"px;top:"+(pos.y)+"px;position:absolute;width:"+wWidth+"px;";
		mesW.style.cssText=styleStr;
		document.body.appendChild(mesW);*/
		 isshow=1;
    	if(!document.getElementById("msgDiv"+id))//小窗口不存在
        creatediv(id);
        
        loadConfig(id);
       //alert(type);
        if (type==("showvr"+id))
        	{
        		setUneditable(id);
        	}
        else
        {
        	setEditable(id);
        }
        //alert(id);
        document.getElementById("msgDiv"+id).style.display="";
        document.getElementById("msgDiv"+id).style.top=(document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
        
	}
	function ajax_loadConfig(id)
	{
	
		createXmlHttp();
		////alert("xmlHTTP");
		xmlhttp.open("post","OpenExperimentAction.action?method=config&vrCode="+id,true);
		xmlhttp.onreadystatechange = showConfig;
		xmlhttp.send(null);
		
	}
	function showConfig(){
		//alert("show congi");
		var rs = xmlhttp.responseText;
		var j;
		//使用eval方法将服务器上的json字符传转换成json对象
		jsonContent = eval('('+rs+')');
		
		var vid = jsonContent["vid"];
		var exists = jsonContent["exists"];
		
		//alert(exists);
		
		//alert(jsonContent["portOSPF0"]);
		if (exists=="yes")
		{
		document.getElementById("config"+vid)[0].value=jsonContent["portIP0"];
		document.getElementById("config"+vid)[1].value=jsonContent["portOSPF0"];
		document.getElementById("config"+vid)[2].value=jsonContent["portIP1"];
		document.getElementById("config"+vid)[3].value=jsonContent["portOSPF1"];
		document.getElementById("config"+vid)[4].value=jsonContent["portIP2"];
		document.getElementById("config"+vid)[5].value=jsonContent["portOSPF2"];
		document.getElementById("config"+vid)[6].value=jsonContent["portIP3"];
		document.getElementById("config"+vid)[7].value=jsonContent["portOSPF3"];
		
		
		}
		
				
				
			
		
	}
	function loadConfig(id)
	{
		ajax_loadConfig(id);
	}
	
	function setUneditable(vid)
	{
		var i=0;
		for( i=0;i<8;i++)
		document.getElementById("config"+vid)[i].disabled=true;
		
	}
	function setEditable(vid)
	{
		var i=0;
		for( i=0;i<8;i++)
		document.getElementById("config"+vid)[i].disabled=false;
	}
	
	//让背景渐渐变暗
	function showBackground(obj,endInt)
	{
		if(isIe)
		{
		obj.filters.alpha.opacity+=1;
		if(obj.filters.alpha.opacity<endInt)
		{
		setTimeout(function(){showBackground(obj,endInt)},5);
		}
		}else{
		var al=parseFloat(obj.style.opacity);al+=0.01;
		obj.style.opacity=al;
		if(al<(endInt/100))
		{setTimeout(function(){showBackground(obj,endInt)},5);}
		}
	}
	//关闭窗口
	function closeWindow()
	{
		if(document.getElementById('back')!=null)
		{
		document.getElementById('back').parentNode.removeChild(document.getElementById('back'));
		}
		if(document.getElementById('mesWindow')!=null)
		{
		document.getElementById('mesWindow').parentNode.removeChild(document.getElementById('mesWindow'));
		}
		if(isIe){
		setSelectState('');}
	}
	//测试弹出
	function testMessageBox(ev,obj)
	{
		//alert(obj.name);
		var objPos = mousePosition(ev);
		messContent="<div style='padding:20px 0 20px 0;text-align:center'>消息正文</div>";
		showMessageBox('窗口标题',messContent,objPos,350,obj.name,obj.id);
	}
	var isshow=0;//0小窗口没有显示，1小窗口已显
	function creatediv(id)
	{       
		
		id = id +"";     
	    var msgw,msgh,bordercolor;
	    msgw=400;//提示窗口的宽度
	    msgh=505;//提示窗口的高度
	    var sWidth,sHeight;
	    if( top.location == self.location )
	        doc = document;
	    var docElement = doc.documentElement;
	    sWidth=docElement.clientWidth;
	    sHeight = docElement.clientHeight;
	    if( docElement.scrollHeight > sHeight )
	        sHeight = docElement.scrollHeight;
	    var bgObj=document.createElement("div");
	    bgObj.setAttribute('id',"bgDiv"+id);
	    bgObj.style.position="absolute";
	    bgObj.style.top="0";
	    bgObj.style.left="0";
	    bgObj.style.background="#777";
	    bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
	    bgObj.style.opacity="0.6";
	    bgObj.style.width=sWidth + "px";
	    bgObj.style.height=sHeight + "px";
	    bgObj.style.zIndex = "10000";
	    document.body.appendChild(bgObj);
	        
	    var msgObj=document.createElement("div");
	    msgObj.setAttribute("id","msgDiv"+id);
	    msgObj.setAttribute("align","center");
	    msgObj.style.position = "absolute";
	    msgObj.style.left = "50%";
	    msgObj.style.background="#fff";
	    msgObj.style.marginLeft = "-200px" ;
	    msgObj.style.top = (document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
	    msgObj.style.width = msgw + "px";
	    msgObj.style.height =msgh + "px";
	    msgObj.style.zIndex ="10001";
	    msgObj.innerHTML = "<form class=\"well\" id=\"config"+id+"\"><label align=\"left\" class=\"control-label\">Eth0 IP:</label><input type=\"text\" name=\"eth0IP\" /><br /><label align=\"left\" class=\"control-label\">Eth0 OSFP:</label><input type=\"text\" name=\"eth0Ospf\" /><br />"
	    					+"<label align=\"left\" class=\"control-label\">Eth1 IP:</label><input type=\"text\" name=\"eth1IP\" /><br /><label align=\"left\" class=\"control-label\">Eth1 OSFP:</label><input type=\"text\" name=\"eth1Ospf\" /><br />"
	    					+"<label align=\"left\" class=\"control-label\">Eth2 IP:</label><input type=\"text\" name=\"eth2IP\" /><br /><label align=\"left\" class=\"control-label\">Eth2 OSFP:</label><input type=\"text\" name=\"eth2Ospfe\" /><br />"
	    					+"<label align=\"left\" class=\"control-label\">Eth3 IP:</label><input type=\"text\" name=\"eth3IP\" /><br /><label align=\"left\" class=\"control-label\">Eth3 OSFP:</label><input type=\"text\" name=\"eth3Ospf\" /><br />"
	    					+"<input type=\"hidden\" name=\"routerId\" display=\"null\" value=\""
	    					+id+"\"/>"
	    					+"<input id="+id+" type=\"button\" onclick='saveConfig(this);' value=\"确定\" /><input id="+id+" type=\"reset\" onclick='delWinD(this);' value=\"取消\" /></form>";
	    				
	    					
	    document.body.appendChild(msgObj);
	    
	    
	}
	function delWinD(obj)
	{
	   document.getElementById("bgDiv"+obj.id).style.display="none";
	   document.getElementById("msgDiv"+obj.id).style.display="none";
	   closeWindow();
	   isshow=0;
	}
	function saveConfig(obj)
	{
		//alert(obj.id);
		getVRNum(editor.graph);
		var i=0,j=0, flag = 0;
		
		for (i = 0;i<configIndex;i++)
		{
			if (obj.id==IDArray[i])
			{
				index = i;
				flag = 1;
				break;
			}
		}
		
		if (flag==0)
		{
			index = configIndex;
		}
		
		if (obj.id<1000)
		{
			//high router
			for (j = 0;j<8;j++)
			{
				if (document.getElementById("config"+obj.id)[j].value!="")	
				{
					IDArray[index]=obj.id;
					portArray[index]=Math.floor(j/2);
					configArray[index]=document.getElementById("config"+obj.id)[j].value;
					////alert(configArray[configIndex]);
					index++;
				}
			}
		}
		else
		{//low router
		
		}
		
		if (flag==0)
		{
			configIndex = index;
		}
		
		delWinD(obj);
				
	}
	
	function sendConfig()
	{
		createXmlHttp();
		
		xmlhttp.open("post","configRouter.action?IDArray="+IDArray+"&configArray="+configArray+"&vrHighNum="+highNum+"&vrLowNum="+lowNum+"&portArray="+portArray,true);
		//xmlhttp.onreadystatechange = ;
		xmlhttp.send(null);
		
		
	}
	
	// end of config router page 
	function saveXML()
	{
		//alert("bye bye");
		ajax_storeXML(XML);
		
	}
	function loadXML()
	{
		
		//if (onloadflag==0)
		//{
		////alert("I am loading");
		ajax_loadXML();
		//onloadflag=1;
		//}
		////alert(onloadflag);
	
	}
	
	
	
	</script>
</head>

<!-- Page passes the container for the graph to the grogram -->
<body  id="body"; onload="start()"; style=" padding-top: 30px;padding-bottom: 0px;">

	<!--  
	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li ><a href=""><b>实验床管理系统</b></a></li>
				
				<li style=" font-size:10px; "><a href="experimenterInfo.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>-->

	
	<!-- Creates a container for the splash screen 
	<div id="splash"
		style="position:absolute;top:0px;left:0px;width:100%;height:100%;background:white;z-index:1;">
		<center id="splash" style="padding-top:230px;">
			<img src="topology/editors/images/loading.gif">
		</center>
	</div>-->

	<!--
	<div id="left">
	<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="create_experiment.jsp">创建实验</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="experiment_system.jsp">申请释放</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="experiment_system.jsp">配置路由</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">实验控制</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">启动停止</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="#">实验数据</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
					<li class="sepra-list first"><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="#">实验报表</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">数据报表</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">评价模型</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="#">实验工具</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">背景流量</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">编程工具</a></li>
				</ul>
			</li>
		</ul>
		
		
		
	</div>
</div>
	</div>-->
	
	 <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">TestBed</a>
          <div class="btn-group pull-right">
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
              <i class="icon-user"></i> weiwang
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="#">设置</a></li>
              <li class="divider"></li>
              <li><a href="#">退出</a></li>
            </ul>
          </div>
          <div class="nav-collapse">
            <ul class="nav">
              <li><p class="navbar-text">管理系统</p></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
	
	
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span2" style="margin-top:70px; font-size:18px;" align="center">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
             <li ><a style="text-decoration:none;" href="UserExpsAction.action">创建打开</a></li>
              <li class="active"><a style="text-decoration:none;" href="createExp.action?method=open">申请配置</a></li>
              <li><a href="">启动停止</a></li>
              <li><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
              <li ><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
              <li><a href="">数据报表</a></li>
              <li><a href="">实验工具</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
		
		
        <div class="span10">
          <div class="page-header" style="padding-bottom:0px">
			<h2>实验申请
			<small>实验 <s:property value="expName"/></small></h2>
	      </div>
		 <!-- Creates a container for the toolboox -->
	<div id="toolbarContainer"
		style="position:relative;white-space:nowrap;overflow:hidden;top:0px;left:0px;max-height:24px;height:36px;right:0px;padding:6px;margin-top:0px;background-color:#f5f5f5;">
	</div>
	
	<!-- Creates a container for the sidebar -->
	<div id="sidebarContainer"
		style="position:float;float:left;overflow:hidden;height:480px;max-width:52px;width:56px;background-color:#f5f5f5">
	</div>
	
	<!-- Creates a container for the graph -->
	<div id="graphContainer"
		style="; height:480px;position:float;overflow:hidden;top:0px;background-image:url('topology/editors/images/grid.gif');cursor:default;">
		
		
	</div>

	<!-- Creates a container for the outline -->
		<div id="outlineContainer"
			style="position:absolute;overflow:hidden;margin-top:10px;margin-right:10px;hidden;top:150px;right:30px;width:200px;height:140px;background:transparent;border-style:solid;border-color:black;">
		</div>
		
	<!-- Creates a container for the sidebar -->
	<div id="statusContainer" 
		style="/*visibility:hidden;*/text-align:right;position:float;overflow:hidden;/*bottom:0px;left:0px;*/max-height:24px;height:36px;/*right:0px;*/padding:6px;background-color:#333;">
		<!-- <div style="font-size:10pt;float:left;">
			 Created with <a href="http://www.jgraph.com" target="_blank">mxGraph</a>
		</div> -->
	</div>
        </div><!--/span-->
	  </div> <!-- /row-fluid--> 
      <hr/>


    </div><!--/.fluid-container-->


	<script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
	
	
	
	
	
	
	
	
	
	
	


	<div style="visibility:hidden" >
	<p id="expName" ><s:property value="expName"/></p>
	<p id="expDescription"><s:property value="expDescription"/></p>
	</div>
	<div id="footer"><div class="cleaner"></div><p><a id="foot_a" href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p>
	</div>
	
	<!--<a href="#none" onclick="testMessageBox(event);">配置路由器</a>-->
	
	
	
	
</body>
</html>
