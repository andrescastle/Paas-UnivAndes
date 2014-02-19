/*
	Copyright (c) 2004-2012, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/
/*
	This is an optimized version of Dojo, built for deployment and not for
	development. To get sources and documentation, please visit:

		http://dojotoolkit.org
*/
//>>built


require({
    cache: {
        "dojox/charting/Chart": function () {
            define("dojox/charting/Chart", ["../main", "dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "dojo/dom-style", "dojo/dom", "dojo/dom-geometry", "dojo/dom-construct", "dojo/_base/Color", "dojo/_base/sniff", "./Element", "./SimpleTheme", "./Series", "./axis2d/common", "dojox/gfx/shape", "dojox/gfx", "dojox/lang/functional", "dojox/lang/functional/fold", "dojox/lang/functional/reversed"], function (_1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, _d, _e, _f, g, _10, _11, _12) {
                var dc = _2.getObject("charting", true, _1),
                    _13 = _10.lambda("item.clear()"),
                    _14 = _10.lambda("item.purgeGroup()"),
                    _15 = _10.lambda("item.destroy()"),
                    _16 = _10.lambda("item.dirty = false"),
                    _17 = _10.lambda("item.dirty = true"),
                    _18 = _10.lambda("item.name");
                var _19 = _4("dojox.charting.Chart", null, {
                    constructor: function (_1a, _1b) {
                        if (!_1b) {
                            _1b = {};
                        }
                        this.margins = _1b.margins ? _1b.margins : {
                            l: 10,
                            t: 10,
                            r: 10,
                            b: 10
                        };
                        this.stroke = _1b.stroke;
                        this.fill = _1b.fill;
                        this.delayInMs = _1b.delayInMs || 200;
                        this.title = _1b.title;
                        this.titleGap = _1b.titleGap;
                        this.titlePos = _1b.titlePos;
                        this.titleFont = _1b.titleFont;
                        this.titleFontColor = _1b.titleFontColor;
                        this.chartTitle = null;
                        this.theme = null;
                        this.axes = {};
                        this.stack = [];
                        this.plots = {};
                        this.series = [];
                        this.runs = {};
                        this.dirty = true;
                        this.node = _6.byId(_1a);
                        var box = _7.getMarginBox(_1a);
                        this.surface = g.createSurface(this.node, box.w || 400, box.h || 300);
                        if (this.surface.declaredClass.indexOf("vml") == -1) {
                            this.plotGroup = this.surface.createGroup();
                        }
                    },
                    destroy: function () {
                        _3.forEach(this.series, _15);
                        _3.forEach(this.stack, _15);
                        _10.forIn(this.axes, _15);
                        this.surface.destroy();
                        if (this.chartTitle && this.chartTitle.tagName) {
                            _8.destroy(this.chartTitle);
                        }
                    },
                    getCoords: function () {
                        var _1c = this.node;
                        var s = _5.getComputedStyle(_1c),
                            _1d = _7.getMarginBox(_1c, s);
                        var abs = _7.position(_1c, true);
                        _1d.x = abs.x;
                        _1d.y = abs.y;
                        return _1d;
                    },
                    setTheme: function (_1e) {
                        this.theme = _1e.clone();
                        this.dirty = true;
                        return this;
                    },
                    addAxis: function (_1f, _20) {
                        var _21, _22 = _20 && _20.type || "Default";
                        if (typeof _22 == "string") {
                            if (!dc.axis2d || !dc.axis2d[_22]) {
                                throw Error("Can't find axis: " + _22 + " - Check " + "require() dependencies.");
                            }
                            _21 = new dc.axis2d[_22](this, _20);
                        } else {
                            _21 = new _22(this, _20);
                        }
                        _21.name = _1f;
                        _21.dirty = true;
                        if (_1f in this.axes) {
                            this.axes[_1f].destroy();
                        }
                        this.axes[_1f] = _21;
                        this.dirty = true;
                        return this;
                    },
                    getAxis: function (_23) {
                        return this.axes[_23];
                    },
                    removeAxis: function (_24) {
                        if (_24 in this.axes) {
                            this.axes[_24].destroy();
                            delete this.axes[_24];
                            this.dirty = true;
                        }
                        return this;
                    },
                    addPlot: function (_25, _26) {
                        var _27, _28 = _26 && _26.type || "Default";
                        if (typeof _28 == "string") {
                            if (!dc.plot2d || !dc.plot2d[_28]) {
                                throw Error("Can't find plot: " + _28 + " - didn't you forget to dojo" + ".require() it?");
                            }
                            _27 = new dc.plot2d[_28](this, _26);
                        } else {
                            _27 = new _28(this, _26);
                        }
                        _27.name = _25;
                        _27.dirty = true;
                        if (_25 in this.plots) {
                            this.stack[this.plots[_25]].destroy();
                            this.stack[this.plots[_25]] = _27;
                        } else {
                            this.plots[_25] = this.stack.length;
                            this.stack.push(_27);
                        }
                        this.dirty = true;
                        return this;
                    },
                    getPlot: function (_29) {
                        return this.stack[this.plots[_29]];
                    },
                    removePlot: function (_2a) {
                        if (_2a in this.plots) {
                            var _2b = this.plots[_2a];
                            delete this.plots[_2a];
                            this.stack[_2b].destroy();
                            this.stack.splice(_2b, 1);
                            _10.forIn(this.plots, function (idx, _2c, _2d) {
                                if (idx > _2b) {
                                    _2d[_2c] = idx - 1;
                                }
                            });
                            var ns = _3.filter(this.series, function (run) {
                                return run.plot != _2a;
                            });
                            if (ns.length < this.series.length) {
                                _3.forEach(this.series, function (run) {
                                    if (run.plot == _2a) {
                                        run.destroy();
                                    }
                                });
                                this.runs = {};
                                _3.forEach(ns, function (run, _2e) {
                                    this.runs[run.plot] = _2e;
                                }, this);
                                this.series = ns;
                            }
                            this.dirty = true;
                        }
                        return this;
                    },
                    getPlotOrder: function () {
                        return _10.map(this.stack, _18);
                    },
                    setPlotOrder: function (_2f) {
                        var _30 = {}, _31 = _10.filter(_2f, function (_32) {
                                if (!(_32 in this.plots) || (_32 in _30)) {
                                    return false;
                                }
                                _30[_32] = 1;
                                return true;
                            }, this);
                        if (_31.length < this.stack.length) {
                            _10.forEach(this.stack, function (_33) {
                                var _34 = _33.name;
                                if (!(_34 in _30)) {
                                    _31.push(_34);
                                }
                            });
                        }
                        var _35 = _10.map(_31, function (_36) {
                            return this.stack[this.plots[_36]];
                        }, this);
                        _10.forEach(_35, function (_37, i) {
                            this.plots[_37.name] = i;
                        }, this);
                        this.stack = _35;
                        this.dirty = true;
                        return this;
                    },
                    movePlotToFront: function (_38) {
                        if (_38 in this.plots) {
                            var _39 = this.plots[_38];
                            if (_39) {
                                var _3a = this.getPlotOrder();
                                _3a.splice(_39, 1);
                                _3a.unshift(_38);
                                return this.setPlotOrder(_3a);
                            }
                        }
                        return this;
                    },
                    movePlotToBack: function (_3b) {
                        if (_3b in this.plots) {
                            var _3c = this.plots[_3b];
                            if (_3c < this.stack.length - 1) {
                                var _3d = this.getPlotOrder();
                                _3d.splice(_3c, 1);
                                _3d.push(_3b);
                                return this.setPlotOrder(_3d);
                            }
                        }
                        return this;
                    },
                    addSeries: function (_3e, _3f, _40) {
                        var run = new _d(this, _3f, _40);
                        run.name = _3e;
                        if (_3e in this.runs) {
                            this.series[this.runs[_3e]].destroy();
                            this.series[this.runs[_3e]] = run;
                        } else {
                            this.runs[_3e] = this.series.length;
                            this.series.push(run);
                        }
                        this.dirty = true;
                        if (!("ymin" in run) && "min" in run) {
                            run.ymin = run.min;
                        }
                        if (!("ymax" in run) && "max" in run) {
                            run.ymax = run.max;
                        }
                        return this;
                    },
                    getSeries: function (_41) {
                        return this.series[this.runs[_41]];
                    },
                    removeSeries: function (_42) {
                        if (_42 in this.runs) {
                            var _43 = this.runs[_42];
                            delete this.runs[_42];
                            this.series[_43].destroy();
                            this.series.splice(_43, 1);
                            _10.forIn(this.runs, function (idx, _44, _45) {
                                if (idx > _43) {
                                    _45[_44] = idx - 1;
                                }
                            });
                            this.dirty = true;
                        }
                        return this;
                    },
                    updateSeries: function (_46, _47, _48) {
                        if (_46 in this.runs) {
                            var run = this.series[this.runs[_46]];
                            run.update(_47);
                            if (_48) {
                                this.dirty = true;
                            } else {
                                this._invalidateDependentPlots(run.plot, false);
                                this._invalidateDependentPlots(run.plot, true);
                            }
                        }
                        return this;
                    },
                    getSeriesOrder: function (_49) {
                        return _10.map(_10.filter(this.series, function (run) {
                            return run.plot == _49;
                        }), _18);
                    },
                    setSeriesOrder: function (_4a) {
                        var _4b, _4c = {}, _4d = _10.filter(_4a, function (_4e) {
                                if (!(_4e in this.runs) || (_4e in _4c)) {
                                    return false;
                                }
                                var run = this.series[this.runs[_4e]];
                                if (_4b) {
                                    if (run.plot != _4b) {
                                        return false;
                                    }
                                } else {
                                    _4b = run.plot;
                                }
                                _4c[_4e] = 1;
                                return true;
                            }, this);
                        _10.forEach(this.series, function (run) {
                            var _4f = run.name;
                            if (!(_4f in _4c) && run.plot == _4b) {
                                _4d.push(_4f);
                            }
                        });
                        var _50 = _10.map(_4d, function (_51) {
                            return this.series[this.runs[_51]];
                        }, this);
                        this.series = _50.concat(_10.filter(this.series, function (run) {
                            return run.plot != _4b;
                        }));
                        _10.forEach(this.series, function (run, i) {
                            this.runs[run.name] = i;
                        }, this);
                        this.dirty = true;
                        return this;
                    },
                    moveSeriesToFront: function (_52) {
                        if (_52 in this.runs) {
                            var _53 = this.runs[_52],
                                _54 = this.getSeriesOrder(this.series[_53].plot);
                            if (_52 != _54[0]) {
                                _54.splice(_53, 1);
                                _54.unshift(_52);
                                return this.setSeriesOrder(_54);
                            }
                        }
                        return this;
                    },
                    moveSeriesToBack: function (_55) {
                        if (_55 in this.runs) {
                            var _56 = this.runs[_55],
                                _57 = this.getSeriesOrder(this.series[_56].plot);
                            if (_55 != _57[_57.length - 1]) {
                                _57.splice(_56, 1);
                                _57.push(_55);
                                return this.setSeriesOrder(_57);
                            }
                        }
                        return this;
                    },
                    resize: function (_58, _59) {
                        var box;
                        switch (arguments.length) {
                        case 1:
                            box = _2.mixin({}, _58);
                            _7.setMarginBox(this.node, box);
                            break;
                        case 2:
                            box = {
                                w: _58,
                                h: _59
                            };
                            _7.setMarginBox(this.node, box);
                            break;
                        }
                        box = _7.getMarginBox(this.node);
                        var d = this.surface.getDimensions();
                        if (d.width != box.w || d.height != box.h) {
                            this.surface.setDimensions(box.w, box.h);
                            this.dirty = true;
                            return this.render();
                        } else {
                            return this;
                        }
                    },
                    getGeometry: function () {
                        var ret = {};
                        _10.forIn(this.axes, function (_5a) {
                            if (_5a.initialized()) {
                                ret[_5a.name] = {
                                    name: _5a.name,
                                    vertical: _5a.vertical,
                                    scaler: _5a.scaler,
                                    ticks: _5a.ticks
                                };
                            }
                        });
                        return ret;
                    },
                    setAxisWindow: function (_5b, _5c, _5d, _5e) {
                        var _5f = this.axes[_5b];
                        if (_5f) {
                            _5f.setWindow(_5c, _5d);
                            _3.forEach(this.stack, function (_60) {
                                if (_60.hAxis == _5b || _60.vAxis == _5b) {
                                    _60.zoom = _5e;
                                }
                            });
                        }
                        return this;
                    },
                    setWindow: function (sx, sy, dx, dy, _61) {
                        if (!("plotArea" in this)) {
                            this.calculateGeometry();
                        }
                        _10.forIn(this.axes, function (_62) {
                            var _63, _64, _65 = _62.getScaler().bounds,
                                s = _65.span / (_65.upper - _65.lower);
                            if (_62.vertical) {
                                _63 = sy;
                                _64 = dy / s / _63;
                            } else {
                                _63 = sx;
                                _64 = dx / s / _63;
                            }
                            _62.setWindow(_63, _64);
                        });
                        _3.forEach(this.stack, function (_66) {
                            _66.zoom = _61;
                        });
                        return this;
                    },
                    zoomIn: function (_67, _68, _69) {
                        var _6a = this.axes[_67];
                        if (_6a) {
                            var _6b, _6c, _6d = _6a.getScaler().bounds;
                            var _6e = Math.min(_68[0], _68[1]);
                            var _6f = Math.max(_68[0], _68[1]);
                            _6e = _68[0] < _6d.lower ? _6d.lower : _6e;
                            _6f = _68[1] > _6d.upper ? _6d.upper : _6f;
                            _6b = (_6d.upper - _6d.lower) / (_6f - _6e);
                            _6c = _6e - _6d.lower;
                            this.setAxisWindow(_67, _6b, _6c);
                            if (_69) {
                                this.delayedRender();
                            } else {
                                this.render();
                            }
                        }
                    },
                    calculateGeometry: function () {
                        if (this.dirty) {
                            return this.fullGeometry();
                        }
                        var _70 = _3.filter(this.stack, function (_71) {
                            return _71.dirty || (_71.hAxis && this.axes[_71.hAxis].dirty) || (_71.vAxis && this.axes[_71.vAxis].dirty);
                        }, this);
                        _72(_70, this.plotArea);
                        return this;
                    },
                    fullGeometry: function () {
                        this._makeDirty();
                        _3.forEach(this.stack, _13);
                        if (!this.theme) {
                            this.setTheme(new _c());
                        }
                        _3.forEach(this.series, function (run) {
                            if (!(run.plot in this.plots)) {
                                if (!dc.plot2d || !dc.plot2d.Default) {
                                    throw Error("Can't find plot: Default - didn't you forget to dojo" + ".require() it?");
                                }
                                var _73 = new dc.plot2d.Default(this, {});
                                _73.name = run.plot;
                                this.plots[run.plot] = this.stack.length;
                                this.stack.push(_73);
                            }
                            this.stack[this.plots[run.plot]].addSeries(run);
                        }, this);
                        _3.forEach(this.stack, function (_74) {
                            if (_74.assignAxes) {
                                _74.assignAxes(this.axes);
                            }
                        }, this);
                        var dim = this.dim = this.surface.getDimensions();
                        dim.width = g.normalizedLength(dim.width);
                        dim.height = g.normalizedLength(dim.height);
                        _10.forIn(this.axes, _13);
                        _72(this.stack, dim);
                        var _75 = this.offsets = {
                            l: 0,
                            r: 0,
                            t: 0,
                            b: 0
                        };
                        _10.forIn(this.axes, function (_76) {
                            _10.forIn(_76.getOffsets(), function (o, i) {
                                _75[i] = Math.max(o, _75[i]);
                            });
                        });
                        if (this.title) {
                            this.titleGap = (this.titleGap == 0) ? 0 : this.titleGap || this.theme.chart.titleGap || 20;
                            this.titlePos = this.titlePos || this.theme.chart.titlePos || "top";
                            this.titleFont = this.titleFont || this.theme.chart.titleFont;
                            this.titleFontColor = this.titleFontColor || this.theme.chart.titleFontColor || "black";
                            var _77 = g.normalizedLength(g.splitFontString(this.titleFont).size);
                            _75[this.titlePos == "top" ? "t" : "b"] += (_77 + this.titleGap);
                        }
                        _10.forIn(this.margins, function (o, i) {
                            _75[i] += o;
                        });
                        this.plotArea = {
                            width: dim.width - _75.l - _75.r,
                            height: dim.height - _75.t - _75.b
                        };
                        _10.forIn(this.axes, _13);
                        _72(this.stack, this.plotArea);
                        return this;
                    },
                    render: function () {
                        if (this._delayedRenderHandle) {
                            clearTimeout(this._delayedRenderHandle);
                            this._delayedRenderHandle = null;
                        }
                        if (this.theme) {
                            this.theme.clear();
                        }
                        if (this.dirty) {
                            return this.fullRender();
                        }
                        this.calculateGeometry();
                        _10.forEachRev(this.stack, function (_78) {
                            _78.render(this.dim, this.offsets);
                        }, this);
                        _10.forIn(this.axes, function (_79) {
                            _79.render(this.dim, this.offsets);
                        }, this);
                        this._makeClean();
                        return this;
                    },
                    fullRender: function () {
                        this.fullGeometry();
                        var _7a = this.offsets,
                            dim = this.dim;
                        var w = Math.max(0, dim.width - _7a.l - _7a.r),
                            h = Math.max(0, dim.height - _7a.t - _7a.b);
                        _3.forEach(this.series, _14);
                        _10.forIn(this.axes, _14);
                        _3.forEach(this.stack, _14);
                        var _7b = this.surface.children;
                        for (var i = 0; i < _7b.length; ++i) {
                            _f.dispose(_7b[i]);
                        }
                        if (this.chartTitle && this.chartTitle.tagName) {
                            _8.destroy(this.chartTitle);
                        }
                        if (this.plotGroup) {
                            this.plotGroup.clear();
                        }
                        this.surface.clear();
                        this.chartTitle = null;
                        if (this.plotGroup) {
                            this._renderChartBackground(dim, _7a);
                            this._renderPlotBackground(dim, _7a, w, h);
                            this.surface.add(this.plotGroup);
                            this.plotGroup.setClip({
                                x: _7a.l,
                                y: _7a.t,
                                width: w,
                                height: h
                            });
                        } else {
                            this._renderPlotBackground(dim, _7a, w, h);
                        }
                        _10.foldr(this.stack, function (z, _7c) {
                            return _7c.render(dim, _7a), 0;
                        }, 0);
                        if (!this.plotGroup) {
                            this._renderChartBackground(dim, _7a);
                        }
                        if (this.title) {
                            var _7d = (g.renderer == "canvas"),
                                _7e = _7d || !_a("ie") && !_a("opera") ? "html" : "gfx",
                                _7f = g.normalizedLength(g.splitFontString(this.titleFont).size);
                            this.chartTitle = _e.createText[_7e](this, this.surface, dim.width / 2, this.titlePos == "top" ? _7f + this.margins.t : dim.height - this.margins.b, "middle", this.title, this.titleFont, this.titleFontColor);
                        }
                        _10.forIn(this.axes, function (_80) {
                            _80.render(dim, _7a);
                        });
                        this._makeClean();
                        return this;
                    },
                    _renderChartBackground: function (dim, _81) {
                        var t = this.theme,
                            _82;
                        var _83 = this.fill !== undefined ? this.fill : (t.chart && t.chart.fill);
                        var _84 = this.stroke !== undefined ? this.stroke : (t.chart && t.chart.stroke);
                        if (_83 == "inherit") {
                            var _85 = this.node;
                            _83 = new _9(_5.get(_85, "backgroundColor"));
                            while (_83.a == 0 && _85 != document.documentElement) {
                                _83 = new _9(_5.get(_85, "backgroundColor"));
                                _85 = _85.parentNode;
                            }
                        }
                        if (_83) {
                            if (this.plotGroup) {
                                _83 = _b.prototype._shapeFill(_b.prototype._plotFill(_83, dim), {
                                    x: 0,
                                    y: 0,
                                    width: dim.width + 1,
                                    height: dim.height + 1
                                });
                                this.surface.createRect({
                                    width: dim.width + 1,
                                    height: dim.height + 1
                                }).setFill(_83);
                            } else {
                                _83 = _b.prototype._plotFill(_83, dim, _81);
                                if (_81.l) {
                                    _82 = {
                                        x: 0,
                                        y: 0,
                                        width: _81.l,
                                        height: dim.height + 1
                                    };
                                    this.surface.createRect(_82).setFill(_b.prototype._shapeFill(_83, _82));
                                }
                                if (_81.r) {
                                    _82 = {
                                        x: dim.width - _81.r,
                                        y: 0,
                                        width: _81.r + 1,
                                        height: dim.height + 2
                                    };
                                    this.surface.createRect(_82).setFill(_b.prototype._shapeFill(_83, _82));
                                }
                                if (_81.t) {
                                    _82 = {
                                        x: 0,
                                        y: 0,
                                        width: dim.width + 1,
                                        height: _81.t
                                    };
                                    this.surface.createRect(_82).setFill(_b.prototype._shapeFill(_83, _82));
                                }
                                if (_81.b) {
                                    _82 = {
                                        x: 0,
                                        y: dim.height - _81.b,
                                        width: dim.width + 1,
                                        height: _81.b + 2
                                    };
                                    this.surface.createRect(_82).setFill(_b.prototype._shapeFill(_83, _82));
                                }
                            }
                        }
                        if (_84) {
                            this.surface.createRect({
                                width: dim.width - 1,
                                height: dim.height - 1
                            }).setStroke(_84);
                        }
                    },
                    _renderPlotBackground: function (dim, _86, w, h) {
                        var t = this.theme;
                        var _87 = t.plotarea && t.plotarea.fill;
                        var _88 = t.plotarea && t.plotarea.stroke;
                        var _89 = {
                            x: _86.l - 1,
                            y: _86.t - 1,
                            width: w + 2,
                            height: h + 2
                        };
                        if (_87) {
                            _87 = _b.prototype._shapeFill(_b.prototype._plotFill(_87, dim, _86), _89);
                            this.surface.createRect(_89).setFill(_87);
                        }
                        if (_88) {
                            this.surface.createRect({
                                x: _86.l,
                                y: _86.t,
                                width: w + 1,
                                height: h + 1
                            }).setStroke(_88);
                        }
                    },
                    delayedRender: function () {
                        if (!this._delayedRenderHandle) {
                            this._delayedRenderHandle = setTimeout(_2.hitch(this, function () {
                                this.render();
                            }), this.delayInMs);
                        }
                        return this;
                    },
                    connectToPlot: function (_8a, _8b, _8c) {
                        return _8a in this.plots ? this.stack[this.plots[_8a]].connect(_8b, _8c) : null;
                    },
                    fireEvent: function (_8d, _8e, _8f) {
                        if (_8d in this.runs) {
                            var _90 = this.series[this.runs[_8d]].plot;
                            if (_90 in this.plots) {
                                var _91 = this.stack[this.plots[_90]];
                                if (_91) {
                                    _91.fireEvent(_8d, _8e, _8f);
                                }
                            }
                        }
                        return this;
                    },
                    _makeClean: function () {
                        _3.forEach(this.axes, _16);
                        _3.forEach(this.stack, _16);
                        _3.forEach(this.series, _16);
                        this.dirty = false;
                    },
                    _makeDirty: function () {
                        _3.forEach(this.axes, _17);
                        _3.forEach(this.stack, _17);
                        _3.forEach(this.series, _17);
                        this.dirty = true;
                    },
                    _invalidateDependentPlots: function (_92, _93) {
                        if (_92 in this.plots) {
                            var _94 = this.stack[this.plots[_92]],
                                _95, _96 = _93 ? "vAxis" : "hAxis";
                            if (_94[_96]) {
                                _95 = this.axes[_94[_96]];
                                if (_95 && _95.dependOnData()) {
                                    _95.dirty = true;
                                    _3.forEach(this.stack, function (p) {
                                        if (p[_96] && p[_96] == _94[_96]) {
                                            p.dirty = true;
                                        }
                                    });
                                }
                            } else {
                                _94.dirty = true;
                            }
                        }
                    }
                });

                function _97(_98) {
                    return {
                        min: _98.hmin,
                        max: _98.hmax
                    };
                };

                function _99(_9a) {
                    return {
                        min: _9a.vmin,
                        max: _9a.vmax
                    };
                };

                function _9b(_9c, h) {
                    _9c.hmin = h.min;
                    _9c.hmax = h.max;
                };

                function _9d(_9e, v) {
                    _9e.vmin = v.min;
                    _9e.vmax = v.max;
                };

                function _9f(_a0, _a1) {
                    if (_a0 && _a1) {
                        _a0.min = Math.min(_a0.min, _a1.min);
                        _a0.max = Math.max(_a0.max, _a1.max);
                    }
                    return _a0 || _a1;
                };

                function _72(_a2, _a3) {
                    var _a4 = {}, _a5 = {};
                    _3.forEach(_a2, function (_a6) {
                        var _a7 = _a4[_a6.name] = _a6.getSeriesStats();
                        if (_a6.hAxis) {
                            _a5[_a6.hAxis] = _9f(_a5[_a6.hAxis], _97(_a7));
                        }
                        if (_a6.vAxis) {
                            _a5[_a6.vAxis] = _9f(_a5[_a6.vAxis], _99(_a7));
                        }
                    });
                    _3.forEach(_a2, function (_a8) {
                        var _a9 = _a4[_a8.name];
                        if (_a8.hAxis) {
                            _9b(_a9, _a5[_a8.hAxis]);
                        }
                        if (_a8.vAxis) {
                            _9d(_a9, _a5[_a8.vAxis]);
                        }
                        _a8.initializeScalers(_a3, _a9);
                    });
                };
                return _19;
            });
        },

        "dojox/main": function () {
            define("dojox/main", ["dojo/_base/kernel"], function (_aa) {
                return _aa.dojox;
            });
        },
        "dojox/charting/Element": function () {
            define("dojox/charting/Element", ["dojo/_base/lang", "dojo/_base/array", "dojo/dom-construct", "dojo/_base/declare", "dojox/gfx", "dojox/gfx/shape"], function (_ab, arr, _ac, _ad, gfx, _ae) {
                return _ad("dojox.charting.Element", null, {
                    chart: null,
                    group: null,
                    htmlElements: null,
                    dirty: true,
                    constructor: function (_af) {
                        this.chart = _af;
                        this.group = null;
                        this.htmlElements = [];
                        this.dirty = true;
                        this.trailingSymbol = "...";
                        this._events = [];
                    },
                    purgeGroup: function () {
                        this.destroyHtmlElements();
                        if (this.group) {
                            this.group.removeShape();
                            var _b0 = this.group.children;
                            for (var i = 0; i < _b0.length; ++i) {
                                _ae.dispose(_b0[i], true);
                            }
                            this.group.clear();
                            _ae.dispose(this.group, true);
                            this.group = null;
                        }
                        this.dirty = true;
                        if (this._events.length) {
                            arr.forEach(this._events, function (_b1) {
                                _b1.shape.disconnect(_b1.handle);
                            });
                            this._events = [];
                        }
                        return this;
                    },
                    cleanGroup: function (_b2) {
                        this.destroyHtmlElements();
                        if (!_b2) {
                            _b2 = this.chart.surface;
                        }
                        if (this.group) {
                            var _b3 = this.group.children;
                            for (var i = 0; i < _b3.length; ++i) {
                                _ae.dispose(_b3[i], true);
                            }
                            this.group.clear();
                        } else {
                            this.group = _b2.createGroup();
                        }
                        this.dirty = true;
                        return this;
                    },
                    destroyHtmlElements: function () {
                        if (this.htmlElements.length) {
                            arr.forEach(this.htmlElements, _ac.destroy);
                            this.htmlElements = [];
                        }
                    },
                    destroy: function () {
                        this.purgeGroup();
                    },
                    getTextWidth: function (s, _b4) {
                        return gfx._base._getTextBox(s, {
                            font: _b4
                        }).w || 0;
                    },
                    getTextWithLimitLength: function (s, _b5, _b6, _b7) {
                        if (!s || s.length <= 0) {
                            return {
                                text: "",
                                truncated: _b7 || false
                            };
                        }
                        if (!_b6 || _b6 <= 0) {
                            return {
                                text: s,
                                truncated: _b7 || false
                            };
                        }
                        var _b8 = 2,
                            _b9 = 0.618,
                            _ba = s.substring(0, 1) + this.trailingSymbol,
                            _bb = this.getTextWidth(_ba, _b5);
                        if (_b6 <= _bb) {
                            return {
                                text: _ba,
                                truncated: true
                            };
                        }
                        var _bc = this.getTextWidth(s, _b5);
                        if (_bc <= _b6) {
                            return {
                                text: s,
                                truncated: _b7 || false
                            };
                        } else {
                            var _bd = 0,
                                end = s.length;
                            while (_bd < end) {
                                if (end - _bd <= _b8) {
                                    while (this.getTextWidth(s.substring(0, _bd) + this.trailingSymbol, _b5) > _b6) {
                                        _bd -= 1;
                                    }
                                    return {
                                        text: (s.substring(0, _bd) + this.trailingSymbol),
                                        truncated: true
                                    };
                                }
                                var _be = _bd + Math.round((end - _bd) * _b9),
                                    _bf = this.getTextWidth(s.substring(0, _be), _b5);
                                if (_bf < _b6) {
                                    _bd = _be;
                                    end = end;
                                } else {
                                    _bd = _bd;
                                    end = _be;
                                }
                            }
                        }
                    },
                    getTextWithLimitCharCount: function (s, _c0, _c1, _c2) {
                        if (!s || s.length <= 0) {
                            return {
                                text: "",
                                truncated: _c2 || false
                            };
                        }
                        if (!_c1 || _c1 <= 0 || s.length <= _c1) {
                            return {
                                text: s,
                                truncated: _c2 || false
                            };
                        }
                        return {
                            text: s.substring(0, _c1) + this.trailingSymbol,
                            truncated: true
                        };
                    },
                    _plotFill: function (_c3, dim, _c4) {
                        if (!_c3 || !_c3.type || !_c3.space) {
                            return _c3;
                        }
                        var _c5 = _c3.space,
                            _c6;
                        switch (_c3.type) {
                        case "linear":
                            if (_c5 === "plot" || _c5 === "shapeX" || _c5 === "shapeY") {
                                _c3 = gfx.makeParameters(gfx.defaultLinearGradient, _c3);
                                _c3.space = _c5;
                                if (_c5 === "plot" || _c5 === "shapeX") {
                                    _c6 = dim.height - _c4.t - _c4.b;
                                    _c3.y1 = _c4.t + _c6 * _c3.y1 / 100;
                                    _c3.y2 = _c4.t + _c6 * _c3.y2 / 100;
                                }
                                if (_c5 === "plot" || _c5 === "shapeY") {
                                    _c6 = dim.width - _c4.l - _c4.r;
                                    _c3.x1 = _c4.l + _c6 * _c3.x1 / 100;
                                    _c3.x2 = _c4.l + _c6 * _c3.x2 / 100;
                                }
                            }
                            break;
                        case "radial":
                            if (_c5 === "plot") {
                                _c3 = gfx.makeParameters(gfx.defaultRadialGradient, _c3);
                                _c3.space = _c5;
                                var _c7 = dim.width - _c4.l - _c4.r,
                                    _c8 = dim.height - _c4.t - _c4.b;
                                _c3.cx = _c4.l + _c7 * _c3.cx / 100;
                                _c3.cy = _c4.t + _c8 * _c3.cy / 100;
                                _c3.r = _c3.r * Math.sqrt(_c7 * _c7 + _c8 * _c8) / 200;
                            }
                            break;
                        case "pattern":
                            if (_c5 === "plot" || _c5 === "shapeX" || _c5 === "shapeY") {
                                _c3 = gfx.makeParameters(gfx.defaultPattern, _c3);
                                _c3.space = _c5;
                                if (_c5 === "plot" || _c5 === "shapeX") {
                                    _c6 = dim.height - _c4.t - _c4.b;
                                    _c3.y = _c4.t + _c6 * _c3.y / 100;
                                    _c3.height = _c6 * _c3.height / 100;
                                }
                                if (_c5 === "plot" || _c5 === "shapeY") {
                                    _c6 = dim.width - _c4.l - _c4.r;
                                    _c3.x = _c4.l + _c6 * _c3.x / 100;
                                    _c3.width = _c6 * _c3.width / 100;
                                }
                            }
                            break;
                        }
                        return _c3;
                    },
                    _shapeFill: function (_c9, _ca) {
                        if (!_c9 || !_c9.space) {
                            return _c9;
                        }
                        var _cb = _c9.space,
                            _cc;
                        switch (_c9.type) {
                        case "linear":
                            if (_cb === "shape" || _cb === "shapeX" || _cb === "shapeY") {
                                _c9 = gfx.makeParameters(gfx.defaultLinearGradient, _c9);
                                _c9.space = _cb;
                                if (_cb === "shape" || _cb === "shapeX") {
                                    _cc = _ca.width;
                                    _c9.x1 = _ca.x + _cc * _c9.x1 / 100;
                                    _c9.x2 = _ca.x + _cc * _c9.x2 / 100;
                                }
                                if (_cb === "shape" || _cb === "shapeY") {
                                    _cc = _ca.height;
                                    _c9.y1 = _ca.y + _cc * _c9.y1 / 100;
                                    _c9.y2 = _ca.y + _cc * _c9.y2 / 100;
                                }
                            }
                            break;
                        case "radial":
                            if (_cb === "shape") {
                                _c9 = gfx.makeParameters(gfx.defaultRadialGradient, _c9);
                                _c9.space = _cb;
                                _c9.cx = _ca.x + _ca.width / 2;
                                _c9.cy = _ca.y + _ca.height / 2;
                                _c9.r = _c9.r * _ca.width / 200;
                            }
                            break;
                        case "pattern":
                            if (_cb === "shape" || _cb === "shapeX" || _cb === "shapeY") {
                                _c9 = gfx.makeParameters(gfx.defaultPattern, _c9);
                                _c9.space = _cb;
                                if (_cb === "shape" || _cb === "shapeX") {
                                    _cc = _ca.width;
                                    _c9.x = _ca.x + _cc * _c9.x / 100;
                                    _c9.width = _cc * _c9.width / 100;
                                }
                                if (_cb === "shape" || _cb === "shapeY") {
                                    _cc = _ca.height;
                                    _c9.y = _ca.y + _cc * _c9.y / 100;
                                    _c9.height = _cc * _c9.height / 100;
                                }
                            }
                            break;
                        }
                        return _c9;
                    },
                    _pseudoRadialFill: function (_cd, _ce, _cf, _d0, end) {
                        if (!_cd || _cd.type !== "radial" || _cd.space !== "shape") {
                            return _cd;
                        }
                        var _d1 = _cd.space;
                        _cd = gfx.makeParameters(gfx.defaultRadialGradient, _cd);
                        _cd.space = _d1;
                        if (arguments.length < 4) {
                            _cd.cx = _ce.x;
                            _cd.cy = _ce.y;
                            _cd.r = _cd.r * _cf / 100;
                            return _cd;
                        }
                        var _d2 = arguments.length < 5 ? _d0 : (end + _d0) / 2;
                        return {
                            type: "linear",
                            x1: _ce.x,
                            y1: _ce.y,
                            x2: _ce.x + _cd.r * _cf * Math.cos(_d2) / 100,
                            y2: _ce.y + _cd.r * _cf * Math.sin(_d2) / 100,
                            colors: _cd.colors
                        };
                        return _cd;
                    }
                });
            });
        },
        "dojox/gfx": function () {
            define("dojox/gfx", ["dojo/_base/lang", "./gfx/_base", "./gfx/renderer!"], function (_d3, _d4, _d5) {
                _d4.switchTo(_d5);
                return _d4;
            });
        },
        "dojox/gfx/_base": function () {
            define("dojox/gfx/_base", ["dojo/_base/kernel", "dojo/_base/lang", "dojo/_base/Color", "dojo/_base/sniff", "dojo/_base/window", "dojo/_base/array", "dojo/dom", "dojo/dom-construct", "dojo/dom-geometry"], function (_d6, _d7, _d8, has, win, arr, dom, _d9, _da) {
                var g = _d7.getObject("dojox.gfx", true),
                    b = g._base = {};
                g._hasClass = function (_db, _dc) {
                    var cls = _db.getAttribute("className");
                    return cls && (" " + cls + " ").indexOf(" " + _dc + " ") >= 0;
                };
                g._addClass = function (_dd, _de) {
                    var cls = _dd.getAttribute("className") || "";
                    if (!cls || (" " + cls + " ").indexOf(" " + _de + " ") < 0) {
                        _dd.setAttribute("className", cls + (cls ? " " : "") + _de);
                    }
                };
                g._removeClass = function (_df, _e0) {
                    var cls = _df.getAttribute("className");
                    if (cls) {
                        _df.setAttribute("className", cls.replace(new RegExp("(^|\\s+)" + _e0 + "(\\s+|$)"), "$1$2"));
                    }
                };
                b._getFontMeasurements = function () {
                    var _e1 = {
                        "1em": 0,
                        "1ex": 0,
                        "100%": 0,
                        "12pt": 0,
                        "16px": 0,
                        "xx-small": 0,
                        "x-small": 0,
                        "small": 0,
                        "medium": 0,
                        "large": 0,
                        "x-large": 0,
                        "xx-large": 0
                    };
                    var p;
                    if (has("ie")) {
                        win.doc.documentElement.style.fontSize = "100%";
                    }
                    var div = _d9.create("div", {
                        style: {
                            position: "absolute",
                            left: "0",
                            top: "-100px",
                            width: "30px",
                            height: "1000em",
                            borderWidth: "0",
                            margin: "0",
                            padding: "0",
                            outline: "none",
                            lineHeight: "1",
                            overflow: "hidden"
                        }
                    }, win.body());
                    for (p in _e1) {
                        div.style.fontSize = p;
                        _e1[p] = Math.round(div.offsetHeight * 12 / 16) * 16 / 12 / 1000;
                    }
                    win.body().removeChild(div);
                    return _e1;
                };
                var _e2 = null;
                b._getCachedFontMeasurements = function (_e3) {
                    if (_e3 || !_e2) {
                        _e2 = b._getFontMeasurements();
                    }
                    return _e2;
                };
                var _e4 = null,
                    _e5 = {};
                b._getTextBox = function (_e6, _e7, _e8) {
                    var m, s, al = arguments.length;
                    var i;
                    if (!_e4) {
                        _e4 = _d9.create("div", {
                            style: {
                                position: "absolute",
                                top: "-10000px",
                                left: "0"
                            }
                        }, win.body());
                    }
                    m = _e4;
                    m.className = "";
                    s = m.style;
                    s.borderWidth = "0";
                    s.margin = "0";
                    s.padding = "0";
                    s.outline = "0";
                    if (al > 1 && _e7) {
                        for (i in _e7) {
                            if (i in _e5) {
                                continue;
                            }
                            s[i] = _e7[i];
                        }
                    }
                    if (al > 2 && _e8) {
                        m.className = _e8;
                    }
                    m.innerHTML = _e6;
                    if (m["getBoundingClientRect"]) {
                        var bcr = m.getBoundingClientRect();
                        return {
                            l: bcr.left,
                            t: bcr.top,
                            w: bcr.width || (bcr.right - bcr.left),
                            h: bcr.height || (bcr.bottom - bcr.top)
                        };
                    } else {
                        return _da.getMarginBox(m);
                    }
                };
                var _e9 = 0;
                b._getUniqueId = function () {
                    var id;
                    do {
                        id = _d6._scopeName + "xUnique" + (++_e9);
                    } while (dom.byId(id));
                    return id;
                };
                _d7.mixin(g, {
                    defaultPath: {
                        type: "path",
                        path: ""
                    },
                    defaultPolyline: {
                        type: "polyline",
                        points: []
                    },
                    defaultRect: {
                        type: "rect",
                        x: 0,
                        y: 0,
                        width: 100,
                        height: 100,
                        r: 0
                    },
                    defaultEllipse: {
                        type: "ellipse",
                        cx: 0,
                        cy: 0,
                        rx: 200,
                        ry: 100
                    },
                    defaultCircle: {
                        type: "circle",
                        cx: 0,
                        cy: 0,
                        r: 100
                    },
                    defaultLine: {
                        type: "line",
                        x1: 0,
                        y1: 0,
                        x2: 100,
                        y2: 100
                    },
                    defaultImage: {
                        type: "image",
                        x: 0,
                        y: 0,
                        width: 0,
                        height: 0,
                        src: ""
                    },
                    defaultText: {
                        type: "text",
                        x: 0,
                        y: 0,
                        text: "",
                        align: "start",
                        decoration: "none",
                        rotated: false,
                        kerning: true
                    },
                    defaultTextPath: {
                        type: "textpath",
                        text: "",
                        align: "start",
                        decoration: "none",
                        rotated: false,
                        kerning: true
                    },
                    defaultStroke: {
                        type: "stroke",
                        color: "black",
                        style: "solid",
                        width: 1,
                        cap: "butt",
                        join: 4
                    },
                    defaultLinearGradient: {
                        type: "linear",
                        x1: 0,
                        y1: 0,
                        x2: 100,
                        y2: 100,
                        colors: [{
                                offset: 0,
                                color: "black"
                            }, {
                                offset: 1,
                                color: "white"
                            }
                        ]
                    },
                    defaultRadialGradient: {
                        type: "radial",
                        cx: 0,
                        cy: 0,
                        r: 100,
                        colors: [{
                                offset: 0,
                                color: "black"
                            }, {
                                offset: 1,
                                color: "white"
                            }
                        ]
                    },
                    defaultPattern: {
                        type: "pattern",
                        x: 0,
                        y: 0,
                        width: 0,
                        height: 0,
                        src: ""
                    },
                    defaultFont: {
                        type: "font",
                        style: "normal",
                        variant: "normal",
                        weight: "normal",
                        size: "10pt",
                        family: "serif"
                    },
                    getDefault: (function () {
                        var _ea = {};
                        return function (_eb) {
                            var t = _ea[_eb];
                            if (t) {
                                return new t();
                            }
                            t = _ea[_eb] = new Function();
                            t.prototype = g["default" + _eb];
                            return new t();
                        };
                    })(),
                    normalizeColor: function (_ec) {
                        return (_ec instanceof _d8) ? _ec : new _d8(_ec);
                    },
                    normalizeParameters: function (_ed, _ee) {
                        var x;
                        if (_ee) {
                            var _ef = {};
                            for (x in _ed) {
                                if (x in _ee && !(x in _ef)) {
                                    _ed[x] = _ee[x];
                                }
                            }
                        }
                        return _ed;
                    },
                    makeParameters: function (_f0, _f1) {
                        var i = null;
                        if (!_f1) {
                            return _d7.delegate(_f0);
                        }
                        var _f2 = {};
                        for (i in _f0) {
                            if (!(i in _f2)) {
                                _f2[i] = _d7.clone((i in _f1) ? _f1[i] : _f0[i]);
                            }
                        }
                        return _f2;
                    },
                    formatNumber: function (x, _f3) {
                        var val = x.toString();
                        if (val.indexOf("e") >= 0) {
                            val = x.toFixed(4);
                        } else {
                            var _f4 = val.indexOf(".");
                            if (_f4 >= 0 && val.length - _f4 > 5) {
                                val = x.toFixed(4);
                            }
                        } if (x < 0) {
                            return val;
                        }
                        return _f3 ? " " + val : val;
                    },
                    makeFontString: function (_f5) {
                        return _f5.style + " " + _f5.variant + " " + _f5.weight + " " + _f5.size + " " + _f5.family;
                    },
                    splitFontString: function (str) {
                        var _f6 = g.getDefault("Font");
                        var t = str.split(/\s+/);
                        do {
                            if (t.length < 5) {
                                break;
                            }
                            _f6.style = t[0];
                            _f6.variant = t[1];
                            _f6.weight = t[2];
                            var i = t[3].indexOf("/");
                            _f6.size = i < 0 ? t[3] : t[3].substring(0, i);
                            var j = 4;
                            if (i < 0) {
                                if (t[4] == "/") {
                                    j = 6;
                                } else {
                                    if (t[4].charAt(0) == "/") {
                                        j = 5;
                                    }
                                }
                            }
                            if (j < t.length) {
                                _f6.family = t.slice(j).join(" ");
                            }
                        } while (false);
                        return _f6;
                    },
                    cm_in_pt: 72 / 2.54,
                    mm_in_pt: 7.2 / 2.54,
                    px_in_pt: function () {
                        return g._base._getCachedFontMeasurements()["12pt"] / 12;
                    },
                    pt2px: function (len) {
                        return len * g.px_in_pt();
                    },
                    px2pt: function (len) {
                        return len / g.px_in_pt();
                    },
                    normalizedLength: function (len) {
                        if (len.length === 0) {
                            return 0;
                        }
                        if (len.length > 2) {
                            var _f7 = g.px_in_pt();
                            var val = parseFloat(len);
                            switch (len.slice(-2)) {
                            case "px":
                                return val;
                            case "pt":
                                return val * _f7;
                            case "in":
                                return val * 72 * _f7;
                            case "pc":
                                return val * 12 * _f7;
                            case "mm":
                                return val * g.mm_in_pt * _f7;
                            case "cm":
                                return val * g.cm_in_pt * _f7;
                            }
                        }
                        return parseFloat(len);
                    },
                    pathVmlRegExp: /([A-Za-z]+)|(\d+(\.\d+)?)|(\.\d+)|(-\d+(\.\d+)?)|(-\.\d+)/g,
                    pathSvgRegExp: /([A-Za-z])|(\d+(\.\d+)?)|(\.\d+)|(-\d+(\.\d+)?)|(-\.\d+)/g,
                    equalSources: function (a, b) {
                        return a && b && a === b;
                    },
                    switchTo: function (_f8) {
                        var ns = typeof _f8 == "string" ? g[_f8] : _f8;
                        if (ns) {
                            arr.forEach(["Group", "Rect", "Ellipse", "Circle", "Line", "Polyline", "Image", "Text", "Path", "TextPath", "Surface", "createSurface", "fixTarget"], function (_f9) {
                                g[_f9] = ns[_f9];
                            });
                        }
                    }
                });
                return g;
            });
        },
        "dojox/gfx/renderer": function () {
            define("dojox/gfx/renderer", ["./_base", "dojo/_base/lang", "dojo/_base/sniff", "dojo/_base/window", "dojo/_base/config"], function (g, _fa, has, win, _fb) {
                var _fc = null;
                return {
                    load: function (id, _fd, _fe) {
                        if (_fc && id != "force") {
                            _fe(_fc);
                            return;
                        }
                        var _ff = _fb.forceGfxRenderer,
                            _100 = !_ff && (_fa.isString(_fb.gfxRenderer) ? _fb.gfxRenderer : "svg,vml,canvas,silverlight").split(","),
                            _101, _102;
                        while (!_ff && _100.length) {
                            switch (_100.shift()) {
                            case "svg":
                                if ("SVGAngle" in win.global) {
                                    _ff = "svg";
                                }
                                break;
                            case "vml":
                                if (has("ie")) {
                                    _ff = "vml";
                                }
                                break;
                            case "silverlight":
                                try {
                                    if (has("ie")) {
                                        _101 = new ActiveXObject("AgControl.AgControl");
                                        if (_101 && _101.IsVersionSupported("1.0")) {
                                            _102 = true;
                                        }
                                    } else {
                                        if (navigator.plugins["Silverlight Plug-In"]) {
                                            _102 = true;
                                        }
                                    }
                                } catch (e) {
                                    _102 = false;
                                } finally {
                                    _101 = null;
                                }
                                if (_102) {
                                    _ff = "silverlight";
                                }
                                break;
                            case "canvas":
                                if (win.global.CanvasRenderingContext2D) {
                                    _ff = "canvas";
                                }
                                break;
                            }
                        }
                        if (_ff === "canvas" && _fb.canvasEvents !== false) {
                            _ff = "canvasWithEvents";
                        }
                        if (_fb.isDebug) {}
                        function _103() {
                            _fd(["dojox/gfx/" + _ff], function (_104) {
                                g.renderer = _ff;
                                _fc = _104;
                                _fe(_104);
                            });
                        };
                        if (_ff == "svg" && typeof window.svgweb != "undefined") {
                            window.svgweb.addOnLoad(_103);
                        } else {
                            _103();
                        }
                    }
                };
            });
        },
        "dojox/gfx/shape": function () {
            define("dojox/gfx/shape", ["./_base", "dojo/_base/lang", "dojo/_base/declare", "dojo/_base/kernel", "dojo/_base/sniff", "dojo/_base/connect", "dojo/_base/array", "dojo/dom-construct", "dojo/_base/Color", "./matrix"], function (g, lang, _105, _106, has, _107, arr, _108, _109, _10a) {
                var _10b = g.shape = {};
                var _10c = {};
                var _10d = {};
                _10b.register = function (s) {
                    var t = s.declaredClass.split(".").pop();
                    var i = t in _10c ? ++_10c[t] : ((_10c[t] = 0));
                    var uid = t + i;
                    _10d[uid] = s;
                    return uid;
                };
                _10b.byId = function (id) {
                    return _10d[id];
                };
                _10b.dispose = function (s, _10e) {
                    if (_10e && s.children) {
                        for (var i = 0; i < s.children.length; ++i) {
                            _10b.dispose(s.children[i], true);
                        }
                    }
                    delete _10d[s.getUID()];
                };
                _10b.Shape = _105("dojox.gfx.shape.Shape", null, {
                    constructor: function () {
                        this.rawNode = null;
                        this.shape = null;
                        this.matrix = null;
                        this.fillStyle = null;
                        this.strokeStyle = null;
                        this.bbox = null;
                        this.parent = null;
                        this.parentMatrix = null;
                        var uid = _10b.register(this);
                        this.getUID = function () {
                            return uid;
                        };
                    },
                    destroy: function () {
                        _10b.dispose(this);
                    },
                    getNode: function () {
                        return this.rawNode;
                    },
                    getShape: function () {
                        return this.shape;
                    },
                    getTransform: function () {
                        return this.matrix;
                    },
                    getFill: function () {
                        return this.fillStyle;
                    },
                    getStroke: function () {
                        return this.strokeStyle;
                    },
                    getParent: function () {
                        return this.parent;
                    },
                    getBoundingBox: function () {
                        return this.bbox;
                    },
                    getTransformedBoundingBox: function () {
                        var b = this.getBoundingBox();
                        if (!b) {
                            return null;
                        }
                        var m = this._getRealMatrix(),
                            gm = _10a;
                        return [gm.multiplyPoint(m, b.x, b.y), gm.multiplyPoint(m, b.x + b.width, b.y), gm.multiplyPoint(m, b.x + b.width, b.y + b.height), gm.multiplyPoint(m, b.x, b.y + b.height)];
                    },
                    getEventSource: function () {
                        return this.rawNode;
                    },
                    setClip: function (clip) {
                        this.clip = clip;
                    },
                    getClip: function () {
                        return this.clip;
                    },
                    setShape: function (_10f) {
                        this.shape = g.makeParameters(this.shape, _10f);
                        this.bbox = null;
                        return this;
                    },
                    setFill: function (fill) {
                        if (!fill) {
                            this.fillStyle = null;
                            return this;
                        }
                        var f = null;
                        if (typeof (fill) == "object" && "type" in fill) {
                            switch (fill.type) {
                            case "linear":
                                f = g.makeParameters(g.defaultLinearGradient, fill);
                                break;
                            case "radial":
                                f = g.makeParameters(g.defaultRadialGradient, fill);
                                break;
                            case "pattern":
                                f = g.makeParameters(g.defaultPattern, fill);
                                break;
                            }
                        } else {
                            f = g.normalizeColor(fill);
                        }
                        this.fillStyle = f;
                        return this;
                    },
                    setStroke: function (_110) {
                        if (!_110) {
                            this.strokeStyle = null;
                            return this;
                        }
                        if (typeof _110 == "string" || lang.isArray(_110) || _110 instanceof _109) {
                            _110 = {
                                color: _110
                            };
                        }
                        var s = this.strokeStyle = g.makeParameters(g.defaultStroke, _110);
                        s.color = g.normalizeColor(s.color);
                        return this;
                    },
                    setTransform: function (_111) {
                        this.matrix = _10a.clone(_111 ? _10a.normalize(_111) : _10a.identity);
                        return this._applyTransform();
                    },
                    _applyTransform: function () {
                        return this;
                    },
                    moveToFront: function () {
                        var p = this.getParent();
                        if (p) {
                            p._moveChildToFront(this);
                            this._moveToFront();
                        }
                        return this;
                    },
                    moveToBack: function () {
                        var p = this.getParent();
                        if (p) {
                            p._moveChildToBack(this);
                            this._moveToBack();
                        }
                        return this;
                    },
                    _moveToFront: function () {},
                    _moveToBack: function () {},
                    applyRightTransform: function (_112) {
                        return _112 ? this.setTransform([this.matrix, _112]) : this;
                    },
                    applyLeftTransform: function (_113) {
                        return _113 ? this.setTransform([_113, this.matrix]) : this;
                    },
                    applyTransform: function (_114) {
                        return _114 ? this.setTransform([this.matrix, _114]) : this;
                    },
                    removeShape: function (_115) {
                        if (this.parent) {
                            this.parent.remove(this, _115);
                        }
                        return this;
                    },
                    _setParent: function (_116, _117) {
                        this.parent = _116;
                        return this._updateParentMatrix(_117);
                    },
                    _updateParentMatrix: function (_118) {
                        this.parentMatrix = _118 ? _10a.clone(_118) : null;
                        return this._applyTransform();
                    },
                    _getRealMatrix: function () {
                        var m = this.matrix;
                        var p = this.parent;
                        while (p) {
                            if (p.matrix) {
                                m = _10a.multiply(p.matrix, m);
                            }
                            p = p.parent;
                        }
                        return m;
                    }
                });
                _10b._eventsProcessing = {
                    connect: function (name, _119, _11a) {
                        return _107.connect(this.getEventSource(), name, _10b.fixCallback(this, g.fixTarget, _119, _11a));
                    },
                    disconnect: function (_11b) {
                        _107.disconnect(_11b);
                    }
                };
                _10b.fixCallback = function (_11c, _11d, _11e, _11f) {
                    if (!_11f) {
                        _11f = _11e;
                        _11e = null;
                    }
                    if (lang.isString(_11f)) {
                        _11e = _11e || _106.global;
                        if (!_11e[_11f]) {
                            throw (["dojox.gfx.shape.fixCallback: scope[\"", _11f, "\"] is null (scope=\"", _11e, "\")"].join(""));
                        }
                        return function (e) {
                            return _11d(e, _11c) ? _11e[_11f].apply(_11e, arguments || []) : undefined;
                        };
                    }
                    return !_11e ? function (e) {
                        return _11d(e, _11c) ? _11f.apply(_11e, arguments) : undefined;
                    } : function (e) {
                        return _11d(e, _11c) ? _11f.apply(_11e, arguments || []) : undefined;
                    };
                };
                lang.extend(_10b.Shape, _10b._eventsProcessing);
                _10b.Container = {
                    _init: function () {
                        this.children = [];
                    },
                    openBatch: function () {},
                    closeBatch: function () {},
                    add: function (_120) {
                        var _121 = _120.getParent();
                        if (_121) {
                            _121.remove(_120, true);
                        }
                        this.children.push(_120);
                        return _120._setParent(this, this._getRealMatrix());
                    },
                    remove: function (_122, _123) {
                        for (var i = 0; i < this.children.length; ++i) {
                            if (this.children[i] == _122) {
                                if (_123) {} else {
                                    _122.parent = null;
                                    _122.parentMatrix = null;
                                }
                                this.children.splice(i, 1);
                                break;
                            }
                        }
                        return this;
                    },
                    clear: function (_124) {
                        var _125;
                        for (var i = 0; i < this.children.length; ++i) {
                            _125 = this.children[i];
                            _125.parent = null;
                            _125.parentMatrix = null;
                            if (_124) {
                                _125.destroy();
                            }
                        }
                        this.children = [];
                        return this;
                    },
                    getBoundingBox: function () {
                        if (this.children) {
                            var _126 = null;
                            arr.forEach(this.children, function (_127) {
                                var bb = _127.getBoundingBox();
                                if (bb) {
                                    var ct = _127.getTransform();
                                    if (ct) {
                                        bb = _10a.multiplyRectangle(ct, bb);
                                    }
                                    if (_126) {
                                        _126.x = Math.min(_126.x, bb.x);
                                        _126.y = Math.min(_126.y, bb.y);
                                        _126.endX = Math.max(_126.endX, bb.x + bb.width);
                                        _126.endY = Math.max(_126.endY, bb.y + bb.height);
                                    } else {
                                        _126 = {
                                            x: bb.x,
                                            y: bb.y,
                                            endX: bb.x + bb.width,
                                            endY: bb.y + bb.height
                                        };
                                    }
                                }
                            });
                            if (_126) {
                                _126.width = _126.endX - _126.x;
                                _126.height = _126.endY - _126.y;
                            }
                            return _126;
                        }
                        return null;
                    },
                    _moveChildToFront: function (_128) {
                        for (var i = 0; i < this.children.length; ++i) {
                            if (this.children[i] == _128) {
                                this.children.splice(i, 1);
                                this.children.push(_128);
                                break;
                            }
                        }
                        return this;
                    },
                    _moveChildToBack: function (_129) {
                        for (var i = 0; i < this.children.length; ++i) {
                            if (this.children[i] == _129) {
                                this.children.splice(i, 1);
                                this.children.unshift(_129);
                                break;
                            }
                        }
                        return this;
                    }
                };
                _10b.Surface = _105("dojox.gfx.shape.Surface", null, {
                    constructor: function () {
                        this.rawNode = null;
                        this._parent = null;
                        this._nodes = [];
                        this._events = [];
                    },
                    destroy: function () {
                        arr.forEach(this._nodes, _108.destroy);
                        this._nodes = [];
                        arr.forEach(this._events, _107.disconnect);
                        this._events = [];
                        this.rawNode = null;
                        if (has("ie")) {
                            while (this._parent.lastChild) {
                                _108.destroy(this._parent.lastChild);
                            }
                        } else {
                            this._parent.innerHTML = "";
                        }
                        this._parent = null;
                    },
                    getEventSource: function () {
                        return this.rawNode;
                    },
                    _getRealMatrix: function () {
                        return null;
                    },
                    isLoaded: true,
                    onLoad: function (_12a) {},
                    whenLoaded: function (_12b, _12c) {
                        var f = lang.hitch(_12b, _12c);
                        if (this.isLoaded) {
                            f(this);
                        } else {
                            var h = _107.connect(this, "onLoad", function (_12d) {
                                _107.disconnect(h);
                                f(_12d);
                            });
                        }
                    }
                });
                lang.extend(_10b.Surface, _10b._eventsProcessing);
                _10b.Rect = _105("dojox.gfx.shape.Rect", _10b.Shape, {
                    constructor: function (_12e) {
                        this.shape = g.getDefault("Rect");
                        this.rawNode = _12e;
                    },
                    getBoundingBox: function () {
                        return this.shape;
                    }
                });
                _10b.Ellipse = _105("dojox.gfx.shape.Ellipse", _10b.Shape, {
                    constructor: function (_12f) {
                        this.shape = g.getDefault("Ellipse");
                        this.rawNode = _12f;
                    },
                    getBoundingBox: function () {
                        if (!this.bbox) {
                            var _130 = this.shape;
                            this.bbox = {
                                x: _130.cx - _130.rx,
                                y: _130.cy - _130.ry,
                                width: 2 * _130.rx,
                                height: 2 * _130.ry
                            };
                        }
                        return this.bbox;
                    }
                });
                _10b.Circle = _105("dojox.gfx.shape.Circle", _10b.Shape, {
                    constructor: function (_131) {
                        this.shape = g.getDefault("Circle");
                        this.rawNode = _131;
                    },
                    getBoundingBox: function () {
                        if (!this.bbox) {
                            var _132 = this.shape;
                            this.bbox = {
                                x: _132.cx - _132.r,
                                y: _132.cy - _132.r,
                                width: 2 * _132.r,
                                height: 2 * _132.r
                            };
                        }
                        return this.bbox;
                    }
                });
                _10b.Line = _105("dojox.gfx.shape.Line", _10b.Shape, {
                    constructor: function (_133) {
                        this.shape = g.getDefault("Line");
                        this.rawNode = _133;
                    },
                    getBoundingBox: function () {
                        if (!this.bbox) {
                            var _134 = this.shape;
                            this.bbox = {
                                x: Math.min(_134.x1, _134.x2),
                                y: Math.min(_134.y1, _134.y2),
                                width: Math.abs(_134.x2 - _134.x1),
                                height: Math.abs(_134.y2 - _134.y1)
                            };
                        }
                        return this.bbox;
                    }
                });
                _10b.Polyline = _105("dojox.gfx.shape.Polyline", _10b.Shape, {
                    constructor: function (_135) {
                        this.shape = g.getDefault("Polyline");
                        this.rawNode = _135;
                    },
                    setShape: function (_136, _137) {
                        if (_136 && _136 instanceof Array) {
                            this.inherited(arguments, [{
                                    points: _136
                                }
                            ]);
                            if (_137 && this.shape.points.length) {
                                this.shape.points.push(this.shape.points[0]);
                            }
                        } else {
                            this.inherited(arguments, [_136]);
                        }
                        return this;
                    },
                    _normalizePoints: function () {
                        var p = this.shape.points,
                            l = p && p.length;
                        if (l && typeof p[0] == "number") {
                            var _138 = [];
                            for (var i = 0; i < l; i += 2) {
                                _138.push({
                                    x: p[i],
                                    y: p[i + 1]
                                });
                            }
                            this.shape.points = _138;
                        }
                    },
                    getBoundingBox: function () {
                        if (!this.bbox && this.shape.points.length) {
                            var p = this.shape.points;
                            var l = p.length;
                            var t = p[0];
                            var bbox = {
                                l: t.x,
                                t: t.y,
                                r: t.x,
                                b: t.y
                            };
                            for (var i = 1; i < l; ++i) {
                                t = p[i];
                                if (bbox.l > t.x) {
                                    bbox.l = t.x;
                                }
                                if (bbox.r < t.x) {
                                    bbox.r = t.x;
                                }
                                if (bbox.t > t.y) {
                                    bbox.t = t.y;
                                }
                                if (bbox.b < t.y) {
                                    bbox.b = t.y;
                                }
                            }
                            this.bbox = {
                                x: bbox.l,
                                y: bbox.t,
                                width: bbox.r - bbox.l,
                                height: bbox.b - bbox.t
                            };
                        }
                        return this.bbox;
                    }
                });
                _10b.Image = _105("dojox.gfx.shape.Image", _10b.Shape, {
                    constructor: function (_139) {
                        this.shape = g.getDefault("Image");
                        this.rawNode = _139;
                    },
                    getBoundingBox: function () {
                        return this.shape;
                    },
                    setStroke: function () {
                        return this;
                    },
                    setFill: function () {
                        return this;
                    }
                });
                _10b.Text = _105(_10b.Shape, {
                    constructor: function (_13a) {
                        this.fontStyle = null;
                        this.shape = g.getDefault("Text");
                        this.rawNode = _13a;
                    },
                    getFont: function () {
                        return this.fontStyle;
                    },
                    setFont: function (_13b) {
                        this.fontStyle = typeof _13b == "string" ? g.splitFontString(_13b) : g.makeParameters(g.defaultFont, _13b);
                        this._setFont();
                        return this;
                    }
                });
                _10b.Creator = {
                    createShape: function (_13c) {
                        switch (_13c.type) {
                        case g.defaultPath.type:
                            return this.createPath(_13c);
                        case g.defaultRect.type:
                            return this.createRect(_13c);
                        case g.defaultCircle.type:
                            return this.createCircle(_13c);
                        case g.defaultEllipse.type:
                            return this.createEllipse(_13c);
                        case g.defaultLine.type:
                            return this.createLine(_13c);
                        case g.defaultPolyline.type:
                            return this.createPolyline(_13c);
                        case g.defaultImage.type:
                            return this.createImage(_13c);
                        case g.defaultText.type:
                            return this.createText(_13c);
                        case g.defaultTextPath.type:
                            return this.createTextPath(_13c);
                        }
                        return null;
                    },
                    createGroup: function () {
                        return this.createObject(g.Group);
                    },
                    createRect: function (rect) {
                        return this.createObject(g.Rect, rect);
                    },
                    createEllipse: function (_13d) {
                        return this.createObject(g.Ellipse, _13d);
                    },
                    createCircle: function (_13e) {
                        return this.createObject(g.Circle, _13e);
                    },
                    createLine: function (line) {
                        return this.createObject(g.Line, line);
                    },
                    createPolyline: function (_13f) {
                        return this.createObject(g.Polyline, _13f);
                    },
                    createImage: function (_140) {
                        return this.createObject(g.Image, _140);
                    },
                    createText: function (text) {
                        return this.createObject(g.Text, text);
                    },
                    createPath: function (path) {
                        return this.createObject(g.Path, path);
                    },
                    createTextPath: function (text) {
                        return this.createObject(g.TextPath, {}).setText(text);
                    },
                    createObject: function (_141, _142) {
                        return null;
                    }
                };
                return _10b;
            });
        },
        "dojox/gfx/matrix": function () {
            define("dojox/gfx/matrix", ["./_base", "dojo/_base/lang"], function (g, lang) {
                var m = g.matrix = {};
                var _143 = {};
                m._degToRad = function (_144) {
                    return _143[_144] || (_143[_144] = (Math.PI * _144 / 180));
                };
                m._radToDeg = function (_145) {
                    return _145 / Math.PI * 180;
                };
                m.Matrix2D = function (arg) {
                    if (arg) {
                        if (typeof arg == "number") {
                            this.xx = this.yy = arg;
                        } else {
                            if (arg instanceof Array) {
                                if (arg.length > 0) {
                                    var _146 = m.normalize(arg[0]);
                                    for (var i = 1; i < arg.length; ++i) {
                                        var l = _146,
                                            r = m.normalize(arg[i]);
                                        _146 = new m.Matrix2D();
                                        _146.xx = l.xx * r.xx + l.xy * r.yx;
                                        _146.xy = l.xx * r.xy + l.xy * r.yy;
                                        _146.yx = l.yx * r.xx + l.yy * r.yx;
                                        _146.yy = l.yx * r.xy + l.yy * r.yy;
                                        _146.dx = l.xx * r.dx + l.xy * r.dy + l.dx;
                                        _146.dy = l.yx * r.dx + l.yy * r.dy + l.dy;
                                    }
                                    lang.mixin(this, _146);
                                }
                            } else {
                                lang.mixin(this, arg);
                            }
                        }
                    }
                };
                lang.extend(m.Matrix2D, {
                    xx: 1,
                    xy: 0,
                    yx: 0,
                    yy: 1,
                    dx: 0,
                    dy: 0
                });
                lang.mixin(m, {
                    identity: new m.Matrix2D(),
                    flipX: new m.Matrix2D({
                        xx: -1
                    }),
                    flipY: new m.Matrix2D({
                        yy: -1
                    }),
                    flipXY: new m.Matrix2D({
                        xx: -1,
                        yy: -1
                    }),
                    translate: function (a, b) {
                        if (arguments.length > 1) {
                            return new m.Matrix2D({
                                dx: a,
                                dy: b
                            });
                        }
                        return new m.Matrix2D({
                            dx: a.x,
                            dy: a.y
                        });
                    },
                    scale: function (a, b) {
                        if (arguments.length > 1) {
                            return new m.Matrix2D({
                                xx: a,
                                yy: b
                            });
                        }
                        if (typeof a == "number") {
                            return new m.Matrix2D({
                                xx: a,
                                yy: a
                            });
                        }
                        return new m.Matrix2D({
                            xx: a.x,
                            yy: a.y
                        });
                    },
                    rotate: function (_147) {
                        var c = Math.cos(_147);
                        var s = Math.sin(_147);
                        return new m.Matrix2D({
                            xx: c,
                            xy: -s,
                            yx: s,
                            yy: c
                        });
                    },
                    rotateg: function (_148) {
                        return m.rotate(m._degToRad(_148));
                    },
                    skewX: function (_149) {
                        return new m.Matrix2D({
                            xy: Math.tan(_149)
                        });
                    },
                    skewXg: function (_14a) {
                        return m.skewX(m._degToRad(_14a));
                    },
                    skewY: function (_14b) {
                        return new m.Matrix2D({
                            yx: Math.tan(_14b)
                        });
                    },
                    skewYg: function (_14c) {
                        return m.skewY(m._degToRad(_14c));
                    },
                    reflect: function (a, b) {
                        if (arguments.length == 1) {
                            b = a.y;
                            a = a.x;
                        }
                        var a2 = a * a,
                            b2 = b * b,
                            n2 = a2 + b2,
                            xy = 2 * a * b / n2;
                        return new m.Matrix2D({
                            xx: 2 * a2 / n2 - 1,
                            xy: xy,
                            yx: xy,
                            yy: 2 * b2 / n2 - 1
                        });
                    },
                    project: function (a, b) {
                        if (arguments.length == 1) {
                            b = a.y;
                            a = a.x;
                        }
                        var a2 = a * a,
                            b2 = b * b,
                            n2 = a2 + b2,
                            xy = a * b / n2;
                        return new m.Matrix2D({
                            xx: a2 / n2,
                            xy: xy,
                            yx: xy,
                            yy: b2 / n2
                        });
                    },
                    normalize: function (_14d) {
                        return (_14d instanceof m.Matrix2D) ? _14d : new m.Matrix2D(_14d);
                    },
                    isIdentity: function (_14e) {
                        return _14e.xx == 1 && _14e.xy == 0 && _14e.yx == 0 && _14e.yy == 1 && _14e.dx == 0 && _14e.dy == 0;
                    },
                    clone: function (_14f) {
                        var obj = new m.Matrix2D();
                        for (var i in _14f) {
                            if (typeof (_14f[i]) == "number" && typeof (obj[i]) == "number" && obj[i] != _14f[i]) {
                                obj[i] = _14f[i];
                            }
                        }
                        return obj;
                    },
                    invert: function (_150) {
                        var M = m.normalize(_150),
                            D = M.xx * M.yy - M.xy * M.yx;
                        M = new m.Matrix2D({
                            xx: M.yy / D,
                            xy: -M.xy / D,
                            yx: -M.yx / D,
                            yy: M.xx / D,
                            dx: (M.xy * M.dy - M.yy * M.dx) / D,
                            dy: (M.yx * M.dx - M.xx * M.dy) / D
                        });
                        return M;
                    },
                    _multiplyPoint: function (_151, x, y) {
                        return {
                            x: _151.xx * x + _151.xy * y + _151.dx,
                            y: _151.yx * x + _151.yy * y + _151.dy
                        };
                    },
                    multiplyPoint: function (_152, a, b) {
                        var M = m.normalize(_152);
                        if (typeof a == "number" && typeof b == "number") {
                            return m._multiplyPoint(M, a, b);
                        }
                        return m._multiplyPoint(M, a.x, a.y);
                    },
                    multiplyRectangle: function (_153, rect) {
                        var M = m.normalize(_153);
                        rect = rect || {
                            x: 0,
                            y: 0,
                            width: 0,
                            height: 0
                        };
                        if (m.isIdentity(M)) {
                            return {
                                x: rect.x,
                                y: rect.y,
                                width: rect.width,
                                height: rect.height
                            };
                        }
                        var p0 = m.multiplyPoint(M, rect.x, rect.y),
                            p1 = m.multiplyPoint(M, rect.x, rect.y + rect.height),
                            p2 = m.multiplyPoint(M, rect.x + rect.width, rect.y),
                            p3 = m.multiplyPoint(M, rect.x + rect.width, rect.y + rect.height),
                            minx = Math.min(p0.x, p1.x, p2.x, p3.x),
                            miny = Math.min(p0.y, p1.y, p2.y, p3.y),
                            maxx = Math.max(p0.x, p1.x, p2.x, p3.x),
                            maxy = Math.max(p0.y, p1.y, p2.y, p3.y);
                        return {
                            x: minx,
                            y: miny,
                            width: maxx - minx,
                            height: maxy - miny
                        };
                    },
                    multiply: function (_154) {
                        var M = m.normalize(_154);
                        for (var i = 1; i < arguments.length; ++i) {
                            var l = M,
                                r = m.normalize(arguments[i]);
                            M = new m.Matrix2D();
                            M.xx = l.xx * r.xx + l.xy * r.yx;
                            M.xy = l.xx * r.xy + l.xy * r.yy;
                            M.yx = l.yx * r.xx + l.yy * r.yx;
                            M.yy = l.yx * r.xy + l.yy * r.yy;
                            M.dx = l.xx * r.dx + l.xy * r.dy + l.dx;
                            M.dy = l.yx * r.dx + l.yy * r.dy + l.dy;
                        }
                        return M;
                    },
                    _sandwich: function (_155, x, y) {
                        return m.multiply(m.translate(x, y), _155, m.translate(-x, -y));
                    },
                    scaleAt: function (a, b, c, d) {
                        switch (arguments.length) {
                        case 4:
                            return m._sandwich(m.scale(a, b), c, d);
                        case 3:
                            if (typeof c == "number") {
                                return m._sandwich(m.scale(a), b, c);
                            }
                            return m._sandwich(m.scale(a, b), c.x, c.y);
                        }
                        return m._sandwich(m.scale(a), b.x, b.y);
                    },
                    rotateAt: function (_156, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.rotate(_156), a, b);
                        }
                        return m._sandwich(m.rotate(_156), a.x, a.y);
                    },
                    rotategAt: function (_157, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.rotateg(_157), a, b);
                        }
                        return m._sandwich(m.rotateg(_157), a.x, a.y);
                    },
                    skewXAt: function (_158, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.skewX(_158), a, b);
                        }
                        return m._sandwich(m.skewX(_158), a.x, a.y);
                    },
                    skewXgAt: function (_159, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.skewXg(_159), a, b);
                        }
                        return m._sandwich(m.skewXg(_159), a.x, a.y);
                    },
                    skewYAt: function (_15a, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.skewY(_15a), a, b);
                        }
                        return m._sandwich(m.skewY(_15a), a.x, a.y);
                    },
                    skewYgAt: function (_15b, a, b) {
                        if (arguments.length > 2) {
                            return m._sandwich(m.skewYg(_15b), a, b);
                        }
                        return m._sandwich(m.skewYg(_15b), a.x, a.y);
                    }
                });
                g.Matrix2D = m.Matrix2D;
                return m;
            });
        },
        "dojox/charting/SimpleTheme": function () {
            define("dojox/charting/SimpleTheme", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "dojo/_base/Color", "dojox/lang/utils", "dojox/gfx/gradutils"], function (lang, arr, _15c, _15d, dlu, dgg) {
                var _15e = _15c("dojox.charting.SimpleTheme", null, {
                    shapeSpaces: {
                        shape: 1,
                        shapeX: 1,
                        shapeY: 1
                    },
                    constructor: function (_15f) {
                        _15f = _15f || {};
                        var def = _15e.defaultTheme;
                        arr.forEach(["chart", "plotarea", "axis", "grid", "series", "marker", "indicator"], function (name) {
                            this[name] = lang.delegate(def[name], _15f[name]);
                        }, this);
                        if (_15f.seriesThemes && _15f.seriesThemes.length) {
                            this.colors = null;
                            this.seriesThemes = _15f.seriesThemes.slice(0);
                        } else {
                            this.seriesThemes = null;
                            this.colors = (_15f.colors || _15e.defaultColors).slice(0);
                        }
                        this.markerThemes = null;
                        if (_15f.markerThemes && _15f.markerThemes.length) {
                            this.markerThemes = _15f.markerThemes.slice(0);
                        }
                        this.markers = _15f.markers ? lang.clone(_15f.markers) : lang.delegate(_15e.defaultMarkers);
                        this.noGradConv = _15f.noGradConv;
                        this.noRadialConv = _15f.noRadialConv;
                        if (_15f.reverseFills) {
                            this.reverseFills();
                        }
                        this._current = 0;
                        this._buildMarkerArray();
                    },
                    clone: function () {
                        var _160 = new this.constructor({
                            chart: this.chart,
                            plotarea: this.plotarea,
                            axis: this.axis,
                            grid: this.grid,
                            series: this.series,
                            marker: this.marker,
                            colors: this.colors,
                            markers: this.markers,
                            indicator: this.indicator,
                            seriesThemes: this.seriesThemes,
                            markerThemes: this.markerThemes,
                            noGradConv: this.noGradConv,
                            noRadialConv: this.noRadialConv
                        });
                        arr.forEach(["clone", "clear", "next", "skip", "addMixin", "post", "getTick"], function (name) {
                            if (this.hasOwnProperty(name)) {
                                _160[name] = this[name];
                            }
                        }, this);
                        return _160;
                    },
                    clear: function () {
                        this._current = 0;
                    },
                    next: function (_161, _162, _163) {
                        var _164 = dlu.merge,
                            _165, _166;
                        if (this.colors) {
                            _165 = lang.delegate(this.series);
                            _166 = lang.delegate(this.marker);
                            var _167 = new _15d(this.colors[this._current % this.colors.length]),
                                old;
                            if (_165.stroke && _165.stroke.color) {
                                _165.stroke = lang.delegate(_165.stroke);
                                old = new _15d(_165.stroke.color);
                                _165.stroke.color = new _15d(_167);
                                _165.stroke.color.a = old.a;
                            } else {
                                _165.stroke = {
                                    color: _167
                                };
                            } if (_166.stroke && _166.stroke.color) {
                                _166.stroke = lang.delegate(_166.stroke);
                                old = new _15d(_166.stroke.color);
                                _166.stroke.color = new _15d(_167);
                                _166.stroke.color.a = old.a;
                            } else {
                                _166.stroke = {
                                    color: _167
                                };
                            } if (!_165.fill || _165.fill.type) {
                                _165.fill = _167;
                            } else {
                                old = new _15d(_165.fill);
                                _165.fill = new _15d(_167);
                                _165.fill.a = old.a;
                            } if (!_166.fill || _166.fill.type) {
                                _166.fill = _167;
                            } else {
                                old = new _15d(_166.fill);
                                _166.fill = new _15d(_167);
                                _166.fill.a = old.a;
                            }
                        } else {
                            _165 = this.seriesThemes ? _164(this.series, this.seriesThemes[this._current % this.seriesThemes.length]) : this.series;
                            _166 = this.markerThemes ? _164(this.marker, this.markerThemes[this._current % this.markerThemes.length]) : _165;
                        }
                        var _168 = _166 && _166.symbol || this._markers[this._current % this._markers.length];
                        var _169 = {
                            series: _165,
                            marker: _166,
                            symbol: _168
                        };
                        ++this._current;
                        if (_162) {
                            _169 = this.addMixin(_169, _161, _162);
                        }
                        if (_163) {
                            _169 = this.post(_169, _161);
                        }
                        return _169;
                    },
                    skip: function () {
                        ++this._current;
                    },
                    addMixin: function (_16a, _16b, _16c, _16d) {
                        if (lang.isArray(_16c)) {
                            arr.forEach(_16c, function (m) {
                                _16a = this.addMixin(_16a, _16b, m);
                            }, this);
                        } else {
                            var t = {};
                            if ("color" in _16c) {
                                if (_16b == "line" || _16b == "area") {
                                    lang.setObject("series.stroke.color", _16c.color, t);
                                    lang.setObject("marker.stroke.color", _16c.color, t);
                                } else {
                                    lang.setObject("series.fill", _16c.color, t);
                                }
                            }
                            arr.forEach(["stroke", "outline", "shadow", "fill", "font", "fontColor", "labelWiring"], function (name) {
                                var _16e = "marker" + name.charAt(0).toUpperCase() + name.substr(1),
                                    b = _16e in _16c;
                                if (name in _16c) {
                                    lang.setObject("series." + name, _16c[name], t);
                                    if (!b) {
                                        lang.setObject("marker." + name, _16c[name], t);
                                    }
                                }
                                if (b) {
                                    lang.setObject("marker." + name, _16c[_16e], t);
                                }
                            });
                            if ("marker" in _16c) {
                                t.symbol = _16c.marker;
                                t.symbol = _16c.marker;
                            }
                            _16a = dlu.merge(_16a, t);
                        } if (_16d) {
                            _16a = this.post(_16a, _16b);
                        }
                        return _16a;
                    },
                    post: function (_16f, _170) {
                        var fill = _16f.series.fill,
                            t;
                        if (!this.noGradConv && this.shapeSpaces[fill.space] && fill.type == "linear") {
                            if (_170 == "bar") {
                                t = {
                                    x1: fill.y1,
                                    y1: fill.x1,
                                    x2: fill.y2,
                                    y2: fill.x2
                                };
                            } else {
                                if (!this.noRadialConv && fill.space == "shape" && (_170 == "slice" || _170 == "circle")) {
                                    t = {
                                        type: "radial",
                                        cx: 0,
                                        cy: 0,
                                        r: 100
                                    };
                                }
                            } if (t) {
                                return dlu.merge(_16f, {
                                    series: {
                                        fill: t
                                    }
                                });
                            }
                        }
                        return _16f;
                    },
                    getTick: function (name, _171) {
                        var tick = this.axis.tick,
                            _172 = name + "Tick",
                            _173 = dlu.merge;
                        if (tick) {
                            if (this.axis[_172]) {
                                tick = _173(tick, this.axis[_172]);
                            }
                        } else {
                            tick = this.axis[_172];
                        } if (_171) {
                            if (tick) {
                                if (_171[_172]) {
                                    tick = _173(tick, _171[_172]);
                                }
                            } else {
                                tick = _171[_172];
                            }
                        }
                        return tick;
                    },
                    inspectObjects: function (f) {
                        arr.forEach(["chart", "plotarea", "axis", "grid", "series", "marker", "indicator"], function (name) {
                            f(this[name]);
                        }, this);
                        if (this.seriesThemes) {
                            arr.forEach(this.seriesThemes, f);
                        }
                        if (this.markerThemes) {
                            arr.forEach(this.markerThemes, f);
                        }
                    },
                    reverseFills: function () {
                        this.inspectObjects(function (o) {
                            if (o && o.fill) {
                                o.fill = dgg.reverse(o.fill);
                            }
                        });
                    },
                    addMarker: function (name, _174) {
                        this.markers[name] = _174;
                        this._buildMarkerArray();
                    },
                    setMarkers: function (obj) {
                        this.markers = obj;
                        this._buildMarkerArray();
                    },
                    _buildMarkerArray: function () {
                        this._markers = [];
                        for (var p in this.markers) {
                            this._markers.push(this.markers[p]);
                        }
                    }
                });
                lang.mixin(_15e, {
                    defaultMarkers: {
                        CIRCLE: "m-3,0 c0,-4 6,-4 6,0 m-6,0 c0,4 6,4 6,0",
                        SQUARE: "m-3,-3 l0,6 6,0 0,-6 z",
                        DIAMOND: "m0,-3 l3,3 -3,3 -3,-3 z",
                        CROSS: "m0,-3 l0,6 m-3,-3 l6,0",
                        X: "m-3,-3 l6,6 m0,-6 l-6,6",
                        TRIANGLE: "m-3,3 l3,-6 3,6 z",
                        TRIANGLE_INVERTED: "m-3,-3 l3,6 3,-6 z"
                    },
                    defaultColors: ["#54544c", "#858e94", "#6e767a", "#948585", "#474747"],
                    defaultTheme: {
                        chart: {
                            stroke: null,
                            fill: "white",
                            pageStyle: null,
                            titleGap: 20,
                            titlePos: "top",
                            titleFont: "normal normal bold 14pt Tahoma",
                            titleFontColor: "#333"
                        },
                        plotarea: {
                            stroke: null,
                            fill: "white"
                        },
                        axis: {
                            stroke: {
                                color: "#333",
                                width: 1
                            },
                            tick: {
                                color: "#666",
                                position: "center",
                                font: "normal normal normal 7pt Tahoma",
                                fontColor: "#333",
                                labelGap: 4
                            },
                            majorTick: {
                                width: 1,
                                length: 6
                            },
                            minorTick: {
                                width: 0.8,
                                length: 3
                            },
                            microTick: {
                                width: 0.5,
                                length: 1
                            },
                            title: {
                                gap: 15,
                                font: "normal normal normal 11pt Tahoma",
                                fontColor: "#333",
                                orientation: "axis"
                            }
                        },
                        series: {
                            stroke: {
                                width: 1.5,
                                color: "#333"
                            },
                            outline: {
                                width: 0.1,
                                color: "#ccc"
                            },
                            shadow: null,
                            fill: "#ccc",
                            font: "normal normal normal 8pt Tahoma",
                            fontColor: "#000",
                            labelWiring: {
                                width: 1,
                                color: "#ccc"
                            }
                        },
                        marker: {
                            stroke: {
                                width: 1.5,
                                color: "#333"
                            },
                            outline: {
                                width: 0.1,
                                color: "#ccc"
                            },
                            shadow: null,
                            fill: "#ccc",
                            font: "normal normal normal 8pt Tahoma",
                            fontColor: "#000"
                        },
                        indicator: {
                            lineStroke: {
                                width: 1.5,
                                color: "#333"
                            },
                            lineOutline: {
                                width: 0.1,
                                color: "#ccc"
                            },
                            lineShadow: null,
                            stroke: {
                                width: 1.5,
                                color: "#333"
                            },
                            outline: {
                                width: 0.1,
                                color: "#ccc"
                            },
                            shadow: null,
                            fill: "#ccc",
                            radius: 3,
                            font: "normal normal normal 10pt Tahoma",
                            fontColor: "#000",
                            markerFill: "#ccc",
                            markerSymbol: "m-3,0 c0,-4 6,-4 6,0 m-6,0 c0,4 6,4 6,0",
                            markerStroke: {
                                width: 1.5,
                                color: "#333"
                            },
                            markerOutline: {
                                width: 0.1,
                                color: "#ccc"
                            },
                            markerShadow: null
                        }
                    }
                });
                return _15e;
            });
        },
        "dojox/lang/utils": function () {
            define("dojox/lang/utils", ["..", "dojo/_base/lang"], function (_175, lang) {
                var du = lang.getObject("lang.utils", true, _175);
                var _176 = {}, opts = Object.prototype.toString;
                var _177 = function (o) {
                    if (o) {
                        switch (opts.call(o)) {
                        case "[object Array]":
                            return o.slice(0);
                        case "[object Object]":
                            return lang.delegate(o);
                        }
                    }
                    return o;
                };
                lang.mixin(du, {
                    coerceType: function (_178, _179) {
                        switch (typeof _178) {
                        case "number":
                            return Number(eval("(" + _179 + ")"));
                        case "string":
                            return String(_179);
                        case "boolean":
                            return Boolean(eval("(" + _179 + ")"));
                        }
                        return eval("(" + _179 + ")");
                    },
                    updateWithObject: function (_17a, _17b, conv) {
                        if (!_17b) {
                            return _17a;
                        }
                        for (var x in _17a) {
                            if (x in _17b && !(x in _176)) {
                                var t = _17a[x];
                                if (t && typeof t == "object") {
                                    du.updateWithObject(t, _17b[x], conv);
                                } else {
                                    _17a[x] = conv ? du.coerceType(t, _17b[x]) : _177(_17b[x]);
                                }
                            }
                        }
                        return _17a;
                    },
                    updateWithPattern: function (_17c, _17d, _17e, conv) {
                        if (!_17d || !_17e) {
                            return _17c;
                        }
                        for (var x in _17e) {
                            if (x in _17d && !(x in _176)) {
                                _17c[x] = conv ? du.coerceType(_17e[x], _17d[x]) : _177(_17d[x]);
                            }
                        }
                        return _17c;
                    },
                    merge: function (_17f, _180) {
                        if (_180) {
                            var _181 = opts.call(_17f),
                                _182 = opts.call(_180),
                                t, i, l, m;
                            switch (_182) {
                            case "[object Array]":
                                if (_182 == _181) {
                                    t = new Array(Math.max(_17f.length, _180.length));
                                    for (i = 0, l = t.length; i < l; ++i) {
                                        t[i] = du.merge(_17f[i], _180[i]);
                                    }
                                    return t;
                                }
                                return _180.slice(0);
                            case "[object Object]":
                                if (_182 == _181 && _17f) {
                                    t = lang.delegate(_17f);
                                    for (i in _180) {
                                        if (i in _17f) {
                                            l = _17f[i];
                                            m = _180[i];
                                            if (m !== l) {
                                                t[i] = du.merge(l, m);
                                            }
                                        } else {
                                            t[i] = lang.clone(_180[i]);
                                        }
                                    }
                                    return t;
                                }
                                return lang.clone(_180);
                            }
                        }
                        return _180;
                    }
                });
                return du;
            });
        },
        "dojox/gfx/gradutils": function () {
            define("dojox/gfx/gradutils", ["./_base", "dojo/_base/lang", "./matrix", "dojo/_base/Color"], function (g, lang, m, _183) {
                var _184 = g.gradutils = {};

                function _185(o, c) {
                    if (o <= 0) {
                        return c[0].color;
                    }
                    var len = c.length;
                    if (o >= 1) {
                        return c[len - 1].color;
                    }
                    for (var i = 0; i < len; ++i) {
                        var stop = c[i];
                        if (stop.offset >= o) {
                            if (i) {
                                var prev = c[i - 1];
                                return _183.blendColors(new _183(prev.color), new _183(stop.color), (o - prev.offset) / (stop.offset - prev.offset));
                            }
                            return stop.color;
                        }
                    }
                    return c[len - 1].color;
                };
                _184.getColor = function (fill, pt) {
                    var o;
                    if (fill) {
                        switch (fill.type) {
                        case "linear":
                            var _186 = Math.atan2(fill.y2 - fill.y1, fill.x2 - fill.x1),
                                _187 = m.rotate(-_186),
                                _188 = m.project(fill.x2 - fill.x1, fill.y2 - fill.y1),
                                p = m.multiplyPoint(_188, pt),
                                pf1 = m.multiplyPoint(_188, fill.x1, fill.y1),
                                pf2 = m.multiplyPoint(_188, fill.x2, fill.y2),
                                _189 = m.multiplyPoint(_187, pf2.x - pf1.x, pf2.y - pf1.y).x;
                            o = m.multiplyPoint(_187, p.x - pf1.x, p.y - pf1.y).x / _189;
                            break;
                        case "radial":
                            var dx = pt.x - fill.cx,
                                dy = pt.y - fill.cy;
                            o = Math.sqrt(dx * dx + dy * dy) / fill.r;
                            break;
                        }
                        return _185(o, fill.colors);
                    }
                    return new _183(fill || [0, 0, 0, 0]);
                };
                _184.reverse = function (fill) {
                    if (fill) {
                        switch (fill.type) {
                        case "linear":
                        case "radial":
                            fill = lang.delegate(fill);
                            if (fill.colors) {
                                var c = fill.colors,
                                    l = c.length,
                                    i = 0,
                                    stop, n = fill.colors = new Array(c.length);
                                for (; i < l; ++i) {
                                    stop = c[i];
                                    n[i] = {
                                        offset: 1 - stop.offset,
                                        color: stop.color
                                    };
                                }
                                n.sort(function (a, b) {
                                    return a.offset - b.offset;
                                });
                            }
                            break;
                        }
                    }
                    return fill;
                };
                return _184;
            });
        },
        "dojox/charting/Series": function () {
            define("dojox/charting/Series", ["dojo/_base/lang", "dojo/_base/declare", "./Element"], function (lang, _18a, _18b) {
                return _18a("dojox.charting.Series", _18b, {
                    constructor: function (_18c, data, _18d) {
                        lang.mixin(this, _18d);
                        if (typeof this.plot != "string") {
                            this.plot = "default";
                        }
                        this.update(data);
                    },
                    clear: function () {
                        this.dyn = {};
                    },
                    update: function (data) {
                        if (lang.isArray(data)) {
                            this.data = data;
                        } else {
                            this.source = data;
                            this.data = this.source.data;
                            if (this.source.setSeriesObject) {
                                this.source.setSeriesObject(this);
                            }
                        }
                        this.dirty = true;
                        this.clear();
                    }
                });
            });
        },
        "dojox/charting/axis2d/common": function () {
            define("dojox/charting/axis2d/common", ["dojo/_base/lang", "dojo/_base/window", "dojo/dom-geometry", "dojox/gfx"], function (lang, win, _18e, g) {
                var _18f = lang.getObject("dojox.charting.axis2d.common", true);
                var _190 = function (s) {
                    s.marginLeft = "0px";
                    s.marginTop = "0px";
                    s.marginRight = "0px";
                    s.marginBottom = "0px";
                    s.paddingLeft = "0px";
                    s.paddingTop = "0px";
                    s.paddingRight = "0px";
                    s.paddingBottom = "0px";
                    s.borderLeftWidth = "0px";
                    s.borderTopWidth = "0px";
                    s.borderRightWidth = "0px";
                    s.borderBottomWidth = "0px";
                };
                var _191 = function (n) {
                    if (n["getBoundingClientRect"]) {
                        var bcr = n.getBoundingClientRect();
                        return bcr.width || (bcr.right - bcr.left);
                    } else {
                        return _18e.getMarginBox(n).w;
                    }
                };
                return lang.mixin(_18f, {
                    createText: {
                        gfx: function (_192, _193, x, y, _194, text, font, _195) {
                            return _193.createText({
                                x: x,
                                y: y,
                                text: text,
                                align: _194
                            }).setFont(font).setFill(_195);
                        },
                        html: function (_196, _197, x, y, _198, text, font, _199, _19a) {
                            var p = win.doc.createElement("div"),
                                s = p.style,
                                _19b;
                            if (_196.getTextDir) {
                                p.dir = _196.getTextDir(text);
                            }
                            _190(s);
                            s.font = font;
                            p.innerHTML = String(text).replace(/\s/g, "&nbsp;");
                            s.color = _199;
                            s.position = "absolute";
                            s.left = "-10000px";
                            win.body().appendChild(p);
                            var size = g.normalizedLength(g.splitFontString(font).size);
                            if (!_19a) {
                                _19b = _191(p);
                            }
                            if (p.dir == "rtl") {
                                x += _19a ? _19a : _19b;
                            }
                            win.body().removeChild(p);
                            s.position = "relative";
                            if (_19a) {
                                s.width = _19a + "px";
                                switch (_198) {
                                case "middle":
                                    s.textAlign = "center";
                                    s.left = (x - _19a / 2) + "px";
                                    break;
                                case "end":
                                    s.textAlign = "right";
                                    s.left = (x - _19a) + "px";
                                    break;
                                default:
                                    s.left = x + "px";
                                    s.textAlign = "left";
                                    break;
                                }
                            } else {
                                switch (_198) {
                                case "middle":
                                    s.left = Math.floor(x - _19b / 2) + "px";
                                    break;
                                case "end":
                                    s.left = Math.floor(x - _19b) + "px";
                                    break;
                                default:
                                    s.left = Math.floor(x) + "px";
                                    break;
                                }
                            }
                            s.top = Math.floor(y - size) + "px";
                            s.whiteSpace = "nowrap";
                            var wrap = win.doc.createElement("div"),
                                w = wrap.style;
                            _190(w);
                            w.width = "0px";
                            w.height = "0px";
                            wrap.appendChild(p);
                            _196.node.insertBefore(wrap, _196.node.firstChild);
                            return wrap;
                        }
                    }
                });
            });
        },
        "dojox/lang/functional": function () {
            define("dojox/lang/functional", ["./functional/lambda", "./functional/array", "./functional/object"], function (df) {
                return df;
            });
        },
        "dojox/lang/functional/lambda": function () {
            define("dojox/lang/functional/lambda", ["../..", "dojo/_base/kernel", "dojo/_base/lang", "dojo/_base/array"], function (_19c, dojo, lang, arr) {
                var df = lang.getObject("lang.functional", true, _19c);
                var _19d = {};
                var _19e = "ab".split(/a*/).length > 1 ? String.prototype.split : function (sep) {
                        var r = this.split.call(this, sep),
                            m = sep.exec(this);
                        if (m && m.index == 0) {
                            r.unshift("");
                        }
                        return r;
                    };
                var _19f = function (s) {
                    var args = [],
                        _1a0 = _19e.call(s, /\s*->\s*/m);
                    if (_1a0.length > 1) {
                        while (_1a0.length) {
                            s = _1a0.pop();
                            args = _1a0.pop().split(/\s*,\s*|\s+/m);
                            if (_1a0.length) {
                                _1a0.push("(function(" + args + "){return (" + s + ")})");
                            }
                        }
                    } else {
                        if (s.match(/\b_\b/)) {
                            args = ["_"];
                        } else {
                            var l = s.match(/^\s*(?:[+*\/%&|\^\.=<>]|!=)/m),
                                r = s.match(/[+\-*\/%&|\^\.=<>!]\s*$/m);
                            if (l || r) {
                                if (l) {
                                    args.push("$1");
                                    s = "$1" + s;
                                }
                                if (r) {
                                    args.push("$2");
                                    s = s + "$2";
                                }
                            } else {
                                var vars = s.replace(/(?:\b[A-Z]|\.[a-zA-Z_$])[a-zA-Z_$\d]*|[a-zA-Z_$][a-zA-Z_$\d]*:|this|true|false|null|undefined|typeof|instanceof|in|delete|new|void|arguments|decodeURI|decodeURIComponent|encodeURI|encodeURIComponent|escape|eval|isFinite|isNaN|parseFloat|parseInt|unescape|dojo|dijit|dojox|window|document|'(?:[^'\\]|\\.)*'|"(?:[^"\\]|\\.)*"/g, "").match(/([a-z_$][a-z_$\d]*)/gi) || [],
                                    t = {};
                                arr.forEach(vars, function (v) {
                                    if (!(v in t)) {
                                        args.push(v);
                                        t[v] = 1;
                                    }
                                });
                            }
                        }
                    }
                    return {
                        args: args,
                        body: s
                    };
                };
                var _1a1 = function (a) {
                    return a.length ? function () {
                        var i = a.length - 1,
                            x = df.lambda(a[i]).apply(this, arguments);
                        for (--i; i >= 0; --i) {
                            x = df.lambda(a[i]).call(this, x);
                        }
                        return x;
                    } : function (x) {
                        return x;
                    };
                };
                lang.mixin(df, {
                    rawLambda: function (s) {
                        return _19f(s);
                    },
                    buildLambda: function (s) {
                        s = _19f(s);
                        return "function(" + s.args.join(",") + "){return (" + s.body + ");}";
                    },
                    lambda: function (s) {
                        if (typeof s == "function") {
                            return s;
                        }
                        if (s instanceof Array) {
                            return _1a1(s);
                        }
                        if (s in _19d) {
                            return _19d[s];
                        }
                        s = _19f(s);
                        return _19d[s] = new Function(s.args, "return (" + s.body + ");");
                    },
                    clearLambdaCache: function () {
                        _19d = {};
                    }
                });
                return df;
            });
        },
        "dojox/lang/functional/array": function () {
            define("dojox/lang/functional/array", ["dojo/_base/kernel", "dojo/_base/lang", "dojo/_base/array", "./lambda"], function (_1a2, lang, arr, df) {
                var _1a3 = {};
                lang.mixin(df, {
                    filter: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a2.global;
                        f = df.lambda(f);
                        var t = [],
                            v, i, n;
                        if (lang.isArray(a)) {
                            for (i = 0, n = a.length; i < n; ++i) {
                                v = a[i];
                                if (f.call(o, v, i, a)) {
                                    t.push(v);
                                }
                            }
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                for (i = 0; a.hasNext();) {
                                    v = a.next();
                                    if (f.call(o, v, i++, a)) {
                                        t.push(v);
                                    }
                                }
                            } else {
                                for (i in a) {
                                    if (!(i in _1a3)) {
                                        v = a[i];
                                        if (f.call(o, v, i, a)) {
                                            t.push(v);
                                        }
                                    }
                                }
                            }
                        }
                        return t;
                    },
                    forEach: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a2.global;
                        f = df.lambda(f);
                        var i, n;
                        if (lang.isArray(a)) {
                            for (i = 0, n = a.length; i < n; f.call(o, a[i], i, a), ++i) {}
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                for (i = 0; a.hasNext(); f.call(o, a.next(), i++, a)) {}
                            } else {
                                for (i in a) {
                                    if (!(i in _1a3)) {
                                        f.call(o, a[i], i, a);
                                    }
                                }
                            }
                        }
                        return o;
                    },
                    map: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a2.global;
                        f = df.lambda(f);
                        var t, n, i;
                        if (lang.isArray(a)) {
                            t = new Array(n = a.length);
                            for (i = 0; i < n; t[i] = f.call(o, a[i], i, a), ++i) {}
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                t = [];
                                for (i = 0; a.hasNext(); t.push(f.call(o, a.next(), i++, a))) {}
                            } else {
                                t = [];
                                for (i in a) {
                                    if (!(i in _1a3)) {
                                        t.push(f.call(o, a[i], i, a));
                                    }
                                }
                            }
                        }
                        return t;
                    },
                    every: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a2.global;
                        f = df.lambda(f);
                        var i, n;
                        if (lang.isArray(a)) {
                            for (i = 0, n = a.length; i < n; ++i) {
                                if (!f.call(o, a[i], i, a)) {
                                    return false;
                                }
                            }
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                for (i = 0; a.hasNext();) {
                                    if (!f.call(o, a.next(), i++, a)) {
                                        return false;
                                    }
                                }
                            } else {
                                for (i in a) {
                                    if (!(i in _1a3)) {
                                        if (!f.call(o, a[i], i, a)) {
                                            return false;
                                        }
                                    }
                                }
                            }
                        }
                        return true;
                    },
                    some: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a2.global;
                        f = df.lambda(f);
                        var i, n;
                        if (lang.isArray(a)) {
                            for (i = 0, n = a.length; i < n; ++i) {
                                if (f.call(o, a[i], i, a)) {
                                    return true;
                                }
                            }
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                for (i = 0; a.hasNext();) {
                                    if (f.call(o, a.next(), i++, a)) {
                                        return true;
                                    }
                                }
                            } else {
                                for (i in a) {
                                    if (!(i in _1a3)) {
                                        if (f.call(o, a[i], i, a)) {
                                            return true;
                                        }
                                    }
                                }
                            }
                        }
                        return false;
                    }
                });
                return df;
            });
        },
        "dojox/lang/functional/object": function () {
            define("dojox/lang/functional/object", ["dojo/_base/kernel", "dojo/_base/lang", "./lambda"], function (_1a4, lang, df) {
                var _1a5 = {};
                lang.mixin(df, {
                    keys: function (obj) {
                        var t = [];
                        for (var i in obj) {
                            if (!(i in _1a5)) {
                                t.push(i);
                            }
                        }
                        return t;
                    },
                    values: function (obj) {
                        var t = [];
                        for (var i in obj) {
                            if (!(i in _1a5)) {
                                t.push(obj[i]);
                            }
                        }
                        return t;
                    },
                    filterIn: function (obj, f, o) {
                        o = o || _1a4.global;
                        f = df.lambda(f);
                        var t = {}, v, i;
                        for (i in obj) {
                            if (!(i in _1a5)) {
                                v = obj[i];
                                if (f.call(o, v, i, obj)) {
                                    t[i] = v;
                                }
                            }
                        }
                        return t;
                    },
                    forIn: function (obj, f, o) {
                        o = o || _1a4.global;
                        f = df.lambda(f);
                        for (var i in obj) {
                            if (!(i in _1a5)) {
                                f.call(o, obj[i], i, obj);
                            }
                        }
                        return o;
                    },
                    mapIn: function (obj, f, o) {
                        o = o || _1a4.global;
                        f = df.lambda(f);
                        var t = {}, i;
                        for (i in obj) {
                            if (!(i in _1a5)) {
                                t[i] = f.call(o, obj[i], i, obj);
                            }
                        }
                        return t;
                    }
                });
                return df;
            });
        },
        "dojox/lang/functional/fold": function () {
            define("dojox/lang/functional/fold", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/kernel", "./lambda"], function (lang, arr, _1a6, df) {
                var _1a7 = {};
                lang.mixin(df, {
                    foldl: function (a, f, z, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a6.global;
                        f = df.lambda(f);
                        var i, n;
                        if (lang.isArray(a)) {
                            for (i = 0, n = a.length; i < n; z = f.call(o, z, a[i], i, a), ++i) {}
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                for (i = 0; a.hasNext(); z = f.call(o, z, a.next(), i++, a)) {}
                            } else {
                                for (i in a) {
                                    if (!(i in _1a7)) {
                                        z = f.call(o, z, a[i], i, a);
                                    }
                                }
                            }
                        }
                        return z;
                    },
                    foldl1: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a6.global;
                        f = df.lambda(f);
                        var z, i, n;
                        if (lang.isArray(a)) {
                            z = a[0];
                            for (i = 1, n = a.length; i < n; z = f.call(o, z, a[i], i, a), ++i) {}
                        } else {
                            if (typeof a.hasNext == "function" && typeof a.next == "function") {
                                if (a.hasNext()) {
                                    z = a.next();
                                    for (i = 1; a.hasNext(); z = f.call(o, z, a.next(), i++, a)) {}
                                }
                            } else {
                                var _1a8 = true;
                                for (i in a) {
                                    if (!(i in _1a7)) {
                                        if (_1a8) {
                                            z = a[i];
                                            _1a8 = false;
                                        } else {
                                            z = f.call(o, z, a[i], i, a);
                                        }
                                    }
                                }
                            }
                        }
                        return z;
                    },
                    foldr: function (a, f, z, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a6.global;
                        f = df.lambda(f);
                        for (var i = a.length; i > 0; --i, z = f.call(o, z, a[i], i, a)) {}
                        return z;
                    },
                    foldr1: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a6.global;
                        f = df.lambda(f);
                        var n = a.length,
                            z = a[n - 1],
                            i = n - 1;
                        for (; i > 0; --i, z = f.call(o, z, a[i], i, a)) {}
                        return z;
                    },
                    reduce: function (a, f, z) {
                        return arguments.length < 3 ? df.foldl1(a, f) : df.foldl(a, f, z);
                    },
                    reduceRight: function (a, f, z) {
                        return arguments.length < 3 ? df.foldr1(a, f) : df.foldr(a, f, z);
                    },
                    unfold: function (pr, f, g, z, o) {
                        o = o || _1a6.global;
                        f = df.lambda(f);
                        g = df.lambda(g);
                        pr = df.lambda(pr);
                        var t = [];
                        for (; !pr.call(o, z); t.push(f.call(o, z)), z = g.call(o, z)) {}
                        return t;
                    }
                });
            });
        },
        "dojox/lang/functional/reversed": function () {
            define("dojox/lang/functional/reversed", ["dojo/_base/lang", "dojo/_base/kernel", "./lambda"], function (lang, _1a9, df) {
                lang.mixin(df, {
                    filterRev: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a9.global;
                        f = df.lambda(f);
                        var t = [],
                            v, i = a.length - 1;
                        for (; i >= 0; --i) {
                            v = a[i];
                            if (f.call(o, v, i, a)) {
                                t.push(v);
                            }
                        }
                        return t;
                    },
                    forEachRev: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a9.global;
                        f = df.lambda(f);
                        for (var i = a.length - 1; i >= 0; f.call(o, a[i], i, a), --i) {}
                    },
                    mapRev: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a9.global;
                        f = df.lambda(f);
                        var n = a.length,
                            t = new Array(n),
                            i = n - 1,
                            j = 0;
                        for (; i >= 0; t[j++] = f.call(o, a[i], i, a), --i) {}
                        return t;
                    },
                    everyRev: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a9.global;
                        f = df.lambda(f);
                        for (var i = a.length - 1; i >= 0; --i) {
                            if (!f.call(o, a[i], i, a)) {
                                return false;
                            }
                        }
                        return true;
                    },
                    someRev: function (a, f, o) {
                        if (typeof a == "string") {
                            a = a.split("");
                        }
                        o = o || _1a9.global;
                        f = df.lambda(f);
                        for (var i = a.length - 1; i >= 0; --i) {
                            if (f.call(o, a[i], i, a)) {
                                return true;
                            }
                        }
                        return false;
                    }
                });
                return df;
            });
        },
        "dojox/charting/axis2d/Default": function () {
            define("dojox/charting/axis2d/Default", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/sniff", "dojo/_base/declare", "dojo/_base/connect", "dojo/dom-geometry", "./Invisible", "../scaler/common", "../scaler/linear", "./common", "dojox/gfx", "dojox/lang/utils", "dojox/lang/functional"], function (lang, arr, has, _1aa, _1ab, _1ac, _1ad, _1ae, lin, _1af, g, du, df) {
                var _1b0 = 45;
                return _1aa("dojox.charting.axis2d.Default", _1ad, {
                    defaultParams: {
                        vertical: false,
                        fixUpper: "none",
                        fixLower: "none",
                        natural: false,
                        leftBottom: true,
                        includeZero: false,
                        fixed: true,
                        majorLabels: true,
                        minorTicks: true,
                        minorLabels: true,
                        microTicks: false,
                        rotation: 0,
                        htmlLabels: true,
                        enableCache: false,
                        dropLabels: true,
                        labelSizeChange: false
                    },
                    optionalParams: {
                        min: 0,
                        max: 1,
                        from: 0,
                        to: 1,
                        majorTickStep: 4,
                        minorTickStep: 2,
                        microTickStep: 1,
                        labels: [],
                        labelFunc: null,
                        maxLabelSize: 0,
                        maxLabelCharCount: 0,
                        trailingSymbol: null,
                        stroke: {},
                        majorTick: {},
                        minorTick: {},
                        microTick: {},
                        tick: {},
                        font: "",
                        fontColor: "",
                        title: "",
                        titleGap: 0,
                        titleFont: "",
                        titleFontColor: "",
                        titleOrientation: ""
                    },
                    constructor: function (_1b1, _1b2) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _1b2);
                        du.updateWithPattern(this.opt, _1b2, this.optionalParams);
                        if (this.opt.enableCache) {
                            this._textFreePool = [];
                            this._lineFreePool = [];
                            this._textUsePool = [];
                            this._lineUsePool = [];
                        }
                        this._invalidMaxLabelSize = true;
                    },
                    setWindow: function (_1b3, _1b4) {
                        if (_1b3 != this.scale) {
                            this._invalidMaxLabelSize = true;
                        }
                        return this.inherited(arguments);
                    },
                    _groupLabelWidth: function (_1b5, font, _1b6) {
                        if (!_1b5.length) {
                            return 0;
                        }
                        if (_1b5.length > 50) {
                            _1b5.length = 50;
                        }
                        if (lang.isObject(_1b5[0])) {
                            _1b5 = df.map(_1b5, function (_1b7) {
                                return _1b7.text;
                            });
                        }
                        if (_1b6) {
                            _1b5 = df.map(_1b5, function (_1b8) {
                                return lang.trim(_1b8).length == 0 ? "" : _1b8.substring(0, _1b6) + this.trailingSymbol;
                            }, this);
                        }
                        var s = _1b5.join("<br>");
                        return g._base._getTextBox(s, {
                            font: font
                        }).w || 0;
                    },
                    _getMaxLabelSize: function (min, max, span, _1b9, font, size) {
                        if (this._maxLabelSize == null && arguments.length == 6) {
                            var o = this.opt;
                            this.scaler.minMinorStep = this._prevMinMinorStep = 0;
                            var ob = lang.clone(o);
                            delete ob.to;
                            delete ob.from;
                            var sb = lin.buildScaler(min, max, span, ob, o.to - o.from);
                            sb.minMinorStep = 0;
                            this._majorStart = sb.major.start;
                            var tb = lin.buildTicks(sb, o);
                            if (size && tb) {
                                var _1ba = 0,
                                    _1bb = 0;
                                var _1bc = function (tick) {
                                    if (tick.label) {
                                        this.push(tick.label);
                                    }
                                };
                                var _1bd = [];
                                if (this.opt.majorLabels) {
                                    arr.forEach(tb.major, _1bc, _1bd);
                                    _1ba = this._groupLabelWidth(_1bd, font, ob.maxLabelCharCount);
                                    if (ob.maxLabelSize) {
                                        _1ba = Math.min(ob.maxLabelSize, _1ba);
                                    }
                                }
                                _1bd = [];
                                if (this.opt.dropLabels && this.opt.minorLabels) {
                                    arr.forEach(tb.minor, _1bc, _1bd);
                                    _1bb = this._groupLabelWidth(_1bd, font, ob.maxLabelCharCount);
                                    if (ob.maxLabelSize) {
                                        _1bb = Math.min(ob.maxLabelSize, _1bb);
                                    }
                                }
                                this._maxLabelSize = {
                                    majLabelW: _1ba,
                                    minLabelW: _1bb,
                                    majLabelH: size,
                                    minLabelH: size
                                };
                            } else {
                                this._maxLabelSize = null;
                            }
                        }
                        return this._maxLabelSize;
                    },
                    calculate: function (min, max, span) {
                        this.inherited(arguments);
                        this.scaler.minMinorStep = this._prevMinMinorStep;
                        if ((this._invalidMaxLabelSize || span != this._oldSpan) && (min != Infinity && max != -Infinity)) {
                            this._invalidMaxLabelSize = false;
                            if (this.opt.labelSizeChange) {
                                this._maxLabelSize = null;
                            }
                            this._oldSpan = span;
                            var o = this.opt;
                            var ta = this.chart.theme.axis,
                                _1be = o.rotation % 360,
                                _1bf = this.chart.theme.axis.tick.labelGap,
                                font = o.font || (ta.majorTick && ta.majorTick.font) || (ta.tick && ta.tick.font),
                                size = font ? g.normalizedLength(g.splitFontString(font).size) : 0,
                                _1c0 = this._getMaxLabelSize(min, max, span, _1be, font, size);
                            if (typeof _1bf != "number") {
                                _1bf = 4;
                            }
                            if (_1c0 && o.dropLabels) {
                                var cosr = Math.abs(Math.cos(_1be * Math.PI / 180)),
                                    sinr = Math.abs(Math.sin(_1be * Math.PI / 180));
                                var _1c1, _1c2;
                                if (_1be < 0) {
                                    _1be += 360;
                                }
                                switch (_1be) {
                                case 0:
                                case 180:
                                    if (this.vertical) {
                                        _1c1 = _1c2 = size;
                                    } else {
                                        _1c1 = _1c0.majLabelW;
                                        _1c2 = _1c0.minLabelW;
                                    }
                                    break;
                                case 90:
                                case 270:
                                    if (this.vertical) {
                                        _1c1 = _1c0.majLabelW;
                                        _1c2 = _1c0.minLabelW;
                                    } else {
                                        _1c1 = _1c2 = size;
                                    }
                                    break;
                                default:
                                    _1c1 = this.vertical ? Math.min(_1c0.majLabelW, size / cosr) : Math.min(_1c0.majLabelW, size / sinr);
                                    var gap1 = Math.sqrt(_1c0.minLabelW * _1c0.minLabelW + size * size),
                                        gap2 = this.vertical ? size * cosr + _1c0.minLabelW * sinr : _1c0.minLabelW * cosr + size * sinr;
                                    _1c2 = Math.min(gap1, gap2);
                                    break;
                                }
                                this.scaler.minMinorStep = this._prevMinMinorStep = Math.max(_1c1, _1c2) + _1bf;
                                var _1c3 = this.scaler.minMinorStep <= this.scaler.minor.tick * this.scaler.bounds.scale;
                                if (!_1c3) {
                                    this._skipInterval = Math.floor((_1c1 + _1bf) / (this.scaler.major.tick * this.scaler.bounds.scale));
                                } else {
                                    this._skipInterval = 0;
                                }
                            } else {
                                this._skipInterval = 0;
                            }
                        }
                        this.ticks = lin.buildTicks(this.scaler, this.opt);
                        return this;
                    },
                    getOffsets: function () {
                        var s = this.scaler,
                            _1c4 = {
                                l: 0,
                                r: 0,
                                t: 0,
                                b: 0
                            };
                        if (!s) {
                            return _1c4;
                        }
                        var o = this.opt,
                            a, b, c, d, gl = _1ae.getNumericLabel,
                            _1c5 = 0,
                            ma = s.major,
                            mi = s.minor,
                            ta = this.chart.theme.axis,
                            _1c6 = this.chart.theme.axis.tick.labelGap,
                            _1c7 = o.titleFont || (ta.title && ta.title.font),
                            _1c8 = (o.titleGap == 0) ? 0 : o.titleGap || (ta.title && ta.title.gap),
                            _1c9 = this.chart.theme.getTick("major", o),
                            _1ca = this.chart.theme.getTick("minor", o),
                            _1cb = _1c7 ? g.normalizedLength(g.splitFontString(_1c7).size) : 0,
                            _1cc = o.rotation % 360,
                            _1cd = o.leftBottom,
                            cosr = Math.abs(Math.cos(_1cc * Math.PI / 180)),
                            sinr = Math.abs(Math.sin(_1cc * Math.PI / 180));
                        this.trailingSymbol = (o.trailingSymbol === undefined || o.trailingSymbol === null) ? this.trailingSymbol : o.trailingSymbol;
                        if (typeof _1c6 != "number") {
                            _1c6 = 4;
                        }
                        if (_1cc < 0) {
                            _1cc += 360;
                        }
                        var _1ce = this._getMaxLabelSize();
                        if (_1ce) {
                            var side;
                            var _1cf = Math.ceil(Math.max(_1ce.majLabelW, _1ce.minLabelW)) + 1,
                                size = Math.ceil(Math.max(_1ce.majLabelH, _1ce.minLabelH)) + 1;
                            if (this.vertical) {
                                side = _1cd ? "l" : "r";
                                switch (_1cc) {
                                case 0:
                                case 180:
                                    _1c4[side] = _1cf;
                                    _1c4.t = _1c4.b = size / 2;
                                    break;
                                case 90:
                                case 270:
                                    _1c4[side] = size;
                                    _1c4.t = _1c4.b = _1cf / 2;
                                    break;
                                default:
                                    if (_1cc <= _1b0 || (180 < _1cc && _1cc <= (180 + _1b0))) {
                                        _1c4[side] = size * sinr / 2 + _1cf * cosr;
                                        _1c4[_1cd ? "t" : "b"] = size * cosr / 2 + _1cf * sinr;
                                        _1c4[_1cd ? "b" : "t"] = size * cosr / 2;
                                    } else {
                                        if (_1cc > (360 - _1b0) || (180 > _1cc && _1cc > (180 - _1b0))) {
                                            _1c4[side] = size * sinr / 2 + _1cf * cosr;
                                            _1c4[_1cd ? "b" : "t"] = size * cosr / 2 + _1cf * sinr;
                                            _1c4[_1cd ? "t" : "b"] = size * cosr / 2;
                                        } else {
                                            if (_1cc < 90 || (180 < _1cc && _1cc < 270)) {
                                                _1c4[side] = size * sinr + _1cf * cosr;
                                                _1c4[_1cd ? "t" : "b"] = size * cosr + _1cf * sinr;
                                            } else {
                                                _1c4[side] = size * sinr + _1cf * cosr;
                                                _1c4[_1cd ? "b" : "t"] = size * cosr + _1cf * sinr;
                                            }
                                        }
                                    }
                                    break;
                                }
                                _1c4[side] += _1c6 + Math.max(_1c9.length, _1ca.length) + (o.title ? (_1cb + _1c8) : 0);
                            } else {
                                side = _1cd ? "b" : "t";
                                switch (_1cc) {
                                case 0:
                                case 180:
                                    _1c4[side] = size;
                                    _1c4.l = _1c4.r = _1cf / 2;
                                    break;
                                case 90:
                                case 270:
                                    _1c4[side] = _1cf;
                                    _1c4.l = _1c4.r = size / 2;
                                    break;
                                default:
                                    if ((90 - _1b0) <= _1cc && _1cc <= 90 || (270 - _1b0) <= _1cc && _1cc <= 270) {
                                        _1c4[side] = size * cosr / 2 + _1cf * sinr;
                                        _1c4[_1cd ? "r" : "l"] = size * sinr / 2 + _1cf * cosr;
                                        _1c4[_1cd ? "l" : "r"] = size * sinr / 2;
                                    } else {
                                        if (90 <= _1cc && _1cc <= (90 + _1b0) || 270 <= _1cc && _1cc <= (270 + _1b0)) {
                                            _1c4[side] = size * cosr / 2 + _1cf * sinr;
                                            _1c4[_1cd ? "l" : "r"] = size * sinr / 2 + _1cf * cosr;
                                            _1c4[_1cd ? "r" : "l"] = size * sinr / 2;
                                        } else {
                                            if (_1cc < _1b0 || (180 < _1cc && _1cc < (180 + _1b0))) {
                                                _1c4[side] = size * cosr + _1cf * sinr;
                                                _1c4[_1cd ? "r" : "l"] = size * sinr + _1cf * cosr;
                                            } else {
                                                _1c4[side] = size * cosr + _1cf * sinr;
                                                _1c4[_1cd ? "l" : "r"] = size * sinr + _1cf * cosr;
                                            }
                                        }
                                    }
                                    break;
                                }
                                _1c4[side] += _1c6 + Math.max(_1c9.length, _1ca.length) + (o.title ? (_1cb + _1c8) : 0);
                            }
                        }
                        return _1c4;
                    },
                    cleanGroup: function (_1d0) {
                        if (this.opt.enableCache && this.group) {
                            this._lineFreePool = this._lineFreePool.concat(this._lineUsePool);
                            this._lineUsePool = [];
                            this._textFreePool = this._textFreePool.concat(this._textUsePool);
                            this._textUsePool = [];
                        }
                        this.inherited(arguments);
                    },
                    createText: function (_1d1, _1d2, x, y, _1d3, _1d4, font, _1d5, _1d6) {
                        if (!this.opt.enableCache || _1d1 == "html") {
                            return _1af.createText[_1d1](this.chart, _1d2, x, y, _1d3, _1d4, font, _1d5, _1d6);
                        }
                        var text;
                        if (this._textFreePool.length > 0) {
                            text = this._textFreePool.pop();
                            text.setShape({
                                x: x,
                                y: y,
                                text: _1d4,
                                align: _1d3
                            });
                            _1d2.add(text);
                        } else {
                            text = _1af.createText[_1d1](this.chart, _1d2, x, y, _1d3, _1d4, font, _1d5);
                        }
                        this._textUsePool.push(text);
                        return text;
                    },
                    createLine: function (_1d7, _1d8) {
                        var line;
                        if (this.opt.enableCache && this._lineFreePool.length > 0) {
                            line = this._lineFreePool.pop();
                            line.setShape(_1d8);
                            _1d7.add(line);
                        } else {
                            line = _1d7.createLine(_1d8);
                        } if (this.opt.enableCache) {
                            this._lineUsePool.push(line);
                        }
                        return line;
                    },
                    render: function (dim, _1d9) {
                        if (!this.dirty || !this.scaler) {
                            return this;
                        }
                        var o = this.opt,
                            ta = this.chart.theme.axis,
                            _1da = o.leftBottom,
                            _1db = o.rotation % 360,
                            _1dc, stop, _1dd, _1de = 0,
                            _1df, _1e0, _1e1, _1e2, _1e3, _1e4, _1e5 = this.chart.theme.axis.tick.labelGap,
                            _1e6 = o.font || (ta.majorTick && ta.majorTick.font) || (ta.tick && ta.tick.font),
                            _1e7 = o.titleFont || (ta.title && ta.title.font),
                            _1e8 = o.fontColor || (ta.majorTick && ta.majorTick.fontColor) || (ta.tick && ta.tick.fontColor) || "black",
                            _1e9 = o.titleFontColor || (ta.title && ta.title.fontColor) || "black",
                            _1ea = (o.titleGap == 0) ? 0 : o.titleGap || (ta.title && ta.title.gap) || 15,
                            _1eb = o.titleOrientation || (ta.title && ta.title.orientation) || "axis",
                            _1ec = this.chart.theme.getTick("major", o),
                            _1ed = this.chart.theme.getTick("minor", o),
                            _1ee = this.chart.theme.getTick("micro", o),
                            _1ef = Math.max(_1ec.length, _1ed.length, _1ee.length),
                            _1f0 = "stroke" in o ? o.stroke : ta.stroke,
                            size = _1e6 ? g.normalizedLength(g.splitFontString(_1e6).size) : 0,
                            cosr = Math.abs(Math.cos(_1db * Math.PI / 180)),
                            sinr = Math.abs(Math.sin(_1db * Math.PI / 180)),
                            _1f1 = _1e7 ? g.normalizedLength(g.splitFontString(_1e7).size) : 0;
                        if (typeof _1e5 != "number") {
                            _1e5 = 4;
                        }
                        if (_1db < 0) {
                            _1db += 360;
                        }
                        var _1f2 = this._getMaxLabelSize();
                        _1f2 = _1f2 && _1f2.majLabelW;
                        if (this.vertical) {
                            _1dc = {
                                y: dim.height - _1d9.b
                            };
                            stop = {
                                y: _1d9.t
                            };
                            _1dd = {
                                y: (dim.height - _1d9.b + _1d9.t) / 2
                            };
                            _1df = size * sinr + (_1f2 || 0) * cosr + _1e5 + Math.max(_1ec.length, _1ed.length) + _1f1 + _1ea;
                            _1e0 = {
                                x: 0,
                                y: -1
                            };
                            _1e3 = {
                                x: 0,
                                y: 0
                            };
                            _1e1 = {
                                x: 1,
                                y: 0
                            };
                            _1e2 = {
                                x: _1e5,
                                y: 0
                            };
                            switch (_1db) {
                            case 0:
                                _1e4 = "end";
                                _1e3.y = size * 0.4;
                                break;
                            case 90:
                                _1e4 = "middle";
                                _1e3.x = -size;
                                break;
                            case 180:
                                _1e4 = "start";
                                _1e3.y = -size * 0.4;
                                break;
                            case 270:
                                _1e4 = "middle";
                                break;
                            default:
                                if (_1db < _1b0) {
                                    _1e4 = "end";
                                    _1e3.y = size * 0.4;
                                } else {
                                    if (_1db < 90) {
                                        _1e4 = "end";
                                        _1e3.y = size * 0.4;
                                    } else {
                                        if (_1db < (180 - _1b0)) {
                                            _1e4 = "start";
                                        } else {
                                            if (_1db < (180 + _1b0)) {
                                                _1e4 = "start";
                                                _1e3.y = -size * 0.4;
                                            } else {
                                                if (_1db < 270) {
                                                    _1e4 = "start";
                                                    _1e3.x = _1da ? 0 : size * 0.4;
                                                } else {
                                                    if (_1db < (360 - _1b0)) {
                                                        _1e4 = "end";
                                                        _1e3.x = _1da ? 0 : size * 0.4;
                                                    } else {
                                                        _1e4 = "end";
                                                        _1e3.y = size * 0.4;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if (_1da) {
                                _1dc.x = stop.x = _1d9.l;
                                _1de = (_1eb && _1eb == "away") ? 90 : 270;
                                _1dd.x = _1d9.l - _1df + (_1de == 270 ? _1f1 : 0);
                                _1e1.x = -1;
                                _1e2.x = -_1e2.x;
                            } else {
                                _1dc.x = stop.x = dim.width - _1d9.r;
                                _1de = (_1eb && _1eb == "axis") ? 90 : 270;
                                _1dd.x = dim.width - _1d9.r + _1df - (_1de == 270 ? 0 : _1f1);
                                switch (_1e4) {
                                case "start":
                                    _1e4 = "end";
                                    break;
                                case "end":
                                    _1e4 = "start";
                                    break;
                                case "middle":
                                    _1e3.x += size;
                                    break;
                                }
                            }
                        } else {
                            _1dc = {
                                x: _1d9.l
                            };
                            stop = {
                                x: dim.width - _1d9.r
                            };
                            _1dd = {
                                x: (dim.width - _1d9.r + _1d9.l) / 2
                            };
                            _1df = size * cosr + (_1f2 || 0) * sinr + _1e5 + Math.max(_1ec.length, _1ed.length) + _1f1 + _1ea;
                            _1e0 = {
                                x: 1,
                                y: 0
                            };
                            _1e3 = {
                                x: 0,
                                y: 0
                            };
                            _1e1 = {
                                x: 0,
                                y: 1
                            };
                            _1e2 = {
                                x: 0,
                                y: _1e5
                            };
                            switch (_1db) {
                            case 0:
                                _1e4 = "middle";
                                _1e3.y = size;
                                break;
                            case 90:
                                _1e4 = "start";
                                _1e3.x = -size * 0.4;
                                break;
                            case 180:
                                _1e4 = "middle";
                                break;
                            case 270:
                                _1e4 = "end";
                                _1e3.x = size * 0.4;
                                break;
                            default:
                                if (_1db < (90 - _1b0)) {
                                    _1e4 = "start";
                                    _1e3.y = _1da ? size : 0;
                                } else {
                                    if (_1db < (90 + _1b0)) {
                                        _1e4 = "start";
                                        _1e3.x = -size * 0.4;
                                    } else {
                                        if (_1db < 180) {
                                            _1e4 = "start";
                                            _1e3.y = _1da ? 0 : -size;
                                        } else {
                                            if (_1db < (270 - _1b0)) {
                                                _1e4 = "end";
                                                _1e3.y = _1da ? 0 : -size;
                                            } else {
                                                if (_1db < (270 + _1b0)) {
                                                    _1e4 = "end";
                                                    _1e3.y = _1da ? size * 0.4 : 0;
                                                } else {
                                                    _1e4 = "end";
                                                    _1e3.y = _1da ? size : 0;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if (_1da) {
                                _1dc.y = stop.y = dim.height - _1d9.b;
                                _1de = (_1eb && _1eb == "axis") ? 180 : 0;
                                _1dd.y = dim.height - _1d9.b + _1df - (_1de ? _1f1 : 0);
                            } else {
                                _1dc.y = stop.y = _1d9.t;
                                _1de = (_1eb && _1eb == "away") ? 180 : 0;
                                _1dd.y = _1d9.t - _1df + (_1de ? 0 : _1f1);
                                _1e1.y = -1;
                                _1e2.y = -_1e2.y;
                                switch (_1e4) {
                                case "start":
                                    _1e4 = "end";
                                    break;
                                case "end":
                                    _1e4 = "start";
                                    break;
                                case "middle":
                                    _1e3.y -= size;
                                    break;
                                }
                            }
                        }
                        this.cleanGroup();
                        var s = this.group,
                            c = this.scaler,
                            t = this.ticks,
                            f = lin.getTransformerFromModel(this.scaler),
                            _1f3 = (!o.title || !_1de) && !_1db && this.opt.htmlLabels && !has("ie") && !has("opera") ? "html" : "gfx",
                            dx = _1e1.x * _1ec.length,
                            dy = _1e1.y * _1ec.length,
                            skip = this._skipInterval;
                        s.createLine({
                            x1: _1dc.x,
                            y1: _1dc.y,
                            x2: stop.x,
                            y2: stop.y
                        }).setStroke(_1f0);
                        if (o.title) {
                            var _1f4 = _1af.createText[_1f3](this.chart, s, _1dd.x, _1dd.y, "middle", o.title, _1e7, _1e9);
                            if (_1f3 == "html") {
                                this.htmlElements.push(_1f4);
                            } else {
                                _1f4.setTransform(g.matrix.rotategAt(_1de, _1dd.x, _1dd.y));
                            }
                        }
                        if (t == null) {
                            this.dirty = false;
                            return this;
                        }
                        var rel = (t.major.length > 0) ? (t.major[0].value - this._majorStart) / c.major.tick : 0;
                        var _1f5 = this.opt.majorLabels;
                        arr.forEach(t.major, function (tick, i) {
                            var _1f6 = f(tick.value),
                                elem, x = _1dc.x + _1e0.x * _1f6,
                                y = _1dc.y + _1e0.y * _1f6;
                            i += rel;
                            this.createLine(s, {
                                x1: x,
                                y1: y,
                                x2: x + dx,
                                y2: y + dy
                            }).setStroke(_1ec);
                            if (tick.label && (!skip || (i - (1 + skip)) % (1 + skip) == 0)) {
                                var _1f7 = o.maxLabelCharCount ? this.getTextWithLimitCharCount(tick.label, _1e6, o.maxLabelCharCount) : {
                                    text: tick.label,
                                    truncated: false
                                };
                                _1f7 = o.maxLabelSize ? this.getTextWithLimitLength(_1f7.text, _1e6, o.maxLabelSize, _1f7.truncated) : _1f7;
                                elem = this.createText(_1f3, s, x + dx + _1e2.x + (_1db ? 0 : _1e3.x), y + dy + _1e2.y + (_1db ? 0 : _1e3.y), _1e4, _1f7.text, _1e6, _1e8);
                                if (this.chart.truncateBidi && _1f7.truncated) {
                                    this.chart.truncateBidi(elem, tick.label, _1f3);
                                }
                                _1f7.truncated && this.labelTooltip(elem, this.chart, tick.label, _1f7.text, _1e6, _1f3);
                                if (_1f3 == "html") {
                                    this.htmlElements.push(elem);
                                } else {
                                    if (_1db) {
                                        elem.setTransform([{
                                                dx: _1e3.x,
                                                dy: _1e3.y
                                            },
                                            g.matrix.rotategAt(_1db, x + dx + _1e2.x, y + dy + _1e2.y)
                                        ]);
                                    }
                                }
                            }
                        }, this);
                        dx = _1e1.x * _1ed.length;
                        dy = _1e1.y * _1ed.length;
                        _1f5 = this.opt.minorLabels && c.minMinorStep <= c.minor.tick * c.bounds.scale;
                        arr.forEach(t.minor, function (tick) {
                            var _1f8 = f(tick.value),
                                elem, x = _1dc.x + _1e0.x * _1f8,
                                y = _1dc.y + _1e0.y * _1f8;
                            this.createLine(s, {
                                x1: x,
                                y1: y,
                                x2: x + dx,
                                y2: y + dy
                            }).setStroke(_1ed);
                            if (_1f5 && tick.label) {
                                var _1f9 = o.maxLabelCharCount ? this.getTextWithLimitCharCount(tick.label, _1e6, o.maxLabelCharCount) : {
                                    text: tick.label,
                                    truncated: false
                                };
                                _1f9 = o.maxLabelSize ? this.getTextWithLimitLength(_1f9.text, _1e6, o.maxLabelSize, _1f9.truncated) : _1f9;
                                elem = this.createText(_1f3, s, x + dx + _1e2.x + (_1db ? 0 : _1e3.x), y + dy + _1e2.y + (_1db ? 0 : _1e3.y), _1e4, _1f9.text, _1e6, _1e8);
                                if (this.chart.getTextDir && _1f9.truncated) {
                                    this.chart.truncateBidi(elem, tick.label, _1f3);
                                }
                                _1f9.truncated && this.labelTooltip(elem, this.chart, tick.label, _1f9.text, _1e6, _1f3);
                                if (_1f3 == "html") {
                                    this.htmlElements.push(elem);
                                } else {
                                    if (_1db) {
                                        elem.setTransform([{
                                                dx: _1e3.x,
                                                dy: _1e3.y
                                            },
                                            g.matrix.rotategAt(_1db, x + dx + _1e2.x, y + dy + _1e2.y)
                                        ]);
                                    }
                                }
                            }
                        }, this);
                        dx = _1e1.x * _1ee.length;
                        dy = _1e1.y * _1ee.length;
                        arr.forEach(t.micro, function (tick) {
                            var _1fa = f(tick.value),
                                elem, x = _1dc.x + _1e0.x * _1fa,
                                y = _1dc.y + _1e0.y * _1fa;
                            this.createLine(s, {
                                x1: x,
                                y1: y,
                                x2: x + dx,
                                y2: y + dy
                            }).setStroke(_1ee);
                        }, this);
                        this.dirty = false;
                        return this;
                    },
                    labelTooltip: function (elem, _1fb, _1fc, _1fd, font, _1fe) {
                        var _1ff = ["dijit/Tooltip"];
                        var _200 = {
                            type: "rect"
                        }, _201 = ["above", "below"],
                            _202 = g._base._getTextBox(_1fd, {
                                font: font
                            }).w || 0,
                            _203 = font ? g.normalizedLength(g.splitFontString(font).size) : 0;
                        if (_1fe == "html") {
                            lang.mixin(_200, _1ac.position(elem.firstChild, true));
                            _200.width = Math.ceil(_202);
                            _200.height = Math.ceil(_203);
                            this._events.push({
                                shape: dojo,
                                handle: _1ab.connect(elem.firstChild, "onmouseover", this, function (e) {
                                    require(_1ff, function (_204) {
                                        _204.show(_1fc, _200, _201);
                                    });
                                })
                            });
                            this._events.push({
                                shape: dojo,
                                handle: _1ab.connect(elem.firstChild, "onmouseout", this, function (e) {
                                    require(_1ff, function (_205) {
                                        _205.hide(_200);
                                    });
                                })
                            });
                        } else {
                            var shp = elem.getShape(),
                                lt = _1fb.getCoords();
                            _200 = lang.mixin(_200, {
                                x: shp.x - _202 / 2,
                                y: shp.y
                            });
                            _200.x += lt.x;
                            _200.y += lt.y;
                            _200.x = Math.round(_200.x);
                            _200.y = Math.round(_200.y);
                            _200.width = Math.ceil(_202);
                            _200.height = Math.ceil(_203);
                            this._events.push({
                                shape: elem,
                                handle: elem.connect("onmouseenter", this, function (e) {
                                    require(_1ff, function (_206) {
                                        _206.show(_1fc, _200, _201);
                                    });
                                })
                            });
                            this._events.push({
                                shape: elem,
                                handle: elem.connect("onmouseleave", this, function (e) {
                                    require(_1ff, function (_207) {
                                        _207.hide(_200);
                                    });
                                })
                            });
                        }
                    }
                });
            });
        },
        "dojox/charting/axis2d/Invisible": function () {
            define("dojox/charting/axis2d/Invisible", ["dojo/_base/lang", "dojo/_base/declare", "./Base", "../scaler/linear", "dojox/gfx", "dojox/lang/utils"], function (lang, _208, Base, lin, g, du) {
                return _208("dojox.charting.axis2d.Invisible", Base, {
                    defaultParams: {
                        vertical: false,
                        fixUpper: "none",
                        fixLower: "none",
                        natural: false,
                        leftBottom: true,
                        includeZero: false,
                        fixed: true
                    },
                    optionalParams: {
                        min: 0,
                        max: 1,
                        from: 0,
                        to: 1,
                        majorTickStep: 4,
                        minorTickStep: 2,
                        microTickStep: 1
                    },
                    constructor: function (_209, _20a) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _20a);
                        du.updateWithPattern(this.opt, _20a, this.optionalParams);
                    },
                    dependOnData: function () {
                        return !("min" in this.opt) || !("max" in this.opt);
                    },
                    clear: function () {
                        delete this.scaler;
                        delete this.ticks;
                        this.dirty = true;
                        return this;
                    },
                    initialized: function () {
                        return "scaler" in this && !(this.dirty && this.dependOnData());
                    },
                    setWindow: function (_20b, _20c) {
                        this.scale = _20b;
                        this.offset = _20c;
                        return this.clear();
                    },
                    getWindowScale: function () {
                        return "scale" in this ? this.scale : 1;
                    },
                    getWindowOffset: function () {
                        return "offset" in this ? this.offset : 0;
                    },
                    calculate: function (min, max, span) {
                        if (this.initialized()) {
                            return this;
                        }
                        var o = this.opt;
                        this.labels = o.labels;
                        this.scaler = lin.buildScaler(min, max, span, o);
                        var tsb = this.scaler.bounds;
                        if ("scale" in this) {
                            o.from = tsb.lower + this.offset;
                            o.to = (tsb.upper - tsb.lower) / this.scale + o.from;
                            if (!isFinite(o.from) || isNaN(o.from) || !isFinite(o.to) || isNaN(o.to) || o.to - o.from >= tsb.upper - tsb.lower) {
                                delete o.from;
                                delete o.to;
                                delete this.scale;
                                delete this.offset;
                            } else {
                                if (o.from < tsb.lower) {
                                    o.to += tsb.lower - o.from;
                                    o.from = tsb.lower;
                                } else {
                                    if (o.to > tsb.upper) {
                                        o.from += tsb.upper - o.to;
                                        o.to = tsb.upper;
                                    }
                                }
                                this.offset = o.from - tsb.lower;
                            }
                            this.scaler = lin.buildScaler(min, max, span, o);
                            tsb = this.scaler.bounds;
                            if (this.scale == 1 && this.offset == 0) {
                                delete this.scale;
                                delete this.offset;
                            }
                        }
                        return this;
                    },
                    getScaler: function () {
                        return this.scaler;
                    },
                    getTicks: function () {
                        return this.ticks;
                    }
                });
            });
        },
        "dojox/charting/axis2d/Base": function () {
            define("dojox/charting/axis2d/Base", ["dojo/_base/declare", "../Element"], function (_20d, _20e) {
                return _20d("dojox.charting.axis2d.Base", _20e, {
                    constructor: function (_20f, _210) {
                        this.vertical = _210 && _210.vertical;
                        this.opt = {};
                        this.opt.min = _210 && _210.min;
                        this.opt.max = _210 && _210.max;
                    },
                    clear: function () {
                        return this;
                    },
                    initialized: function () {
                        return false;
                    },
                    calculate: function (min, max, span) {
                        return this;
                    },
                    getScaler: function () {
                        return null;
                    },
                    getTicks: function () {
                        return null;
                    },
                    getOffsets: function () {
                        return {
                            l: 0,
                            r: 0,
                            t: 0,
                            b: 0
                        };
                    },
                    render: function (dim, _211) {
                        this.dirty = false;
                        return this;
                    }
                });
            });
        },
        "dojox/charting/scaler/linear": function () {
            define("dojox/charting/scaler/linear", ["dojo/_base/lang", "./common"], function (lang, _212) {
                var _213 = lang.getObject("dojox.charting.scaler.linear", true);
                var _214 = 3,
                    _215 = _212.getNumericLabel;

                function _216(val, text) {
                    val = val.toLowerCase();
                    for (var i = text.length - 1; i >= 0; --i) {
                        if (val === text[i]) {
                            return true;
                        }
                    }
                    return false;
                };
                var _217 = function (min, max, _218, _219, _21a, _21b, span) {
                    _218 = lang.delegate(_218);
                    if (!_219) {
                        if (_218.fixUpper == "major") {
                            _218.fixUpper = "minor";
                        }
                        if (_218.fixLower == "major") {
                            _218.fixLower = "minor";
                        }
                    }
                    if (!_21a) {
                        if (_218.fixUpper == "minor") {
                            _218.fixUpper = "micro";
                        }
                        if (_218.fixLower == "minor") {
                            _218.fixLower = "micro";
                        }
                    }
                    if (!_21b) {
                        if (_218.fixUpper == "micro") {
                            _218.fixUpper = "none";
                        }
                        if (_218.fixLower == "micro") {
                            _218.fixLower = "none";
                        }
                    }
                    var _21c = _216(_218.fixLower, ["major"]) ? Math.floor(_218.min / _219) * _219 : _216(_218.fixLower, ["minor"]) ? Math.floor(_218.min / _21a) * _21a : _216(_218.fixLower, ["micro"]) ? Math.floor(_218.min / _21b) * _21b : _218.min,
                        _21d = _216(_218.fixUpper, ["major"]) ? Math.ceil(_218.max / _219) * _219 : _216(_218.fixUpper, ["minor"]) ? Math.ceil(_218.max / _21a) * _21a : _216(_218.fixUpper, ["micro"]) ? Math.ceil(_218.max / _21b) * _21b : _218.max;
                    if (_218.useMin) {
                        min = _21c;
                    }
                    if (_218.useMax) {
                        max = _21d;
                    }
                    var _21e = (!_219 || _218.useMin && _216(_218.fixLower, ["major"])) ? min : Math.ceil(min / _219) * _219,
                        _21f = (!_21a || _218.useMin && _216(_218.fixLower, ["major", "minor"])) ? min : Math.ceil(min / _21a) * _21a,
                        _220 = (!_21b || _218.useMin && _216(_218.fixLower, ["major", "minor", "micro"])) ? min : Math.ceil(min / _21b) * _21b,
                        _221 = !_219 ? 0 : (_218.useMax && _216(_218.fixUpper, ["major"]) ? Math.round((max - _21e) / _219) : Math.floor((max - _21e) / _219)) + 1,
                        _222 = !_21a ? 0 : (_218.useMax && _216(_218.fixUpper, ["major", "minor"]) ? Math.round((max - _21f) / _21a) : Math.floor((max - _21f) / _21a)) + 1,
                        _223 = !_21b ? 0 : (_218.useMax && _216(_218.fixUpper, ["major", "minor", "micro"]) ? Math.round((max - _220) / _21b) : Math.floor((max - _220) / _21b)) + 1,
                        _224 = _21a ? Math.round(_219 / _21a) : 0,
                        _225 = _21b ? Math.round(_21a / _21b) : 0,
                        _226 = _219 ? Math.floor(Math.log(_219) / Math.LN10) : 0,
                        _227 = _21a ? Math.floor(Math.log(_21a) / Math.LN10) : 0,
                        _228 = span / (max - min);
                    if (!isFinite(_228)) {
                        _228 = 1;
                    }
                    return {
                        bounds: {
                            lower: _21c,
                            upper: _21d,
                            from: min,
                            to: max,
                            scale: _228,
                            span: span
                        },
                        major: {
                            tick: _219,
                            start: _21e,
                            count: _221,
                            prec: _226
                        },
                        minor: {
                            tick: _21a,
                            start: _21f,
                            count: _222,
                            prec: _227
                        },
                        micro: {
                            tick: _21b,
                            start: _220,
                            count: _223,
                            prec: 0
                        },
                        minorPerMajor: _224,
                        microPerMinor: _225,
                        scaler: _213
                    };
                };
                return lang.mixin(_213, {
                    buildScaler: function (min, max, span, _229, _22a, _22b) {
                        var h = {
                            fixUpper: "none",
                            fixLower: "none",
                            natural: false
                        };
                        if (_229) {
                            if ("fixUpper" in _229) {
                                h.fixUpper = String(_229.fixUpper);
                            }
                            if ("fixLower" in _229) {
                                h.fixLower = String(_229.fixLower);
                            }
                            if ("natural" in _229) {
                                h.natural = Boolean(_229.natural);
                            }
                        }
                        _22b = !_22b || _22b < _214 ? _214 : _22b;
                        if ("min" in _229) {
                            min = _229.min;
                        }
                        if ("max" in _229) {
                            max = _229.max;
                        }
                        if (_229.includeZero) {
                            if (min > 0) {
                                min = 0;
                            }
                            if (max < 0) {
                                max = 0;
                            }
                        }
                        h.min = min;
                        h.useMin = true;
                        h.max = max;
                        h.useMax = true;
                        if ("from" in _229) {
                            min = _229.from;
                            h.useMin = false;
                        }
                        if ("to" in _229) {
                            max = _229.to;
                            h.useMax = false;
                        }
                        if (max <= min) {
                            return _217(min, max, h, 0, 0, 0, span);
                        }
                        if (!_22a) {
                            _22a = max - min;
                        }
                        var mag = Math.floor(Math.log(_22a) / Math.LN10),
                            _22c = _229 && ("majorTickStep" in _229) ? _229.majorTickStep : Math.pow(10, mag),
                            _22d = 0,
                            _22e = 0,
                            _22f;
                        if (_229 && ("minorTickStep" in _229)) {
                            _22d = _229.minorTickStep;
                        } else {
                            do {
                                _22d = _22c / 10;
                                if (!h.natural || _22d > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, 0, span);
                                    if (_22f.bounds.scale * _22f.minor.tick > _22b) {
                                        break;
                                    }
                                }
                                _22d = _22c / 5;
                                if (!h.natural || _22d > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, 0, span);
                                    if (_22f.bounds.scale * _22f.minor.tick > _22b) {
                                        break;
                                    }
                                }
                                _22d = _22c / 2;
                                if (!h.natural || _22d > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, 0, span);
                                    if (_22f.bounds.scale * _22f.minor.tick > _22b) {
                                        break;
                                    }
                                }
                                return _217(min, max, h, _22c, 0, 0, span);
                            } while (false);
                        } if (_229 && ("microTickStep" in _229)) {
                            _22e = _229.microTickStep;
                            _22f = _217(min, max, h, _22c, _22d, _22e, span);
                        } else {
                            do {
                                _22e = _22d / 10;
                                if (!h.natural || _22e > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, _22e, span);
                                    if (_22f.bounds.scale * _22f.micro.tick > _214) {
                                        break;
                                    }
                                }
                                _22e = _22d / 5;
                                if (!h.natural || _22e > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, _22e, span);
                                    if (_22f.bounds.scale * _22f.micro.tick > _214) {
                                        break;
                                    }
                                }
                                _22e = _22d / 2;
                                if (!h.natural || _22e > 0.9) {
                                    _22f = _217(min, max, h, _22c, _22d, _22e, span);
                                    if (_22f.bounds.scale * _22f.micro.tick > _214) {
                                        break;
                                    }
                                }
                                _22e = 0;
                            } while (false);
                        }
                        return _22e ? _22f : _217(min, max, h, _22c, _22d, 0, span);
                    },
                    buildTicks: function (_230, _231) {
                        var step, next, tick, _232 = _230.major.start,
                            _233 = _230.minor.start,
                            _234 = _230.micro.start;
                        if (_231.microTicks && _230.micro.tick) {
                            step = _230.micro.tick, next = _234;
                        } else {
                            if (_231.minorTicks && _230.minor.tick) {
                                step = _230.minor.tick, next = _233;
                            } else {
                                if (_230.major.tick) {
                                    step = _230.major.tick, next = _232;
                                } else {
                                    return null;
                                }
                            }
                        }
                        var _235 = 1 / _230.bounds.scale;
                        if (_230.bounds.to <= _230.bounds.from || isNaN(_235) || !isFinite(_235) || step <= 0 || isNaN(step) || !isFinite(step)) {
                            return null;
                        }
                        var _236 = [],
                            _237 = [],
                            _238 = [];
                        while (next <= _230.bounds.to + _235) {
                            if (Math.abs(_232 - next) < step / 2) {
                                tick = {
                                    value: _232
                                };
                                if (_231.majorLabels) {
                                    tick.label = _215(_232, _230.major.prec, _231);
                                }
                                _236.push(tick);
                                _232 += _230.major.tick;
                                _233 += _230.minor.tick;
                                _234 += _230.micro.tick;
                            } else {
                                if (Math.abs(_233 - next) < step / 2) {
                                    if (_231.minorTicks) {
                                        tick = {
                                            value: _233
                                        };
                                        if (_231.minorLabels && (_230.minMinorStep <= _230.minor.tick * _230.bounds.scale)) {
                                            tick.label = _215(_233, _230.minor.prec, _231);
                                        }
                                        _237.push(tick);
                                    }
                                    _233 += _230.minor.tick;
                                    _234 += _230.micro.tick;
                                } else {
                                    if (_231.microTicks) {
                                        _238.push({
                                            value: _234
                                        });
                                    }
                                    _234 += _230.micro.tick;
                                }
                            }
                            next += step;
                        }
                        return {
                            major: _236,
                            minor: _237,
                            micro: _238
                        };
                    },
                    getTransformerFromModel: function (_239) {
                        var _23a = _239.bounds.from,
                            _23b = _239.bounds.scale;
                        return function (x) {
                            return (x - _23a) * _23b;
                        };
                    },
                    getTransformerFromPlot: function (_23c) {
                        var _23d = _23c.bounds.from,
                            _23e = _23c.bounds.scale;
                        return function (x) {
                            return x / _23e + _23d;
                        };
                    }
                });
            });
        },
        "dojox/charting/scaler/common": function () {
            define("dojox/charting/scaler/common", ["dojo/_base/lang"], function (lang) {
                var eq = function (a, b) {
                    return Math.abs(a - b) <= 0.000001 * (Math.abs(a) + Math.abs(b));
                };
                var _23f = lang.getObject("dojox.charting.scaler.common", true);
                var _240 = {};
                return lang.mixin(_23f, {
                    doIfLoaded: function (_241, _242, _243) {
                        if (_240[_241] == undefined) {
                            try {
                                _240[_241] = require(_241);
                            } catch (e) {
                                _240[_241] = null;
                            }
                        }
                        if (_240[_241]) {
                            return _242(_240[_241]);
                        } else {
                            return _243();
                        }
                    },
                    getNumericLabel: function (_244, _245, _246) {
                        var def = "";
                        _23f.doIfLoaded("dojo/number", function (_247) {
                            def = (_246.fixed ? _247.format(_244, {
                                places: _245 < 0 ? -_245 : 0
                            }) : _247.format(_244)) || "";
                        }, function () {
                            def = _246.fixed ? _244.toFixed(_245 < 0 ? -_245 : 0) : _244.toString();
                        });
                        if (_246.labelFunc) {
                            var r = _246.labelFunc(def, _244, _245);
                            if (r) {
                                return r;
                            }
                        }
                        if (_246.labels) {
                            var l = _246.labels,
                                lo = 0,
                                hi = l.length;
                            while (lo < hi) {
                                var mid = Math.floor((lo + hi) / 2),
                                    val = l[mid].value;
                                if (val < _244) {
                                    lo = mid + 1;
                                } else {
                                    hi = mid;
                                }
                            }
                            if (lo < l.length && eq(l[lo].value, _244)) {
                                return l[lo].text;
                            }--lo;
                            if (lo >= 0 && lo < l.length && eq(l[lo].value, _244)) {
                                return l[lo].text;
                            }
                            lo += 2;
                            if (lo < l.length && eq(l[lo].value, _244)) {
                                return l[lo].text;
                            }
                        }
                        return def;
                    }
                });
            });
        },
        "dojox/charting/plot2d/ClusteredBars": function () {
            define("dojox/charting/plot2d/ClusteredBars", ["dojo/_base/declare", "./Bars", "./common"], function (_248, Bars, dc) {
                return _248("dojox.charting.plot2d.ClusteredBars", Bars, {
                    getBarProperties: function () {
                        var f = dc.calculateBarSize(this._vScaler.bounds.scale, this.opt, this.series.length);
                        return {
                            gap: f.gap,
                            height: f.size,
                            thickness: f.size
                        };
                    }
                });
            });
        },
        "dojox/charting/plot2d/Bars": function () {
            define("dojox/charting/plot2d/Bars", ["dojo/_base/kernel", "dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "./CartesianBase", "./_PlotEvents", "./common", "dojox/gfx/fx", "dojox/lang/utils", "dojox/lang/functional", "dojox/lang/functional/reversed"], function (dojo, lang, arr, _249, _24a, _24b, dc, fx, du, df, dfr) {
                var _24c = dfr.lambda("item.purgeGroup()");
                return _249("dojox.charting.plot2d.Bars", [_24a, _24b], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        gap: 0,
                        animate: null,
                        enableCache: false
                    },
                    optionalParams: {
                        minBarSize: 1,
                        maxBarSize: 1,
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        styleFunc: null,
                        font: "",
                        fontColor: ""
                    },
                    constructor: function (_24d, _24e) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _24e);
                        du.updateWithPattern(this.opt, _24e, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    getSeriesStats: function () {
                        var _24f = dc.collectSimpleStats(this.series),
                            t;
                        _24f.hmin -= 0.5;
                        _24f.hmax += 0.5;
                        t = _24f.hmin, _24f.hmin = _24f.vmin, _24f.vmin = t;
                        t = _24f.hmax, _24f.hmax = _24f.vmax, _24f.vmax = t;
                        return _24f;
                    },
                    createRect: function (run, _250, _251) {
                        var rect;
                        if (this.opt.enableCache && run._rectFreePool.length > 0) {
                            rect = run._rectFreePool.pop();
                            rect.setShape(_251);
                            _250.add(rect);
                        } else {
                            rect = _250.createRect(_251);
                        } if (this.opt.enableCache) {
                            run._rectUsePool.push(rect);
                        }
                        return rect;
                    },
                    render: function (dim, _252) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _252);
                        }
                        this.dirty = this.isDirty();
                        this.resetEvents();
                        var s;
                        if (this.dirty) {
                            arr.forEach(this.series, _24c);
                            this._eventSeries = {};
                            this.cleanGroup();
                            s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                            vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                            _253 = Math.max(0, this._hScaler.bounds.lower),
                            _254 = ht(_253),
                            _255 = this.events();
                        var bar = this.getBarProperties();
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            if (this.opt.enableCache) {
                                run._rectFreePool = (run._rectFreePool ? run._rectFreePool : []).concat(run._rectUsePool ? run._rectUsePool : []);
                                run._rectUsePool = [];
                            }
                            var _256 = t.next("bar", [this.opt, run]),
                                _257 = new Array(run.data.length);
                            s = run.group;
                            var _258 = arr.some(run.data, function (item) {
                                return typeof item == "number" || (item && !item.hasOwnProperty("x"));
                            });
                            var min = _258 ? Math.max(0, Math.floor(this._vScaler.bounds.from - 1)) : 0;
                            var max = _258 ? Math.min(run.data.length, Math.ceil(this._vScaler.bounds.to)) : run.data.length;
                            for (var j = min; j < max; ++j) {
                                var _259 = run.data[j];
                                if (_259 != null) {
                                    var val = this.getValue(_259, j, i, _258),
                                        hv = ht(val.y),
                                        w = Math.abs(hv - _254),
                                        _25a, _25b;
                                    if (this.opt.styleFunc || typeof _259 != "number") {
                                        var _25c = typeof _259 != "number" ? [_259] : [];
                                        if (this.opt.styleFunc) {
                                            _25c.push(this.opt.styleFunc(_259));
                                        }
                                        _25a = t.addMixin(_256, "bar", _25c, true);
                                    } else {
                                        _25a = t.post(_256, "bar");
                                    } if (w >= 0 && bar.height >= 1) {
                                        var rect = {
                                            x: _252.l + (val.y < _253 ? hv : _254),
                                            y: dim.height - _252.b - vt(val.x + 1.5) + bar.gap + bar.thickness * (this.series.length - i - 1),
                                            width: w,
                                            height: bar.height
                                        };
                                        if (_25a.series.shadow) {
                                            var _25d = lang.clone(rect);
                                            _25d.x += _25a.series.shadow.dx;
                                            _25d.y += _25a.series.shadow.dy;
                                            _25b = this.createRect(run, s, _25d).setFill(_25a.series.shadow.color).setStroke(_25a.series.shadow);
                                            if (this.animate) {
                                                this._animateBar(_25b, _252.l + _254, -w);
                                            }
                                        }
                                        var _25e = this._plotFill(_25a.series.fill, dim, _252);
                                        _25e = this._shapeFill(_25e, rect);
                                        var _25f = this.createRect(run, s, rect).setFill(_25e).setStroke(_25a.series.stroke);
                                        run.dyn.fill = _25f.getFill();
                                        run.dyn.stroke = _25f.getStroke();
                                        if (_255) {
                                            var o = {
                                                element: "bar",
                                                index: j,
                                                run: run,
                                                shape: _25f,
                                                shadow: _25b,
                                                x: val.y,
                                                y: val.x + 1.5
                                            };
                                            this._connectEvents(o);
                                            _257[j] = o;
                                        }
                                        if (this.animate) {
                                            this._animateBar(_25f, _252.l + _254, -w);
                                        }
                                    }
                                }
                            }
                            this._eventSeries[run.name] = _257;
                            run.dirty = false;
                        }
                        this.dirty = false;
                        return this;
                    },
                    getValue: function (_260, j, _261, _262) {
                        var y, x;
                        if (_262) {
                            if (typeof _260 == "number") {
                                y = _260;
                            } else {
                                y = _260.y;
                            }
                            x = j;
                        } else {
                            y = _260.y;
                            x = _260.x - 1;
                        }
                        return {
                            y: y,
                            x: x
                        };
                    },
                    getBarProperties: function () {
                        var f = dc.calculateBarSize(this._vScaler.bounds.scale, this.opt);
                        return {
                            gap: f.gap,
                            height: f.size,
                            thickness: 0
                        };
                    },
                    _animateBar: function (_263, _264, _265) {
                        if (_265 == 0) {
                            _265 = 1;
                        }
                        fx.animateTransform(lang.delegate({
                            shape: _263,
                            duration: 1200,
                            transform: [{
                                    name: "translate",
                                    start: [_264 - (_264 / _265), 0],
                                    end: [0, 0]
                                }, {
                                    name: "scale",
                                    start: [1 / _265, 1],
                                    end: [1, 1]
                                }, {
                                    name: "original"
                                }
                            ]
                        }, this.animate)).play();
                    }
                });
            });
        },
        "dojox/charting/plot2d/CartesianBase": function () {
            define("dojox/charting/plot2d/CartesianBase", ["dojo/_base/lang", "dojo/_base/declare", "dojo/_base/connect", "./Base", "../scaler/primitive", "dojox/gfx/fx"], function (lang, _266, hub, Base, _267, fx) {
                return _266("dojox.charting.plot2d.CartesianBase", Base, {
                    constructor: function (_268, _269) {
                        this.axes = ["hAxis", "vAxis"];
                        this.zoom = null, this.zoomQueue = [];
                        this.lastWindow = {
                            vscale: 1,
                            hscale: 1,
                            xoffset: 0,
                            yoffset: 0
                        };
                    },
                    clear: function () {
                        this.inherited(arguments);
                        this._hAxis = null;
                        this._vAxis = null;
                        return this;
                    },
                    cleanGroup: function (_26a) {
                        this.inherited(arguments, [_26a || this.chart.plotGroup]);
                    },
                    setAxis: function (axis) {
                        if (axis) {
                            this[axis.vertical ? "_vAxis" : "_hAxis"] = axis;
                        }
                        return this;
                    },
                    toPage: function (_26b) {
                        var ah = this._hAxis,
                            av = this._vAxis,
                            sh = ah.getScaler(),
                            sv = av.getScaler(),
                            th = sh.scaler.getTransformerFromModel(sh),
                            tv = sv.scaler.getTransformerFromModel(sv),
                            c = this.chart.getCoords(),
                            o = this.chart.offsets,
                            dim = this.chart.dim;
                        var t = function (_26c) {
                            var r = {};
                            r.x = th(_26c[ah.name]) + c.x + o.l;
                            r.y = c.y + dim.height - o.b - tv(_26c[av.name]);
                            return r;
                        };
                        return _26b ? t(_26b) : t;
                    },
                    toData: function (_26d) {
                        var ah = this._hAxis,
                            av = this._vAxis,
                            sh = ah.getScaler(),
                            sv = av.getScaler(),
                            th = sh.scaler.getTransformerFromPlot(sh),
                            tv = sv.scaler.getTransformerFromPlot(sv),
                            c = this.chart.getCoords(),
                            o = this.chart.offsets,
                            dim = this.chart.dim;
                        var t = function (_26e) {
                            var r = {};
                            r[ah.name] = th(_26e.x - c.x - o.l);
                            r[av.name] = tv(c.y + dim.height - _26e.y - o.b);
                            return r;
                        };
                        return _26d ? t(_26d) : t;
                    },
                    isDirty: function () {
                        return this.dirty || this._hAxis && this._hAxis.dirty || this._vAxis && this._vAxis.dirty;
                    },
                    performZoom: function (dim, _26f) {
                        var vs = this._vAxis.scale || 1,
                            hs = this._hAxis.scale || 1,
                            _270 = dim.height - _26f.b,
                            _271 = this._hScaler.bounds,
                            _272 = (_271.from - _271.lower) * _271.scale,
                            _273 = this._vScaler.bounds,
                            _274 = (_273.from - _273.lower) * _273.scale,
                            _275 = vs / this.lastWindow.vscale,
                            _276 = hs / this.lastWindow.hscale,
                            _277 = (this.lastWindow.xoffset - _272) / ((this.lastWindow.hscale == 1) ? hs : this.lastWindow.hscale),
                            _278 = (_274 - this.lastWindow.yoffset) / ((this.lastWindow.vscale == 1) ? vs : this.lastWindow.vscale),
                            _279 = this.group,
                            anim = fx.animateTransform(lang.delegate({
                                shape: _279,
                                duration: 1200,
                                transform: [{
                                        name: "translate",
                                        start: [0, 0],
                                        end: [_26f.l * (1 - _276), _270 * (1 - _275)]
                                    }, {
                                        name: "scale",
                                        start: [1, 1],
                                        end: [_276, _275]
                                    }, {
                                        name: "original"
                                    }, {
                                        name: "translate",
                                        start: [0, 0],
                                        end: [_277, _278]
                                    }
                                ]
                            }, this.zoom));
                        lang.mixin(this.lastWindow, {
                            vscale: vs,
                            hscale: hs,
                            xoffset: _272,
                            yoffset: _274
                        });
                        this.zoomQueue.push(anim);
                        hub.connect(anim, "onEnd", this, function () {
                            this.zoom = null;
                            this.zoomQueue.shift();
                            if (this.zoomQueue.length > 0) {
                                this.zoomQueue[0].play();
                            }
                        });
                        if (this.zoomQueue.length == 1) {
                            this.zoomQueue[0].play();
                        }
                        return this;
                    },
                    initializeScalers: function (dim, _27a) {
                        if (this._hAxis) {
                            if (!this._hAxis.initialized()) {
                                this._hAxis.calculate(_27a.hmin, _27a.hmax, dim.width);
                            }
                            this._hScaler = this._hAxis.getScaler();
                        } else {
                            this._hScaler = _267.buildScaler(_27a.hmin, _27a.hmax, dim.width);
                        } if (this._vAxis) {
                            if (!this._vAxis.initialized()) {
                                this._vAxis.calculate(_27a.vmin, _27a.vmax, dim.height);
                            }
                            this._vScaler = this._vAxis.getScaler();
                        } else {
                            this._vScaler = _267.buildScaler(_27a.vmin, _27a.vmax, dim.height);
                        }
                        return this;
                    }
                });
            });
        },
        "dojox/charting/plot2d/Base": function () {
            define("dojox/charting/plot2d/Base", ["dojo/_base/declare", "../Element", "dojo/_base/array", "./common"], function (_27b, _27c, arr, _27d) {
                return _27b("dojox.charting.plot2d.Base", _27c, {
                    constructor: function (_27e, _27f) {},
                    clear: function () {
                        this.series = [];
                        this.dirty = true;
                        return this;
                    },
                    setAxis: function (axis) {
                        return this;
                    },
                    assignAxes: function (axes) {
                        arr.forEach(this.axes, function (axis) {
                            if (this[axis]) {
                                this.setAxis(axes[this[axis]]);
                            }
                        }, this);
                    },
                    addSeries: function (run) {
                        this.series.push(run);
                        return this;
                    },
                    getSeriesStats: function () {
                        return _27d.collectSimpleStats(this.series);
                    },
                    calculateAxes: function (dim) {
                        this.initializeScalers(dim, this.getSeriesStats());
                        return this;
                    },
                    initializeScalers: function () {
                        return this;
                    },
                    isDataDirty: function () {
                        return arr.some(this.series, function (item) {
                            return item.dirty;
                        });
                    },
                    render: function (dim, _280) {
                        return this;
                    },
                    getRequiredColors: function () {
                        return this.series.length;
                    }
                });
            });
        },
        "dojox/charting/plot2d/common": function () {
            define("dojox/charting/plot2d/common", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/Color", "dojox/gfx", "dojox/lang/functional", "../scaler/common"], function (lang, arr, _281, g, df, sc) {
                var _282 = lang.getObject("dojox.charting.plot2d.common", true);
                return lang.mixin(_282, {
                    doIfLoaded: sc.doIfLoaded,
                    makeStroke: function (_283) {
                        if (!_283) {
                            return _283;
                        }
                        if (typeof _283 == "string" || _283 instanceof _281) {
                            _283 = {
                                color: _283
                            };
                        }
                        return g.makeParameters(g.defaultStroke, _283);
                    },
                    augmentColor: function (_284, _285) {
                        var t = new _281(_284),
                            c = new _281(_285);
                        c.a = t.a;
                        return c;
                    },
                    augmentStroke: function (_286, _287) {
                        var s = _282.makeStroke(_286);
                        if (s) {
                            s.color = _282.augmentColor(s.color, _287);
                        }
                        return s;
                    },
                    augmentFill: function (fill, _288) {
                        var fc, c = new _281(_288);
                        if (typeof fill == "string" || fill instanceof _281) {
                            return _282.augmentColor(fill, _288);
                        }
                        return fill;
                    },
                    defaultStats: {
                        vmin: Number.POSITIVE_INFINITY,
                        vmax: Number.NEGATIVE_INFINITY,
                        hmin: Number.POSITIVE_INFINITY,
                        hmax: Number.NEGATIVE_INFINITY
                    },
                    collectSimpleStats: function (_289) {
                        var _28a = lang.delegate(_282.defaultStats);
                        for (var i = 0; i < _289.length; ++i) {
                            var run = _289[i];
                            for (var j = 0; j < run.data.length; j++) {
                                if (run.data[j] !== null) {
                                    if (typeof run.data[j] == "number") {
                                        var _28b = _28a.vmin,
                                            _28c = _28a.vmax;
                                        if (!("ymin" in run) || !("ymax" in run)) {
                                            arr.forEach(run.data, function (val, i) {
                                                if (val !== null) {
                                                    var x = i + 1,
                                                        y = val;
                                                    if (isNaN(y)) {
                                                        y = 0;
                                                    }
                                                    _28a.hmin = Math.min(_28a.hmin, x);
                                                    _28a.hmax = Math.max(_28a.hmax, x);
                                                    _28a.vmin = Math.min(_28a.vmin, y);
                                                    _28a.vmax = Math.max(_28a.vmax, y);
                                                }
                                            });
                                        }
                                        if ("ymin" in run) {
                                            _28a.vmin = Math.min(_28b, run.ymin);
                                        }
                                        if ("ymax" in run) {
                                            _28a.vmax = Math.max(_28c, run.ymax);
                                        }
                                    } else {
                                        var _28d = _28a.hmin,
                                            _28e = _28a.hmax,
                                            _28b = _28a.vmin,
                                            _28c = _28a.vmax;
                                        if (!("xmin" in run) || !("xmax" in run) || !("ymin" in run) || !("ymax" in run)) {
                                            arr.forEach(run.data, function (val, i) {
                                                if (val !== null) {
                                                    var x = "x" in val ? val.x : i + 1,
                                                        y = val.y;
                                                    if (isNaN(x)) {
                                                        x = 0;
                                                    }
                                                    if (isNaN(y)) {
                                                        y = 0;
                                                    }
                                                    _28a.hmin = Math.min(_28a.hmin, x);
                                                    _28a.hmax = Math.max(_28a.hmax, x);
                                                    _28a.vmin = Math.min(_28a.vmin, y);
                                                    _28a.vmax = Math.max(_28a.vmax, y);
                                                }
                                            });
                                        }
                                        if ("xmin" in run) {
                                            _28a.hmin = Math.min(_28d, run.xmin);
                                        }
                                        if ("xmax" in run) {
                                            _28a.hmax = Math.max(_28e, run.xmax);
                                        }
                                        if ("ymin" in run) {
                                            _28a.vmin = Math.min(_28b, run.ymin);
                                        }
                                        if ("ymax" in run) {
                                            _28a.vmax = Math.max(_28c, run.ymax);
                                        }
                                    }
                                    break;
                                }
                            }
                        }
                        return _28a;
                    },
                    calculateBarSize: function (_28f, opt, _290) {
                        if (!_290) {
                            _290 = 1;
                        }
                        var gap = opt.gap,
                            size = (_28f - 2 * gap) / _290;
                        if ("minBarSize" in opt) {
                            size = Math.max(size, opt.minBarSize);
                        }
                        if ("maxBarSize" in opt) {
                            size = Math.min(size, opt.maxBarSize);
                        }
                        size = Math.max(size, 1);
                        gap = (_28f - size * _290) / 2;
                        return {
                            size: size,
                            gap: gap
                        };
                    },
                    collectStackedStats: function (_291) {
                        var _292 = lang.clone(_282.defaultStats);
                        if (_291.length) {
                            _292.hmin = Math.min(_292.hmin, 1);
                            _292.hmax = df.foldl(_291, "seed, run -> Math.max(seed, run.data.length)", _292.hmax);
                            for (var i = 0; i < _292.hmax; ++i) {
                                var v = _291[0].data[i];
                                v = v && (typeof v == "number" ? v : v.y);
                                if (isNaN(v)) {
                                    v = 0;
                                }
                                _292.vmin = Math.min(_292.vmin, v);
                                for (var j = 1; j < _291.length; ++j) {
                                    var t = _291[j].data[i];
                                    t = t && (typeof t == "number" ? t : t.y);
                                    if (isNaN(t)) {
                                        t = 0;
                                    }
                                    v += t;
                                }
                                _292.vmax = Math.max(_292.vmax, v);
                            }
                        }
                        return _292;
                    },
                    curve: function (a, _293) {
                        var _294 = a.slice(0);
                        if (_293 == "x") {
                            _294[_294.length] = _294[0];
                        }
                        var p = arr.map(_294, function (item, i) {
                            if (i == 0) {
                                return "M" + item.x + "," + item.y;
                            }
                            if (!isNaN(_293)) {
                                var dx = item.x - _294[i - 1].x,
                                    dy = _294[i - 1].y;
                                return "C" + (item.x - (_293 - 1) * (dx / _293)) + "," + dy + " " + (item.x - (dx / _293)) + "," + item.y + " " + item.x + "," + item.y;
                            } else {
                                if (_293 == "X" || _293 == "x" || _293 == "S") {
                                    var p0, p1 = _294[i - 1],
                                        p2 = _294[i],
                                        p3;
                                    var bz1x, bz1y, bz2x, bz2y;
                                    var f = 1 / 6;
                                    if (i == 1) {
                                        if (_293 == "x") {
                                            p0 = _294[_294.length - 2];
                                        } else {
                                            p0 = p1;
                                        }
                                        f = 1 / 3;
                                    } else {
                                        p0 = _294[i - 2];
                                    } if (i == (_294.length - 1)) {
                                        if (_293 == "x") {
                                            p3 = _294[1];
                                        } else {
                                            p3 = p2;
                                        }
                                        f = 1 / 3;
                                    } else {
                                        p3 = _294[i + 1];
                                    }
                                    var p1p2 = Math.sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
                                    var p0p2 = Math.sqrt((p2.x - p0.x) * (p2.x - p0.x) + (p2.y - p0.y) * (p2.y - p0.y));
                                    var p1p3 = Math.sqrt((p3.x - p1.x) * (p3.x - p1.x) + (p3.y - p1.y) * (p3.y - p1.y));
                                    var _295 = p0p2 * f;
                                    var _296 = p1p3 * f;
                                    if (_295 > p1p2 / 2 && _296 > p1p2 / 2) {
                                        _295 = p1p2 / 2;
                                        _296 = p1p2 / 2;
                                    } else {
                                        if (_295 > p1p2 / 2) {
                                            _295 = p1p2 / 2;
                                            _296 = p1p2 / 2 * p1p3 / p0p2;
                                        } else {
                                            if (_296 > p1p2 / 2) {
                                                _296 = p1p2 / 2;
                                                _295 = p1p2 / 2 * p0p2 / p1p3;
                                            }
                                        }
                                    } if (_293 == "S") {
                                        if (p0 == p1) {
                                            _295 = 0;
                                        }
                                        if (p2 == p3) {
                                            _296 = 0;
                                        }
                                    }
                                    bz1x = p1.x + _295 * (p2.x - p0.x) / p0p2;
                                    bz1y = p1.y + _295 * (p2.y - p0.y) / p0p2;
                                    bz2x = p2.x - _296 * (p3.x - p1.x) / p1p3;
                                    bz2y = p2.y - _296 * (p3.y - p1.y) / p1p3;
                                }
                            }
                            return "C" + (bz1x + "," + bz1y + " " + bz2x + "," + bz2y + " " + p2.x + "," + p2.y);
                        });
                        return p.join(" ");
                    },
                    getLabel: function (_297, _298, _299) {
                        return sc.doIfLoaded("dojo/number", function (_29a) {
                            return (_298 ? _29a.format(_297, {
                                places: _299
                            }) : _29a.format(_297)) || "";
                        }, function () {
                            return _298 ? _297.toFixed(_299) : _297.toString();
                        });
                    }
                });
            });
        },
        "dojox/charting/scaler/primitive": function () {
            define("dojox/charting/scaler/primitive", ["dojo/_base/lang"], function (lang) {
                var _29b = lang.getObject("dojox.charting.scaler.primitive", true);
                return lang.mixin(_29b, {
                    buildScaler: function (min, max, span, _29c) {
                        if (min == max) {
                            min -= 0.5;
                            max += 0.5;
                        }
                        return {
                            bounds: {
                                lower: min,
                                upper: max,
                                from: min,
                                to: max,
                                scale: span / (max - min),
                                span: span
                            },
                            scaler: _29b
                        };
                    },
                    buildTicks: function (_29d, _29e) {
                        return {
                            major: [],
                            minor: [],
                            micro: []
                        };
                    },
                    getTransformerFromModel: function (_29f) {
                        var _2a0 = _29f.bounds.from,
                            _2a1 = _29f.bounds.scale;
                        return function (x) {
                            return (x - _2a0) * _2a1;
                        };
                    },
                    getTransformerFromPlot: function (_2a2) {
                        var _2a3 = _2a2.bounds.from,
                            _2a4 = _2a2.bounds.scale;
                        return function (x) {
                            return x / _2a4 + _2a3;
                        };
                    }
                });
            });
        },
        "dojox/gfx/fx": function () {
            define("dojox/gfx/fx", ["dojo/_base/lang", "./_base", "./matrix", "dojo/_base/Color", "dojo/_base/array", "dojo/_base/fx", "dojo/_base/connect"], function (lang, g, m, _2a5, arr, fx, Hub) {
                var fxg = g.fx = {};

                function _2a6(_2a7, end) {
                    this.start = _2a7, this.end = end;
                };
                _2a6.prototype.getValue = function (r) {
                    return (this.end - this.start) * r + this.start;
                };

                function _2a8(_2a9, end, _2aa) {
                    this.start = _2a9, this.end = end;
                    this.units = _2aa;
                };
                _2a8.prototype.getValue = function (r) {
                    return (this.end - this.start) * r + this.start + this.units;
                };

                function _2ab(_2ac, end) {
                    this.start = _2ac, this.end = end;
                    this.temp = new _2a5();
                };
                _2ab.prototype.getValue = function (r) {
                    return _2a5.blendColors(this.start, this.end, r, this.temp);
                };

                function _2ad(_2ae) {
                    this.values = _2ae;
                    this.length = _2ae.length;
                };
                _2ad.prototype.getValue = function (r) {
                    return this.values[Math.min(Math.floor(r * this.length), this.length - 1)];
                };

                function _2af(_2b0, def) {
                    this.values = _2b0;
                    this.def = def ? def : {};
                };
                _2af.prototype.getValue = function (r) {
                    var ret = lang.clone(this.def);
                    for (var i in this.values) {
                        ret[i] = this.values[i].getValue(r);
                    }
                    return ret;
                };

                function _2b1(_2b2, _2b3) {
                    this.stack = _2b2;
                    this.original = _2b3;
                };
                _2b1.prototype.getValue = function (r) {
                    var ret = [];
                    arr.forEach(this.stack, function (t) {
                        if (t instanceof m.Matrix2D) {
                            ret.push(t);
                            return;
                        }
                        if (t.name == "original" && this.original) {
                            ret.push(this.original);
                            return;
                        }
                        if (t.name == "matrix") {
                            if ((t.start instanceof m.Matrix2D) && (t.end instanceof m.Matrix2D)) {
                                var _2b4 = new m.Matrix2D();
                                for (var p in t.start) {
                                    _2b4[p] = (t.end[p] - t.start[p]) * r + t.start[p];
                                }
                                ret.push(_2b4);
                            }
                            return;
                        }
                        if (!(t.name in m)) {
                            return;
                        }
                        var f = m[t.name];
                        if (typeof f != "function") {
                            ret.push(f);
                            return;
                        }
                        var val = arr.map(t.start, function (v, i) {
                            return (t.end[i] - v) * r + v;
                        }),
                            _2b5 = f.apply(m, val);
                        if (_2b5 instanceof m.Matrix2D) {
                            ret.push(_2b5);
                        }
                    }, this);
                    return ret;
                };
                var _2b6 = new _2a5(0, 0, 0, 0);

                function _2b7(prop, obj, name, def) {
                    if (prop.values) {
                        return new _2ad(prop.values);
                    }
                    var _2b8, _2b9, end;
                    if (prop.start) {
                        _2b9 = g.normalizeColor(prop.start);
                    } else {
                        _2b9 = _2b8 = obj ? (name ? obj[name] : obj) : def;
                    } if (prop.end) {
                        end = g.normalizeColor(prop.end);
                    } else {
                        if (!_2b8) {
                            _2b8 = obj ? (name ? obj[name] : obj) : def;
                        }
                        end = _2b8;
                    }
                    return new _2ab(_2b9, end);
                };

                function _2ba(prop, obj, name, def) {
                    if (prop.values) {
                        return new _2ad(prop.values);
                    }
                    var _2bb, _2bc, end;
                    if (prop.start) {
                        _2bc = prop.start;
                    } else {
                        _2bc = _2bb = obj ? obj[name] : def;
                    } if (prop.end) {
                        end = prop.end;
                    } else {
                        if (typeof _2bb != "number") {
                            _2bb = obj ? obj[name] : def;
                        }
                        end = _2bb;
                    }
                    return new _2a6(_2bc, end);
                };
                fxg.animateStroke = function (args) {
                    if (!args.easing) {
                        args.easing = fx._defaultEasing;
                    }
                    var anim = new fx.Animation(args),
                        _2bd = args.shape,
                        _2be;
                    Hub.connect(anim, "beforeBegin", anim, function () {
                        _2be = _2bd.getStroke();
                        var prop = args.color,
                            _2bf = {}, _2c0, _2c1, end;
                        if (prop) {
                            _2bf.color = _2b7(prop, _2be, "color", _2b6);
                        }
                        prop = args.style;
                        if (prop && prop.values) {
                            _2bf.style = new _2ad(prop.values);
                        }
                        prop = args.width;
                        if (prop) {
                            _2bf.width = _2ba(prop, _2be, "width", 1);
                        }
                        prop = args.cap;
                        if (prop && prop.values) {
                            _2bf.cap = new _2ad(prop.values);
                        }
                        prop = args.join;
                        if (prop) {
                            if (prop.values) {
                                _2bf.join = new _2ad(prop.values);
                            } else {
                                _2c1 = prop.start ? prop.start : (_2be && _2be.join || 0);
                                end = prop.end ? prop.end : (_2be && _2be.join || 0);
                                if (typeof _2c1 == "number" && typeof end == "number") {
                                    _2bf.join = new _2a6(_2c1, end);
                                }
                            }
                        }
                        this.curve = new _2af(_2bf, _2be);
                    });
                    Hub.connect(anim, "onAnimate", _2bd, "setStroke");
                    return anim;
                };
                fxg.animateFill = function (args) {
                    if (!args.easing) {
                        args.easing = fx._defaultEasing;
                    }
                    var anim = new fx.Animation(args),
                        _2c2 = args.shape,
                        fill;
                    Hub.connect(anim, "beforeBegin", anim, function () {
                        fill = _2c2.getFill();
                        var prop = args.color,
                            _2c3 = {};
                        if (prop) {
                            this.curve = _2b7(prop, fill, "", _2b6);
                        }
                    });
                    Hub.connect(anim, "onAnimate", _2c2, "setFill");
                    return anim;
                };
                fxg.animateFont = function (args) {
                    if (!args.easing) {
                        args.easing = fx._defaultEasing;
                    }
                    var anim = new fx.Animation(args),
                        _2c4 = args.shape,
                        font;
                    Hub.connect(anim, "beforeBegin", anim, function () {
                        font = _2c4.getFont();
                        var prop = args.style,
                            _2c5 = {}, _2c6, _2c7, end;
                        if (prop && prop.values) {
                            _2c5.style = new _2ad(prop.values);
                        }
                        prop = args.variant;
                        if (prop && prop.values) {
                            _2c5.variant = new _2ad(prop.values);
                        }
                        prop = args.weight;
                        if (prop && prop.values) {
                            _2c5.weight = new _2ad(prop.values);
                        }
                        prop = args.family;
                        if (prop && prop.values) {
                            _2c5.family = new _2ad(prop.values);
                        }
                        prop = args.size;
                        if (prop && prop.units) {
                            _2c7 = parseFloat(prop.start ? prop.start : (_2c4.font && _2c4.font.size || "0"));
                            end = parseFloat(prop.end ? prop.end : (_2c4.font && _2c4.font.size || "0"));
                            _2c5.size = new _2a8(_2c7, end, prop.units);
                        }
                        this.curve = new _2af(_2c5, font);
                    });
                    Hub.connect(anim, "onAnimate", _2c4, "setFont");
                    return anim;
                };
                fxg.animateTransform = function (args) {
                    if (!args.easing) {
                        args.easing = fx._defaultEasing;
                    }
                    var anim = new fx.Animation(args),
                        _2c8 = args.shape,
                        _2c9;
                    Hub.connect(anim, "beforeBegin", anim, function () {
                        _2c9 = _2c8.getTransform();
                        this.curve = new _2b1(args.transform, _2c9);
                    });
                    Hub.connect(anim, "onAnimate", _2c8, "setTransform");
                    return anim;
                };
                return fxg;
            });
        },
        "dojox/charting/plot2d/_PlotEvents": function () {
            define("dojox/charting/plot2d/_PlotEvents", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "dojo/_base/connect"], function (lang, arr, _2ca, hub) {
                return _2ca("dojox.charting.plot2d._PlotEvents", null, {
                    constructor: function () {
                        this._shapeEvents = [];
                        this._eventSeries = {};
                    },
                    destroy: function () {
                        this.resetEvents();
                        this.inherited(arguments);
                    },
                    plotEvent: function (o) {},
                    raiseEvent: function (o) {
                        this.plotEvent(o);
                        var t = lang.delegate(o);
                        t.originalEvent = o.type;
                        t.originalPlot = o.plot;
                        t.type = "onindirect";
                        arr.forEach(this.chart.stack, function (plot) {
                            if (plot !== this && plot.plotEvent) {
                                t.plot = plot;
                                plot.plotEvent(t);
                            }
                        }, this);
                    },
                    connect: function (_2cb, _2cc) {
                        this.dirty = true;
                        return hub.connect(this, "plotEvent", _2cb, _2cc);
                    },
                    events: function () {
                        return !!this.plotEvent.after;
                    },
                    resetEvents: function () {
                        if (this._shapeEvents.length) {
                            arr.forEach(this._shapeEvents, function (item) {
                                item.shape.disconnect(item.handle);
                            });
                            this._shapeEvents = [];
                        }
                        this.raiseEvent({
                            type: "onplotreset",
                            plot: this
                        });
                    },
                    _connectSingleEvent: function (o, _2cd) {
                        this._shapeEvents.push({
                            shape: o.eventMask,
                            handle: o.eventMask.connect(_2cd, this, function (e) {
                                o.type = _2cd;
                                o.event = e;
                                this.raiseEvent(o);
                                o.event = null;
                            })
                        });
                    },
                    _connectEvents: function (o) {
                        if (o) {
                            o.chart = this.chart;
                            o.plot = this;
                            o.hAxis = this.hAxis || null;
                            o.vAxis = this.vAxis || null;
                            o.eventMask = o.eventMask || o.shape;
                            this._connectSingleEvent(o, "onmouseover");
                            this._connectSingleEvent(o, "onmouseout");
                            this._connectSingleEvent(o, "onclick");
                        }
                    },
                    _reconnectEvents: function (_2ce) {
                        var a = this._eventSeries[_2ce];
                        if (a) {
                            arr.forEach(a, this._connectEvents, this);
                        }
                    },
                    fireEvent: function (_2cf, _2d0, _2d1, _2d2) {
                        var s = this._eventSeries[_2cf];
                        if (s && s.length && _2d1 < s.length) {
                            var o = s[_2d1];
                            o.type = _2d0;
                            o.event = _2d2 || null;
                            this.raiseEvent(o);
                            o.event = null;
                        }
                    }
                });
            });
        },
        "dojox/charting/plot2d/ClusteredColumns": function () {
            define("dojox/charting/plot2d/ClusteredColumns", ["dojo/_base/declare", "./Columns", "./common"], function (_2d3, _2d4, dc) {
                return _2d3("dojox.charting.plot2d.ClusteredColumns", _2d4, {
                    getBarProperties: function () {
                        var f = dc.calculateBarSize(this._hScaler.bounds.scale, this.opt, this.series.length);
                        return {
                            gap: f.gap,
                            width: f.size,
                            thickness: f.size
                        };
                    }
                });
            });
        },
        "dojox/charting/plot2d/Columns": function () {
            define("dojox/charting/plot2d/Columns", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "./CartesianBase", "./_PlotEvents", "./common", "dojox/lang/functional", "dojox/lang/functional/reversed", "dojox/lang/utils", "dojox/gfx/fx"], function (lang, arr, _2d5, _2d6, _2d7, dc, df, dfr, du, fx) {
                var _2d8 = dfr.lambda("item.purgeGroup()");
                return _2d5("dojox.charting.plot2d.Columns", [_2d6, _2d7], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        gap: 0,
                        animate: null,
                        enableCache: false
                    },
                    optionalParams: {
                        minBarSize: 1,
                        maxBarSize: 1,
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        styleFunc: null,
                        font: "",
                        fontColor: ""
                    },
                    constructor: function (_2d9, _2da) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _2da);
                        du.updateWithPattern(this.opt, _2da, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    getSeriesStats: function () {
                        var _2db = dc.collectSimpleStats(this.series);
                        _2db.hmin -= 0.5;
                        _2db.hmax += 0.5;
                        return _2db;
                    },
                    createRect: function (run, _2dc, _2dd) {
                        var rect;
                        if (this.opt.enableCache && run._rectFreePool.length > 0) {
                            rect = run._rectFreePool.pop();
                            rect.setShape(_2dd);
                            _2dc.add(rect);
                        } else {
                            rect = _2dc.createRect(_2dd);
                        } if (this.opt.enableCache) {
                            run._rectUsePool.push(rect);
                        }
                        return rect;
                    },
                    render: function (dim, _2de) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _2de);
                        }
                        this.getSeriesStats();
                        this.resetEvents();
                        this.dirty = this.isDirty();
                        var s;
                        if (this.dirty) {
                            arr.forEach(this.series, _2d8);
                            this._eventSeries = {};
                            this.cleanGroup();
                            s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                            vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                            _2df = Math.max(0, this._vScaler.bounds.lower),
                            _2e0 = vt(_2df),
                            _2e1 = this.events();
                        var bar = this.getBarProperties();
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            if (this.opt.enableCache) {
                                run._rectFreePool = (run._rectFreePool ? run._rectFreePool : []).concat(run._rectUsePool ? run._rectUsePool : []);
                                run._rectUsePool = [];
                            }
                            var _2e2 = t.next("column", [this.opt, run]),
                                _2e3 = new Array(run.data.length);
                            s = run.group;
                            var _2e4 = arr.some(run.data, function (item) {
                                return typeof item == "number" || (item && !item.hasOwnProperty("x"));
                            });
                            var min = _2e4 ? Math.max(0, Math.floor(this._hScaler.bounds.from - 1)) : 0;
                            var max = _2e4 ? Math.min(run.data.length, Math.ceil(this._hScaler.bounds.to)) : run.data.length;
                            for (var j = min; j < max; ++j) {
                                var _2e5 = run.data[j];
                                if (_2e5 != null) {
                                    var val = this.getValue(_2e5, j, i, _2e4),
                                        vv = vt(val.y),
                                        h = Math.abs(vv - _2e0),
                                        _2e6, _2e7;
                                    if (this.opt.styleFunc || typeof _2e5 != "number") {
                                        var _2e8 = typeof _2e5 != "number" ? [_2e5] : [];
                                        if (this.opt.styleFunc) {
                                            _2e8.push(this.opt.styleFunc(_2e5));
                                        }
                                        _2e6 = t.addMixin(_2e2, "column", _2e8, true);
                                    } else {
                                        _2e6 = t.post(_2e2, "column");
                                    } if (bar.width >= 1 && h >= 0) {
                                        var rect = {
                                            x: _2de.l + ht(val.x + 0.5) + bar.gap + bar.thickness * i,
                                            y: dim.height - _2de.b - (val.y > _2df ? vv : _2e0),
                                            width: bar.width,
                                            height: h
                                        };
                                        if (_2e6.series.shadow) {
                                            var _2e9 = lang.clone(rect);
                                            _2e9.x += _2e6.series.shadow.dx;
                                            _2e9.y += _2e6.series.shadow.dy;
                                            _2e7 = this.createRect(run, s, _2e9).setFill(_2e6.series.shadow.color).setStroke(_2e6.series.shadow);
                                            if (this.animate) {
                                                this._animateColumn(_2e7, dim.height - _2de.b + _2e0, h);
                                            }
                                        }
                                        var _2ea = this._plotFill(_2e6.series.fill, dim, _2de);
                                        _2ea = this._shapeFill(_2ea, rect);
                                        var _2eb = this.createRect(run, s, rect).setFill(_2ea).setStroke(_2e6.series.stroke);
                                        run.dyn.fill = _2eb.getFill();
                                        run.dyn.stroke = _2eb.getStroke();
                                        if (_2e1) {
                                            var o = {
                                                element: "column",
                                                index: j,
                                                run: run,
                                                shape: _2eb,
                                                shadow: _2e7,
                                                x: val.x + 0.5,
                                                y: val.y
                                            };
                                            this._connectEvents(o);
                                            _2e3[j] = o;
                                        }
                                        if (this.animate) {
                                            this._animateColumn(_2eb, dim.height - _2de.b - _2e0, h);
                                        }
                                    }
                                }
                            }
                            this._eventSeries[run.name] = _2e3;
                            run.dirty = false;
                        }
                        this.dirty = false;
                        return this;
                    },
                    getValue: function (_2ec, j, _2ed, _2ee) {
                        var y, x;
                        if (_2ee) {
                            if (typeof _2ec == "number") {
                                y = _2ec;
                            } else {
                                y = _2ec.y;
                            }
                            x = j;
                        } else {
                            y = _2ec.y;
                            x = _2ec.x - 1;
                        }
                        return {
                            y: y,
                            x: x
                        };
                    },
                    getBarProperties: function () {
                        var f = dc.calculateBarSize(this._hScaler.bounds.scale, this.opt);
                        return {
                            gap: f.gap,
                            width: f.size,
                            thickness: 0
                        };
                    },
                    _animateColumn: function (_2ef, _2f0, _2f1) {
                        if (_2f1 == 0) {
                            _2f1 = 1;
                        }
                        fx.animateTransform(lang.delegate({
                            shape: _2ef,
                            duration: 1200,
                            transform: [{
                                    name: "translate",
                                    start: [0, _2f0 - (_2f0 / _2f1)],
                                    end: [0, 0]
                                }, {
                                    name: "scale",
                                    start: [1, 1 / _2f1],
                                    end: [1, 1]
                                }, {
                                    name: "original"
                                }
                            ]
                        }, this.animate)).play();
                    }
                });
            });
        },
        "dojox/charting/plot2d/Default": function () {
            define("dojox/charting/plot2d/Default", ["dojo/_base/lang", "dojo/_base/declare", "dojo/_base/array", "./CartesianBase", "./_PlotEvents", "./common", "dojox/lang/functional", "dojox/lang/functional/reversed", "dojox/lang/utils", "dojox/gfx/fx"], function (lang, _2f2, arr, _2f3, _2f4, dc, df, dfr, du, fx) {
                var _2f5 = dfr.lambda("item.purgeGroup()");
                var _2f6 = 1200;
                return _2f2("dojox.charting.plot2d.Default", [_2f3, _2f4], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        lines: true,
                        areas: false,
                        markers: false,
                        tension: "",
                        animate: false,
                        enableCache: false,
                        interpolate: false
                    },
                    optionalParams: {
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        styleFunc: null,
                        font: "",
                        fontColor: "",
                        marker: "",
                        markerStroke: {},
                        markerOutline: {},
                        markerShadow: {},
                        markerFill: {},
                        markerFont: "",
                        markerFontColor: ""
                    },
                    constructor: function (_2f7, _2f8) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _2f8);
                        du.updateWithPattern(this.opt, _2f8, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    createPath: function (run, _2f9, _2fa) {
                        var path;
                        if (this.opt.enableCache && run._pathFreePool.length > 0) {
                            path = run._pathFreePool.pop();
                            path.setShape(_2fa);
                            _2f9.add(path);
                        } else {
                            path = _2f9.createPath(_2fa);
                        } if (this.opt.enableCache) {
                            run._pathUsePool.push(path);
                        }
                        return path;
                    },
                    buildSegments: function (i, _2fb) {
                        var run = this.series[i],
                            min = _2fb ? Math.max(0, Math.floor(this._hScaler.bounds.from - 1)) : 0,
                            max = _2fb ? Math.min(run.data.length, Math.ceil(this._hScaler.bounds.to)) : run.data.length,
                            rseg = null,
                            _2fc = [];
                        for (var j = min; j < max; j++) {
                            if (run.data[j] != null && (_2fb || run.data[j].y != null)) {
                                if (!rseg) {
                                    rseg = [];
                                    _2fc.push({
                                        index: j,
                                        rseg: rseg
                                    });
                                }
                                rseg.push((_2fb && run.data[j].hasOwnProperty("y")) ? run.data[j].y : run.data[j]);
                            } else {
                                if (!this.opt.interpolate || _2fb) {
                                    rseg = null;
                                }
                            }
                        }
                        return _2fc;
                    },
                    render: function (dim, _2fd) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _2fd);
                        }
                        this.resetEvents();
                        this.dirty = this.isDirty();
                        var s;
                        if (this.dirty) {
                            arr.forEach(this.series, _2f5);
                            this._eventSeries = {};
                            this.cleanGroup();
                            this.group.setTransform(null);
                            s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            _2fe, _2ff, _300, _301 = this.events();
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            if (this.opt.enableCache) {
                                run._pathFreePool = (run._pathFreePool ? run._pathFreePool : []).concat(run._pathUsePool ? run._pathUsePool : []);
                                run._pathUsePool = [];
                            }
                            if (!run.data.length) {
                                run.dirty = false;
                                t.skip();
                                continue;
                            }
                            var _302 = t.next(this.opt.areas ? "area" : "line", [this.opt, run], true),
                                _303, ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                                vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                                _304 = this._eventSeries[run.name] = new Array(run.data.length);
                            s = run.group;
                            var _305 = arr.some(run.data, function (item) {
                                return typeof item == "number" || (item && !item.hasOwnProperty("x"));
                            });
                            var _306 = this.buildSegments(i, _305);
                            for (var seg = 0; seg < _306.length; seg++) {
                                var _307 = _306[seg];
                                if (_305) {
                                    _303 = arr.map(_307.rseg, function (v, i) {
                                        return {
                                            x: ht(i + _307.index + 1) + _2fd.l,
                                            y: dim.height - _2fd.b - vt(v),
                                            data: v
                                        };
                                    }, this);
                                } else {
                                    _303 = arr.map(_307.rseg, function (v) {
                                        return {
                                            x: ht(v.x) + _2fd.l,
                                            y: dim.height - _2fd.b - vt(v.y),
                                            data: v
                                        };
                                    }, this);
                                } if (_305 && this.opt.interpolate) {
                                    while (seg < _306.length) {
                                        seg++;
                                        _307 = _306[seg];
                                        if (_307) {
                                            _303 = _303.concat(arr.map(_307.rseg, function (v, i) {
                                                return {
                                                    x: ht(i + _307.index + 1) + _2fd.l,
                                                    y: dim.height - _2fd.b - vt(v),
                                                    data: v
                                                };
                                            }, this));
                                        }
                                    }
                                }
                                var _308 = this.opt.tension ? dc.curve(_303, this.opt.tension) : "";
                                if (this.opt.areas && _303.length > 1) {
                                    var fill = this._plotFill(_302.series.fill, dim, _2fd),
                                        _309 = lang.clone(_303);
                                    if (this.opt.tension) {
                                        var _30a = "L" + _309[_309.length - 1].x + "," + (dim.height - _2fd.b) + " L" + _309[0].x + "," + (dim.height - _2fd.b) + " L" + _309[0].x + "," + _309[0].y;
                                        run.dyn.fill = s.createPath(_308 + " " + _30a).setFill(fill).getFill();
                                    } else {
                                        _309.push({
                                            x: _303[_303.length - 1].x,
                                            y: dim.height - _2fd.b
                                        });
                                        _309.push({
                                            x: _303[0].x,
                                            y: dim.height - _2fd.b
                                        });
                                        _309.push(_303[0]);
                                        run.dyn.fill = s.createPolyline(_309).setFill(fill).getFill();
                                    }
                                }
                                if (this.opt.lines || this.opt.markers) {
                                    _2fe = _302.series.stroke;
                                    if (_302.series.outline) {
                                        _2ff = run.dyn.outline = dc.makeStroke(_302.series.outline);
                                        _2ff.width = 2 * _2ff.width + _2fe.width;
                                    }
                                }
                                if (this.opt.markers) {
                                    run.dyn.marker = _302.symbol;
                                }
                                var _30b = null,
                                    _30c = null,
                                    _30d = null;
                                if (_2fe && _302.series.shadow && _303.length > 1) {
                                    var _30e = _302.series.shadow,
                                        _30f = arr.map(_303, function (c) {
                                            return {
                                                x: c.x + _30e.dx,
                                                y: c.y + _30e.dy
                                            };
                                        });
                                    if (this.opt.lines) {
                                        if (this.opt.tension) {
                                            run.dyn.shadow = s.createPath(dc.curve(_30f, this.opt.tension)).setStroke(_30e).getStroke();
                                        } else {
                                            run.dyn.shadow = s.createPolyline(_30f).setStroke(_30e).getStroke();
                                        }
                                    }
                                    if (this.opt.markers && _302.marker.shadow) {
                                        _30e = _302.marker.shadow;
                                        _30d = arr.map(_30f, function (c) {
                                            return this.createPath(run, s, "M" + c.x + " " + c.y + " " + _302.symbol).setStroke(_30e).setFill(_30e.color);
                                        }, this);
                                    }
                                }
                                if (this.opt.lines && _303.length > 1) {
                                    if (_2ff) {
                                        if (this.opt.tension) {
                                            run.dyn.outline = s.createPath(_308).setStroke(_2ff).getStroke();
                                        } else {
                                            run.dyn.outline = s.createPolyline(_303).setStroke(_2ff).getStroke();
                                        }
                                    }
                                    if (this.opt.tension) {
                                        run.dyn.stroke = s.createPath(_308).setStroke(_2fe).getStroke();
                                    } else {
                                        run.dyn.stroke = s.createPolyline(_303).setStroke(_2fe).getStroke();
                                    }
                                }
                                if (this.opt.markers) {
                                    var _310 = _302;
                                    _30b = new Array(_303.length);
                                    _30c = new Array(_303.length);
                                    _2ff = null;
                                    if (_310.marker.outline) {
                                        _2ff = dc.makeStroke(_310.marker.outline);
                                        _2ff.width = 2 * _2ff.width + (_310.marker.stroke ? _310.marker.stroke.width : 0);
                                    }
                                    arr.forEach(_303, function (c, i) {
                                        if (this.opt.styleFunc || typeof c.data != "number") {
                                            var _311 = typeof c.data != "number" ? [c.data] : [];
                                            if (this.opt.styleFunc) {
                                                _311.push(this.opt.styleFunc(c.data));
                                            }
                                            _310 = t.addMixin(_302, "marker", _311, true);
                                        } else {
                                            _310 = t.post(_302, "marker");
                                        }
                                        var path = "M" + c.x + " " + c.y + " " + _310.symbol;
                                        if (_2ff) {
                                            _30c[i] = this.createPath(run, s, path).setStroke(_2ff);
                                        }
                                        _30b[i] = this.createPath(run, s, path).setStroke(_310.marker.stroke).setFill(_310.marker.fill);
                                    }, this);
                                    run.dyn.markerFill = _310.marker.fill;
                                    run.dyn.markerStroke = _310.marker.stroke;
                                    if (_301) {
                                        arr.forEach(_30b, function (s, i) {
                                            var o = {
                                                element: "marker",
                                                index: i + _307.index,
                                                run: run,
                                                shape: s,
                                                outline: _30c[i] || null,
                                                shadow: _30d && _30d[i] || null,
                                                cx: _303[i].x,
                                                cy: _303[i].y
                                            };
                                            if (_305) {
                                                o.x = i + _307.index + 1;
                                                o.y = _307.rseg[i];
                                            } else {
                                                o.x = _307.rseg[i].x;
                                                o.y = _307.rseg[i].y;
                                            }
                                            this._connectEvents(o);
                                            _304[i + _307.index] = o;
                                        }, this);
                                    } else {
                                        delete this._eventSeries[run.name];
                                    }
                                }
                            }
                            run.dirty = false;
                        }
                        if (this.animate) {
                            var _312 = this.group;
                            fx.animateTransform(lang.delegate({
                                shape: _312,
                                duration: _2f6,
                                transform: [{
                                        name: "translate",
                                        start: [0, dim.height - _2fd.b],
                                        end: [0, 0]
                                    }, {
                                        name: "scale",
                                        start: [1, 0],
                                        end: [1, 1]
                                    }, {
                                        name: "original"
                                    }
                                ]
                            }, this.animate)).play();
                        }
                        this.dirty = false;
                        return this;
                    }
                });
            });
        },
        "dojox/charting/plot2d/StackedAreas": function () {
            define("dojox/charting/plot2d/StackedAreas", ["dojo/_base/declare", "./Stacked"], function (_313, _314) {
                return _313("dojox.charting.plot2d.StackedAreas", _314, {
                    constructor: function () {
                        this.opt.lines = true;
                        this.opt.areas = true;
                    }
                });
            });
        },
        "dojox/charting/plot2d/Stacked": function () {
            define("dojox/charting/plot2d/Stacked", ["dojo/_base/declare", "./Default", "./commonStacked"], function (_315, _316, _317) {
                return _315("dojox.charting.plot2d.Stacked", _316, {
                    getSeriesStats: function () {
                        var _318 = _317.collectStats(this.series);
                        return _318;
                    },
                    buildSegments: function (i, _319) {
                        var run = this.series[i],
                            min = _319 ? Math.max(0, Math.floor(this._hScaler.bounds.from - 1)) : 0,
                            max = _319 ? Math.min(run.data.length - 1, Math.ceil(this._hScaler.bounds.to)) : run.data.length - 1,
                            rseg = null,
                            _31a = [];
                        for (var j = min; j <= max; j++) {
                            var _31b = _319 ? _317.getIndexValue(this.series, i, j) : _317.getValue(this.series, i, run.data[j] ? run.data[j].x : null);
                            if (_31b != null && (_319 || _31b.y != null)) {
                                if (!rseg) {
                                    rseg = [];
                                    _31a.push({
                                        index: j,
                                        rseg: rseg
                                    });
                                }
                                rseg.push(_31b);
                            } else {
                                if (!this.opt.interpolate || _319) {
                                    rseg = null;
                                }
                            }
                        }
                        return _31a;
                    }
                });
            });
        },
        "dojox/charting/plot2d/commonStacked": function () {
            define("dojox/charting/plot2d/commonStacked", ["dojo/_base/lang", "./common"], function (lang, _31c) {
                var _31d = lang.getObject("dojox.charting.plot2d.commonStacked", true);
                return lang.mixin(_31d, {
                    collectStats: function (_31e) {
                        var _31f = lang.delegate(_31c.defaultStats);
                        for (var i = 0; i < _31e.length; ++i) {
                            var run = _31e[i];
                            for (var j = 0; j < run.data.length; j++) {
                                var x, y;
                                if (run.data[j] !== null) {
                                    if (typeof run.data[j] == "number" || !run.data[j].hasOwnProperty("x")) {
                                        y = _31d.getIndexValue(_31e, i, j);
                                        x = j + 1;
                                    } else {
                                        x = run.data[j].x;
                                        if (x !== null) {
                                            y = _31d.getValue(_31e, i, x);
                                            y = y != null && y.y ? y.y : null;
                                        }
                                    }
                                    _31f.hmin = Math.min(_31f.hmin, x);
                                    _31f.hmax = Math.max(_31f.hmax, x);
                                    _31f.vmin = Math.min(_31f.vmin, y);
                                    _31f.vmax = Math.max(_31f.vmax, y);
                                }
                            }
                        }
                        return _31f;
                    },
                    getIndexValue: function (_320, i, _321) {
                        var _322 = 0,
                            v, j;
                        for (j = 0; j <= i; ++j) {
                            v = _320[j].data[_321];
                            if (v != null) {
                                if (isNaN(v)) {
                                    v = v.y || 0;
                                }
                                _322 += v;
                            }
                        }
                        return _322;
                    },
                    getValue: function (_323, i, x) {
                        var _324 = null,
                            j, z;
                        for (j = 0; j <= i; ++j) {
                            for (z = 0; z < _323[j].data.length; z++) {
                                v = _323[j].data[z];
                                if (v !== null) {
                                    if (v.x == x) {
                                        if (!_324) {
                                            _324 = {
                                                x: x
                                            };
                                        }
                                        if (v.y != null) {
                                            if (_324.y == null) {
                                                _324.y = 0;
                                            }
                                            _324.y += v.y;
                                        }
                                        break;
                                    } else {
                                        if (v.x > x) {
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        return _324;
                    }
                });
            });
        },
        "dojox/charting/plot2d/Bubble": function () {
            define("dojox/charting/plot2d/Bubble", ["dojo/_base/lang", "dojo/_base/declare", "dojo/_base/array", "./CartesianBase", "./_PlotEvents", "./common", "dojox/lang/functional", "dojox/lang/functional/reversed", "dojox/lang/utils", "dojox/gfx/fx"], function (lang, _325, arr, _326, _327, dc, df, dfr, du, fx) {
                var _328 = dfr.lambda("item.purgeGroup()");
                return _325("dojox.charting.plot2d.Bubble", [_326, _327], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        animate: null
                    },
                    optionalParams: {
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        styleFunc: null,
                        font: "",
                        fontColor: ""
                    },
                    constructor: function (_329, _32a) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _32a);
                        du.updateWithPattern(this.opt, _32a, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    render: function (dim, _32b) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _32b);
                        }
                        this.resetEvents();
                        this.dirty = this.isDirty();
                        if (this.dirty) {
                            arr.forEach(this.series, _328);
                            this._eventSeries = {};
                            this.cleanGroup();
                            var s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                            vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                            _32c = this.events();
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            if (!run.data.length) {
                                run.dirty = false;
                                t.skip();
                                continue;
                            }
                            if (typeof run.data[0] == "number") {
                                console.warn("dojox.charting.plot2d.Bubble: the data in the following series cannot be rendered as a bubble chart; ", run);
                                continue;
                            }
                            var _32d = t.next("circle", [this.opt, run]),
                                s = run.group,
                                _32e = arr.map(run.data, function (v, i) {
                                    return v ? {
                                        x: ht(v.x) + _32b.l,
                                        y: dim.height - _32b.b - vt(v.y),
                                        radius: this._vScaler.bounds.scale * (v.size / 2)
                                    } : null;
                                }, this);
                            var _32f = null,
                                _330 = null,
                                _331 = null,
                                _332 = this.opt.styleFunc;
                            var _333 = function (item) {
                                if (_332) {
                                    return t.addMixin(_32d, "circle", [item, _332(item)], true);
                                }
                                return t.addMixin(_32d, "circle", item, true);
                            };
                            if (_32d.series.shadow) {
                                _331 = arr.map(_32e, function (item, i) {
                                    if (item !== null) {
                                        var _334 = _333(run.data[i]),
                                            _335 = _334.series.shadow;
                                        var _336 = s.createCircle({
                                            cx: item.x + _335.dx,
                                            cy: item.y + _335.dy,
                                            r: item.radius
                                        }).setStroke(_335).setFill(_335.color);
                                        if (this.animate) {
                                            this._animateBubble(_336, dim.height - _32b.b, item.radius);
                                        }
                                        return _336;
                                    }
                                    return null;
                                }, this);
                                if (_331.length) {
                                    run.dyn.shadow = _331[_331.length - 1].getStroke();
                                }
                            }
                            if (_32d.series.outline) {
                                _330 = arr.map(_32e, function (item, i) {
                                    if (item !== null) {
                                        var _337 = _333(run.data[i]),
                                            _338 = dc.makeStroke(_337.series.outline);
                                        _338.width = 2 * _338.width + _32d.series.stroke.width;
                                        var _339 = s.createCircle({
                                            cx: item.x,
                                            cy: item.y,
                                            r: item.radius
                                        }).setStroke(_338);
                                        if (this.animate) {
                                            this._animateBubble(_339, dim.height - _32b.b, item.radius);
                                        }
                                        return _339;
                                    }
                                    return null;
                                }, this);
                                if (_330.length) {
                                    run.dyn.outline = _330[_330.length - 1].getStroke();
                                }
                            }
                            _32f = arr.map(_32e, function (item, i) {
                                if (item !== null) {
                                    var _33a = _333(run.data[i]),
                                        rect = {
                                            x: item.x - item.radius,
                                            y: item.y - item.radius,
                                            width: 2 * item.radius,
                                            height: 2 * item.radius
                                        };
                                    var _33b = this._plotFill(_33a.series.fill, dim, _32b);
                                    _33b = this._shapeFill(_33b, rect);
                                    var _33c = s.createCircle({
                                        cx: item.x,
                                        cy: item.y,
                                        r: item.radius
                                    }).setFill(_33b).setStroke(_33a.series.stroke);
                                    if (this.animate) {
                                        this._animateBubble(_33c, dim.height - _32b.b, item.radius);
                                    }
                                    return _33c;
                                }
                                return null;
                            }, this);
                            if (_32f.length) {
                                run.dyn.fill = _32f[_32f.length - 1].getFill();
                                run.dyn.stroke = _32f[_32f.length - 1].getStroke();
                            }
                            if (_32c) {
                                var _33d = new Array(_32f.length);
                                arr.forEach(_32f, function (s, i) {
                                    if (s !== null) {
                                        var o = {
                                            element: "circle",
                                            index: i,
                                            run: run,
                                            shape: s,
                                            outline: _330 && _330[i] || null,
                                            shadow: _331 && _331[i] || null,
                                            x: run.data[i].x,
                                            y: run.data[i].y,
                                            r: run.data[i].size / 2,
                                            cx: _32e[i].x,
                                            cy: _32e[i].y,
                                            cr: _32e[i].radius
                                        };
                                        this._connectEvents(o);
                                        _33d[i] = o;
                                    }
                                }, this);
                                this._eventSeries[run.name] = _33d;
                            } else {
                                delete this._eventSeries[run.name];
                            }
                            run.dirty = false;
                        }
                        this.dirty = false;
                        return this;
                    },
                    _animateBubble: function (_33e, _33f, size) {
                        fx.animateTransform(lang.delegate({
                            shape: _33e,
                            duration: 1200,
                            transform: [{
                                    name: "translate",
                                    start: [0, _33f],
                                    end: [0, 0]
                                }, {
                                    name: "scale",
                                    start: [0, 1 / size],
                                    end: [1, 1]
                                }, {
                                    name: "original"
                                }
                            ]
                        }, this.animate)).play();
                    }
                });
            });
        },
        "dojox/charting/plot2d/Candlesticks": function () {
            define("dojox/charting/plot2d/Candlesticks", ["dojo/_base/lang", "dojo/_base/declare", "dojo/_base/array", "./CartesianBase", "./_PlotEvents", "./common", "dojox/lang/functional", "dojox/lang/functional/reversed", "dojox/lang/utils", "dojox/gfx/fx"], function (lang, _340, arr, _341, _342, dc, df, dfr, du, fx) {
                var _343 = dfr.lambda("item.purgeGroup()");
                return _340("dojox.charting.plot2d.Candlesticks", [_341, _342], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        gap: 2,
                        animate: null
                    },
                    optionalParams: {
                        minBarSize: 1,
                        maxBarSize: 1,
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        font: "",
                        fontColor: ""
                    },
                    constructor: function (_344, _345) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _345);
                        du.updateWithPattern(this.opt, _345, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    collectStats: function (_346) {
                        var _347 = lang.delegate(dc.defaultStats);
                        for (var i = 0; i < _346.length; i++) {
                            var run = _346[i];
                            if (!run.data.length) {
                                continue;
                            }
                            var _348 = _347.vmin,
                                _349 = _347.vmax;
                            if (!("ymin" in run) || !("ymax" in run)) {
                                arr.forEach(run.data, function (val, idx) {
                                    if (val !== null) {
                                        var x = val.x || idx + 1;
                                        _347.hmin = Math.min(_347.hmin, x);
                                        _347.hmax = Math.max(_347.hmax, x);
                                        _347.vmin = Math.min(_347.vmin, val.open, val.close, val.high, val.low);
                                        _347.vmax = Math.max(_347.vmax, val.open, val.close, val.high, val.low);
                                    }
                                });
                            }
                            if ("ymin" in run) {
                                _347.vmin = Math.min(_348, run.ymin);
                            }
                            if ("ymax" in run) {
                                _347.vmax = Math.max(_349, run.ymax);
                            }
                        }
                        return _347;
                    },
                    getSeriesStats: function () {
                        var _34a = this.collectStats(this.series);
                        _34a.hmin -= 0.5;
                        _34a.hmax += 0.5;
                        return _34a;
                    },
                    render: function (dim, _34b) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _34b);
                        }
                        this.resetEvents();
                        this.dirty = this.isDirty();
                        if (this.dirty) {
                            arr.forEach(this.series, _343);
                            this._eventSeries = {};
                            this.cleanGroup();
                            var s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            f, gap, _34c, ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                            vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                            _34d = Math.max(0, this._vScaler.bounds.lower),
                            _34e = vt(_34d),
                            _34f = this.events();
                        f = dc.calculateBarSize(this._hScaler.bounds.scale, this.opt);
                        gap = f.gap;
                        _34c = f.size;
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            var _350 = t.next("candlestick", [this.opt, run]),
                                s = run.group,
                                _351 = new Array(run.data.length);
                            for (var j = 0; j < run.data.length; ++j) {
                                var v = run.data[j];
                                if (v !== null) {
                                    var _352 = t.addMixin(_350, "candlestick", v, true);
                                    var x = ht(v.x || (j + 0.5)) + _34b.l + gap,
                                        y = dim.height - _34b.b,
                                        open = vt(v.open),
                                        _353 = vt(v.close),
                                        high = vt(v.high),
                                        low = vt(v.low);
                                    if ("mid" in v) {
                                        var mid = vt(v.mid);
                                    }
                                    if (low > high) {
                                        var tmp = high;
                                        high = low;
                                        low = tmp;
                                    }
                                    if (_34c >= 1) {
                                        var _354 = open > _353;
                                        var line = {
                                            x1: _34c / 2,
                                            x2: _34c / 2,
                                            y1: y - high,
                                            y2: y - low
                                        }, rect = {
                                                x: 0,
                                                y: y - Math.max(open, _353),
                                                width: _34c,
                                                height: Math.max(_354 ? open - _353 : _353 - open, 1)
                                            };
                                        var _355 = s.createGroup();
                                        _355.setTransform({
                                            dx: x,
                                            dy: 0
                                        });
                                        var _356 = _355.createGroup();
                                        _356.createLine(line).setStroke(_352.series.stroke);
                                        _356.createRect(rect).setStroke(_352.series.stroke).setFill(_354 ? _352.series.fill : "white");
                                        if ("mid" in v) {
                                            _356.createLine({
                                                x1: (_352.series.stroke.width || 1),
                                                x2: _34c - (_352.series.stroke.width || 1),
                                                y1: y - mid,
                                                y2: y - mid
                                            }).setStroke(_354 ? "white" : _352.series.stroke);
                                        }
                                        run.dyn.fill = _352.series.fill;
                                        run.dyn.stroke = _352.series.stroke;
                                        if (_34f) {
                                            var o = {
                                                element: "candlestick",
                                                index: j,
                                                run: run,
                                                shape: _356,
                                                x: x,
                                                y: y - Math.max(open, _353),
                                                cx: _34c / 2,
                                                cy: (y - Math.max(open, _353)) + (Math.max(_354 ? open - _353 : _353 - open, 1) / 2),
                                                width: _34c,
                                                height: Math.max(_354 ? open - _353 : _353 - open, 1),
                                                data: v
                                            };
                                            this._connectEvents(o);
                                            _351[j] = o;
                                        }
                                    }
                                    if (this.animate) {
                                        this._animateCandlesticks(_355, y - low, high - low);
                                    }
                                }
                            }
                            this._eventSeries[run.name] = _351;
                            run.dirty = false;
                        }
                        this.dirty = false;
                        return this;
                    },
                    _animateCandlesticks: function (_357, _358, _359) {
                        fx.animateTransform(lang.delegate({
                            shape: _357,
                            duration: 1200,
                            transform: [{
                                    name: "translate",
                                    start: [0, _358 - (_358 / _359)],
                                    end: [0, 0]
                                }, {
                                    name: "scale",
                                    start: [1, 1 / _359],
                                    end: [1, 1]
                                }, {
                                    name: "original"
                                }
                            ]
                        }, this.animate)).play();
                    }
                });
            });
        },
        "dojox/charting/plot2d/OHLC": function () {
            define("dojox/charting/plot2d/OHLC", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "./CartesianBase", "./_PlotEvents", "./common", "dojox/lang/functional", "dojox/lang/functional/reversed", "dojox/lang/utils", "dojox/gfx/fx"], function (lang, arr, _35a, _35b, _35c, dc, df, dfr, du, fx) {
                var _35d = dfr.lambda("item.purgeGroup()");
                return _35a("dojox.charting.plot2d.OHLC", [_35b, _35c], {
                    defaultParams: {
                        hAxis: "x",
                        vAxis: "y",
                        gap: 2,
                        animate: null
                    },
                    optionalParams: {
                        minBarSize: 1,
                        maxBarSize: 1,
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        font: "",
                        fontColor: ""
                    },
                    constructor: function (_35e, _35f) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _35f);
                        du.updateWithPattern(this.opt, _35f, this.optionalParams);
                        this.series = [];
                        this.hAxis = this.opt.hAxis;
                        this.vAxis = this.opt.vAxis;
                        this.animate = this.opt.animate;
                    },
                    collectStats: function (_360) {
                        var _361 = lang.delegate(dc.defaultStats);
                        for (var i = 0; i < _360.length; i++) {
                            var run = _360[i];
                            if (!run.data.length) {
                                continue;
                            }
                            var _362 = _361.vmin,
                                _363 = _361.vmax;
                            if (!("ymin" in run) || !("ymax" in run)) {
                                arr.forEach(run.data, function (val, idx) {
                                    if (val !== null) {
                                        var x = val.x || idx + 1;
                                        _361.hmin = Math.min(_361.hmin, x);
                                        _361.hmax = Math.max(_361.hmax, x);
                                        _361.vmin = Math.min(_361.vmin, val.open, val.close, val.high, val.low);
                                        _361.vmax = Math.max(_361.vmax, val.open, val.close, val.high, val.low);
                                    }
                                });
                            }
                            if ("ymin" in run) {
                                _361.vmin = Math.min(_362, run.ymin);
                            }
                            if ("ymax" in run) {
                                _361.vmax = Math.max(_363, run.ymax);
                            }
                        }
                        return _361;
                    },
                    getSeriesStats: function () {
                        var _364 = this.collectStats(this.series);
                        _364.hmin -= 0.5;
                        _364.hmax += 0.5;
                        return _364;
                    },
                    render: function (dim, _365) {
                        if (this.zoom && !this.isDataDirty()) {
                            return this.performZoom(dim, _365);
                        }
                        this.resetEvents();
                        this.dirty = this.isDirty();
                        if (this.dirty) {
                            arr.forEach(this.series, _35d);
                            this._eventSeries = {};
                            this.cleanGroup();
                            var s = this.group;
                            df.forEachRev(this.series, function (item) {
                                item.cleanGroup(s);
                            });
                        }
                        var t = this.chart.theme,
                            f, gap, _366, ht = this._hScaler.scaler.getTransformerFromModel(this._hScaler),
                            vt = this._vScaler.scaler.getTransformerFromModel(this._vScaler),
                            _367 = Math.max(0, this._vScaler.bounds.lower),
                            _368 = vt(_367),
                            _369 = this.events();
                        f = dc.calculateBarSize(this._hScaler.bounds.scale, this.opt);
                        gap = f.gap;
                        _366 = f.size;
                        for (var i = this.series.length - 1; i >= 0; --i) {
                            var run = this.series[i];
                            if (!this.dirty && !run.dirty) {
                                t.skip();
                                this._reconnectEvents(run.name);
                                continue;
                            }
                            run.cleanGroup();
                            var _36a = t.next("candlestick", [this.opt, run]),
                                s = run.group,
                                _36b = new Array(run.data.length);
                            for (var j = 0; j < run.data.length; ++j) {
                                var v = run.data[j];
                                if (v !== null) {
                                    var _36c = t.addMixin(_36a, "candlestick", v, true);
                                    var x = ht(v.x || (j + 0.5)) + _365.l + gap,
                                        y = dim.height - _365.b,
                                        open = vt(v.open),
                                        _36d = vt(v.close),
                                        high = vt(v.high),
                                        low = vt(v.low);
                                    if (low > high) {
                                        var tmp = high;
                                        high = low;
                                        low = tmp;
                                    }
                                    if (_366 >= 1) {
                                        var hl = {
                                            x1: _366 / 2,
                                            x2: _366 / 2,
                                            y1: y - high,
                                            y2: y - low
                                        }, op = {
                                                x1: 0,
                                                x2: ((_366 / 2) + ((_36c.series.stroke.width || 1) / 2)),
                                                y1: y - open,
                                                y2: y - open
                                            }, cl = {
                                                x1: ((_366 / 2) - ((_36c.series.stroke.width || 1) / 2)),
                                                x2: _366,
                                                y1: y - _36d,
                                                y2: y - _36d
                                            };
                                        var _36e = s.createGroup();
                                        _36e.setTransform({
                                            dx: x,
                                            dy: 0
                                        });
                                        var _36f = _36e.createGroup();
                                        _36f.createLine(hl).setStroke(_36c.series.stroke);
                                        _36f.createLine(op).setStroke(_36c.series.stroke);
                                        _36f.createLine(cl).setStroke(_36c.series.stroke);
                                        run.dyn.stroke = _36c.series.stroke;
                                        if (_369) {
                                            var o = {
                                                element: "candlestick",
                                                index: j,
                                                run: run,
                                                shape: _36f,
                                                x: x,
                                                y: y - Math.max(open, _36d),
                                                cx: _366 / 2,
                                                cy: (y - Math.max(open, _36d)) + (Math.max(open > _36d ? open - _36d : _36d - open, 1) / 2),
                                                width: _366,
                                                height: Math.max(open > _36d ? open - _36d : _36d - open, 1),
                                                data: v
                                            };
                                            this._connectEvents(o);
                                            _36b[j] = o;
                                        }
                                    }
                                    if (this.animate) {
                                        this._animateOHLC(_36e, y - low, high - low);
                                    }
                                }
                            }
                            this._eventSeries[run.name] = _36b;
                            run.dirty = false;
                        }
                        this.dirty = false;
                        return this;
                    },
                    _animateOHLC: function (_370, _371, _372) {
                        fx.animateTransform(lang.delegate({
                            shape: _370,
                            duration: 1200,
                            transform: [{
                                    name: "translate",
                                    start: [0, _371 - (_371 / _372)],
                                    end: [0, 0]
                                }, {
                                    name: "scale",
                                    start: [1, 1 / _372],
                                    end: [1, 1]
                                }, {
                                    name: "original"
                                }
                            ]
                        }, this.animate)).play();
                    }
                });
            });
        },
        "dojox/charting/plot2d/Pie": function () {
            define("dojox/charting/plot2d/Pie", ["dojo/_base/lang", "dojo/_base/array", "dojo/_base/declare", "./Base", "./_PlotEvents", "./common", "../axis2d/common", "dojox/gfx", "dojox/gfx/matrix", "dojox/lang/functional", "dojox/lang/utils"], function (lang, arr, _373, Base, _374, dc, da, g, m, df, du) {
                var _375 = 0.2;
                return _373("dojox.charting.plot2d.Pie", [Base, _374], {
                    defaultParams: {
                        labels: true,
                        ticks: false,
                        fixed: true,
                        precision: 1,
                        labelOffset: 20,
                        labelStyle: "default",
                        htmlLabels: true,
                        radGrad: "native",
                        fanSize: 5,
                        startAngle: 0
                    },
                    optionalParams: {
                        radius: 0,
                        omitLabels: false,
                        stroke: {},
                        outline: {},
                        shadow: {},
                        fill: {},
                        styleFunc: null,
                        font: "",
                        fontColor: "",
                        labelWiring: {}
                    },
                    constructor: function (_376, _377) {
                        this.opt = lang.clone(this.defaultParams);
                        du.updateWithObject(this.opt, _377);
                        du.updateWithPattern(this.opt, _377, this.optionalParams);
                        this.axes = [];
                        this.run = null;
                        this.dyn = [];
                    },
                    clear: function () {
                        this.inherited(arguments);
                        this.dyn = [];
                        this.run = null;
                        return this;
                    },
                    setAxis: function (axis) {
                        return this;
                    },
                    addSeries: function (run) {
                        this.run = run;
                        return this;
                    },
                    getSeriesStats: function () {
                        return lang.delegate(dc.defaultStats);
                    },
                    getRequiredColors: function () {
                        return this.run ? this.run.data.length : 0;
                    },
                    render: function (dim, _378) {
                        if (!this.dirty) {
                            return this;
                        }
                        this.resetEvents();
                        this.dirty = false;
                        this._eventSeries = {};
                        this.cleanGroup();
                        var s = this.group,
                            t = this.chart.theme;
                        if (!this.run || !this.run.data.length) {
                            return this;
                        }
                        var rx = (dim.width - _378.l - _378.r) / 2,
                            ry = (dim.height - _378.t - _378.b) / 2,
                            r = Math.min(rx, ry),
                            _379 = "font" in this.opt ? this.opt.font : t.series.font,
                            size, _37a = m._degToRad(this.opt.startAngle),
                            _37b = _37a,
                            step, _37c, _37d, _37e, _37f, _380, run = this.run.data,
                            _381 = this.events();
                        this.dyn = [];
                        if ("radius" in this.opt) {
                            r = this.opt.radius;
                            _380 = r - this.opt.labelOffset;
                        }
                        var _382 = {
                            cx: _378.l + rx,
                            cy: _378.t + ry,
                            r: r
                        };
                        if (this.opt.shadow || t.shadow) {
                            var _383 = this.opt.shadow || t.shadow;
                            var _384 = lang.clone(_382);
                            _384.cx += _383.dx;
                            _384.cy += _383.dy;
                            s.createCircle(_384).setFill(_383.color).setStroke(_383);
                        }
                        if (typeof run[0] == "number") {
                            _37c = df.map(run, "x ? Math.max(x, 0) : 0");
                            if (df.every(_37c, "<= 0")) {
                                s.createCircle(_382).setStroke(t.series.stroke);
                                this.dyn = arr.map(_37c, function () {
                                    return {};
                                });
                                return this;
                            } else {
                                _37d = df.map(_37c, "/this", df.foldl(_37c, "+", 0));
                                if (this.opt.labels) {
                                    _37e = arr.map(_37d, function (x) {
                                        return x > 0 ? this._getLabel(x * 100) + "%" : "";
                                    }, this);
                                }
                            }
                        } else {
                            _37c = df.map(run, "x ? Math.max(x.y, 0) : 0");
                            if (df.every(_37c, "<= 0")) {
                                s.createCircle(_382).setStroke(t.series.stroke);
                                this.dyn = arr.map(_37c, function () {
                                    return {};
                                });
                                return this;
                            } else {
                                _37d = df.map(_37c, "/this", df.foldl(_37c, "+", 0));
                                if (this.opt.labels) {
                                    _37e = arr.map(_37d, function (x, i) {
                                        if (x < 0) {
                                            return "";
                                        }
                                        var v = run[i];
                                        return "text" in v ? v.text : this._getLabel(x * 100) + "%";
                                    }, this);
                                }
                            }
                        }
                        var _385 = df.map(run, function (v, i) {
                            var _386 = [this.opt, this.run];
                            if (v !== null && typeof v != "number") {
                                _386.push(v);
                            }
                            if (this.opt.styleFunc) {
                                _386.push(this.opt.styleFunc(v));
                            }
                            return t.next("slice", _386, true);
                        }, this);
                        if (this.opt.labels) {
                            size = _379 ? g.normalizedLength(g.splitFontString(_379).size) : 0;
                            _37f = df.foldl1(df.map(_37e, function (_387, i) {
                                var font = _385[i].series.font;
                                return g._base._getTextBox(_387, {
                                    font: font
                                }).w;
                            }, this), "Math.max(a, b)") / 2;
                            if (this.opt.labelOffset < 0) {
                                r = Math.min(rx - 2 * _37f, ry - size) + this.opt.labelOffset;
                            }
                            _380 = r - this.opt.labelOffset;
                        }
                        var _388 = new Array(_37d.length);
                        arr.some(_37d, function (_389, i) {
                            if (_389 < 0) {
                                return false;
                            }
                            if (_389 == 0) {
                                this.dyn.push({
                                    fill: null,
                                    stroke: null
                                });
                                return false;
                            }
                            var v = run[i],
                                _38a = _385[i],
                                _38b, o;
                            if (_389 >= 1) {
                                _38b = this._plotFill(_38a.series.fill, dim, _378);
                                _38b = this._shapeFill(_38b, {
                                    x: _382.cx - _382.r,
                                    y: _382.cy - _382.r,
                                    width: 2 * _382.r,
                                    height: 2 * _382.r
                                });
                                _38b = this._pseudoRadialFill(_38b, {
                                    x: _382.cx,
                                    y: _382.cy
                                }, _382.r);
                                var _38c = s.createCircle(_382).setFill(_38b).setStroke(_38a.series.stroke);
                                this.dyn.push({
                                    fill: _38b,
                                    stroke: _38a.series.stroke
                                });
                                if (_381) {
                                    o = {
                                        element: "slice",
                                        index: i,
                                        run: this.run,
                                        shape: _38c,
                                        x: i,
                                        y: typeof v == "number" ? v : v.y,
                                        cx: _382.cx,
                                        cy: _382.cy,
                                        cr: r
                                    };
                                    this._connectEvents(o);
                                    _388[i] = o;
                                }
                                return true;
                            }
                            var end = _37b + _389 * 2 * Math.PI;
                            if (i + 1 == _37d.length) {
                                end = _37a + 2 * Math.PI;
                            }
                            var step = end - _37b,
                                x1 = _382.cx + r * Math.cos(_37b),
                                y1 = _382.cy + r * Math.sin(_37b),
                                x2 = _382.cx + r * Math.cos(end),
                                y2 = _382.cy + r * Math.sin(end);
                            var _38d = m._degToRad(this.opt.fanSize);
                            if (_38a.series.fill && _38a.series.fill.type === "radial" && this.opt.radGrad === "fan" && step > _38d) {
                                var _38e = s.createGroup(),
                                    _38f = Math.ceil(step / _38d),
                                    _390 = step / _38f;
                                _38b = this._shapeFill(_38a.series.fill, {
                                    x: _382.cx - _382.r,
                                    y: _382.cy - _382.r,
                                    width: 2 * _382.r,
                                    height: 2 * _382.r
                                });
                                for (var j = 0; j < _38f; ++j) {
                                    var _391 = j == 0 ? x1 : _382.cx + r * Math.cos(_37b + (j - _375) * _390),
                                        _392 = j == 0 ? y1 : _382.cy + r * Math.sin(_37b + (j - _375) * _390),
                                        _393 = j == _38f - 1 ? x2 : _382.cx + r * Math.cos(_37b + (j + 1 + _375) * _390),
                                        _394 = j == _38f - 1 ? y2 : _382.cy + r * Math.sin(_37b + (j + 1 + _375) * _390),
                                        fan = _38e.createPath().moveTo(_382.cx, _382.cy).lineTo(_391, _392).arcTo(r, r, 0, _390 > Math.PI, true, _393, _394).lineTo(_382.cx, _382.cy).closePath().setFill(this._pseudoRadialFill(_38b, {
                                            x: _382.cx,
                                            y: _382.cy
                                        }, r, _37b + (j + 0.5) * _390, _37b + (j + 0.5) * _390));
                                }
                                _38e.createPath().moveTo(_382.cx, _382.cy).lineTo(x1, y1).arcTo(r, r, 0, step > Math.PI, true, x2, y2).lineTo(_382.cx, _382.cy).closePath().setStroke(_38a.series.stroke);
                                _38c = _38e;
                            } else {
                                _38c = s.createPath().moveTo(_382.cx, _382.cy).lineTo(x1, y1).arcTo(r, r, 0, step > Math.PI, true, x2, y2).lineTo(_382.cx, _382.cy).closePath().setStroke(_38a.series.stroke);
                                _38b = _38a.series.fill;
                                if (_38b && _38b.type === "radial") {
                                    _38b = this._shapeFill(_38b, {
                                        x: _382.cx - _382.r,
                                        y: _382.cy - _382.r,
                                        width: 2 * _382.r,
                                        height: 2 * _382.r
                                    });
                                    if (this.opt.radGrad === "linear") {
                                        _38b = this._pseudoRadialFill(_38b, {
                                            x: _382.cx,
                                            y: _382.cy
                                        }, r, _37b, end);
                                    }
                                } else {
                                    if (_38b && _38b.type === "linear") {
                                        _38b = this._plotFill(_38b, dim, _378);
                                        _38b = this._shapeFill(_38b, _38c.getBoundingBox());
                                    }
                                }
                                _38c.setFill(_38b);
                            }
                            this.dyn.push({
                                fill: _38b,
                                stroke: _38a.series.stroke
                            });
                            if (_381) {
                                o = {
                                    element: "slice",
                                    index: i,
                                    run: this.run,
                                    shape: _38c,
                                    x: i,
                                    y: typeof v == "number" ? v : v.y,
                                    cx: _382.cx,
                                    cy: _382.cy,
                                    cr: r
                                };
                                this._connectEvents(o);
                                _388[i] = o;
                            }
                            _37b = end;
                            return false;
                        }, this);
                        if (this.opt.labels) {
                            if (this.opt.labelStyle == "default") {
                                _37b = _37a;
                                arr.some(_37d, function (_395, i) {
                                    if (_395 <= 0) {
                                        return false;
                                    }
                                    var _396 = _385[i],
                                        elem;
                                    if (_395 >= 1) {
                                        elem = da.createText[this.opt.htmlLabels && g.renderer != "vml" ? "html" : "gfx"](this.chart, s, _382.cx, _382.cy + size / 2, "middle", _37e[i], _396.series.font, _396.series.fontColor);
                                        if (this.opt.htmlLabels) {
                                            this.htmlElements.push(elem);
                                        }
                                        return true;
                                    }
                                    var end = _37b + _395 * 2 * Math.PI;
                                    if (i + 1 == _37d.length) {
                                        end = _37a + 2 * Math.PI;
                                    }
                                    if (this.opt.omitLabels && end - _37b < 0.001) {
                                        return false;
                                    }
                                    var _397 = (_37b + end) / 2,
                                        x = _382.cx + _380 * Math.cos(_397),
                                        y = _382.cy + _380 * Math.sin(_397) + size / 2;
                                    elem = da.createText[this.opt.htmlLabels && g.renderer != "vml" ? "html" : "gfx"](this.chart, s, x, y, "middle", _37e[i], _396.series.font, _396.series.fontColor);
                                    if (this.opt.htmlLabels) {
                                        this.htmlElements.push(elem);
                                    }
                                    _37b = end;
                                    return false;
                                }, this);
                            } else {
                                if (this.opt.labelStyle == "columns") {
                                    _37b = _37a;
                                    var _398 = this.opt.omitLabels;
                                    var _399 = [];
                                    arr.forEach(_37d, function (_39a, i) {
                                        var end = _37b + _39a * 2 * Math.PI;
                                        if (i + 1 == _37d.length) {
                                            end = _37a + 2 * Math.PI;
                                        }
                                        var _39b = (_37b + end) / 2;
                                        _399.push({
                                            angle: _39b,
                                            left: Math.cos(_39b) < 0,
                                            theme: _385[i],
                                            index: i,
                                            omit: _398 ? end - _37b < 0.001 : false
                                        });
                                        _37b = end;
                                    });
                                    var _39c = g._base._getTextBox("a", {
                                        font: _379
                                    }).h;
                                    this._getProperLabelRadius(_399, _39c, _382.r * 1.1);
                                    arr.forEach(_399, function (_39d, i) {
                                        if (!_39d.omit) {
                                            var _39e = _382.cx - _382.r * 2,
                                                _39f = _382.cx + _382.r * 2,
                                                _3a0 = g._base._getTextBox(_37e[i], {
                                                    font: _39d.theme.series.font
                                                }).w,
                                                x = _382.cx + _39d.labelR * Math.cos(_39d.angle),
                                                y = _382.cy + _39d.labelR * Math.sin(_39d.angle),
                                                _3a1 = (_39d.left) ? (_39e + _3a0) : (_39f - _3a0),
                                                _3a2 = (_39d.left) ? _39e : _3a1;
                                            var _3a3 = s.createPath().moveTo(_382.cx + _382.r * Math.cos(_39d.angle), _382.cy + _382.r * Math.sin(_39d.angle));
                                            if (Math.abs(_39d.labelR * Math.cos(_39d.angle)) < _382.r * 2 - _3a0) {
                                                _3a3.lineTo(x, y);
                                            }
                                            _3a3.lineTo(_3a1, y).setStroke(_39d.theme.series.labelWiring);
                                            var elem = da.createText[this.opt.htmlLabels && g.renderer != "vml" ? "html" : "gfx"](this.chart, s, _3a2, y, "left", _37e[i], _39d.theme.series.font, _39d.theme.series.fontColor);
                                            if (this.opt.htmlLabels) {
                                                this.htmlElements.push(elem);
                                            }
                                        }
                                    }, this);
                                }
                            }
                        }
                        var esi = 0;
                        this._eventSeries[this.run.name] = df.map(run, function (v) {
                            return v <= 0 ? null : _388[esi++];
                        });
                        return this;
                    },
                    _getProperLabelRadius: function (_3a4, _3a5, _3a6) {
                        var _3a7, _3a8, _3a9 = 1,
                            _3aa = 1;
                        if (_3a4.length == 1) {
                            _3a4[0].labelR = _3a6;
                            return;
                        }
                        for (var i = 0; i < _3a4.length; i++) {
                            var _3ab = Math.abs(Math.sin(_3a4[i].angle));
                            if (_3a4[i].left) {
                                if (_3a9 >= _3ab) {
                                    _3a9 = _3ab;
                                    _3a7 = _3a4[i];
                                }
                            } else {
                                if (_3aa >= _3ab) {
                                    _3aa = _3ab;
                                    _3a8 = _3a4[i];
                                }
                            }
                        }
                        _3a7.labelR = _3a8.labelR = _3a6;
                        this._calculateLabelR(_3a7, _3a4, _3a5);
                        this._calculateLabelR(_3a8, _3a4, _3a5);
                    },
                    _calculateLabelR: function (_3ac, _3ad, _3ae) {
                        var i = _3ac.index,
                            _3af = _3ad.length,
                            _3b0 = _3ac.labelR,
                            _3b1;
                        while (!(_3ad[i % _3af].left ^ _3ad[(i + 1) % _3af].left)) {
                            if (!_3ad[(i + 1) % _3af].omit) {
                                _3b1 = (Math.sin(_3ad[i % _3af].angle) * _3b0 + ((_3ad[i % _3af].left) ? (-_3ae) : _3ae)) / Math.sin(_3ad[(i + 1) % _3af].angle);
                                _3b0 = (_3b1 < _3ac.labelR) ? _3ac.labelR : _3b1;
                                _3ad[(i + 1) % _3af].labelR = _3b0;
                            }
                            i++;
                        }
                        i = _3ac.index;
                        var j = (i == 0) ? _3af - 1 : i - 1;
                        while (!(_3ad[i].left ^ _3ad[j].left)) {
                            if (!_3ad[j].omit) {
                                _3b1 = (Math.sin(_3ad[i].angle) * _3b0 + ((_3ad[i].left) ? _3ae : (-_3ae))) / Math.sin(_3ad[j].angle);
                                _3b0 = (_3b1 < _3ac.labelR) ? _3ac.labelR : _3b1;
                                _3ad[j].labelR = _3b0;
                            }
                            i--;
                            j--;
                            i = (i < 0) ? i + _3ad.length : i;
                            j = (j < 0) ? j + _3ad.length : j;
                        }
                    },
                    _getLabel: function (_3b2) {
                        return dc.getLabel(_3b2, this.opt.fixed, this.opt.precision);
                    }
                });
            });
        }
    }
});
require(["dojo/_base/window", "dojo/dom", "dojo/dom-construct", "dojo/dom-style", "dojo/ready", "dojo/on", "dojo/query", "dojox/charting/Chart", "dojox/charting/axis2d/Default", "dojox/charting/plot2d/ClusteredBars", "dojox/charting/plot2d/ClusteredColumns", "dojox/charting/plot2d/Default", "dojox/charting/plot2d/StackedAreas", "dojox/charting/plot2d/Bubble", "dojox/charting/plot2d/Candlesticks", "dojox/charting/plot2d/OHLC", "dojox/charting/plot2d/Pie"], function (win, dom, _3b3, _3b4, _3b5, on, _3b6, _3b7, _3b8, _3b9, _3ba, _3bb, _3bc, _3bd, _3be, OHLC, Pie) {
    var _3bf = {}, _3c0, _3c1, _3c2, _3c3 = "";

    function _3c4(name) {
        var _3c5 = dom.byId("themeChooser"),
            _3c6 = dom.byId("pageStyleChooser").checked;
        var test = false;
        if (name) {
            for (var i = 0, l = _3c5.options.length; i < l; i++) {
                if (_3c5.options[i].value == name) {
                    _3c5.options[i].selected = true;
                    test = true;
                    break;
                }
            }
        }
        if (!test) {
            name = _3c5.options[_3c5.selectedIndex].value;
        }
        require(["dojox/charting/themes/" + name.replace(".", "/")], function (_3c7) {
            var _3c8 = _3c7.chart;
            if (_3c6 && _3c8.pageStyle) {
                _3b4.set(win.body(), _3c8.pageStyle);
            } else {
                _3b4.set(win.body(), {
                    backgroundColor: _3c1,
                    backgroundImage: _3c0,
                    color: _3c2
                });
            } if (_3c3 != name) {
                _3c3 = name;
                if (_3c7) {
                    for (var _3c9 in _3bf) {
                        _3bf[_3c9].setTheme(_3c7).render();
                    }
                }
            }
        });
    };


    function init() {

        _3c0 = _3b4.get(win.body(), "backgroundImage");
        _3c1 = _3b4.get(win.body(), "backgroundColor");
        _3c2 = _3b4.get(win.body(), "color");
        _3bf.bars = new _3b7("bars").addAxis("y", {
            fixLower: "minor",
            fixUpper: "minor",
            natural: true
        }).addAxis("x", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            includeZero: true
        }).addPlot("default", {
            type: _3b9,
            gap: 5
        }).addSeries("Series A", [0.53, 0.51]).addSeries("Series B", [0.84, 0.79]).addSeries("Series C", [0.68, 0.95]).addSeries("Series D", [0.77, 0.66]);

        //grafico de costo

        _3bf.columns = new _3b7("columns").addAxis("x", {
            fixLower: "minor",
            fixUpper: "minor",
            natural: true,
            labels: [{value: 1, text: nombres0}, {value: 2, text: nombres1},
                {value: 3, text: nombres2}]
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            includeZero: true
        }).addPlot("default", {
            type: _3ba,
            gap: 5
        });

        //acá van los datos

        _3bf.columns.addSeries("Series A", [0.84, 0.79, 0.33]).addSeries("Series B", [0.13, 0.51, 0.12]);



        _3bf.lines = new _3b7("lines").addAxis("x", {
            min: 0,
            max: 6,
            fixLower: "minor",
            fixUpper: "minor",
            natural: true
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            includeZero: true,
            max: 1
        }).addPlot("default", {
            type: _3bb,
            lines: true,
            markers: true,
            tension: "X"
        }).addSeries("Series A", [{
                x: 0.5,
                y: 0.2
            }, {
                x: 1.5,
                y: 0.4
            }, {
                x: 2,
                y: 0.1
            }, {
                x: 5,
                y: 0.9
            }
        ]).addSeries("Series B", [{
                x: 0.3,
                y: 0.6
            }, {
                x: 3,
                y: 0.5
            }, {
                x: 4,
                y: 0.9
            }, {
                x: 5.5,
                y: 0.7
            }
        ]).addSeries("Series C", [{
                x: 0.8,
                y: 0.8
            }, {
                x: 3.4,
                y: 0.2
            }, {
                x: 5.3,
                y: 0.3
            }
        ]).addSeries("Series D", [{
                x: 0.6,
                y: 0.9
            }, {
                x: 3.2,
                y: 0.8
            }, {
                x: 5,
                y: 0.1
            }
        ]);

        // piechart graph

        _3bf.pieFan = new _3b7("pieFan").addPlot("default", {
            type: Pie,
            radius: 60,
            labelOffset: -20,
            radGrad: dojox.gfx.renderer == "vml" ? "fan" : "native"
        }).addSeries("Series A", [0.35, 0.25, 0.42, 0.53, 0.19]);



        _3bf.bubbles = new _3b7("bubbles").addAxis("x", {
            min: 0,
            max: 6,
            fixLower: "minor",
            fixUpper: "minor",
            natural: true
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            includeZero: true
        }).addPlot("default", {
            type: _3bd
        }).addSeries("Series A", [{
                x: 0.5,
                y: 5,
                size: 1.4
            }, {
                x: 1.5,
                y: 1.5,
                size: 4.5
            }, {
                x: 2,
                y: 9,
                size: 1.5
            }, {
                x: 5,
                y: 0.3,
                size: 0.8
            }
        ]).addSeries("Series B", [{
                x: 0.3,
                y: 8,
                size: 2.5
            }, {
                x: 4,
                y: 6,
                size: 2.1
            }, {
                x: 5.5,
                y: 2,
                size: 3.2
            }
        ]).addSeries("Series C", [{
                x: 2,
                y: 5.5,
                size: 2.5
            }, {
                x: 3.5,
                y: 2.5,
                size: 3.5
            }, {
                x: 5.2,
                y: 7,
                size: 3
            }
        ]).addSeries("Series D", [{
                x: 3.2,
                y: 8,
                size: 2
            }
        ]);
        _3bf.area = new _3b7("area").addAxis("x", {
            fixLower: "major",
            fixUpper: "major"
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            min: 0
        }).addPlot("default", {
            type: _3bc,
            tension: "X"
        }).addSeries("Series A", [-2, 1.1, 1.2, 1.3, 1.4, 1.5, -1.6]).addSeries("Series B", [1, 1.6, 1.3, 1.4, 1.1, 1.5, 1.1]).addSeries("Series C", [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6]);
        _3bf.pieLin = new _3b7("pieLin").addPlot("default", {
            type: Pie,
            radius: 60,
            labelOffset: -20,
            radGrad: "linear"
        }).addSeries("Series A", [0.35, 0.25, 0.42, 0.53, 0.69]);
        _3bf.candle = new _3b7("candle").addPlot("default", {
            type: _3be,
            gap: 1
        }).addAxis("x", {
            fixLower: "major",
            fixUpper: "major",
            includeZero: true
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            natural: true
        }).addSeries("Series A", [{
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6,
                mid: 18
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11,
                mid: 21
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14,
                mid: 27
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13,
                mid: 27
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6,
                mid: 18
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11,
                mid: 21
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14,
                mid: 27
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13,
                mid: 27
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }
        ]);
        _3bf.ohlc = new _3b7("ohlc").addPlot("default", {
            type: OHLC,
            gap: 1
        }).addAxis("x", {
            fixLower: "major",
            fixUpper: "major",
            includeZero: true
        }).addAxis("y", {
            vertical: true,
            fixLower: "major",
            fixUpper: "major",
            natural: true
        }).addSeries("Series A", [{
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }, {
                open: 16,
                close: 22,
                high: 26,
                low: 6
            }, {
                open: 22,
                close: 18,
                high: 22,
                low: 11
            }, {
                open: 18,
                close: 29,
                high: 32,
                low: 14
            }, {
                open: 29,
                close: 24,
                high: 29,
                low: 13
            }, {
                open: 24,
                close: 8,
                high: 24,
                low: 5
            }, {
                open: 8,
                close: 16,
                high: 22,
                low: 2
            }, {
                open: 16,
                close: 12,
                high: 19,
                low: 7
            }, {
                open: 12,
                close: 20,
                high: 22,
                low: 8
            }, {
                open: 20,
                close: 16,
                high: 22,
                low: 8
            }
        ]);
        var name;
        if (window.location.search.indexOf("?") > -1) {
            name = window.location.search.substring(1);
            _3b3.create("span", {
                style: "display: inline-block; margin-left: 1em;",
                innerHTML: "<a href=\"theme_preview-amd.html\">Back to the Theme Previewer &raquo;&raquo;</a>"
            }, _3b6("p.controls")[0]);
        }
        _3c4(name);
        on(dom.byId("themeChooser"), "change", _3c4);
        on(dom.byId("pageStyleChooser"), "click", _3c4);
    };
    _3b5(init);
});