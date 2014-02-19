define(["bpmn/editor", "bpmn/renderer", "bpmn/utils", "dojo/dom", "dojo/_base/xhr", "dojo/_base/declare", "dojo/_base/lang", "dojox/jsonPath", "dojo/_base/array", "dojo/query", "dojo/topic", "dojo/store/Memory", "dojo/Deferred", "dojo/domReady!"], function(editor, renderer, utils, dom, xhr, declare, l, path, array, query, topic, Memory, Deferred) {

	var Log = declare("bpmn.Log", null, {
		error: function(error, obj) {
			console.log(error, obj);
			alert("error:" + error);
		},
		info: function(info, obj) {
			console.log(info, obj);
		},
		debug: function(debug, obj) {
			console.log(debug, obj);
		}
	});

	var Node = declare("bpmn.Node", null, {
		id: null,
		x: 0,
		y: 0,
		z: 0,
		width: 0,
		height: 0,
		type: "default",
		props: {},
		bpmnElement : null,
		bounds: null,
		anchors : null,

		constructor: function(args) {
			declare.safeMixin(this, args);
		}
	});

	var Connection = declare("bpmn.Connection", null, {
		id: null,
		source: null,
		target: null,
		type: null,
		label: null,
		waypoints: new Memory(),
		
		constructor: function(args) {
			declare.safeMixin(this, args);
		}
	});
	
	var Anchor = declare("BpmnAnchor", null, {
		id : null,
		incoming: [],
		outgoing: [],
		x : 0,
		y : 0,
		
		constructor: function(args) {
			declare.safeMixin(this, args);
		}
	});

	var Container = declare("bpmn.Container", bpmn.Node, {
		children: [],
		
		constructor: function(args) {
			declare.safeMixin(this, args);
		}
	});

	var Diagram = declare("bpmn.Diagram", null, {
		nodes: new Memory(),
		connections: new Memory(),
		root : new bpmn.Container(),
		width : 800,
		height : 600
	});

	var clazz = {
		constructor: function(args) {
			declare.safeMixin(clazz, args);
			if (clazz.editor != undefined && clazz.editable) {
				clazz.editor.init(clazz);
			}
			
			clazz.renderer.enableListeners(clazz.editable);
		},
		diagramElement : undefined, 
		renderer : renderer,
		log: new Log(),
		editable: false,
		editor: editor,
		prefixes: {},
		di: {
			shapes: new Memory(),
			edges: new Memory()
		},
		definitionsNamespace: "http://www.omg.org/spec/BPMN/20100524/MODEL",
		propertyElement : {"eventDefinitions" : true},
		eventDefinitions : ["escalationEventDefinition", "compensateEventDefinition", "conditionalEventDefinition", "timerEventDefinition", "messageEventDefinition", "errorEventDefinition", "signalEventDefinition", "cancelEventDefinition"],
		isCollaboration : false,
		uuid : function (prefix) {
			var time = new Date().getTime();
			return prefix ? prefix + "_" +time : "_" + time;
		},
		elementHandler: {
			"default": function(element, name) {
				// element might be an array of element
				if (element["@id"] == undefined) {
					return null;
				}
				
				var props = {};
				
				for (var elementProperty in element) { // e.g. element = 'userTask'
					
					if (clazz.localName(elementProperty).indexOf("@") != -1) {
						props[clazz.localName(elementProperty)] = element[elementProperty];
						continue;
					}
				}
				
				var bounds = clazz.getBounds(element["@id"]);
				console.log("element bounds", bounds);
				
				var wrapped = clazz.wrap(element);
				var label = wrapped.attr("name") ? wrapped.attr("name") : "";
				
				return new bpmn.Node({
					id: wrapped.attr("id"),
					type: name,
					bpmnElement: wrapped,
					bounds : bounds,
					label: label,
					x : parseFloat(bounds.attr("x")),
					y :  parseFloat(bounds.attr("y")),
					width : parseFloat(bounds.attr("width")),
					height : parseFloat(bounds.attr("height")),
					anchors : new Memory(),
					"props" : props
				});
			},
			"event" : function (element, name) {
				var node = this["default"](element, name);
				node.props["eventDefinitions"] = {};
				
				array.forEach(clazz.eventDefinitions, function (definition) {
					if (element[clazz.tag(definition, "BPMN")]) {
						node.props["eventDefinitions"][definition] = element[clazz.tag(definition, "BPMN")];
					}
				});
				
				return node;
			},
			"flow" : function (element, name) {
				var edge = clazz.di.edges.get(element["@id"]);
				
				var points = edge[clazz.tag("waypoint", "OMGDI")];
				
				var connection =  new bpmn.Connection({
					id: element["@id"],
					"source" : element["@sourceRef"],
					"target" : element["@targetRef"],
					type : name,
					label :  element["@name"],
					waypoints: points
				});
				
				return connection;
			},
			"sequenceFlow" : function(element, name) {
				return this["flow"](element, name);
			},
			"messageFlow" : function(element, name) {
				return this["flow"](element, name);
			},
			"startEvent" : function(element, name) {
				return this["event"](element, name);
			},
			"boundaryEvent" : function(element, name) {
				return this["event"](element, name);
			},
			"endEvent" : function(element, name) {
				return this["event"](element, name);
			},
			"intermediateThrowEvent" : function(element, name) {
				return this["event"](element, name);
			},
			"intermediateCatchEvent" : function(element, name) {
				return this["event"](element, name);
			},
			"container" : function (container, name) {
				var bounds = clazz.getBounds(container["@id"]);
				
				var containerNode = new bpmn.Container( {
					type: name, 
					id : container["@id"], 
					children: [],
					label: container["@name"],
					bpmnElement :  container,
					bounds : bounds,
					x : parseFloat(bounds.attr("x")),
					y :  parseFloat(bounds.attr("y")),
					width : parseFloat(bounds.attr("width")),
					height : parseFloat(bounds.attr("height")),
					anchors : new Memory(),
					props: {}
				});
				
				var di =  clazz.di.shapes.get(container["@id"]);
				
				if (di) {
					containerNode.props["@isExpanded"] = di["@isExpanded"];
				}
					
				for (var element in container) { // e.g. element = 'userTask'
					console.log("element" + element);
					
					if (clazz.localName(element).indexOf("@") != -1) {
						containerNode.props[clazz.localName(element)] = container[element];
						continue;
					}
					
					var elements = null;
					var node = null;
					
					elements = clazz.elementArray(container[element]); // elements = [ {id: "UserTask_1" ...} ]
					
					array.forEach(elements, function (currentElement) {
						
						if (clazz.elementHandler[clazz.localName(element)] == undefined) {
							node = clazz.elementHandler["default"](currentElement, clazz.localName(element));
						} else {
							node = clazz.elementHandler[clazz.localName(element)](currentElement, clazz.localName(element), containerNode, container);
						}
						
						if (node instanceof bpmn.Node) {
							clazz.diagram.nodes.put(node);
							containerNode.children.push(node.id);
						}
						
						if (node instanceof bpmn.Connection) {
							clazz.diagram.connections.put(node);
						}
					});
	
				}
				return containerNode;
			},
			"process" : function (element, name) {
				return this["container"](element, name);
			},
			"subProcess" : function (element, name) {
				return this["container"](element, name);
			},
			"collaboration" : function (element, name) {
				clazz.isCollaboration = true;
				return this["container"](element, name);
			},
			"definitions": function(definitions) {
				return this["container"](definitions, "definitions");
			},
			"laneSet" : function (element, name) {
				return this["container"](element, name);
			},
			"@id": function(id, name, node, element) {
				console.log("handling id" + id, element);
				node["id"] = id;
			}
		},
		
		wrap : function (element) {
			
			return {
				fn : function (prefix, name, value, schema) {
					if (value) {
						element[prefix+ clazz.tag(name, schema)] = value;
						return element;
					}else {
						return element[prefix + clazz.tag(name, schema)];
					}
				},
				
				attr: function (name, value, schema) {
					return this.fn ("@", name, value, schema);
				},
				
				element : function (name, value, schema) {
					return clazz.wrap(this.fn ("", name, value, schema));
				}
			};
		
		},
		
		getBoundsElement : function (id) {
			var shape = clazz.di.shapes.get(id);
			
			if (shape == undefined) {
				return undefined;
			}
			
			var elementBounds = clazz.di.shapes.get(id)[clazz.tag("bounds", "OMGDC")];
			
			if (elementBounds == undefined) {
				elementBounds = clazz.di.shapes.get(id)[clazz.tag("Bounds","OMGDC")];		
			}
			
			if (elementBounds == undefined) {
				console.log("could not get element bounds!");
				return undefined;
			}
			
			return clazz.wrap(elementBounds);
		},
		
		getBounds : function (id) {
			var nullResult = {"@x" : 0, "@y" : 0, "@width" : 0, "@height" : 0};
		
			var elementBounds = clazz.getBoundsElement(id);
			
			if (elementBounds == undefined) {
				return clazz.wrap(nullResult);
			}
			
			if (clazz.diagram != undefined) {
				var xLimit = +elementBounds.attr("x") + elementBounds.attr("width") * 2;
				var yLimit = +elementBounds.attr("y") + elementBounds.attr("height") * 2;
				
				if (clazz.diagram.width <= xLimit) {
					clazz.diagram.width = xLimit;
				}
				
				if (clazz.diagram.height <= yLimit) {
					clazz.diagram.height = yLimit;
				}
			}
			
			return elementBounds;
		},
		
		/*element : function (jsonElement) {
			if (jsonElement == undefined) {
				return undefined;
			}
		
			return {
				bpmnElement : jsonElement,
				element : function (el, schema) {
					var tag = clazz.tag(el, schema);
					
					if(!jsonElement[tag]) {
						return undefined;
					}
				
					return clazz.element(jsonElement[tag]);
				},
				attr : function (at, schema) {
					var tag = "@"+clazz.tag(el, schema);
					
					if(!jsonElement[tag]) {
						return undefined;
					}
				
					return jsonElement[tag];
				}
			};
		},*/

		show: function(bpmnXml) {
			var deferred = new Deferred();
			
			if (bpmnXml) {
				clazz.renderer.render(clazz.parseJson(clazz.xmlToJson(clazz.sanitizeXml(bpmnXml))), clazz.diagramElement);
			}
			else if (clazz.url) {
				var modelRequest = xhr.get({
					url: clazz.url
				});

				modelRequest.then(l.hitch(clazz, function(data) {
					clazz.renderer.render(clazz.parseJson(clazz.xmlToJson(clazz.sanitizeXml(data))), clazz.diagramElement);
					deferred.resolve("rendered");
				}), l.hitch(clazz, function(error) {
					this.log.error("Error during retrieval of model: " + error);
				}));
			}
			return deferred.promise;
		},
		
		refresh : function (id) {
			if (id == undefined) {
				clazz.clear();
			
				if (clazz.definitions) {
					clazz.renderer.render(clazz.parseDefinitions(clazz.definitions));
				}
			}
			else {
				clazz.renderer.redraw(id);
			}
		},
		
		clear: function() {
			clazz.renderer.clear();
			if (clazz.diagram) {
				clazz.diagram.nodes.query().forEach(function (entry) {clazz.diagram.nodes.remove(entry.id);});
				clazz.diagram.connections.query().forEach(function (entry) {clazz.diagram.connections.remove(entry.id);});
			}
		},

		parsePrefixes: function(bpmnJson) {
			for (var key in bpmnJson) {
				if (key.indexOf("definitions") != -1) {
					if (key.indexOf(":") != -1) {
						this.prefixes["BPMN"] = key.split(":");
					}
					var definitions = bpmnJson[key];

					for (var prop in definitions) {
						if (prop.indexOf("@xmlns:") != -1) {
							var propPrefix = prop.split(":")[1];

							if (definitions[prop] == "http://www.omg.org/spec/BPMN/20100524/MODEL") {
								this.prefixes["BPMN"] = propPrefix;
							} else if (definitions[prop] == "http://www.omg.org/spec/BPMN/20100524/DI") {
								this.prefixes["BPMNDI"] = propPrefix;
							} else if (definitions[prop] == "http://www.omg.org/spec/DD/20100524/DI") {
								this.prefixes["OMGDI"] = propPrefix;
							} else if (definitions[prop] == "http://www.omg.org/spec/DD/20100524/DC") {
								this.prefixes["OMGDC"] = propPrefix;
							} else {
								this.prefixes[propPrefix] = propPrefix;
							}
						} else if (prop == "@xmlns") {
							this.definitionsNamespace = definitions[prop];
						}
					}
					break;
				}
			}
		},
		
		parseDI: function (definitions) {
			console.log("parsing di", definitions[this.tag("BPMNDiagram","BPMNDI")]);
			var plane = definitions[this.tag("BPMNDiagram","BPMNDI")][this.tag("BPMNPlane","BPMNDI")];
			
			var shapes = clazz.elementArray(plane[this.tag("BPMNShape", "BPMNDI")]);
			var edges = clazz.elementArray(plane[this.tag("BPMNEdge","BPMNDI")]);
			
			this.di.shapes = new Memory({"idProperty" : "@bpmnElement", data : shapes});
			this.di.edges = new Memory({"idProperty" : "@bpmnElement", data : edges});
		},

		localName: function(tag) {
			if (tag.indexOf(":") != -1) {
				return tag.split(":")[1];
			}
			return tag;
		},

		tag: function tag(name, schema) {
			if (schema && this.prefixes[schema]) {
				return this.prefixes[schema] + ":" + name;
			} else if (this.prefixes["BPMN"]) {
				return this.prefixes["BPMN"] + ":" + name;
			}
			return name;
		},
		
		getDiagram : function () {
			return clazz.diagram;
		},
		
		getDefinitions : function () {
			return clazz.definitions;
		},
		
		parseDefinitions : function (definitions) {
			var diagram = new bpmn.Diagram({connections: new Memory(), nodes: new Memory()});

			clazz.diagram = diagram;
			clazz.parseDI(definitions);
			clazz.definitions = definitions;
			
			var definitionsNode = clazz.elementHandler["definitions"](definitions);
			diagram.nodes.put(definitionsNode);
			
			clazz.diagram.connections.query().forEach(function (connection) {
				clazz.addAnchors(connection);
			});
			
			/*
			if (definitions[clazz.tag("collaboration")]) {
				this.log.info("parsing collaboration");
				clazz.parseCollaboration(definitions[clazz.tag("collaboration")]);
			} else if (definitions[clazz.tag("process")]) {
				this.log.info("parsing process");
				var process = definitions[clazz.tag("process")];
				diagram.nodes.put(clazz.parseProcess(process));
			} */
			console.log("diagram", diagram);

			return diagram;
		},
		
		addAnchors : function (connection) {
			var sourceNode = clazz.diagram.nodes.get(connection.source);
			var targetNode = clazz.diagram.nodes.get(connection.target);
			
			// first calculate side for the anchors
			var minDistanceIndex = function(pArg, points) {
				var minDistance = 4294967295;
				var minIndex = points.length +1;
				
				array.forEach(points, function (point, index) {
					var xdist = Math.abs(pArg.x - point.x);
					var ydist = Math.abs(pArg.y - point.y);
					
					var currentDistance = Math.sqrt(xdist * xdist + ydist * ydist);
					
					if ( currentDistance < minDistance) {
						minDistance = currentDistance;
						minIndex = index;
					}
				});
				
				return minIndex;
			};
			
			var nodeFunction = function (node, anchorProperty, connectionProperty) {
				var anchors = [
					{x : node.x , y: node.y + node.height / 2}, // left side
					{x : node.x + node.width / 2 , y: node.y}, // top side
					{x : node.x + node.width, y: node.y +node.height / 2}, // right side
					{x : node.x + node.width / 2, y: node.y + node.height} // bottom side
				];
				var wps = connection.waypoints;
				var firstWaypoint = wps[0];
				
				if (anchorProperty != "outgoing") {
					firstWaypoint = wps[wps.length-1];
				}
				
				var sourcePoint = {x : +firstWaypoint["@x"] , y: +firstWaypoint["@y"] };
				
				var minIndex = minDistanceIndex(sourcePoint, anchors);
				
				var anchor = node.anchors.get(minIndex);
				
				connection[connectionProperty] = minIndex;
				
				if (!anchor) {
					var newAnchor = new BpmnAnchor({
						id : minIndex,
						x : anchors[minIndex].x,
						y : anchors[minIndex].y,
						incoming: [],
						outgoing: []
					});	
					newAnchor[anchorProperty] = [connection.id];
					node.anchors.put(newAnchor);
				} else {
					anchor[anchorProperty].push(connection.id);
				}
			};
			
			nodeFunction(sourceNode, "outgoing", "sourceAnchor");
			nodeFunction(targetNode, "incoming", "targetAnchor");
		},

		parseJson: function(bpmnJson) {
			clazz.parsePrefixes(bpmnJson);
			var definitions = bpmnJson[clazz.tag("definitions")];
			return clazz.parseDefinitions(definitions);
		},
		
		highlight : function (id, param, html) {
			if (id instanceof Array) {
				array.forEach(id, function (i) {
					clazz.renderer.highlight(i, param, html);
				});
			}else {
				clazz.renderer.highlight(id, param, html);
			}
		},
		
		elementArray: function (el) {
		if (!el) {
			return [];
		}
			
		 if (el instanceof Array) {
		 	return el;
		 }
		 return [el];
		},
		
		idMap : function (elems, idProp) {
			var resultMap = {};
			array.forEach(elems, function (elem, index) {
				if (elem[idProp] != undefined) {
					resultMap[elem[idProp]] = elem;
				}
			});
			return resultMap;
		},
		
		getXml : function() {
			var output = {};
			output[clazz.tag("definitions")] = clazz.definitions;
			return '<?xml version="1.0"?>' + utils.json2xml(output);
		},

		xmlToJson: function(xml) {
			var xmlJson = utils.xml2json(this.parseXml(xml), "  ");
			this.log.debug("xmlToJson", xmlJson);
			var jsonObj = JSON.parse(xmlJson);
			this.log.debug("bpmnJson", jsonObj);
			return jsonObj;
		},

		parseXml: function(xml) {
			var dom = null;
			if (window.DOMParser) {
				try {
					dom = (new DOMParser()).parseFromString(xml, "text/xml");
				} catch (e) {
					dom = null;
				}
			} else if (window.ActiveXObject) {
				try {
					dom = new ActiveXObject('Microsoft.XMLDOM');
					dom.async = false;
					if (!dom.loadXML(xml)) // parse error ..
					this.log.error(dom.parseError.reason + dom.parseError.srcText);
				} catch (e) {
					dom = null;
				}
			} else {
				this.log.error("cannot parse xml string!");
			}
			return dom;
		},

		sanitizeXml: function(xml) {
			xml = xml.replace(/&#xA;/g, "\\n");
			xml = xml.replace(/&#10;/g, " ");
			xml = xml.replace(/&/g, "");
			return xml;
		}
	};

	declare("Bpmn", null, clazz);
	return new Bpmn();
});