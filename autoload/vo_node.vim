" Node class {{{
function! vo_node#newNode(name, type, value) "{{{
	if !exists('s:nodes')
		call vo_node#init()
	endif
	let s:currentNodeID += 1
	let s:nodes[s:currentNodeID] = {
				\ 'ID'                     : s:currentNodeID                            ,
				\ 'class'                  : 'Node'                                     ,
				\ 'name'                   : a:name                                     ,
				\ 'type'                   : a:type                                     ,
				\ 'value'                  : a:value                                    ,
				\ 'attributes'             : {}                                         ,
				\ 'str'                    : function(s:SID().'Node2String')            ,
				\ 'setAttribute'           : function(s:SID().'SetAttribute')           ,
				\ 'removeAttribute'        : function(s:SID().'RemoveAttribute')        ,
				\ 'getAttribute'           : function(s:SID().'GetAttribute')           ,
				\ 'hasAttribute'           : function(s:SID().'HasAttribute')           ,
				\ 'hasAttributes'          : function(s:SID().'HasAttributes')          ,
				\ 'getAttributes'          : function(s:SID().'GetAttributes')          ,
				\ 'setAttributes'          : function(s:SID().'SetAttributes')          ,
				\ 'getFirstChild'          : function(s:SID().'GetFirstChild')          ,
				\ 'getNextSibling'         : function(s:SID().'GetNextSibling')         ,
				\ 'getParent'              : function(s:SID().'GetParent')              ,
				\ 'hasFirstChild'          : function(s:SID().'HasFirstChild')          ,
				\ 'hasNextSibling'         : function(s:SID().'HasNextSibling')         ,
				\ 'hasParent'              : function(s:SID().'HasParent')              ,
				\ 'getLastChild'           : function(s:SID().'GetLastChild')           ,
				\ 'getPrevSibling'         : function(s:SID().'GetPrevSibling')         ,
				\ 'hasLastChild'           : function(s:SID().'HasLastChild')           ,
				\ 'hasPrevSibling'         : function(s:SID().'HasPrevSibling')         ,
				\ 'getName'                : function(s:SID().'GetName')                ,
				\ 'getType'                : function(s:SID().'GetType')                ,
				\ 'getValue'               : function(s:SID().'GetValue')               ,
				\ 'setName'                : function(s:SID().'SetName')                ,
				\ 'setType'                : function(s:SID().'SetType')                ,
				\ 'setValue'               : function(s:SID().'SetValue')               ,
				\ 'hasName'                : function(s:SID().'HasName')                ,
				\ 'hasType'                : function(s:SID().'HasType')                ,
				\ 'hasValue'               : function(s:SID().'HasValue')               ,
				\ 'setFirstChild'          : function(s:SID().'SetFirstChild')          ,
				\ 'setNextSibling'         : function(s:SID().'SetNextSibling')         ,
				\ 'setParent'              : function(s:SID().'SetParent')              ,
				\ 'setLastChild'           : function(s:SID().'SetLastChild')           ,
				\ 'setPrevSibling'         : function(s:SID().'SetPrevSibling')         ,
				\ 'insertSiblingBeforeYou' : function(s:SID().'InsertSiblingBeforeYou') ,
				\ 'insertSiblingAfterYou'  : function(s:SID().'InsertSiblingAfterYou')  ,
				\ 'insertFirstChild'       : function(s:SID().'InsertFirstChild')       ,
				\ 'insertLastChild'        : function(s:SID().'InsertLastChild')        ,
				\ 'clone'                  : function(s:SID().'Clone')                  ,
				\ 'deleteSelf'             : function(s:SID().'DeleteSelf')             ,
				\ 'deleteTree'             : function(s:SID().'DeleteTree')
				\ }
	return s:nodes[s:currentNodeID]
endfunction "vo_node#newNode }}}
function! s:Node2String() dict "{{{
	let result = []
	for key in keys(filter(copy(s:nodes[self.ID]), 'type(v:val) != type({}) && type(v:val) != type(function("tr"))'))
		call add(result, string(key).': '.string(s:nodes[self.ID][key]))
	endfor
	let attrs = get(s:nodes[self.ID], 'attributes', {})
	let attrlist = []
	call map(copy(attrs), 'add(attrlist, string(v:key).": ".string(v:val))')
	"for key in keys(attrs)
	"	call add(attrlist, string(key).': '.string(attrs[key]))
	"endfor

	return '{'.join(result, ', ').', ''attributes'': {'.join(attrlist, ', ').'}}'
