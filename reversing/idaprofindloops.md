# Finde Funktionen mit einer Schleife in IDA

```python
from idaapi import *

def _branches_from (ea):
    if is_call_insn(ea):
        return []
    xrefsgen = CodeRefsFrom(ea, 1)
    xrefs=[]
    for xref in xrefsgen:
      xrefs.append(xref)
    if len(xrefs) == 1 and xrefs[0] == NextNotTail(ea):
        xrefs = []
    return xrefs

def _branches_from_noflow (ea):
    if is_call_insn(ea):
        return []
    xrefsgen = CodeRefsFrom(ea, 0)
    xrefs=[]
    for xref in xrefsgen:
      xrefs.append(xref)
    if len(xrefs) == 1 and xrefs[0] == NextNotTail(ea):
        xrefs = []
    return xrefs

def _branches_to (ea):
    xrefs        = []
    prev_ea      = PrevNotTail(ea)
    prev_code_ea = prev_ea
    while not isCode(GetFlags(prev_code_ea)):
        prev_code_ea = PrevNotTail(prev_code_ea)
    for xref in CodeRefsTo(ea, 1):
        if not is_call_insn(xref) and xref not in [prev_ea, prev_code_ea]:
            xrefs.append(xref)
    return xrefs

def get_bb_from_function(function):
    """
    Returns a list of the basic blocks contained in the function.
    """

    #print "[+] Enumerating basic blocks of %08x" % function
    basic_blocks_from = []
    basic_blocks_to = []
    function_end   = FindFuncEnd(function)

#    print "Function start: %08x" % function
#    print "Function end:   %08x" % function_end

    basic_blocks_from.append(function)

    # Walk over all the address looking for references *to* Code
    for address in range(function, function_end):
        refsfrom = CodeRefsFrom(address, 1)
        refsfrom = list(refsfrom)

        # We just care for the ones pointing to TWO places (Next EIP + Other Address)
        # And these will be pointing within our function
        if len(refsfrom) > 1:
            if  (function < refsfrom[0] < function_end) and (function < refsfrom[1] < function_end):
                basic_blocks_from.append(refsfrom[0])
                basic_blocks_from.append(refsfrom[1])

     # Walk over all the address looking for referenced addresses
    for address in range(function, function_end):
        # If this address was already appended, keep going
        if address in basic_blocks_from:
            continue
        refsto = CodeRefsTo(address, 1)
        refsto = list(refsto)

        if len(refsto) > 1:
            if  function < refsto[0] < function_end:
                basic_blocks_to.append(address)

    return basic_blocks_from + basic_blocks_to

def get_bb_limits(bb_addr):
        eip = bb_addr

        while True:
            eip=NextHead(eip,MaxEA())
            if eip==0xffffffff:
                end_addr = eip
                break

            refs_from=_branches_from(eip)
            refs_to=_branches_to(eip)

            if len(refs_from) or len(refs_to) or is_ret_insn(eip) or (eip == MaxEA()):
              end_addr = eip
              break

        return bb_addr, end_addr

def get_all_bb(ea):
    bb_init_list = get_bb_from_function(ea)
    bb_list = []

    for bb_addr in bb_init_list:
        bb_init, bb_end = get_bb_limits(bb_addr)
        bb_list.append((bb_init, bb_end))

    return bb_list

def find_loops(bb_limits):
    try:
        if _branches_from_noflow(bb_limits[1])[0] == bb_limits[0]:
            print "[+] There is a loop at basic block = %08x" % bb_limits[0]
            return True
    except:
        return False

def has_loops(funct_ea):

    bb_list = get_all_bb(funct_ea)
    for x in bb_list:
        #print x
        if find_loops(x):
            return True

    return False

def get_num_of_callers(function_ea):

        f_name = GetFunctionName(function_ea)
        # save the callers name and size
        # return len(list(CodeRefsTo(function_ea, 0))) # Only code refs
        # return len(list(CodeRefsTo(function_ea, 0))) + len(list(DataRefsTo(function_ea))) # Code refs + Data refs
        return len(list(CodeRefsTo(function_ea, 0))) + len(list(DataRefsTo(function_ea))) + len(list(DataRefsTo(function_ea+1))) # Code refs + Data refs + (Data refs+1)ARM thingy

def doit():
    DEBUG = 0

    ea = ScreenEA()
    functs_with_loops = []

    # Loop through all the functions
    for function_ea in Functions(SegStart(ea), SegEnd(ea)):
        if DEBUG: print "DEBUG: Finding loops"
        if has_loops(function_ea):
            if DEBUG: print "DEBUG: Appending functions with loops"
            functs_with_loops.append([function_ea, get_num_of_callers(function_ea)])

    if DEBUG: print "DEBUG: Finished appending of 'loop' functions"
    # Sort it
    functs_with_loops = sorted (functs_with_loops, key=lambda functions:functions[1])
    functs_with_loops.reverse()

    print "\n\n[ ] Most called 'loop' functions:"

    for function in functs_with_loops[:10]:
        print "[+] %s is called %d times" % (hex(function[0]), function[1])

    print "[+] I think %s could be memcpy or memset" % hex(functs_with_loops[0][0])
```

tags: reversing [ida pro] python snippets