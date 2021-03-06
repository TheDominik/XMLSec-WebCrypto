###
Adapted from certain functions from here:
https://github.com/yaronn/ws.js/blob/master/lib/utils.js
###
class window.utils

  constructor: () ->
  
  @findAttr: (node, localName, namespace) ->
    for attr in node.attributes
      if @attrEqualsExplicitly(attr, localName, namespace) || @attrEqualsImplicitly(attr, localName, namespace, node)
        return attr
    return null
    
  @findFirst: (doc, input_xpath) ->
    nodes = xpath.select input_xpath, doc
    if nodes.length == 0
      throw "could not find xpath " + input_xpath
    return nodes[0]

  @findChilds: (node, localName, namespace) ->
    node = node.documentElement || node;
    res = []
    for child in node.childNodes
      if child.localName == localName && (child.namespaceURI == namespace || !namespace)
        res.push child
    return res

  @attrEqualsExplicitly: (attr, localName, namespace) ->
    return attr.localName==localName && (attr.namespaceURI==namespace || !namespace)

  @attrEqualsImplicitly: (attr, localName, namespace, node) ->
    return attr.localName==localName && ((!attr.namespaceURI && node.namespaceURI==namespace) || !namespace)
  
  # borrowed from jquery
  # https://github.com/jquery/jquery/blob/master/src/ajax/parseXML.js
  @parseXML: (data) ->
    if !data or typeof data isnt "string"
      return null
    # Support: IE 9 - 11 only
    # IE throws on parseFromString with invalid input.
    try
      xml = (new window.DOMParser()).parseFromString(data, "text/xml")
    catch error
      xml = undefined
    if !xml or xml.getElementsByTagName("parsererror").length
      throw "Invalid XML: #{data}"
    return xml