endfunction "NodeString }}}
function! s:SetAttribute(attr, val)      dict "{{{
	let s:nodes[self.ID].attributes[a:attr] = a:val
endfunction "SetAttribute }}}
function! s:RemoveAttribute(attr)        dict "{{{
	silent! unlet s:nodes[self.attributes[a:attr]
endfunction "RemoveAttribute }}}
function! s:GetAttribute(attr)           dict "{{{
	if self.hasAttribute(a:attr)
		return s:nodes[self.ID].attributes[a:attr]
	else
		return ''
	endif
endfunction "GetAttribute }}}
function! s:HasAttribute(attr)           dict "{{{
	if self.hasAttributes()
		return exists('s:nodes[self.ID].attributes.'.a:attr)
	else
		return 0
	endif
endfunction "HasAttribute }}}
function! s:HasAttributes()              dict "{{{
	return exists('s:nodes[self.ID].attributes')
endfunction "HasAttributes }}}
function! s:GetAttributes()              dict "{{{
	return s:nodes[self.ID].attributes
endfunction "GetAttributes }}}
function! s:SetAttributes(attrs)         dict "{{{
	let s:nodes[self.ID].attributes = a:attrs
endfunction "SetAttributes }}}
function! s:GetFirstChild()              dict "{{{
	if self.hasFirstChild()
		return s:nodes[s:nodes[self.ID].firstchild]
	else
		return ''
	endif
endfunction "GetFirstChild }}}
function! s:GetNextSibling()             dict "{{{
	if s:nodes[self.ID].hasNextSibling()
		return s:nodes[s:nodes[self.ID].nextsibling]
	else
		return ''
	endif
endfunction "GetNextSibling }}}
function! s:GetParent()                  dict "{{{
	if s:nodes[self.ID].hasParent()
		return s:nodes[s:nodes[self.ID].parent]
	else
		return ''
	endif
endfunction "GetParent }}}
function! s:HasFirstChild()              dict "{{{
	return exists('s:nodes[self.ID].firstchild')
endfunction "HasFirstChild }}}
function! s:HasNextSibling()             dict "{{{
	return exists('s:nodes[self.ID].nextsibling')
endfunction "HasNextSibling }}}
function! s:HasParent()                  dict "{{{
	return exists('s:nodes[self.ID].parent')
endfunction "HasParent }}}
function! s:GetLastChild()               dict "{{{
	return s:nodes[s:nodes[sel.ID].lastchild]
endfunction "GetLastChild }}}
function! s:GetPrevSibling()             dict "{{{
	if s:nodes[self.ID].hasPrevSibling()
		return s:nodes[s:nodes[self.ID].prevsibling]
	else
		return ''
	endif
endfunction "GetPrevSibling }}}
function! s:HasLastChild()               dict "{{{
	return exists('s:nodes[self.ID].lastchild')
endfunction "HasLastChild }}}
function! s:HasPrevSibling()             dict "{{{
	return exists('s:nodes[self.ID].prevsibling')
endfunction "HasPrevSibling }}}
function! s:GetName()                    dict "{{{
	return s:nodes[self.ID].name
endfunction "GetName }}}
function! s:GetType()                    dict "{{{
	return s:nodes[self.ID].type
endfunction "GetType }}}
function! s:GetValue()                   dict "{{{
	return s:nodes[self.ID].value
endfunction "GetValue }}}
function! s:SetName(node)                dict "{{{
	let s:nodes[self.ID].name = a:name
endfunction "SetName }}}
function! s:SetType(type)                dict "{{{
	let s:nodes[self.ID].type = a:type
endfunction "SetType }}}
function! s:SetValue(value)              dict "{{{
	let s:nodes[self.ID].value = a:value
endfunction "SetValue }}}
function! s:HasName()                    dict "{{{
	return exists('s:nodes[self.ID].name')
endfunction "HasName }}}
function! s:HasType()                    dict "{{{
	return exists('s:nodes[self.ID].type')
endfunction "HasType }}}
function! s:HasValue()                   dict "{{{
	return exists('s:nodes[self.ID].value')
endfunction "HasValue }}}
function! s:SetFirstChild(node)          dict "{{{
	if type(a:node) == type('')
		silent! unlet! s:nodes[self.ID].firstchild
	else
		Decho a:node.ID.' is now the firstchild of '.self.ID
		let s:nodes[self.ID].firstchild = a:node.ID
	endif
endfunction "SetFirstChild }}}
function! s:SetNextSibling(node)         dict "{{{
	if type(a:node) == type('')
		silent! unlet! s:nodes[self.ID].nextsibling
	else
		Decho a:node.ID.' is now the nextsibling of '.self.ID
		let s:nodes[self.ID].nextsibling = a:node.ID
	endif
endfunction "SetNextSibling }}}
function! s:SetParent(node)              dict "{{{
	if type(a:node) == type('')
		silent! unlet! s:nodes[self.ID].parent
	else
		Decho a:node.ID.' is now the parent of '.self.ID
		let s:nodes[self.ID].parent = a:node.ID
	endif
endfunction "SetParent }}}
function! s:SetLastChild(node)           dict "{{{
	if type(a:node) == type('')
		silent! unlet s:nodes[self.ID].lastchild
	else
		Decho a:node.ID.' is now the lastchild of '.self.ID
		let s:nodes[self.ID].lastchild = a:node.ID
	endif
endfunction "SetLastChild }}}
function! s:SetPrevSibling(node)         dict "{{{
	if type(a:node) == type('')
		silent! unlet s:nodes[self.ID].prevsibling
	else
		Decho a:node.ID.' is now the prevsibling of '.self.ID
		let s:nodes[self.ID].prevsibling = a:node.ID
	endif
endfunction "SetPrevSibling }}}
function! s:InsertSiblingBeforeYou(node) dict "{{{
	let oldPrevSibling = self.getPrevSibling()
	call self.setPrevSibling(a:node)
	call self.getPrevSibling().setParent(self.getParent())
	call self.getPrevSibling().setNextSibling(self)
	if type(oldPrevSibling) == type('')
		Decho 'ISBY if1'
		call self.getParent().setFirstChild(self.getPrevSibling())
		call self.getPrevSibling().setPrevSibling('')
	else
		Decho 'ISBY if2'
		call self.getPrevSibling().setPrevSibling(oldPrevSibling)
		call oldPrevSibling.setNextSibling(self.getPrevSibling())
	endif
	return self.getPrevSibling()
endfunction "InsertSiblingBeforeYou }}}
function! s:InsertSiblingAfterYou(node)  dict "{{{
	let oldNextSibling = self.getNextSibling()
	call self.setNextSibling(a:node)
	call self.getNextSibling().setParent(self.getParent())
	call self.getNextSibling().setPrevSibling(self)
	if type(oldNextSibling) == type('')
		Decho 'ISAY if1'
		if self.hasParent()
			call self.getParent().setLastChild(self.getNextSibling())
		endif
		call self.getNextSibling().setNextSibling('')
	else
		Decho 'ISAY if2'
		call self.getNextSibling().setNextSibling(oldNextSibling)
		call oldNextSibling.setPrevSibling(self.getNextSibling())
	endif
	return self.getNextSibling()
endfunction "InserrtSiblingAfterYou }}}
function! s:InsertFirstChild(node)       dict "{{{
	let oldFirstChild = self.getFirstChild()
	if type(oldFirstChild) == type({})
		Decho 'IFC if1'
		call oldFirstChild.insertSiblingBeforeYou(a:node)
	else
		Decho 'IFC if2'
		call self.setFirstChild(a:node)
		call self.setLastChild(a:node)
		"Decho string(self.getFirstChild())
		call self.getFirstChild().setParent(self)
	endif
	return self.getFirstChild()
endfunction "InsertFirstChild }}}
function! s:InsertLastChild(node)        dict "{{{
	let oldLastChild = self.getLastChild()
	if type(oldLastChild) == type({})
		Decho 'ILC if1'
		call oldLastChild.insertSiblingAfterYou(a:node)
	else
		Decho 'ILC if2'
		call self.setFirstChild(a:node)
		call self.setLastChild(a:node)
		call self.getFirstChild().setParent(self)
	endif
	return self.getLastChild()
endfunction "InsertLastChild }}}
function! s:Clone()                      dict "{{{
	let clone = vo_node#newNode('','','')
	call clone.setName(self.getName())
	call clone.setType(self.getType())
	call clone.setValue(self.getValue())

	call clone.setParent(self.getParent())
	call clone.setFirstChild(self.getFirstChild())
	call clone.setLastChild(self.getLastChild())
	call clone.setPrevSibling(self.getPrevSibling())
	call clone.setNextSibling(self.getNextSibling())
	return clone
endfunction "Clone }}}
function! s:DeleteSelf()                 dict "{{{
	let self = self.getPrevSibling()
	let next = self.getNextSibling()
	let parent = self.getParent()
	if self.hasPrevSibling() && self.hasNextSibling()
		call self.getNextSibling().setPrevSibling(self.getPrevSibling())
		call self.getPrevSibling().setNextSibling(self.getNextSibling())
	elseif !self.hasPrevSibling() && !self.hasNextSibling()
		call self.getParent().setFirstChild('')
		call self.getParent().setLastChild('')
	elseif !self.hasPrevSibling()
		call self.getParent().setFirstChild(self.getNextSibling())
		call self.getNextSibling().setPrevSibling('')
	elseif !self.hasNextSibling()
		call self.getParent().setLastChild(self.getPrevSibling())
		call self.getPrevSibling().setNextSibling('')
	endif
	call self.setFirstChild('')
	call self.setLastChild('')
endfunction "DeleteSelf }}}
function! s:DeleteTree()                 dict "{{{
	call self.deleteSelf()
endfunction "DeleteTree }}}
" End Node }}}
" VOParser class {{{
function! vo_node#newParser() "{{{
	if !exists('s:parsers')
		call vo_node#init()
	endif
	let s:currentParserID += 1
	let s:parsers[s:currentParserID] =
				\{
				\ 'ID'                   : s:currentParserID                            ,
				\ 'class'                : 'VOParser'                                   ,
				\ 'head'                 : vo_node#newNode('Header Node'                ,
				\                                          'Head'                       ,
				\                                          'Inserted by OutlineParser') ,
				\ 'fromstdin'            : 1                                            ,
				\	'zapblanks'            : 1                                            ,
				\ 'buffers': [],
				\ 'setFromstdin'         : function(s:SID().'SetFromstdin')             ,
				\ 'getFromstdin'         : function(s:SID().'GetFromstdin')             ,
				\ 'setZapblanks'         : function(s:SID().'SetZapblanks')             ,
				\ 'getZapblanks'         : function(s:SID().'GetZapblanks')             ,
				\ 'setCommentChar'       : function(s:SID().'SetCommentChar')           ,
				\ 'getCommentChar'       : function(s:SID().'GetCommentChar')           ,
				\ 'hasCommentChar'       : function(s:SID().'HasCommentChar')           ,
				\ 'getFirstNonBlankChar' : function(s:SID().'GetFirstNonBlankChar')     ,
				\ 'parse'                : function(s:SID().'Parse')                    ,
				\ 'fromStdin'            : function(s:SID().'FromStdin')                ,
				\ 'fromFile'             : function(s:SID().'FromFile')                 ,
				\ 'zapBlanks'            : function(s:SID().'ZapBlanks')                ,
				\ 'dontZapBlanks'        : function(s:SID().'DontZapBlanks')            ,
				\ 'getHead'              : function(s:SID().'GetHead')
				\}
	return s:parsers[s:currentParserID]
