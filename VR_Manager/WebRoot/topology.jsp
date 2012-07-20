<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"   pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<!--
  $Id: ports.html,v 1.77 2011-10-29 07:52:49 gaudenz Exp $
  Copyright (c) 2006-2010, JGraph Ltd
  
  Ports example for mxGraph. This example demonstrates implementing
  ports as child vertices with relative positions and drag and drop
  as well as the use of images and HTML in cells.
-->
<html>
<head>
	<title>试验床</title>
	<style type="text/css" media="screen">
		BODY {
			font-family: Arial;
		}
		H1 {
			font-size: 18px;
		}
		H2 {
			font-size: 16px;
		}
	</style>

	<!-- Sets the basepath for the library if not in same directory -->
	<script type="text/javascript">
		mxBasePath = 'topology/src';
	</script>

	<!-- Loads and initializes the library -->
	<link href="css/nav.css" rel="stylesheet" type="text/css" />
	
	<script type="text/javascript" src="topology/src/js/mxClient.js"></script>

	<!-- Example code -->
	<script type="text/javascript">
		// Program starts here. Creates a sample graph in the
		// DOM node with the specified ID. This function is invoked
		// from the onLoad event handler of the document (see below).
		var phyMachineMarkID = 10000;
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
				var editor = new mxEditor();
				var graph = editor.graph;
				var model = graph.getModel();

				// Disable highlight of cells when dragging from toolbar
				graph.setDropEnabled(false);

				// Uses the port icon while connections are previewed
				graph.connectionHandler.getConnectImage = function(state)
				{
					return new mxImage(state.style[mxConstants.STYLE_IMAGE], 16, 16);
				};

				// Centers the port icon on the target port
				graph.connectionHandler.targetConnectImage = true;

				// Does not allow dangling edges
				graph.setAllowDanglingEdges(false);

				// Sets the graph container and configures the editor
				editor.setGraphContainer(container);
				var config = mxUtils.load(
					'editors/config/keyhandler-commons.xml').
						getDocumentElement();
				editor.configure(config);
				
				// Defines the default group to be used for grouping. The
				// default group is a field in the mxEditor instance that
				// is supposed to be a cell which is cloned for new cells.
				// The groupBorderSize is used to define the spacing between
				// the children of a group and the group bounds.
				var group = new mxCell('Group', new mxGeometry(), 'group');
				group.setVertex(true);
				group.setConnectable(false);
				editor.defaultGroup = group;
				editor.groupBorderSize = 20;

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

				// Disables HTML labels for swimlanes to avoid conflict
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
				// be as follows:
				// addSidebarIcon(graph, sidebar, 'Website', 'topology/images/icons48/earth.png');
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Physical<br>Machine</h1><br>'+
					'<img src="topology/images/icons48/server.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" onclick="testMessageBox(event)">details</a>',
					'topology/images/icons48/server.png');
					/*
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Process</h1><br>'+
					'<img src="topology/images/icons48/gear.png" width="48" height="48">'+
					'<br><select><option>Value1</option><option>Value2</option></select><br>',
					'topology/images/icons48/gear.png');
				addSidebarIcon(graph, sidebar,
					'<h1 style="margin:0px;">Keys</h1><br>'+
					'<img src="topology/images/icons48/keys.png" width="48" height="48">'+
					'<br>'+
					'<button onclick="mxUtils.//alert(\'generate\');">Generate</button>',
					'topology/images/icons48/keys.png');
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

				
				// Displays useful hints in a small semi-transparent box.
				var hints = document.createElement('div');
				hints.style.position = 'absolute';
				hints.style.overflow = 'hidden';
				hints.style.width = '230px';
				hints.style.bottom = '56px';
				hints.style.height = '76px';
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
				
				addToolbarButton(editor, toolbar, 'groupOrUngroup', '(Un)group', 'topology/images/group.png');
				
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

				addToolbarButton(editor, toolbar, 'delete', 'Delete', 'topology/images/delete2.png');
				
				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'cut', 'Cut', 'topology/images/cut.png');
				addToolbarButton(editor, toolbar, 'copy', 'Copy', 'topology/images/copy.png');
				addToolbarButton(editor, toolbar, 'paste', 'Paste', 'topology/images/paste.png');

				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'undo', '', 'topology/images/undo.png');
				addToolbarButton(editor, toolbar, 'redo', '', 'topology/images/redo.png');
				
				toolbar.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, toolbar, 'show', 'Show', 'topology/images/camera.png');
				addToolbarButton(editor, toolbar, 'print', 'Print', 'topology/images/printer.png');
				
				toolbar.appendChild(spacer.cloneNode(true));

				// Defines a new export action
				editor.addAction('export', function(editor, cell)
				{
					var textarea = document.createElement('textarea');
					textarea.style.width = '400px';
					textarea.style.height = '400px';
					var enc = new mxCodec(mxUtils.createXmlDocument());
					var node = enc.encode(editor.graph.getModel());
					textarea.value = mxUtils.getPrettyXml(node);
					showModalWindow(graph, 'XML', textarea, 410, 440);
				});

				addToolbarButton(editor, toolbar, 'export', 'Export', 'topology/images/export1.png');

				// ---
				
				// Adds toolbar buttons into the status bar at the bottom
				// of the window.
				addToolbarButton(editor, status, 'collapseAll', 'Collapse All', 'topology/images/navigate_minus.png', true);
				addToolbarButton(editor, status, 'expandAll', 'Expand All', 'topology/images/navigate_plus.png', true);

				status.appendChild(spacer.cloneNode(true));
				
				addToolbarButton(editor, status, 'enterGroup', 'Enter', 'topology/images/view_next.png', true);
				addToolbarButton(editor, status, 'exitGroup', 'Exit', 'topology/images/view_previous.png', true);

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
		
		function addSidebarIcon(graph, sidebar, label, image)
		{
			
			// Function that is executed when the image is dropped on
			// the graph. The cell argument points to the cell under
			// the mousepointer if there is one.
			
			var funct = function(graph, evt, cell, x, y)
			{
				var parent = graph.getDefaultParent();
				var model = graph.getModel();
				
				phyMachineMarkID++;
				var v1 = null;
				
				model.beginUpdate();
				try
				{
					// NOTE: For non-HTML labels the image must be displayed via the style
					// rather than the label markup, so use 'image=' + image for the style.
					// as follows: v1 = graph.insertVertex(parent, null, label,
					// pt.x, pt.y, 120, 120, 'image=' + image);
					v1 = graph.insertVertex(parent, null, label, x, y, 120, 120);
					v1.setConnectable(false);
					
					// Presets the collapsed size
					v1.geometry.alternateBounds = new mxRectangle(0, 0, 120, 40);
					
					v1.setId(highID+"");
						v1.setValue('<h1 style="margin:0px">HighRouter'+highID+
					'</h1><br>'+
					'<img src="topology/images/icons48/Router.png" width="48" height="48">'+
					'<br>'+
					'<a href="#none" name='+highID+
					' onclick="testMessageBox(event,this)">Configure</a>');
					
					//v2 = graph.insertVertex(parent, null, label, x, y, 120, 120);
					//v2.setConnectable(true);
					//v2.geometry.alternateBounds = new mxRectangle(0, 0, 120, 40);
										
					// Adds the ports at various relative locations
					var port = graph.insertVertex(v1, null, 'Trigger', 0.5, 0.5, 16, 16,
							'port;image=topology/images/green-dot.gif;align=right;imageAlign=right;spacingRight=18');
					port.geometry.offset = new mxPoint(-6, -8);
					port.geometry.relative = true;
					
					
					
				}
				finally
				{
					model.endUpdate();
				}
				
				graph.setSelectionCell(v1);
			}
			
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
			graph.getStylesheet().putCellStyle('port', style);
			
			style = graph.getStylesheet().getDefaultEdgeStyle();
			style[mxConstants.STYLE_LABEL_BACKGROUNDCOLOR] = '#FFFFFF';
			style[mxConstants.STYLE_STROKEWIDTH] = '2';
			style[mxConstants.STYLE_ROUNDED] = true;
			style[mxConstants.STYLE_EDGE] = mxEdgeStyle.EntityRelation;
		};
		
		
		
		
	//config phyMachine page
	
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
	function showMessageBox(wTitle,content,pos,wWidth,id)
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
        document.getElementById("msgDiv"+id).style.display="";
        document.getElementById("msgDiv"+id).style.top=(document.documentElement.clientHeight/2+document.documentElement.scrollTop-252)+"px";
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
		////alert(obj.name);
		var objPos = mousePosition(ev);
		messContent="<div style='padding:20px 0 20px 0;text-align:center'>消息正文</div>";
		showMessageBox('窗口标题',messContent,objPos,350,obj.name);
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
	    msgObj.innerHTML = "这是弹出的小窗口！<br /><a href=\"javascript:void(0);\" onclick='delWinD();return false;'>点我关闭窗口</a><br />"
	    					+"<form id=\"config"+id+"\">Eth0 IP: <input type=\"text\" name=\"eth0IP\" /><br />Eth0 OSPF域: <input type=\"text\" name=\"eth0Ospf\" /><br />"
	    					+"Eth1 IP: <input type=\"text\" name=\"eth1IP\" /><br />Eth1 OSPF域: <input type=\"text\" name=\"eth1Ospf\" /><br />"
	    					+"Eth2 IP: <input type=\"text\" name=\"eth2IP\" /><br />Eth2 OSPF域: <input type=\"text\" name=\"eth2Ospfe\" /><br />"
	    					+"Eth3 IP: <input type=\"text\" name=\"eth3IP\" /><br />Eth3 OSPF域: <input type=\"text\" name=\"eth3Ospf\" /><br />"
	    					+"<input type=\"hidden\" name=\"routerId\" display=\"null\" value=\""
	    					+id+"\"/>"
	    					+"<input id="+id+" type=\"button\" onclick='saveConfig(this);' value=\"确定\" /><input id="+id+" type=\"reset\" onclick='delWinD(this);' value=\"取消\" /></form>";
	    				
	    					
	    document.body.appendChild(msgObj);
	}
	function delWinD()
	{
	   document.getElementById("bgDiv").style.display="none";
	   document.getElementById("msgDiv").style.display="none";
	   closeWindow();
	   isshow=0;
	}
	
	function saveConfig(obj)
	{
		//alert(obj.id);
		
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
	
	</script>
</head>

<!-- Page passes the container for the graph to the grogram -->
<body  id="body" onLoad="main(document.getElementById('graphContainer'),
			document.getElementById('outlineContainer'),
		 	document.getElementById('toolbarContainer'),
			document.getElementById('sidebarContainer'),
			document.getElementById('statusContainer'));">
<div id="my_container" >

	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li><a href=""><b>实验床管理系统</b></a></li>
				<li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li>
				<li style=" font-size:10px"><a href="topology.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>		
	
	<div id="left">
		<table id="treeList">
    		<tr>
        		<td  style="text-align:left;"><b>资源查看</b></td>
      		</tr>
			<tr>
        		<td style="text-align:right">物理机器</td>
      		</tr>
	  		<tr>
        		<td style="text-align:right">虚拟路由器</td>
      		</tr>
	  		<tr>
        		<td  style="text-align:left"><b>资源分配与回收</b></td>
      		</tr>
			<tr>
       	 		<td style="text-align:right">申请列表</td>
      		</tr>
	  		<tr>
        		<td style="text-align:right">资源归还</td>
      		</tr>
	  		<tr>
        		<td style="text-align:left"><b>实验者管理</b></td>
      		</tr>
	  		<tr>
       			<td style="text-align:left"><b>实验管理</b></td>
      		</tr>
	  		<tr>
        		<td style="text-align:left"><b>拓扑图</b></td>
      		</tr>
    	</table>
	</div>
	
	
	<div id="right">
	
	
	<!-- Creates a container for the toolboox -->
	<div id="toolbarContainer"
		style="position:relative;white-space:nowrap;overflow:hidden;top:0px;left:0px;max-height:24px;height:36px;right:0px;padding:6px;margin-top:0px;background-image:url('topology/images/toolbar_bg.jpg');">
	</div>
	
	<!-- Creates a container for the sidebar -->
	<div id="sidebarContainer"
		style="position:float;float:left;overflow:hidden;height:516px;max-width:52px;width:56px;background-image:url('topology/images/sidebar_bg.gif');">
	</div>
	
	<!-- Creates a container for the graph -->
	<div id="graphContainer"
		style="; height:480px;position:float;overflow:hidden;top:0px;background-image:url('topology/editors/images/grid.gif');cursor:default;">
		
		
	</div>

	<!-- Creates a container for the outline -->
		<div id="outlineContainer"
			style="position:absolute;overflow:hidden;top:134px;right:100px;width:200px;height:140px;background:transparent;border-style:solid;border-color:black;">
		</div>
		
	<!-- Creates a container for the sidebar -->
	<div id="statusContainer" 
		style="/*visibility:hidden;*/text-align:right;position:float;overflow:hidden;/*bottom:0px;left:0px;*/max-height:24px;height:36px;/*right:0px;*/color:white;padding:6px;background-image:url('topology/images/toolbar_bg.jpg');">
		<!-- <div style="font-size:10pt;float:left;">
			 Created with <a href="http://www.jgraph.com" target="_blank">mxGraph</a>
		</div> -->
	</div>
	</div>
	
</div>
	<div id="footer"><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p>
	</div>

</body>
</html>
