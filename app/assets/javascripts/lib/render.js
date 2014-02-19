load(['env.rhino.1.2.js']);
load(['raphael.js']);
var dojoConfig = {
	baseUrl : "./",
	rhinoBase : "dojo-1.7.2/dojo",
	packages : [ {
		name : "dojo",
		location : "dojo-1.7.2/dojo"
	}, {
		name : "dojox",
		location : "dojo-1.7.2/dojox"
	}, {
		name : "dijit",
		location : "dojo-1.7.2/dijit"
	}, {
		name : "bpmn",
		location : "bpmn"
	} ],
	async : false
};
load([ 'dojo-1.7.2/dojo/dojo.js' ]);

window.location.template('<!DOCTYPE html><html><head><title>Title of the document</title></head><body><div id="diagram"></div></body></html>');

var div = window.document.createElement("div");
div.attributes["id"]="diagram";
window.document.appendChild(div);

var bpmnXml = arguments[0];
var result;

require(["bpmn/core"], function(bpmn) {
        bpmn.parseXml(''+bpmnXml, function() {
            result = window.document.getElementById("diagram").innerHTML;
        }, 
        {
            diagramElement: "diagram"
        });
});