endfunction "vo_node#newParser }}}
function! s:SetFromstdin(char)         dict "{{{
	let s:parsers[self.ID].fromstdin = a:char
endfunction "SetFromstdin }}}
function! s:GetFromstdin()             dict "{{{
	return s:parsers[self.ID].fromstdin
endfunction "GetFromstdin }}}
function! s:SetZapblanks(char)         dict "{{{
	let s:parsers[self.ID].zapblanks = a:char
endfunction "SetZapblanks }}}
function! s:GetZapblanks()             dict "{{{
	return s:parsers[self.ID].zapblanks
endfunction "GetZapblanks }}}
function! s:SetCommentChar(char)       dict "{{{
	let s:parsers[self.ID].commentchar = a:char
endfunction "SetCommentChar }}}
function! s:GetCommentChar()           dict "{{{
	if self.hasCommentChar()
		return s:parsers[self.ID].commentchar
	else
		return []
	endif
endfunction "GetCommentChar }}}
function! s:HasCommentChar()           dict "{{{
	return exists('s:parsers[self.ID].commentchar')
endfunction "HasCommentChar }}}
function! s:GetFirstNonBlankChar(line) dict "{{{
	return matchstr(a:line, '^\s*\zs\S')
endfunction "GetFirstNonBlankChar }}}
function! s:Parse(lines)               dict "{{{
	let levelStack = [self.getHead()]
	let checker = self.getHead()
	let lineno = 0
	let prevLevel = -1
	for line in a:lines
		let lineno += 1
		let zapFlag = 0
		let firstNonBlankChar = self.getFirstNonBlankChar(line)
		if self.getZapblanks() != 0 && firstNonBlankChar == ''
			let zapFlag = 1
		endif
		if self.hasCommentChar() && self.getCommentChar() == firstNonBlankChar
			let zapFlag = 1
		endif
		if !zapFlag
			let level = 0
			let [_,m1,m2;m0] = matchlist(line, '^\(\t*\)\(.*\)')
			if m1 != ''
				let level = len(m1)
				let line = m2
			else
				let line = m2
			endif

			let node = vo_node#newNode('','Node',line)
			call node.setAttribute('_lineno', lineno)

			"Decho string([prevLevel,level])
			if level == prevLevel
				call levelStack[prevLevel].insertSiblingAfterYou(node)
				call s:SetListItem(levelStack, node, level)
			elseif level == prevLevel + 1
				call levelStack[prevLevel].insertFirstChild(node)
				call s:SetListItem(levelStack, node, level)
			elseif level > prevLevel + 1
				throw 'Multiple indent at line '.line.', terminating.'
			elseif level < prevLevel
				"let dedent = prevLevel - level
				while level < prevLevel
					"let levelStack = levelStack[:-2]
					call filter(levelStack, 'len(levelStack) != v:key+1')
					let prevLevel -= 1
				endwhile
				call levelStack[prevLevel].insertSiblingAfterYou(node)
				call s:SetListItem(levelStack, node, level)
			endif
			let prevLevel = level
		Decho node.str()
		Decho string(map(copy(levelStack), 'v:val.ID'))
		"Decho len(levelStack)
		endif
	endfor
	return self.getHead()
