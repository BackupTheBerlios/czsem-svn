serialize_rule(end_of_file).

serialize_rule(T):- 
	write('<Rule>\n'),
	
%	T =.. L, write(L), write('\n'), 
	 
		numbervars(T, 0, _),
		serialize_term(T),
	
	write('\n</Rule>\n').
	

 

serialize_term('$VAR'(N)):- char_code('A',I), Var is I + N, format('<var>~c</var>',[Var]),!.
serialize_term(T):- atom(T), format('<atom>~a</atom>',[T]),!.
serialize_term(T):- simple(T), format('<atom>~k</atom>',[T]),!.
serialize_term(','(A,B)):- serialize_term(A), write('\n'), serialize_term(B),!.
	

serialize_term(:-(H, B)) :-  
	write('<implication>\n'),
		
		write('<head>\n'),
			serialize_term(H),
		write('\n</head>\n'),
		
		write('<body>\n'),
			serialize_term(B),
		write('\n</body>\n'),	
	
	write('</implication>'),!.


serialize_term(T):- functor(T,F,N),
	format('<functor name="~k" args="~d">\n', [F,N]),
	serialize_arg(T, 0, N),		
	write('</functor>').



serialize_arg(T, _, 0).
serialize_arg(T, N, N).
serialize_arg(T, M, N) :-  M2 is M+1, arg(M2, T, A),
	format('<arg num="~d">', [M2]), 
		serialize_term(A),
	write('</arg>\n'), 
	serialize_arg(T, M2, N).  





serialize_rule_file(RuleFileName, OutputFileName) :-
	open(OutputFileName, 'write', Stream),
	set_output(Stream),
	
	write('<RuleSet>\n'),	
	consult(RuleFileName),
	write('</RuleSet>'),	
		
	close(Stream).


term_expansion(T,T):- serialize_rule(T).
