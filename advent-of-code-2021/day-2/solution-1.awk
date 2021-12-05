{ state[$1] += $2 }
END { 
	depth = state["down"] - state["up"];
	print "horizontal position:" state["forward"]", depth:" depth;
	print "solution:" state["forward"] * depth
}