endfunction "Parse }}}
function! s:FromStdin()                dict "{{{
	call self.setFromstdin(1)
endfunction "FromStdin }}}
function! s:FromFile()                 dict "{{{
	call self.setFromstdin(0)
endfunction "FromFile }}}
function! s:ZapBlanks()                dict "{{{
	call self.setZapblanks(1)
endfunction "ZapBlanks }}}
function! s:DontZapBlanks()            dict "{{{
	call self.setZapblanks(1)
endfunction "DontZapBlanks }}}
function! s:GetHead()                  dict "{{{
	return s:parsers[self.ID].head
endfunction "GetHead }}}
function! s:GetBuffer( buf ) dict "{{{
	let s:parsers[self.ID].
endfunction "s:GetBuffer }}}
" End OutlineParser }}}
" Walker class {{{
function! vo_node#newWalker(topNode, entrycallback, exitcallback) "{{{
	if !exists('s:walkers')
		call vo_node#init()
	endif
	let s:currentWalkerID += 1
	let s:walkers[s:currentWalkerID] =
				\{
				\ 'ID'            : s:currentWalkerID ,
				\ 'class'         : 'Walker'          ,
				\ 'top'           : a:topNode         ,
				\ 'walk'          : function(s:SID().'Walk')
				\}
	if type(a:entrycallback) == type(function("tr"))
		let s:walkers[s:currentWalkerID].entrycallback = a:entrycallback
	elseif type(a:entrycallback) == type('') && a:exitcallback != ''
		let s:walkers[s:currentWalkerID].entrycallback = function(substitute(a:entrycallback, '\m()$', '', ''))
	endif
	if type(a:exitcallback) == type(function("tr"))
		let s:walkers[s:currentWalkerID].exitcallback = a:exitcallback
	elseif type(a:exitcallback) == type('') && a:exitcallback != ''
		let s:walkers[s:currentWalkerID].exitcallback = function(substitute(a:exitcallback, '\m()$', '', ''))
	endif
	return s:walkers[s:currentWalkerID]
