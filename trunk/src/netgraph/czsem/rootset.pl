%%%%%%%%%%%%%%%%%%%%%%%
% Declarations
%:- set(nodes,500000)?
:- set(h,3000)?
%:- set(r,10000)?
:- set(c,11),set(i,12),  set(inflate,800)?
:- set(verbose,2)?
%:- modeh(1,tree_root(+node))?
:- modeh(1,contains_num_injured(+node))?
:- modeh(1,contains_num_injured_root(+node))?
:- modeb(*,edge(-node,+node))?
:- modeb(*,edge(+node,-node))?
:- modeb(*,edge(+node,+node))?

:- modeb(1,m_tag0(+node,#const))?
:- modeb(1,m_tag1(+node,#const))?
:- modeb(1,m_tag2(+node,#const))?
:- modeb(1,m_tag3(+node,#const))?
:- modeb(1,m_tag4(+node,#const))?
:- modeb(1,m_tag5(+node,#const))?
:- modeb(1,m_tag6(+node,#const))?
:- modeb(1,m_tag7(+node,#const))?
:- modeb(1,m_tag8(+node,#const))?
:- modeb(1,m_tag9(+node,#const))?
:- modeb(1,m_tag10(+node,#const))?
:- modeb(1,m_tag11(+node,#const))?
:- modeb(1,m_tag12(+node,#const))?
:- modeb(1,m_tag13(+node,#const))?
:- modeb(1,m_tag14(+node,#const))?

% begin of definitions of linguistic attributes
:- modeb(1,functor(+node,#const))?
:- modeb(1,gram_sempos(+node,#const))?
:- modeb(1,t_lemma(+node,#const))?
:- modeb(1,a_afun(+node,#const))?
:- modeb(1,m_form(+node,#const))?
%:- modeb(1,m_lemma(+node,#const))?
:- modeb(1,m_tag(+node,#const))?
% end of definitions of linguistic attributes

consult(number_nodes_bkg01)?
consult(number_nodes_bkg02)?

%consult(number_nodes_exmpl01)?
%consult(train_number_nodes_exmpl03)?
consult(train_roots_number_nodes_exmpl03)?

%generalise(contains_num_injured/1)?
generalise(contains_num_injured_root/1)?

%test(test_number_nodes_exmpl03)?
test(test_roots_number_nodes_exmpl03)?
