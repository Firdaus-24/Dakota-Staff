/*!
 Buttons for DataTables 2.0.0
 ©2016-2021 SpryMedia Ltd - datatables.net/license
*/
(function (e) { "function" === typeof define && define.amd ? define(["jquery", "datatables.net"], function (B) { return e(B, window, document) }) : "object" === typeof exports ? module.exports = function (B, y) { B || (B = window); y && y.fn.dataTable || (y = require("datatables.net")(B, y).$); return e(y, B, B.document) } : e(jQuery, window, document) })(function (e, B, y, q) {
    function I(a, b, c) { e.fn.animate ? a.stop().fadeIn(b, c) : (a.css("display", "block"), c && c.call(a)) } function J(a, b, c) { e.fn.animate ? a.stop().fadeOut(b, c) : (a.css("display", "none"), c && c.call(a)) }
    function L(a, b) { a = new t.Api(a); b = b ? b : a.init().buttons || t.defaults.buttons; return (new v(a, b)).container() } var t = e.fn.dataTable, O = 0, P = 0, z = t.ext.buttons, v = function (a, b) {
        if (!(this instanceof v)) return function (c) { return (new v(c, a)).container() }; "undefined" === typeof b && (b = {}); !0 === b && (b = {}); Array.isArray(b) && (b = { buttons: b }); this.c = e.extend(!0, {}, v.defaults, b); b.buttons && (this.c.buttons = b.buttons); this.s = { dt: new t.Api(a), buttons: [], listenKeys: "", namespace: "dtb" + O++ }; this.dom = {
            container: e("<" + this.c.dom.container.tag +
                "/>").addClass(this.c.dom.container.className)
        }; this._constructor()
    }; e.extend(v.prototype, {
        action: function (a, b) { a = this._nodeToButton(a); if (b === q) return a.conf.action; a.conf.action = b; return this }, active: function (a, b) { var c = this._nodeToButton(a); a = this.c.dom.button.active; c = e(c.node); if (b === q) return c.hasClass(a); c.toggleClass(a, b === q ? !0 : b); return this }, add: function (a, b) {
            var c = this.s.buttons; if ("string" === typeof b) {
                b = b.split("-"); var d = this.s; c = 0; for (var h = b.length - 1; c < h; c++)d = d.buttons[1 * b[c]]; c = d.buttons;
                b = 1 * b[b.length - 1]
            } this._expandButton(c, a, a !== q ? a.split : q, (a === q || a.split === q || 0 === a.split.length) && d !== q, !1, b); this._draw(); return this
        }, collectionRebuild: function (a, b) { a = this._nodeToButton(a); var c; for (c = a.buttons.length - 1; 0 <= c; c--)this.remove(a.buttons[c].node); for (c = 0; c < b.length; c++)this._expandButton(a.buttons, b[c], !0, c); this._draw(a.collection, a.buttons) }, container: function () { return this.dom.container }, disable: function (a) {
            a = this._nodeToButton(a); e(a.node).addClass(this.c.dom.button.disabled).attr("disabled",
                !0); return this
        }, destroy: function () { e("body").off("keyup." + this.s.namespace); var a = this.s.buttons.slice(), b; var c = 0; for (b = a.length; c < b; c++)this.remove(a[c].node); this.dom.container.remove(); a = this.s.dt.settings()[0]; c = 0; for (b = a.length; c < b; c++)if (a.inst === this) { a.splice(c, 1); break } return this }, enable: function (a, b) { if (!1 === b) return this.disable(a); a = this._nodeToButton(a); e(a.node).removeClass(this.c.dom.button.disabled).removeAttr("disabled"); return this }, name: function () { return this.c.name }, node: function (a) {
            if (!a) return this.dom.container;
            a = this._nodeToButton(a); return e(a.node)
        }, processing: function (a, b) { var c = this.s.dt, d = this._nodeToButton(a); if (b === q) return e(d.node).hasClass("processing"); e(d.node).toggleClass("processing", b); e(c.table().node()).triggerHandler("buttons-processing.dt", [b, c.button(a), c, e(a), d.conf]); return this }, remove: function (a) {
            var b = this._nodeToButton(a), c = this._nodeToHost(a), d = this.s.dt; if (b.buttons.length) for (var h = b.buttons.length - 1; 0 <= h; h--)this.remove(b.buttons[h].node); b.conf.destroying = !0; b.conf.destroy &&
                b.conf.destroy.call(d.button(a), d, e(a), b.conf); this._removeKey(b.conf); e(b.node).remove(); a = e.inArray(b, c); c.splice(a, 1); return this
        }, text: function (a, b) { var c = this._nodeToButton(a); a = this.c.dom.collection.buttonLiner; a = c.inCollection && a && a.tag ? a.tag : this.c.dom.buttonLiner.tag; var d = this.s.dt, h = e(c.node), g = function (l) { return "function" === typeof l ? l(d, h, c.conf) : l }; if (b === q) return g(c.conf.text); c.conf.text = b; a ? h.children(a).html(g(b)) : h.html(g(b)); return this }, _constructor: function () {
            var a = this, b = this.s.dt,
                c = b.settings()[0], d = this.c.buttons; c._buttons || (c._buttons = []); c._buttons.push({ inst: this, name: this.c.name }); for (var h = 0, g = d.length; h < g; h++)this.add(d[h]); b.on("destroy", function (l, k) { k === c && a.destroy() }); e("body").on("keyup." + this.s.namespace, function (l) { if (!y.activeElement || y.activeElement === y.body) { var k = String.fromCharCode(l.keyCode).toLowerCase(); -1 !== a.s.listenKeys.toLowerCase().indexOf(k) && a._keypress(k, l) } })
        }, _addKey: function (a) {
            a.key && (this.s.listenKeys += e.isPlainObject(a.key) ? a.key.key :
                a.key)
        }, _draw: function (a, b) { a || (a = this.dom.container, b = this.s.buttons); a.children().detach(); for (var c = 0, d = b.length; c < d; c++)a.append(b[c].inserter), a.append(" "), b[c].buttons && b[c].buttons.length && this._draw(b[c].collection, b[c].buttons) }, _expandButton: function (a, b, c, d, h, g, l) {
            var k = this.s.dt, n = 0, p = Array.isArray(b) ? b : [b]; b === q && (p = Array.isArray(c) ? c : [c]); c = 0; for (var r = p.length; c < r; c++) {
                var f = this._resolveExtends(p[c]); if (f) if (b = f.config !== q && f.config.split ? !0 : !1, Array.isArray(f)) this._expandButton(a,
                    f, m !== q && m.conf !== q ? m.conf.split : q, d, l !== q && l.split !== q, g, l); else {
                    var m = this._buildButton(f, d, f.split !== q || f.config !== q && f.config.split !== q, h); if (m) {
                        g !== q && null !== g ? (a.splice(g, 0, m), g++) : a.push(m); if (m.conf.buttons || m.conf.split) {
                            m.collection = e("<" + (b ? this.c.dom.splitCollection.tag : this.c.dom.collection.tag) + "/>"); m.conf._collection = m.collection; if (m.conf.split) for (var u = 0; u < m.conf.split.length; u++)"object" === typeof m.conf.split[u] && (m.conf.split[c].parent = l, m.conf.split[u].collectionLayout === q &&
                                (m.conf.split[u].collectionLayout = m.conf.collectionLayout), m.conf.split[u].dropup === q && (m.conf.split[u].dropup = m.conf.dropup), m.conf.split[u].fade === q && (m.conf.split[u].fade = m.conf.fade)); else e(m.node).append(e('<span class="dt-down-arrow">' + this.c.dom.splitDropdown.text + "</span>")); this._expandButton(m.buttons, m.conf.buttons, m.conf.split, !b, b, g, m.conf)
                        } m.conf.parent = l; f.init && f.init.call(k.button(m.node), k, e(m.node), f); n++
                    }
                }
            }
        }, _buildButton: function (a, b, c, d) {
            var h = this.c.dom.button, g = this.c.dom.buttonLiner,
                l = this.c.dom.collection, k = this.c.dom.splitCollection, n = this.c.dom.splitDropdownButton, p = this.s.dt, r = function (w) { return "function" === typeof w ? w(p, f, a) : w }; !c && d && k ? h = n : !c && b && l.button && (h = l.button); !c && d && k.buttonLiner ? g = k.buttonLiner : !c && b && l.buttonLiner && (g = l.buttonLiner); if (a.available && !a.available(p, a) && !a.hasOwnProperty("html")) return !1; if (a.hasOwnProperty("html")) var f = e(a.html); else {
                    var m = function (w, A, C, F) {
                        F.action.call(A.button(C), w, A, C, F); e(A.table().node()).triggerHandler("buttons-action.dt",
                            [A.button(C), A, C, F])
                    }; l = a.tag || h.tag; var u = a.clickBlurs === q ? !0 : a.clickBlurs; f = e("<" + l + "/>").addClass(h.className).addClass(d ? this.c.dom.splitDropdownButton.className : "").attr("tabindex", this.s.dt.settings()[0].iTabIndex).attr("aria-controls", this.s.dt.table().node().id).on("click.dtb", function (w) { w.preventDefault(); !f.hasClass(h.disabled) && a.action && m(w, p, f, a); u && f.trigger("blur") }).on("keyup.dtb", function (w) { 13 === w.keyCode && !f.hasClass(h.disabled) && a.action && m(w, p, f, a) }); "a" === l.toLowerCase() && f.attr("href",
                        "#"); "button" === l.toLowerCase() && f.attr("type", "button"); g.tag ? (l = e("<" + g.tag + "/>").html(r(a.text)).addClass(g.className), "a" === g.tag.toLowerCase() && l.attr("href", "#"), f.append(l)) : f.html(r(a.text)); !1 === a.enabled && f.addClass(h.disabled); a.className && f.addClass(a.className); a.titleAttr && f.attr("title", r(a.titleAttr)); a.attr && f.attr(a.attr); a.namespace || (a.namespace = ".dt-button-" + P++); a.config !== q && a.config.split && (a.split = a.config.split)
                } g = (g = this.c.dom.buttonContainer) && g.tag ? e("<" + g.tag + "/>").addClass(g.className).append(f) :
                    f; this._addKey(a); this.c.buttonCreated && (g = this.c.buttonCreated(a, g)); if (c) {
                        var x = e("<div/>").addClass(this.c.dom.splitWrapper.className); x.append(f); var D = e.extend(a, { text: this.c.dom.splitDropdown.text, className: this.c.dom.splitDropdown.className, attr: { "aria-haspopup": !0, "aria-expanded": !1 }, align: this.c.dom.splitDropdown.align, splitAlignClass: this.c.dom.splitDropdown.splitAlignClass }); this._addKey(D); var G = function (w, A, C, F) {
                            z.split.action.call(A.button(e("div.dt-btn-split-wrapper")[0]), w, A, C, F);
                            e(A.table().node()).triggerHandler("buttons-action.dt", [A.button(C), A, C, F]); C.attr("aria-expanded", !0)
                        }, E = e('<button class="' + this.c.dom.splitDropdown.className + ' dt-button"><span class="dt-btn-split-drop-arrow">' + this.c.dom.splitDropdown.text + "</span></button>").on("click.dtb", function (w) { w.preventDefault(); !E.hasClass(h.disabled) && D.action && G(w, p, E, D); u && E.trigger("blur") }).on("keyup.dtb", function (w) { 13 === w.keyCode && !E.hasClass(h.disabled) && D.action && G(w, p, E, D) }); 0 === a.split.length && E.addClass("dtb-hide-drop");
                        x.append(E).attr(D.attr)
                    } return { conf: a, node: c ? x.get(0) : f.get(0), inserter: c ? x : g, buttons: [], inCollection: b, isSplit: c, inSplit: d, collection: null }
        }, _nodeToButton: function (a, b) { b || (b = this.s.buttons); for (var c = 0, d = b.length; c < d; c++) { if (b[c].node === a) return b[c]; if (b[c].buttons.length) { var h = this._nodeToButton(a, b[c].buttons); if (h) return h } } }, _nodeToHost: function (a, b) {
            b || (b = this.s.buttons); for (var c = 0, d = b.length; c < d; c++) {
                if (b[c].node === a) return b; if (b[c].buttons.length) {
                    var h = this._nodeToHost(a, b[c].buttons);
                    if (h) return h
                }
            }
        }, _keypress: function (a, b) { if (!b._buttonsHandled) { var c = function (d) { for (var h = 0, g = d.length; h < g; h++) { var l = d[h].conf, k = d[h].node; l.key && (l.key === a ? (b._buttonsHandled = !0, e(k).click()) : !e.isPlainObject(l.key) || l.key.key !== a || l.key.shiftKey && !b.shiftKey || l.key.altKey && !b.altKey || l.key.ctrlKey && !b.ctrlKey || l.key.metaKey && !b.metaKey || (b._buttonsHandled = !0, e(k).click())); d[h].buttons.length && c(d[h].buttons) } }; c(this.s.buttons) } }, _removeKey: function (a) {
            if (a.key) {
                var b = e.isPlainObject(a.key) ?
                    a.key.key : a.key; a = this.s.listenKeys.split(""); b = e.inArray(b, a); a.splice(b, 1); this.s.listenKeys = a.join("")
            }
        }, _resolveExtends: function (a) {
            var b = this.s.dt, c, d = function (k) { for (var n = 0; !e.isPlainObject(k) && !Array.isArray(k);) { if (k === q) return; if ("function" === typeof k) { if (k = k(b, a), !k) return !1 } else if ("string" === typeof k) { if (!z[k]) return { html: k }; k = z[k] } n++; if (30 < n) throw "Buttons: Too many iterations"; } return Array.isArray(k) ? k : e.extend({}, k) }; for (a = d(a); a && a.extend;) {
                if (!z[a.extend]) throw "Cannot extend unknown button type: " +
                    a.extend; var h = d(z[a.extend]); if (Array.isArray(h)) return h; if (!h) return !1; var g = h.className; a.config !== q && h.config !== q && (a.config = e.extend({}, h.config, a.config)); a = e.extend({}, h, a); g && a.className !== g && (a.className = g + " " + a.className); var l = a.postfixButtons; if (l) { a.buttons || (a.buttons = []); g = 0; for (c = l.length; g < c; g++)a.buttons.push(l[g]); a.postfixButtons = null } if (l = a.prefixButtons) { a.buttons || (a.buttons = []); g = 0; for (c = l.length; g < c; g++)a.buttons.splice(g, 0, l[g]); a.prefixButtons = null } a.extend = h.extend
            } return a
        },
        _popover: function (a, b, c) {
            var d = this.c, h = e.extend({ align: "button-left", autoClose: !1, background: !0, backgroundClassName: "dt-button-background", contentClassName: d.dom.collection.className, collectionLayout: "", collectionTitle: "", dropup: !1, fade: 400, popoverTitle: "", rightAlignClassName: "dt-button-right", splitRightAlignClassName: "dt-button-split-right", splitLeftAlignClassName: "dt-button-split-left", tag: d.dom.collection.tag }, c), g = b.node(), l = function () {
                J(e(".dt-button-collection"), h.fade, function () { e(this).detach() });
                e(b.buttons('[aria-haspopup="true"][aria-expanded="true"]').nodes()).attr("aria-expanded", "false"); e("div.dt-button-background").off("click.dtb-collection"); v.background(!1, h.backgroundClassName, h.fade, g); e("body").off(".dtb-collection"); b.off("buttons-action.b-internal")
            }; !1 === a && l(); c = e(b.buttons('[aria-haspopup="true"][aria-expanded="true"]').nodes()); c.length && (g = c.eq(0), l()); c = e("<div/>").addClass("dt-button-collection").addClass(h.collectionLayout).addClass(h.splitAlignClass).css("display",
                "none"); a = e(a).addClass(h.contentClassName).attr("role", "menu").appendTo(c); g.attr("aria-expanded", "true"); g.parents("body")[0] !== y.body && (g = y.body.lastChild); h.popoverTitle ? c.prepend('<div class="dt-button-collection-title">' + h.popoverTitle + "</div>") : h.collectionTitle && c.prepend('<div class="dt-button-collection-title">' + h.collectionTitle + "</div>"); I(c.insertAfter(g), h.fade); var k = e(b.table().container()); d = c.css("position"); "dt-container" === h.align && (g = g.parent(), c.css("width", k.width())); if ("absolute" ===
                    d) {
                var n = g.position(); d = e(b.node()).position(); c.css({ top: e(e(b[0].node).parent()[0]).hasClass("dt-buttons") ? d.top + g.outerHeight() : n.top + g.outerHeight(), left: n.left }); n = c.outerHeight(); var p = k.offset().top + k.height(); p = d.top + g.outerHeight() + n - p; var r = d.top - n, f = k.offset().top; d = d.top - n - 5; (p > f - r || h.dropup) && -d < f && c.css("top", d); d = k.offset().left; k = k.width(); k = d + k; n = c.offset().left; p = c.outerWidth(); 0 === p && 0 < c.children().length && (p = e(c.children()[0]).outerWidth()); p = n + p; var m = g.offset().left; f = g.outerWidth();
                r = m + f; if (c.hasClass(h.rightAlignClassName) || c.hasClass(h.leftAlignClassName) || c.hasClass(h.splitAlignClass) || "dt-container" === h.align) {
                    var u = r; g.hasClass("dt-btn-split-wrapper") && 0 < g.children("button.dt-btn-split-drop").length && (m = g.children("button.dt-btn-split-drop").offset().left, f = g.children("button.dt-btn-split-drop").outerWidth(), u = m + f); f = 0; if (c.hasClass(h.rightAlignClassName)) f = r - p, d > n + f && (d -= n + f, k -= p + f, f = d > k ? f + k : f + d); else if (c.hasClass(h.splitRightAlignClassName)) f = u - p, d > n + f && (d -= n + f, k -= p +
                        f, f = d > k ? f + k : f + d); else if (c.hasClass(h.splitLeftAlignClassName)) { if (f = m - n, k < p + f || d > n + f) d -= n + f, k -= p + f, f = d > k ? f + k : f + d } else f = d - n, k < p + f && (d -= n + f, k -= p + f, f = d > k ? f + k : f + d)
                } else d = g.offset().top, f = 0, f = "button-right" === h.align ? r - p : m - n; c.css("left", c.position().left + f)
            } else d = c.height() / 2, d > e(B).height() / 2 && (d = e(B).height() / 2), c.css("marginTop", -1 * d); h.background && v.background(!0, h.backgroundClassName, h.fade, g); e("div.dt-button-background").on("click.dtb-collection", function () { }); e("body").on("click.dtb-collection",
                function (x) { var D = e.fn.addBack ? "addBack" : "andSelf", G = e(x.target).parent()[0]; (!e(x.target).parents()[D]().filter(a).length && !e(G).hasClass("dt-buttons") || e(x.target).hasClass("dt-button-background")) && l() }).on("keyup.dtb-collection", function (x) { 27 === x.keyCode && l() }); h.autoClose && setTimeout(function () { b.on("buttons-action.b-internal", function (x, D, G, E) { E[0] !== g[0] && l() }) }, 0); e(c).trigger("buttons-popover.dt")
        }
    }); v.background = function (a, b, c, d) {
        c === q && (c = 400); d || (d = y.body); a ? I(e("<div/>").addClass(b).css("display",
            "none").insertAfter(d), c) : J(e("div." + b), c, function () { e(this).removeClass(b).remove() })
    }; v.instanceSelector = function (a, b) { if (a === q || null === a) return e.map(b, function (g) { return g.inst }); var c = [], d = e.map(b, function (g) { return g.name }), h = function (g) { if (Array.isArray(g)) for (var l = 0, k = g.length; l < k; l++)h(g[l]); else "string" === typeof g ? -1 !== g.indexOf(",") ? h(g.split(",")) : (g = e.inArray(g.trim(), d), -1 !== g && c.push(b[g].inst)) : "number" === typeof g && c.push(b[g].inst) }; h(a); return c }; v.buttonSelector = function (a, b) {
        for (var c =
            [], d = function (k, n, p) { for (var r, f, m = 0, u = n.length; m < u; m++)if (r = n[m]) f = p !== q ? p + m : m + "", k.push({ node: r.node, name: r.conf.name, idx: f }), r.buttons && d(k, r.buttons, f + "-") }, h = function (k, n) {
                var p, r = []; d(r, n.s.buttons); var f = e.map(r, function (m) { return m.node }); if (Array.isArray(k) || k instanceof e) for (f = 0, p = k.length; f < p; f++)h(k[f], n); else if (null === k || k === q || "*" === k) for (f = 0, p = r.length; f < p; f++)c.push({ inst: n, node: r[f].node }); else if ("number" === typeof k) c.push({ inst: n, node: n.s.buttons[k].node }); else if ("string" ===
                    typeof k) if (-1 !== k.indexOf(",")) for (r = k.split(","), f = 0, p = r.length; f < p; f++)h(r[f].trim(), n); else if (k.match(/^\d+(\-\d+)*$/)) f = e.map(r, function (m) { return m.idx }), c.push({ inst: n, node: r[e.inArray(k, f)].node }); else if (-1 !== k.indexOf(":name")) for (k = k.replace(":name", ""), f = 0, p = r.length; f < p; f++)r[f].name === k && c.push({ inst: n, node: r[f].node }); else e(f).filter(k).each(function () { c.push({ inst: n, node: this }) }); else "object" === typeof k && k.nodeName && (r = e.inArray(k, f), -1 !== r && c.push({ inst: n, node: f[r] }))
            }, g = 0, l = a.length; g <
            l; g++)h(b, a[g]); return c
    }; v.stripData = function (a, b) { if ("string" !== typeof a) return a; a = a.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, ""); a = a.replace(/<!\-\-.*?\-\->/g, ""); if (!b || b.stripHtml) a = a.replace(/<[^>]*>/g, ""); if (!b || b.trim) a = a.replace(/^\s+|\s+$/g, ""); if (!b || b.stripNewlines) a = a.replace(/\n/g, " "); if (!b || b.decodeEntities) M.innerHTML = a, a = M.value; return a }; v.defaults = {
        buttons: ["copy", "excel", "csv", "pdf", "print"], name: "main", tabIndex: 0, dom: {
            container: { tag: "div", className: "dt-buttons" },
            collection: { tag: "div", className: "" }, button: { tag: "button", className: "dt-button", active: "active", disabled: "disabled" }, buttonLiner: { tag: "span", className: "" }, split: { tag: "div", className: "dt-button-split" }, splitWrapper: { tag: "div", className: "dt-btn-split-wrapper" }, splitDropdown: { tag: "button", text: "&#x25BC;", className: "dt-btn-split-drop", align: "split-right", splitAlignClass: "dt-button-split-left" }, splitDropdownButton: { tag: "button", className: "dt-btn-split-drop-button dt-button" }, splitCollection: {
                tag: "div",
                className: "dt-button-split-collection"
            }
        }
    }; v.version = "2.0.0"; e.extend(z, {
        collection: { text: function (a) { return a.i18n("buttons.collection", "Collection") }, className: "buttons-collection", init: function (a, b, c) { b.attr("aria-expanded", !1) }, action: function (a, b, c, d) { a.stopPropagation(); d._collection.parents("body").length ? this.popover(!1, d) : this.popover(d._collection, d) }, attr: { "aria-haspopup": !0 } }, split: {
            text: function (a) { return a.i18n("buttons.split", "Split") }, className: "buttons-split", init: function (a, b, c) {
                return b.attr("aria-expanded",
                    !1)
            }, action: function (a, b, c, d) { a.stopPropagation(); this.popover(d._collection, d) }, attr: { "aria-haspopup": !0 }
        }, copy: function (a, b) { if (z.copyHtml5) return "copyHtml5" }, csv: function (a, b) { if (z.csvHtml5 && z.csvHtml5.available(a, b)) return "csvHtml5" }, excel: function (a, b) { if (z.excelHtml5 && z.excelHtml5.available(a, b)) return "excelHtml5" }, pdf: function (a, b) { if (z.pdfHtml5 && z.pdfHtml5.available(a, b)) return "pdfHtml5" }, pageLength: function (a) {
            a = a.settings()[0].aLengthMenu; var b = [], c = []; if (Array.isArray(a[0])) b = a[0], c = a[1];
            else for (var d = 0; d < a.length; d++) { var h = a[d]; e.isPlainObject(h) ? (b.push(h.value), c.push(h.label)) : (b.push(h), c.push(h)) } return {
                extend: "collection", text: function (g) { return g.i18n("buttons.pageLength", { "-1": "Show all rows", _: "Show %d rows" }, g.page.len()) }, className: "buttons-page-length", autoClose: !0, buttons: e.map(b, function (g, l) {
                    return {
                        text: c[l], className: "button-page-length", action: function (k, n) { n.page.len(g).draw() }, init: function (k, n, p) {
                            var r = this; n = function () { r.active(k.page.len() === g) }; k.on("length.dt" +
                                p.namespace, n); n()
                        }, destroy: function (k, n, p) { k.off("length.dt" + p.namespace) }
                    }
                }), init: function (g, l, k) { var n = this; g.on("length.dt" + k.namespace, function () { n.text(k.text) }) }, destroy: function (g, l, k) { g.off("length.dt" + k.namespace) }
            }
        }
    }); t.Api.register("buttons()", function (a, b) { b === q && (b = a, a = q); this.selector.buttonGroup = a; var c = this.iterator(!0, "table", function (d) { if (d._buttons) return v.buttonSelector(v.instanceSelector(a, d._buttons), b) }, !0); c._groupSelector = a; return c }); t.Api.register("button()", function (a,
        b) { a = this.buttons(a, b); 1 < a.length && a.splice(1, a.length); return a }); t.Api.registerPlural("buttons().active()", "button().active()", function (a) { return a === q ? this.map(function (b) { return b.inst.active(b.node) }) : this.each(function (b) { b.inst.active(b.node, a) }) }); t.Api.registerPlural("buttons().action()", "button().action()", function (a) { return a === q ? this.map(function (b) { return b.inst.action(b.node) }) : this.each(function (b) { b.inst.action(b.node, a) }) }); t.Api.registerPlural("buttons().collectionRebuild()", "button().collectionRebuild()",
            function (a) { return this.each(function (b) { b.inst.collectionRebuild(b.node, a) }) }); t.Api.register(["buttons().enable()", "button().enable()"], function (a) { return this.each(function (b) { b.inst.enable(b.node, a) }) }); t.Api.register(["buttons().disable()", "button().disable()"], function () { return this.each(function (a) { a.inst.disable(a.node) }) }); t.Api.registerPlural("buttons().nodes()", "button().node()", function () { var a = e(); e(this.each(function (b) { a = a.add(b.inst.node(b.node)) })); return a }); t.Api.registerPlural("buttons().processing()",
                "button().processing()", function (a) { return a === q ? this.map(function (b) { return b.inst.processing(b.node) }) : this.each(function (b) { b.inst.processing(b.node, a) }) }); t.Api.registerPlural("buttons().text()", "button().text()", function (a) { return a === q ? this.map(function (b) { return b.inst.text(b.node) }) : this.each(function (b) { b.inst.text(b.node, a) }) }); t.Api.registerPlural("buttons().trigger()", "button().trigger()", function () { return this.each(function (a) { a.inst.node(a.node).trigger("click") }) }); t.Api.register("button().popover()",
                    function (a, b) { return this.map(function (c) { return c.inst._popover(a, this.button(this[0].node), b) }) }); t.Api.register("buttons().containers()", function () { var a = e(), b = this._groupSelector; this.iterator(!0, "table", function (c) { if (c._buttons) { c = v.instanceSelector(b, c._buttons); for (var d = 0, h = c.length; d < h; d++)a = a.add(c[d].container()) } }); return a }); t.Api.register("buttons().container()", function () { return this.containers().eq(0) }); t.Api.register("button().add()", function (a, b) {
                        var c = this.context; c.length && (c =
                            v.instanceSelector(this._groupSelector, c[0]._buttons), c.length && c[0].add(b, a)); return this.button(this._groupSelector, a)
                    }); t.Api.register("buttons().destroy()", function () { this.pluck("inst").unique().each(function (a) { a.destroy() }); return this }); t.Api.registerPlural("buttons().remove()", "buttons().remove()", function () { this.each(function (a) { a.inst.remove(a.node) }); return this }); var H; t.Api.register("buttons.info()", function (a, b, c) {
                        var d = this; if (!1 === a) return this.off("destroy.btn-info"), J(e("#datatables_buttons_info"),
                            400, function () { e(this).remove() }), clearTimeout(H), H = null, this; H && clearTimeout(H); e("#datatables_buttons_info").length && e("#datatables_buttons_info").remove(); a = a ? "<h2>" + a + "</h2>" : ""; I(e('<div id="datatables_buttons_info" class="dt-button-info"/>').html(a).append(e("<div/>")["string" === typeof b ? "html" : "append"](b)).css("display", "none").appendTo("body")); c !== q && 0 !== c && (H = setTimeout(function () { d.buttons.info(!1) }, c)); this.on("destroy.btn-info", function () { d.buttons.info(!1) }); return this
                    }); t.Api.register("buttons.exportData()",
                        function (a) { if (this.context.length) return Q(new t.Api(this.context[0]), a) }); t.Api.register("buttons.exportInfo()", function (a) {
                            a || (a = {}); var b = a; var c = "*" === b.filename && "*" !== b.title && b.title !== q && null !== b.title && "" !== b.title ? b.title : b.filename; "function" === typeof c && (c = c()); c === q || null === c ? c = null : (-1 !== c.indexOf("*") && (c = c.replace("*", e("head > title").text()).trim()), c = c.replace(/[^a-zA-Z0-9_\u00A1-\uFFFF\.,\-_ !\(\)]/g, ""), (b = K(b.extension)) || (b = ""), c += b); b = K(a.title); b = null === b ? null : -1 !== b.indexOf("*") ?
                                b.replace("*", e("head > title").text() || "Exported data") : b; return { filename: c, title: b, messageTop: N(this, a.message || a.messageTop, "top"), messageBottom: N(this, a.messageBottom, "bottom") }
                        }); var K = function (a) { return null === a || a === q ? null : "function" === typeof a ? a() : a }, N = function (a, b, c) { b = K(b); if (null === b) return null; a = e("caption", a.table().container()).eq(0); return "*" === b ? a.css("caption-side") !== c ? null : a.length ? a.text() : "" : b }, M = e("<textarea/>")[0], Q = function (a, b) {
                            var c = e.extend(!0, {}, {
                                rows: null, columns: "",
                                modifier: { search: "applied", order: "applied" }, orthogonal: "display", stripHtml: !0, stripNewlines: !0, decodeEntities: !0, trim: !0, format: { header: function (u) { return v.stripData(u, c) }, footer: function (u) { return v.stripData(u, c) }, body: function (u) { return v.stripData(u, c) } }, customizeData: null
                            }, b); b = a.columns(c.columns).indexes().map(function (u) { var x = a.column(u).header(); return c.format.header(x.innerHTML, u, x) }).toArray(); var d = a.table().footer() ? a.columns(c.columns).indexes().map(function (u) {
                                var x = a.column(u).footer();
                                return c.format.footer(x ? x.innerHTML : "", u, x)
                            }).toArray() : null, h = e.extend({}, c.modifier); a.select && "function" === typeof a.select.info && h.selected === q && a.rows(c.rows, e.extend({ selected: !0 }, h)).any() && e.extend(h, { selected: !0 }); h = a.rows(c.rows, h).indexes().toArray(); var g = a.cells(h, c.columns); h = g.render(c.orthogonal).toArray(); g = g.nodes().toArray(); for (var l = b.length, k = [], n = 0, p = 0, r = 0 < l ? h.length / l : 0; p < r; p++) { for (var f = [l], m = 0; m < l; m++)f[m] = c.format.body(h[n], p, m, g[n]), n++; k[p] = f } b = { header: b, footer: d, body: k };
                            c.customizeData && c.customizeData(b); return b
                        }; e.fn.dataTable.Buttons = v; e.fn.DataTable.Buttons = v; e(y).on("init.dt plugin-init.dt", function (a, b) { "dt" === a.namespace && (a = b.oInit.buttons || t.defaults.buttons) && !b._buttons && (new v(b, a)).container() }); t.ext.feature.push({ fnInit: L, cFeature: "B" }); t.ext.features && t.ext.features.register("buttons", L); return v
});