endfunction "vo_node#newWalker }}}
function! s:Walk() dict "{{{
	let ascending = 0
	let checker = self.top
	let level = 0
	let continue = 1
	let counter = 0
	while continue
		Decho 'while: '.counter.' - '.ascending.', ID: '.checker.ID
		if !ascending
			if exists('self.entrycallback')
				let level = call(self.entrycallback, [checker, level])
			endif
			if level < 0
				let continue = 0
			endif
		else
			if exists('self.exitcallback')
				let continue = call(self.exitcallback, [checker, level])
			endif
			if level < 0
				let continue = 0
			endif
			if checker.ID == self.top.ID
				let continue = 0
			endif
		endif

		if !continue
			Decho 'step: '.1.' - '.ascending
			" Skip the rest.
		elseif !ascending && checker.hasFirstChild()
			let ascending = 0
			let checker = checker.getFirstChild()
			let level += 1
			Decho 'step: '.2.' - '.ascending.', ID: '.checker.ID
		elseif checker.hasNextSibling() && checker.ID != self.top.ID
			let ascending = 0
			let checker = checker.getNextSibling()
			Decho 'step: '.3.' - '.ascending.', ID: '.checker.ID
		elseif checker.hasParent()
			let ascending = 1
			let checker = checker.getParent()
			let level -= 1
			Decho 'step: '.4.' - '.ascending.', ID: '.checker.ID
		else
			let continue = 0
			Decho 'step: '.5.' - '.ascending.', ID: '.checker.ID
		endif
		let counter += 1
	endwhile
endfunction "Walk }}}
" End Walker }}}
function! vo_node#main( list, entryFunc, exitFunc ) "{{{
	let parser = vo_node#newParser()
	let topNode = parser.parse(a:list)
	let walker = vo_node#newWalker(topNode, a:entryFunc, a:exitFunc)
	call walker.walk()
endfunction "vo_node#testMain }}}
function! vo_node#init() "{{{
	let s:nodes = {}
	let s:currentNodeID = 0
	let s:parsers = {}
	let s:currentParserID = 0
	let s:walkers = {}
	let s:currentWalkerID = 0
endfunction "vo_node#init }}}
function! s:SID() "{{{
	  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID$')
endfunction "s:SID }}}
function! s:Decho(msg) "{{{
	if exists('g:node_debug') && g:node_debug > 0
		"call append(line('$'), a:msg)
		echom a:msg
	endif
endfunction
command! -nargs=1 -bar Decho call s:Decho(<args>) "Decho }}}
function! s:SetListItem( list, item, index ) "{{{
	let list = a:list
	let last = len(list) - 1
	if a:index <= last
		let list[a:index] = a:item
	else
		call add(list, a:item)
	endif
	return list
endfunction "s:SetListItem }}}
function! vo_node#testEntry( node, level ) "{{{
	echo 'Entry. Node '.a:node.ID.' is at level '.a:level.', X-rayed: '.a:node.str()
	return a:level
endfunction "vo_node#testEntry }}}
function! vo_node#testExit( node, level ) "{{{
	echo 'Exit. Node '.a:node.ID.' is at level '.a:level.', X-rayed: '.a:node.str()
	return a:level
endfunction "vo_node#testExit }}}
Decho 'Sourced'
unlet s:walkers
call vo_node#main(['a','	b', 'c', '	d', '		e', '	f', '		g','h'], 'vo_node#testEntry', 'vo_node#testExit')
finish
