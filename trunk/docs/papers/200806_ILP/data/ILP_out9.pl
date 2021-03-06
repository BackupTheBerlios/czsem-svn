%%%%%%%%%%%%%%%%%%%%%%%
% Declarations
%:- set(nodes,500000)?
%:- set(r,10000)?
%:- set(inflate,800000)?
%:- set(posonly,1)?

:- set(c,15),set(i,15)?
:- set(verbose,1)?
%:- set(noise,0.5)?
:- set(h,2000)?

:- modeh(1,injured(+const))?
:- modeh(1,number_injured(+const, #numConst))?
:- modeh(1,number_dead(+const, #numConst))?
:- modeh(1,number_severe_injury(+const, #numConst))?
:- modeb(*,edge(-node,+node))?
:- modeb(*,edge(+node,-node))?
:- modeb(*,edge(+node,+node))?
:- modeb(1,id(+node,-const))?
:- modeb(1,id(-node,+const))?
%:- modeb(1,injured(+const))?
%:- modeb(1,number_injured(+const, #numConst))?
%:- modeb(1,number_dead(+const, #numConst))?
%:- modeb(1,number_severe_injury(+const, #numConst))?


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
:- modeb(1,id(+node,#const))?
:- modeb(1,t_lemma(+node,#const))?
:- modeb(1,a_afun(+node,#const))?
:- modeb(1,m_form(+node,#const))?
:- modeb(1,m_lemma(+node,#const))?
:- modeb(1,m_tag(+node,#const))?
% end of definitions of linguistic attributes

%injured(A):-injured(B), edge(A,B).
%injured(B):-injured(A), edge(A,B).
%number_injured(A,X):-number_injured(B,X), edge(A,B).
%number_injured(A,2):-injured(B), edge(A,B), injured(C), edge(A,C).

injured(t_plzensky60412_txt_001_p1s2).
injured(t_plzensky60412_txt_001_p4s2).
injured(t_plzensky57870_txt_001_p1s1).
injured(t_plzensky57870_txt_001_p8s2).
injured(t_plzensky62815_txt_001_p1s4).
injured(t_plzensky62815_txt_001_p1s12).
injured(t_plzensky59310_txt_001_p11s2).
injured(t_plzensky57770_txt_001_p5s2).
injured(t_plzensky70827_txt_001_p1s3).
injured(t_plzensky72450_txt_001_p3s2).
injured(t_plzensky72450_txt_001_p19s2).
injured(t_plzensky49076_txt_001_p1s3).
injured(t_plzensky72795_txt_001_p2s3).
injured(t_plzensky60375_txt_001_p1s6).
injured(t_plzensky60375_txt_001_p1s8).
injured(t_plzensky72977_txt_001_p1s2).
injured(t_plzensky61718_txt_001_p3s3).
injured(t_plzensky56858_txt_001_p3s3).
injured(t_plzensky58020_txt_001_p1s2).
injured(t_plzensky58020_txt_001_p1s4).
injured(t_plzensky69694_txt_001_p4s2).
injured(t_plzensky58562_txt_001_p3s3).



:- injured(t_plzensky49244_txt_001_p1s8).
:- injured(t_plzensky51278_txt_001_p4s2).
:- injured(t_plzensky57806_txt_001_p2s3).
:- injured(t_plzensky51278_txt_001_p4s3).
:- injured(t_plzensky51278_txt_001_p5s1).
:- injured(t_plzensky51278_txt_001_p5s2).
:- injured(t_plzensky71843_txt_001_p1s7).
:- injured(t_plzensky51278_txt_001_p5s9).
:- injured(t_plzensky58468_txt_001_p1s1).
:- injured(t_plzensky58468_txt_001_p1s2).
:- injured(t_plzensky58468_txt_001_p1s3).
:- injured(t_plzensky70461_txt_001_p1s12).
:- injured(t_plzensky58468_txt_001_p1s7).



:- number_injured(t_plzensky69695_txt_001_p1s1,1).
:- number_injured(t_plzensky69695_txt_001_p1s1,2).
:- number_injured(t_plzensky69695_txt_001_p1s1,3).
:- number_injured(t_plzensky69695_txt_001_p1s1,4).
:- number_injured(t_plzensky69695_txt_001_p1s1,6).
:- number_injured(t_plzensky69695_txt_001_p1s1,7).
:- number_injured(t_plzensky69695_txt_001_p1s1,8).
:- number_injured(t_plzensky69695_txt_001_p1s1,9).


:- number_injured(t_plzensky55831_txt_001_p1s3,2).
:- number_injured(t_plzensky55831_txt_001_p1s3,3).
:- number_injured(t_plzensky55831_txt_001_p1s3,4).
:- number_injured(t_plzensky55831_txt_001_p1s3,5).
:- number_injured(t_plzensky55831_txt_001_p1s3,6).
:- number_injured(t_plzensky55831_txt_001_p1s3,7).
:- number_injured(t_plzensky55831_txt_001_p1s3,8).
:- number_injured(t_plzensky55831_txt_001_p1s3,9).


:- number_injured(t_plzensky59722_txt_001_p2s3,2).
:- number_injured(t_plzensky59722_txt_001_p2s3,3).
:- number_injured(t_plzensky59722_txt_001_p2s3,4).
:- number_injured(t_plzensky59722_txt_001_p2s3,5).
:- number_injured(t_plzensky59722_txt_001_p2s3,6).
:- number_injured(t_plzensky59722_txt_001_p2s3,7).
:- number_injured(t_plzensky59722_txt_001_p2s3,8).
:- number_injured(t_plzensky59722_txt_001_p2s3,9).


:- number_injured(t_plzensky62815_txt_001_p1s4,2).
:- number_injured(t_plzensky62815_txt_001_p1s4,3).
:- number_injured(t_plzensky62815_txt_001_p1s4,4).
:- number_injured(t_plzensky62815_txt_001_p1s4,5).
:- number_injured(t_plzensky62815_txt_001_p1s4,6).
:- number_injured(t_plzensky62815_txt_001_p1s4,7).
:- number_injured(t_plzensky62815_txt_001_p1s4,8).
:- number_injured(t_plzensky62815_txt_001_p1s4,9).


:- number_injured(t_plzensky57870_txt_001_p8s2,1).
:- number_injured(t_plzensky57870_txt_001_p8s2,3).
:- number_injured(t_plzensky57870_txt_001_p8s2,4).
:- number_injured(t_plzensky57870_txt_001_p8s2,5).
:- number_injured(t_plzensky57870_txt_001_p8s2,6).
:- number_injured(t_plzensky57870_txt_001_p8s2,7).
:- number_injured(t_plzensky57870_txt_001_p8s2,8).
:- number_injured(t_plzensky57870_txt_001_p8s2,9).


:- number_injured(t_plzensky57870_txt_001_p1s1,1).
:- number_injured(t_plzensky57870_txt_001_p1s1,3).
:- number_injured(t_plzensky57870_txt_001_p1s1,4).
:- number_injured(t_plzensky57870_txt_001_p1s1,5).
:- number_injured(t_plzensky57870_txt_001_p1s1,6).
:- number_injured(t_plzensky57870_txt_001_p1s1,7).
:- number_injured(t_plzensky57870_txt_001_p1s1,8).
:- number_injured(t_plzensky57870_txt_001_p1s1,9).



:- number_injured(t_plzensky62815_txt_001_p1s12,2).
:- number_injured(t_plzensky62815_txt_001_p1s12,3).
:- number_injured(t_plzensky62815_txt_001_p1s12,4).
:- number_injured(t_plzensky62815_txt_001_p1s12,5).
:- number_injured(t_plzensky62815_txt_001_p1s12,6).
:- number_injured(t_plzensky62815_txt_001_p1s12,7).
:- number_injured(t_plzensky62815_txt_001_p1s12,8).
:- number_injured(t_plzensky62815_txt_001_p1s12,9).
number_injured(t_plzensky62815_txt_001_p1s12,1).

:- number_injured(t_plzensky58562_txt_001_p3s3,2).
:- number_injured(t_plzensky58562_txt_001_p3s3,3).
:- number_injured(t_plzensky58562_txt_001_p3s3,4).
:- number_injured(t_plzensky58562_txt_001_p3s3,5).
:- number_injured(t_plzensky58562_txt_001_p3s3,6).
:- number_injured(t_plzensky58562_txt_001_p3s3,7).
:- number_injured(t_plzensky58562_txt_001_p3s3,8).
:- number_injured(t_plzensky58562_txt_001_p3s3,9).
number_injured(t_plzensky58562_txt_001_p3s3,1).
:- number_injured(t_plzensky72261_txt_001_p14s2,2).
:- number_injured(t_plzensky72261_txt_001_p14s2,3).
:- number_injured(t_plzensky72261_txt_001_p14s2,4).
:- number_injured(t_plzensky72261_txt_001_p14s2,5).
:- number_injured(t_plzensky72261_txt_001_p14s2,6).
:- number_injured(t_plzensky72261_txt_001_p14s2,7).
:- number_injured(t_plzensky72261_txt_001_p14s2,8).
:- number_injured(t_plzensky72261_txt_001_p14s2,9).
number_injured(t_plzensky72261_txt_001_p14s2,1).

:- number_injured(t_plzensky60375_txt_001_p1s8,2).
:- number_injured(t_plzensky60375_txt_001_p1s8,3).
:- number_injured(t_plzensky60375_txt_001_p1s8,4).
:- number_injured(t_plzensky60375_txt_001_p1s8,5).
:- number_injured(t_plzensky60375_txt_001_p1s8,6).
:- number_injured(t_plzensky60375_txt_001_p1s8,7).
:- number_injured(t_plzensky60375_txt_001_p1s8,8).
:- number_injured(t_plzensky60375_txt_001_p1s8,9).
number_injured(t_plzensky60375_txt_001_p1s8,1).
:- number_injured(t_plzensky72977_txt_001_p1s2,2).
:- number_injured(t_plzensky72977_txt_001_p1s2,3).
:- number_injured(t_plzensky72977_txt_001_p1s2,4).
:- number_injured(t_plzensky72977_txt_001_p1s2,5).
:- number_injured(t_plzensky72977_txt_001_p1s2,6).
:- number_injured(t_plzensky72977_txt_001_p1s2,7).
:- number_injured(t_plzensky72977_txt_001_p1s2,8).
:- number_injured(t_plzensky72977_txt_001_p1s2,9).
number_injured(t_plzensky72977_txt_001_p1s2,1).
:- number_injured(t_plzensky51802_txt_001_p6s2,2).
:- number_injured(t_plzensky51802_txt_001_p6s2,3).
:- number_injured(t_plzensky51802_txt_001_p6s2,4).
:- number_injured(t_plzensky51802_txt_001_p6s2,5).
:- number_injured(t_plzensky51802_txt_001_p6s2,6).
:- number_injured(t_plzensky51802_txt_001_p6s2,7).
:- number_injured(t_plzensky51802_txt_001_p6s2,8).
:- number_injured(t_plzensky51802_txt_001_p6s2,9).
number_injured(t_plzensky51802_txt_001_p6s2,1).
:- number_injured(t_plzensky69694_txt_001_p3s4,2).
:- number_injured(t_plzensky69694_txt_001_p3s4,3).
:- number_injured(t_plzensky69694_txt_001_p3s4,4).
:- number_injured(t_plzensky69694_txt_001_p3s4,5).
:- number_injured(t_plzensky69694_txt_001_p3s4,6).
:- number_injured(t_plzensky69694_txt_001_p3s4,7).
:- number_injured(t_plzensky69694_txt_001_p3s4,8).
:- number_injured(t_plzensky69694_txt_001_p3s4,9).
number_injured(t_plzensky69694_txt_001_p3s4,1).


number_injured(t_plzensky69695_txt_001_p1s1,5).
number_injured(t_plzensky55831_txt_001_p1s3,1).
number_injured(t_plzensky59722_txt_001_p2s3,1).
number_injured(t_plzensky57870_txt_001_p1s1,2).
number_injured(t_plzensky57870_txt_001_p8s2,2).
number_injured(t_plzensky62815_txt_001_p1s4,1).


:- number_injured(t_plzensky69694_txt_001_p4s2,1).
:- number_injured(t_plzensky69694_txt_001_p4s2,3).
:- number_injured(t_plzensky69694_txt_001_p4s2,4).
:- number_injured(t_plzensky69694_txt_001_p4s2,5).
:- number_injured(t_plzensky69694_txt_001_p4s2,6).
:- number_injured(t_plzensky69694_txt_001_p4s2,7).
:- number_injured(t_plzensky69694_txt_001_p4s2,8).
:- number_injured(t_plzensky69694_txt_001_p4s2,9).
number_injured(t_plzensky69694_txt_001_p4s2,2).
:- number_injured(t_plzensky71760_txt_001_p2s7,1).
:- number_injured(t_plzensky71760_txt_001_p2s7,2).
:- number_injured(t_plzensky71760_txt_001_p2s7,3).
:- number_injured(t_plzensky71760_txt_001_p2s7,4).
:- number_injured(t_plzensky71760_txt_001_p2s7,6).
:- number_injured(t_plzensky71760_txt_001_p2s7,7).
:- number_injured(t_plzensky71760_txt_001_p2s7,8).
:- number_injured(t_plzensky71760_txt_001_p2s7,9).
number_injured(t_plzensky71760_txt_001_p2s7,5).
:- number_injured(t_plzensky48663_txt_001_p2s2,1).
:- number_injured(t_plzensky48663_txt_001_p2s2,2).
:- number_injured(t_plzensky48663_txt_001_p2s2,3).
:- number_injured(t_plzensky48663_txt_001_p2s2,4).
:- number_injured(t_plzensky48663_txt_001_p2s2,5).
:- number_injured(t_plzensky48663_txt_001_p2s2,6).
:- number_injured(t_plzensky48663_txt_001_p2s2,7).
:- number_injured(t_plzensky48663_txt_001_p2s2,8).
:- number_injured(t_plzensky48663_txt_001_p2s2,9).
number_injured(t_plzensky48663_txt_001_p2s2,18).
:- number_injured(t_plzensky61718_txt_001_p3s3,1).
:- number_injured(t_plzensky61718_txt_001_p3s3,2).
:- number_injured(t_plzensky61718_txt_001_p3s3,3).
:- number_injured(t_plzensky61718_txt_001_p3s3,4).
:- number_injured(t_plzensky61718_txt_001_p3s3,5).
:- number_injured(t_plzensky61718_txt_001_p3s3,6).
:- number_injured(t_plzensky61718_txt_001_p3s3,7).
:- number_injured(t_plzensky61718_txt_001_p3s3,8).
:- number_injured(t_plzensky61718_txt_001_p3s3,9).
number_injured(t_plzensky61718_txt_001_p3s3,5321).
:- number_injured(t_plzensky56858_txt_001_p3s3,1).
:- number_injured(t_plzensky56858_txt_001_p3s3,2).
:- number_injured(t_plzensky56858_txt_001_p3s3,3).
:- number_injured(t_plzensky56858_txt_001_p3s3,5).
:- number_injured(t_plzensky56858_txt_001_p3s3,6).
:- number_injured(t_plzensky56858_txt_001_p3s3,7).
:- number_injured(t_plzensky56858_txt_001_p3s3,8).
:- number_injured(t_plzensky56858_txt_001_p3s3,9).
number_injured(t_plzensky56858_txt_001_p3s3,4).
:- number_injured(t_plzensky58020_txt_001_p1s2,1).
:- number_injured(t_plzensky58020_txt_001_p1s2,3).
:- number_injured(t_plzensky58020_txt_001_p1s2,4).
:- number_injured(t_plzensky58020_txt_001_p1s2,5).
:- number_injured(t_plzensky58020_txt_001_p1s2,6).
:- number_injured(t_plzensky58020_txt_001_p1s2,7).
:- number_injured(t_plzensky58020_txt_001_p1s2,8).
:- number_injured(t_plzensky58020_txt_001_p1s2,9).
number_injured(t_plzensky58020_txt_001_p1s2,2).
:- number_injured(t_plzensky58020_txt_001_p1s4,1).
:- number_injured(t_plzensky58020_txt_001_p1s4,3).
:- number_injured(t_plzensky58020_txt_001_p1s4,4).
:- number_injured(t_plzensky58020_txt_001_p1s4,5).
:- number_injured(t_plzensky58020_txt_001_p1s4,6).
:- number_injured(t_plzensky58020_txt_001_p1s4,7).
:- number_injured(t_plzensky58020_txt_001_p1s4,8).
:- number_injured(t_plzensky58020_txt_001_p1s4,9).
number_injured(t_plzensky58020_txt_001_p1s4,2).
:- number_injured(t_plzensky59310_txt_001_p11s2,1).
:- number_injured(t_plzensky59310_txt_001_p11s2,3).
:- number_injured(t_plzensky59310_txt_001_p11s2,4).
:- number_injured(t_plzensky59310_txt_001_p11s2,5).
:- number_injured(t_plzensky59310_txt_001_p11s2,6).
:- number_injured(t_plzensky59310_txt_001_p11s2,7).
:- number_injured(t_plzensky59310_txt_001_p11s2,8).
:- number_injured(t_plzensky59310_txt_001_p11s2,9).
number_injured(t_plzensky59310_txt_001_p11s2,2).
:- number_injured(t_plzensky69691_txt_001_p2s4,2).
:- number_injured(t_plzensky69691_txt_001_p2s4,3).
:- number_injured(t_plzensky69691_txt_001_p2s4,4).
:- number_injured(t_plzensky69691_txt_001_p2s4,5).
:- number_injured(t_plzensky69691_txt_001_p2s4,6).
:- number_injured(t_plzensky69691_txt_001_p2s4,7).
:- number_injured(t_plzensky69691_txt_001_p2s4,8).
:- number_injured(t_plzensky69691_txt_001_p2s4,9).
number_injured(t_plzensky69691_txt_001_p2s4,1).
:- number_injured(t_plzensky78857_txt_001_p1s7,2).
:- number_injured(t_plzensky78857_txt_001_p1s7,3).
:- number_injured(t_plzensky78857_txt_001_p1s7,4).
:- number_injured(t_plzensky78857_txt_001_p1s7,5).
:- number_injured(t_plzensky78857_txt_001_p1s7,6).
:- number_injured(t_plzensky78857_txt_001_p1s7,7).
:- number_injured(t_plzensky78857_txt_001_p1s7,8).
:- number_injured(t_plzensky78857_txt_001_p1s7,9).
number_injured(t_plzensky78857_txt_001_p1s7,1).
:- number_injured(t_plzensky60412_txt_001_p1s2,1).
:- number_injured(t_plzensky60412_txt_001_p1s2,2).
:- number_injured(t_plzensky60412_txt_001_p1s2,4).
:- number_injured(t_plzensky60412_txt_001_p1s2,5).
:- number_injured(t_plzensky60412_txt_001_p1s2,6).
:- number_injured(t_plzensky60412_txt_001_p1s2,7).
:- number_injured(t_plzensky60412_txt_001_p1s2,8).
:- number_injured(t_plzensky60412_txt_001_p1s2,9).
number_injured(t_plzensky60412_txt_001_p1s2,3).
:- number_injured(t_plzensky60412_txt_001_p4s2,1).
:- number_injured(t_plzensky60412_txt_001_p4s2,2).
:- number_injured(t_plzensky60412_txt_001_p4s2,4).
:- number_injured(t_plzensky60412_txt_001_p4s2,5).
:- number_injured(t_plzensky60412_txt_001_p4s2,6).
:- number_injured(t_plzensky60412_txt_001_p4s2,7).
:- number_injured(t_plzensky60412_txt_001_p4s2,8).
:- number_injured(t_plzensky60412_txt_001_p4s2,9).
number_injured(t_plzensky60412_txt_001_p4s2,3).
:- number_injured(t_plzensky57770_txt_001_p5s2,1).
:- number_injured(t_plzensky57770_txt_001_p5s2,2).
:- number_injured(t_plzensky57770_txt_001_p5s2,3).
:- number_injured(t_plzensky57770_txt_001_p5s2,4).
:- number_injured(t_plzensky57770_txt_001_p5s2,6).
:- number_injured(t_plzensky57770_txt_001_p5s2,7).
:- number_injured(t_plzensky57770_txt_001_p5s2,8).
:- number_injured(t_plzensky57770_txt_001_p5s2,9).
number_injured(t_plzensky57770_txt_001_p5s2,5).
:- number_injured(t_plzensky72675_txt_001_p7s2,1).
:- number_injured(t_plzensky72675_txt_001_p7s2,2).
:- number_injured(t_plzensky72675_txt_001_p7s2,4).
:- number_injured(t_plzensky72675_txt_001_p7s2,5).
:- number_injured(t_plzensky72675_txt_001_p7s2,6).
:- number_injured(t_plzensky72675_txt_001_p7s2,7).
:- number_injured(t_plzensky72675_txt_001_p7s2,8).
:- number_injured(t_plzensky72675_txt_001_p7s2,9).
number_injured(t_plzensky72675_txt_001_p7s2,3).
:- number_injured(t_plzensky60661_txt_001_p1s2,2).
:- number_injured(t_plzensky60661_txt_001_p1s2,3).
:- number_injured(t_plzensky60661_txt_001_p1s2,4).
:- number_injured(t_plzensky60661_txt_001_p1s2,5).
:- number_injured(t_plzensky60661_txt_001_p1s2,6).
:- number_injured(t_plzensky60661_txt_001_p1s2,7).
:- number_injured(t_plzensky60661_txt_001_p1s2,8).
:- number_injured(t_plzensky60661_txt_001_p1s2,9).
number_injured(t_plzensky60661_txt_001_p1s2,1).
:- number_injured(t_plzensky58576_txt_001_p5s2,1).
:- number_injured(t_plzensky58576_txt_001_p5s2,2).
:- number_injured(t_plzensky58576_txt_001_p5s2,4).
:- number_injured(t_plzensky58576_txt_001_p5s2,5).
:- number_injured(t_plzensky58576_txt_001_p5s2,6).
:- number_injured(t_plzensky58576_txt_001_p5s2,7).
:- number_injured(t_plzensky58576_txt_001_p5s2,8).
:- number_injured(t_plzensky58576_txt_001_p5s2,9).
number_injured(t_plzensky58576_txt_001_p5s2,3).
:- number_injured(t_plzensky64131_txt_001_p2s2,2).
:- number_injured(t_plzensky64131_txt_001_p2s2,3).
:- number_injured(t_plzensky64131_txt_001_p2s2,4).
:- number_injured(t_plzensky64131_txt_001_p2s2,5).
:- number_injured(t_plzensky64131_txt_001_p2s2,6).
:- number_injured(t_plzensky64131_txt_001_p2s2,7).
:- number_injured(t_plzensky64131_txt_001_p2s2,8).
:- number_injured(t_plzensky64131_txt_001_p2s2,9).
number_injured(t_plzensky64131_txt_001_p2s2,1).


:- number_dead(t_plzensky57870_txt_001_p8s2,1).
:- number_dead(t_plzensky57870_txt_001_p8s2,3).
:- number_dead(t_plzensky57870_txt_001_p8s2,4).
:- number_dead(t_plzensky57870_txt_001_p8s2,5).
:- number_dead(t_plzensky57870_txt_001_p8s2,6).
:- number_dead(t_plzensky57870_txt_001_p8s2,7).
:- number_dead(t_plzensky57870_txt_001_p8s2,8).
:- number_dead(t_plzensky57870_txt_001_p8s2,9).
number_dead(t_plzensky57870_txt_001_p8s2,2).
:- number_dead(t_plzensky62815_txt_001_p1s4,2).
:- number_dead(t_plzensky62815_txt_001_p1s4,3).
:- number_dead(t_plzensky62815_txt_001_p1s4,4).
:- number_dead(t_plzensky62815_txt_001_p1s4,5).
:- number_dead(t_plzensky62815_txt_001_p1s4,6).
:- number_dead(t_plzensky62815_txt_001_p1s4,7).
:- number_dead(t_plzensky62815_txt_001_p1s4,8).
:- number_dead(t_plzensky62815_txt_001_p1s4,9).
number_dead(t_plzensky62815_txt_001_p1s4,1).
:- number_dead(t_plzensky69691_txt_001_p2s4,2).
:- number_dead(t_plzensky69691_txt_001_p2s4,3).
:- number_dead(t_plzensky69691_txt_001_p2s4,4).
:- number_dead(t_plzensky69691_txt_001_p2s4,5).
:- number_dead(t_plzensky69691_txt_001_p2s4,6).
:- number_dead(t_plzensky69691_txt_001_p2s4,7).
:- number_dead(t_plzensky69691_txt_001_p2s4,8).
:- number_dead(t_plzensky69691_txt_001_p2s4,9).
number_dead(t_plzensky69691_txt_001_p2s4,1).
:- number_dead(t_plzensky60661_txt_001_p1s2,2).
:- number_dead(t_plzensky60661_txt_001_p1s2,3).
:- number_dead(t_plzensky60661_txt_001_p1s2,4).
:- number_dead(t_plzensky60661_txt_001_p1s2,5).
:- number_dead(t_plzensky60661_txt_001_p1s2,6).
:- number_dead(t_plzensky60661_txt_001_p1s2,7).
:- number_dead(t_plzensky60661_txt_001_p1s2,8).
:- number_dead(t_plzensky60661_txt_001_p1s2,9).
number_dead(t_plzensky60661_txt_001_p1s2,1).

:- number_severe_injury(t_plzensky57870_txt_001_p8s2,1).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,3).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,4).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,5).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,6).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,7).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,8).
:- number_severe_injury(t_plzensky57870_txt_001_p8s2,9).
number_severe_injury(t_plzensky57870_txt_001_p8s2,2).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,2).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,3).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,4).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,5).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,6).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,7).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,8).
:- number_severe_injury(t_plzensky62815_txt_001_p1s4,9).
number_severe_injury(t_plzensky62815_txt_001_p1s4,1).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,2).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,3).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,4).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,5).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,6).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,7).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,8).
:- number_severe_injury(t_plzensky62815_txt_001_p1s12,9).
number_severe_injury(t_plzensky62815_txt_001_p1s12,1).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,2).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,3).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,4).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,5).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,6).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,7).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,8).
:- number_severe_injury(t_plzensky59310_txt_001_p11s2,9).
number_severe_injury(t_plzensky59310_txt_001_p11s2,1).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,2).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,3).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,4).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,5).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,6).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,7).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,8).
:- number_severe_injury(t_plzensky69691_txt_001_p2s4,9).
number_severe_injury(t_plzensky69691_txt_001_p2s4,1).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,2).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,3).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,4).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,5).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,6).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,7).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,8).
:- number_severe_injury(t_plzensky60412_txt_001_p1s2,9).
number_severe_injury(t_plzensky60412_txt_001_p1s2,1).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,2).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,3).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,4).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,5).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,6).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,7).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,8).
:- number_severe_injury(t_plzensky60412_txt_001_p4s2,9).
number_severe_injury(t_plzensky60412_txt_001_p4s2,1).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,2).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,3).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,4).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,5).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,6).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,7).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,8).
:- number_severe_injury(t_plzensky60661_txt_001_p1s2,9).
number_severe_injury(t_plzensky60661_txt_001_p1s2,1).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,1).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,3).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,4).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,5).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,6).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,7).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,8).
:- number_severe_injury(t_plzensky69695_txt_001_p1s1,9).
number_severe_injury(t_plzensky69695_txt_001_p1s1,2).


numConst(0).
numConst(1).
numConst(2).
numConst(3).
numConst(4).
numConst(5).
numConst(6).
numConst(7).
numConst(8).
numConst(9).
numConst(10).
numConst(18).
numConst(333).
numConst(5321).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby. 
tree_root(node0_0).
%%%%%%%% node0_0 %%%%%%%%%%%%%%%%%%%
node(node0_0).
id(node0_0, t_plzensky70827_txt_001_p1s3).         const(t_plzensky70827_txt_001_p1s3).
%%%%%%%% node0_1 %%%%%%%%%%%%%%%%%%%
node(node0_1).
functor(node0_1, pred).         const(pred).
gram_sempos(node0_1, v).         const(v).
id(node0_1, t_plzensky70827_txt_001_p1s3a1).         const(t_plzensky70827_txt_001_p1s3a1).
t_lemma(node0_1, zranit).         const(zranit).
%%%%%%%% node0_2 %%%%%%%%%%%%%%%%%%%
node(node0_2).
functor(node0_2, act).         const(act).
id(node0_2, t_plzensky70827_txt_001_p1s3a7).         const(t_plzensky70827_txt_001_p1s3a7).
t_lemma(node0_2, x_gen).         const(x_gen).
%%%%%%%% node0_3 %%%%%%%%%%%%%%%%%%%
node(node0_3).
functor(node0_3, twhen).         const(twhen).
gram_sempos(node0_3, n_denot).         const(n_denot).
id(node0_3, t_plzensky70827_txt_001_p1s3a3).         const(t_plzensky70827_txt_001_p1s3a3).
t_lemma(node0_3, nehoda).         const(nehoda).
%%%%%%%% node0_4 %%%%%%%%%%%%%%%%%%%
node(node0_4).
a_afun(node0_4, auxp).         const(auxp).
m_form(node0_4, pri).         const(pri).
m_lemma(node0_4, pri_1).         const(pri_1).
m_tag(node0_4, rr__6__________).         const(rr__6__________).
m_tag0(node0_4,'r'). const('r'). m_tag1(node0_4,'r'). const('r'). m_tag4(node0_4,'6'). const('6'). 
%%%%%%%% node0_5 %%%%%%%%%%%%%%%%%%%
node(node0_5).
a_afun(node0_5, adv).         const(adv).
m_form(node0_5, nehode).         const(nehode).
m_lemma(node0_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node0_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node0_5,'n'). const('n'). m_tag1(node0_5,'n'). const('n'). m_tag2(node0_5,'f'). const('f'). m_tag3(node0_5,'s'). const('s'). m_tag4(node0_5,'6'). const('6'). m_tag10(node0_5,'a'). const('a'). 
%%%%%%%% node0_6 %%%%%%%%%%%%%%%%%%%
node(node0_6).
a_afun(node0_6, auxv).         const(auxv).
m_form(node0_6, byly).         const(byly).
m_lemma(node0_6, byt).         const(byt).
m_tag(node0_6, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node0_6,'v'). const('v'). m_tag1(node0_6,'p'). const('p'). m_tag2(node0_6,'t'). const('t'). m_tag3(node0_6,'p'). const('p'). m_tag7(node0_6,'x'). const('x'). m_tag8(node0_6,'r'). const('r'). m_tag10(node0_6,'a'). const('a'). m_tag11(node0_6,'a'). const('a'). 
%%%%%%%% node0_7 %%%%%%%%%%%%%%%%%%%
node(node0_7).
a_afun(node0_7, pred).         const(pred).
m_form(node0_7, zraneny).         const(zraneny).
m_lemma(node0_7, zranit__w).         const(zranit__w).
m_tag(node0_7, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node0_7,'v'). const('v'). m_tag1(node0_7,'s'). const('s'). m_tag2(node0_7,'t'). const('t'). m_tag3(node0_7,'p'). const('p'). m_tag7(node0_7,'x'). const('x'). m_tag8(node0_7,'x'). const('x'). m_tag10(node0_7,'a'). const('a'). m_tag11(node0_7,'p'). const('p'). 
%%%%%%%% node0_8 %%%%%%%%%%%%%%%%%%%
node(node0_8).
functor(node0_8, pat).         const(pat).
gram_sempos(node0_8, n_denot).         const(n_denot).
id(node0_8, t_plzensky70827_txt_001_p1s3a5).         const(t_plzensky70827_txt_001_p1s3a5).
t_lemma(node0_8, osoba).         const(osoba).
%%%%%%%% node0_9 %%%%%%%%%%%%%%%%%%%
node(node0_9).
functor(node0_9, rstr).         const(rstr).
gram_sempos(node0_9, adj_quant_def).         const(adj_quant_def).
id(node0_9, t_plzensky70827_txt_001_p1s3a6).         const(t_plzensky70827_txt_001_p1s3a6).
t_lemma(node0_9, dva).         const(dva).
%%%%%%%% node0_10 %%%%%%%%%%%%%%%%%%%
node(node0_10).
a_afun(node0_10, atr).         const(atr).
m_form(node0_10, dve).         const(dve).
m_lemma(node0_10, dva_2).         const(dva_2).
m_tag(node0_10, clhp1__________).         const(clhp1__________).
m_tag0(node0_10,'c'). const('c'). m_tag1(node0_10,'l'). const('l'). m_tag2(node0_10,'h'). const('h'). m_tag3(node0_10,'p'). const('p'). m_tag4(node0_10,'1'). const('1'). 
%%%%%%%% node0_11 %%%%%%%%%%%%%%%%%%%
node(node0_11).
a_afun(node0_11, sb).         const(sb).
m_form(node0_11, osoby).         const(osoby).
m_lemma(node0_11, osoba).         const(osoba).
m_tag(node0_11, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node0_11,'n'). const('n'). m_tag1(node0_11,'n'). const('n'). m_tag2(node0_11,'f'). const('f'). m_tag3(node0_11,'p'). const('p'). m_tag4(node0_11,'1'). const('1'). m_tag10(node0_11,'a'). const('a'). 
edge(node0_0, node0_1).
edge(node0_1, node0_2).
edge(node0_1, node0_3).
edge(node0_3, node0_4).
edge(node0_3, node0_5).
edge(node0_1, node0_6).
edge(node0_1, node0_7).
edge(node0_1, node0_8).
edge(node0_8, node0_9).
edge(node0_9, node0_10).
edge(node0_8, node0_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl zranen muz. 
tree_root(node1_0).
%%%%%%%% node1_0 %%%%%%%%%%%%%%%%%%%
node(node1_0).
id(node1_0, t_plzensky72450_txt_001_p3s2).         const(t_plzensky72450_txt_001_p3s2).
%%%%%%%% node1_1 %%%%%%%%%%%%%%%%%%%
node(node1_1).
functor(node1_1, pred).         const(pred).
gram_sempos(node1_1, v).         const(v).
id(node1_1, t_plzensky72450_txt_001_p3s2a1).         const(t_plzensky72450_txt_001_p3s2a1).
t_lemma(node1_1, zranit).         const(zranit).
%%%%%%%% node1_2 %%%%%%%%%%%%%%%%%%%
node(node1_2).
functor(node1_2, act).         const(act).
id(node1_2, t_plzensky72450_txt_001_p3s2a6).         const(t_plzensky72450_txt_001_p3s2a6).
t_lemma(node1_2, x_gen).         const(x_gen).
%%%%%%%% node1_3 %%%%%%%%%%%%%%%%%%%
node(node1_3).
functor(node1_3, twhen).         const(twhen).
gram_sempos(node1_3, n_denot).         const(n_denot).
id(node1_3, t_plzensky72450_txt_001_p3s2a3).         const(t_plzensky72450_txt_001_p3s2a3).
t_lemma(node1_3, nehoda).         const(nehoda).
%%%%%%%% node1_4 %%%%%%%%%%%%%%%%%%%
node(node1_4).
a_afun(node1_4, auxp).         const(auxp).
m_form(node1_4, pri).         const(pri).
m_lemma(node1_4, pri_1).         const(pri_1).
m_tag(node1_4, rr__6__________).         const(rr__6__________).
m_tag0(node1_4,'r'). const('r'). m_tag1(node1_4,'r'). const('r'). m_tag4(node1_4,'6'). const('6'). 
%%%%%%%% node1_5 %%%%%%%%%%%%%%%%%%%
node(node1_5).
a_afun(node1_5, adv).         const(adv).
m_form(node1_5, nehode).         const(nehode).
m_lemma(node1_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node1_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node1_5,'n'). const('n'). m_tag1(node1_5,'n'). const('n'). m_tag2(node1_5,'f'). const('f'). m_tag3(node1_5,'s'). const('s'). m_tag4(node1_5,'6'). const('6'). m_tag10(node1_5,'a'). const('a'). 
%%%%%%%% node1_6 %%%%%%%%%%%%%%%%%%%
node(node1_6).
a_afun(node1_6, auxv).         const(auxv).
m_form(node1_6, byl).         const(byl).
m_lemma(node1_6, byt).         const(byt).
m_tag(node1_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node1_6,'v'). const('v'). m_tag1(node1_6,'p'). const('p'). m_tag2(node1_6,'y'). const('y'). m_tag3(node1_6,'s'). const('s'). m_tag7(node1_6,'x'). const('x'). m_tag8(node1_6,'r'). const('r'). m_tag10(node1_6,'a'). const('a'). m_tag11(node1_6,'a'). const('a'). 
%%%%%%%% node1_7 %%%%%%%%%%%%%%%%%%%
node(node1_7).
a_afun(node1_7, pred).         const(pred).
m_form(node1_7, zranen).         const(zranen).
m_lemma(node1_7, zranit__w).         const(zranit__w).
m_tag(node1_7, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node1_7,'v'). const('v'). m_tag1(node1_7,'s'). const('s'). m_tag2(node1_7,'y'). const('y'). m_tag3(node1_7,'s'). const('s'). m_tag7(node1_7,'x'). const('x'). m_tag8(node1_7,'x'). const('x'). m_tag10(node1_7,'a'). const('a'). m_tag11(node1_7,'p'). const('p'). 
%%%%%%%% node1_8 %%%%%%%%%%%%%%%%%%%
node(node1_8).
functor(node1_8, pat).         const(pat).
gram_sempos(node1_8, n_denot).         const(n_denot).
id(node1_8, t_plzensky72450_txt_001_p3s2a5).         const(t_plzensky72450_txt_001_p3s2a5).
t_lemma(node1_8, muz).         const(muz).
%%%%%%%% node1_9 %%%%%%%%%%%%%%%%%%%
node(node1_9).
a_afun(node1_9, sb).         const(sb).
m_form(node1_9, muz).         const(muz).
m_lemma(node1_9, muz).         const(muz).
m_tag(node1_9, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node1_9,'n'). const('n'). m_tag1(node1_9,'n'). const('n'). m_tag2(node1_9,'m'). const('m'). m_tag3(node1_9,'s'). const('s'). m_tag4(node1_9,'1'). const('1'). m_tag10(node1_9,'a'). const('a'). 
edge(node1_0, node1_1).
edge(node1_1, node1_2).
edge(node1_1, node1_3).
edge(node1_3, node1_4).
edge(node1_3, node1_5).
edge(node1_1, node1_6).
edge(node1_1, node1_7).
edge(node1_1, node1_8).
edge(node1_8, node1_9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byla lehce zranena jedna osoba. 
tree_root(node2_0).
%%%%%%%% node2_0 %%%%%%%%%%%%%%%%%%%
node(node2_0).
id(node2_0, t_plzensky72450_txt_001_p19s2).         const(t_plzensky72450_txt_001_p19s2).
%%%%%%%% node2_1 %%%%%%%%%%%%%%%%%%%
node(node2_1).
functor(node2_1, pred).         const(pred).
gram_sempos(node2_1, v).         const(v).
id(node2_1, t_plzensky72450_txt_001_p19s2a1).         const(t_plzensky72450_txt_001_p19s2a1).
t_lemma(node2_1, zranit).         const(zranit).
%%%%%%%% node2_2 %%%%%%%%%%%%%%%%%%%
node(node2_2).
functor(node2_2, act).         const(act).
id(node2_2, t_plzensky72450_txt_001_p19s2a8).         const(t_plzensky72450_txt_001_p19s2a8).
t_lemma(node2_2, x_gen).         const(x_gen).
%%%%%%%% node2_3 %%%%%%%%%%%%%%%%%%%
node(node2_3).
functor(node2_3, twhen).         const(twhen).
gram_sempos(node2_3, n_denot).         const(n_denot).
id(node2_3, t_plzensky72450_txt_001_p19s2a3).         const(t_plzensky72450_txt_001_p19s2a3).
t_lemma(node2_3, nehoda).         const(nehoda).
%%%%%%%% node2_4 %%%%%%%%%%%%%%%%%%%
node(node2_4).
a_afun(node2_4, auxp).         const(auxp).
m_form(node2_4, pri).         const(pri).
m_lemma(node2_4, pri_1).         const(pri_1).
m_tag(node2_4, rr__6__________).         const(rr__6__________).
m_tag0(node2_4,'r'). const('r'). m_tag1(node2_4,'r'). const('r'). m_tag4(node2_4,'6'). const('6'). 
%%%%%%%% node2_5 %%%%%%%%%%%%%%%%%%%
node(node2_5).
a_afun(node2_5, adv).         const(adv).
m_form(node2_5, nehode).         const(nehode).
m_lemma(node2_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node2_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node2_5,'n'). const('n'). m_tag1(node2_5,'n'). const('n'). m_tag2(node2_5,'f'). const('f'). m_tag3(node2_5,'s'). const('s'). m_tag4(node2_5,'6'). const('6'). m_tag10(node2_5,'a'). const('a'). 
%%%%%%%% node2_6 %%%%%%%%%%%%%%%%%%%
node(node2_6).
functor(node2_6, mann).         const(mann).
gram_sempos(node2_6, adj_denot).         const(adj_denot).
id(node2_6, t_plzensky72450_txt_001_p19s2a5).         const(t_plzensky72450_txt_001_p19s2a5).
t_lemma(node2_6, lehky).         const(lehky).
%%%%%%%% node2_7 %%%%%%%%%%%%%%%%%%%
node(node2_7).
a_afun(node2_7, adv).         const(adv).
m_form(node2_7, lehce).         const(lehce).
m_lemma(node2_7, lehce).         const(lehce).
m_tag(node2_7, dg_______1a____).         const(dg_______1a____).
m_tag0(node2_7,'d'). const('d'). m_tag1(node2_7,'g'). const('g'). m_tag9(node2_7,'1'). const('1'). m_tag10(node2_7,'a'). const('a'). 
%%%%%%%% node2_8 %%%%%%%%%%%%%%%%%%%
node(node2_8).
a_afun(node2_8, auxv).         const(auxv).
m_form(node2_8, byla).         const(byla).
m_lemma(node2_8, byt).         const(byt).
m_tag(node2_8, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node2_8,'v'). const('v'). m_tag1(node2_8,'p'). const('p'). m_tag2(node2_8,'q'). const('q'). m_tag3(node2_8,'w'). const('w'). m_tag7(node2_8,'x'). const('x'). m_tag8(node2_8,'r'). const('r'). m_tag10(node2_8,'a'). const('a'). m_tag11(node2_8,'a'). const('a'). 
%%%%%%%% node2_9 %%%%%%%%%%%%%%%%%%%
node(node2_9).
a_afun(node2_9, pred).         const(pred).
m_form(node2_9, zranena).         const(zranena).
m_lemma(node2_9, zranit__w).         const(zranit__w).
m_tag(node2_9, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node2_9,'v'). const('v'). m_tag1(node2_9,'s'). const('s'). m_tag2(node2_9,'q'). const('q'). m_tag3(node2_9,'w'). const('w'). m_tag7(node2_9,'x'). const('x'). m_tag8(node2_9,'x'). const('x'). m_tag10(node2_9,'a'). const('a'). m_tag11(node2_9,'p'). const('p'). 
%%%%%%%% node2_10 %%%%%%%%%%%%%%%%%%%
node(node2_10).
functor(node2_10, pat).         const(pat).
gram_sempos(node2_10, n_denot).         const(n_denot).
id(node2_10, t_plzensky72450_txt_001_p19s2a6).         const(t_plzensky72450_txt_001_p19s2a6).
t_lemma(node2_10, osoba).         const(osoba).
%%%%%%%% node2_11 %%%%%%%%%%%%%%%%%%%
node(node2_11).
functor(node2_11, rstr).         const(rstr).
gram_sempos(node2_11, adj_quant_def).         const(adj_quant_def).
id(node2_11, t_plzensky72450_txt_001_p19s2a7).         const(t_plzensky72450_txt_001_p19s2a7).
t_lemma(node2_11, jeden).         const(jeden).
%%%%%%%% node2_12 %%%%%%%%%%%%%%%%%%%
node(node2_12).
a_afun(node2_12, atr).         const(atr).
m_form(node2_12, jedna).         const(jedna).
m_lemma(node2_12, jeden_1).         const(jeden_1).
m_tag(node2_12, clfs1__________).         const(clfs1__________).
m_tag0(node2_12,'c'). const('c'). m_tag1(node2_12,'l'). const('l'). m_tag2(node2_12,'f'). const('f'). m_tag3(node2_12,'s'). const('s'). m_tag4(node2_12,'1'). const('1'). 
%%%%%%%% node2_13 %%%%%%%%%%%%%%%%%%%
node(node2_13).
a_afun(node2_13, sb).         const(sb).
m_form(node2_13, osoba).         const(osoba).
m_lemma(node2_13, osoba).         const(osoba).
m_tag(node2_13, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node2_13,'n'). const('n'). m_tag1(node2_13,'n'). const('n'). m_tag2(node2_13,'f'). const('f'). m_tag3(node2_13,'s'). const('s'). m_tag4(node2_13,'1'). const('1'). m_tag10(node2_13,'a'). const('a'). 
edge(node2_0, node2_1).
edge(node2_1, node2_2).
edge(node2_1, node2_3).
edge(node2_3, node2_4).
edge(node2_3, node2_5).
edge(node2_1, node2_6).
edge(node2_6, node2_7).
edge(node2_1, node2_8).
edge(node2_1, node2_9).
edge(node2_1, node2_10).
edge(node2_10, node2_11).
edge(node2_11, node2_12).
edge(node2_10, node2_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby. 
tree_root(node3_0).
%%%%%%%% node3_0 %%%%%%%%%%%%%%%%%%%
node(node3_0).
id(node3_0, t_plzensky49076_txt_001_p1s3).         const(t_plzensky49076_txt_001_p1s3).
%%%%%%%% node3_1 %%%%%%%%%%%%%%%%%%%
node(node3_1).
functor(node3_1, pred).         const(pred).
gram_sempos(node3_1, v).         const(v).
id(node3_1, t_plzensky49076_txt_001_p1s3a1).         const(t_plzensky49076_txt_001_p1s3a1).
t_lemma(node3_1, zranit).         const(zranit).
%%%%%%%% node3_2 %%%%%%%%%%%%%%%%%%%
node(node3_2).
functor(node3_2, act).         const(act).
id(node3_2, t_plzensky49076_txt_001_p1s3a7).         const(t_plzensky49076_txt_001_p1s3a7).
t_lemma(node3_2, x_gen).         const(x_gen).
%%%%%%%% node3_3 %%%%%%%%%%%%%%%%%%%
node(node3_3).
functor(node3_3, twhen).         const(twhen).
gram_sempos(node3_3, n_denot).         const(n_denot).
id(node3_3, t_plzensky49076_txt_001_p1s3a3).         const(t_plzensky49076_txt_001_p1s3a3).
t_lemma(node3_3, nehoda).         const(nehoda).
%%%%%%%% node3_4 %%%%%%%%%%%%%%%%%%%
node(node3_4).
a_afun(node3_4, auxp).         const(auxp).
m_form(node3_4, pri).         const(pri).
m_lemma(node3_4, pri_1).         const(pri_1).
m_tag(node3_4, rr__6__________).         const(rr__6__________).
m_tag0(node3_4,'r'). const('r'). m_tag1(node3_4,'r'). const('r'). m_tag4(node3_4,'6'). const('6'). 
%%%%%%%% node3_5 %%%%%%%%%%%%%%%%%%%
node(node3_5).
a_afun(node3_5, adv).         const(adv).
m_form(node3_5, nehode).         const(nehode).
m_lemma(node3_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node3_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node3_5,'n'). const('n'). m_tag1(node3_5,'n'). const('n'). m_tag2(node3_5,'f'). const('f'). m_tag3(node3_5,'s'). const('s'). m_tag4(node3_5,'6'). const('6'). m_tag10(node3_5,'a'). const('a'). 
%%%%%%%% node3_6 %%%%%%%%%%%%%%%%%%%
node(node3_6).
a_afun(node3_6, auxv).         const(auxv).
m_form(node3_6, byly).         const(byly).
m_lemma(node3_6, byt).         const(byt).
m_tag(node3_6, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node3_6,'v'). const('v'). m_tag1(node3_6,'p'). const('p'). m_tag2(node3_6,'t'). const('t'). m_tag3(node3_6,'p'). const('p'). m_tag7(node3_6,'x'). const('x'). m_tag8(node3_6,'r'). const('r'). m_tag10(node3_6,'a'). const('a'). m_tag11(node3_6,'a'). const('a'). 
%%%%%%%% node3_7 %%%%%%%%%%%%%%%%%%%
node(node3_7).
a_afun(node3_7, pred).         const(pred).
m_form(node3_7, zraneny).         const(zraneny).
m_lemma(node3_7, zranit__w).         const(zranit__w).
m_tag(node3_7, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node3_7,'v'). const('v'). m_tag1(node3_7,'s'). const('s'). m_tag2(node3_7,'t'). const('t'). m_tag3(node3_7,'p'). const('p'). m_tag7(node3_7,'x'). const('x'). m_tag8(node3_7,'x'). const('x'). m_tag10(node3_7,'a'). const('a'). m_tag11(node3_7,'p'). const('p'). 
%%%%%%%% node3_8 %%%%%%%%%%%%%%%%%%%
node(node3_8).
functor(node3_8, pat).         const(pat).
gram_sempos(node3_8, n_denot).         const(n_denot).
id(node3_8, t_plzensky49076_txt_001_p1s3a5).         const(t_plzensky49076_txt_001_p1s3a5).
t_lemma(node3_8, osoba).         const(osoba).
%%%%%%%% node3_9 %%%%%%%%%%%%%%%%%%%
node(node3_9).
functor(node3_9, rstr).         const(rstr).
gram_sempos(node3_9, adj_quant_def).         const(adj_quant_def).
id(node3_9, t_plzensky49076_txt_001_p1s3a6).         const(t_plzensky49076_txt_001_p1s3a6).
t_lemma(node3_9, dva).         const(dva).
%%%%%%%% node3_10 %%%%%%%%%%%%%%%%%%%
node(node3_10).
a_afun(node3_10, atr).         const(atr).
m_form(node3_10, dve).         const(dve).
m_lemma(node3_10, dva_2).         const(dva_2).
m_tag(node3_10, clhp1__________).         const(clhp1__________).
m_tag0(node3_10,'c'). const('c'). m_tag1(node3_10,'l'). const('l'). m_tag2(node3_10,'h'). const('h'). m_tag3(node3_10,'p'). const('p'). m_tag4(node3_10,'1'). const('1'). 
%%%%%%%% node3_11 %%%%%%%%%%%%%%%%%%%
node(node3_11).
a_afun(node3_11, sb).         const(sb).
m_form(node3_11, osoby).         const(osoby).
m_lemma(node3_11, osoba).         const(osoba).
m_tag(node3_11, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node3_11,'n'). const('n'). m_tag1(node3_11,'n'). const('n'). m_tag2(node3_11,'f'). const('f'). m_tag3(node3_11,'p'). const('p'). m_tag4(node3_11,'1'). const('1'). m_tag10(node3_11,'a'). const('a'). 
edge(node3_0, node3_1).
edge(node3_1, node3_2).
edge(node3_1, node3_3).
edge(node3_3, node3_4).
edge(node3_3, node3_5).
edge(node3_1, node3_6).
edge(node3_1, node3_7).
edge(node3_1, node3_8).
edge(node3_8, node3_9).
edge(node3_9, node3_10).
edge(node3_8, node3_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ve vozidle cestovaly dve osoby, ridic byl lehce zranen a do sve pece ho prevzala zzs. 
tree_root(node4_0).
%%%%%%%% node4_0 %%%%%%%%%%%%%%%%%%%
node(node4_0).
id(node4_0, t_plzensky63162_txt_001_p1s3).         const(t_plzensky63162_txt_001_p1s3).
%%%%%%%% node4_1 %%%%%%%%%%%%%%%%%%%
node(node4_1).
functor(node4_1, pred).         const(pred).
gram_sempos(node4_1, v).         const(v).
id(node4_1, t_plzensky63162_txt_001_p1s3a1).         const(t_plzensky63162_txt_001_p1s3a1).
t_lemma(node4_1, cestovat).         const(cestovat).
%%%%%%%% node4_2 %%%%%%%%%%%%%%%%%%%
node(node4_2).
functor(node4_2, loc).         const(loc).
gram_sempos(node4_2, n_denot).         const(n_denot).
id(node4_2, t_plzensky63162_txt_001_p1s3a3).         const(t_plzensky63162_txt_001_p1s3a3).
t_lemma(node4_2, vozidlo).         const(vozidlo).
%%%%%%%% node4_3 %%%%%%%%%%%%%%%%%%%
node(node4_3).
a_afun(node4_3, auxp).         const(auxp).
m_form(node4_3, ve).         const(ve).
m_lemma(node4_3, v_1).         const(v_1).
m_tag(node4_3, rv__6__________).         const(rv__6__________).
m_tag0(node4_3,'r'). const('r'). m_tag1(node4_3,'v'). const('v'). m_tag4(node4_3,'6'). const('6'). 
%%%%%%%% node4_4 %%%%%%%%%%%%%%%%%%%
node(node4_4).
a_afun(node4_4, adv).         const(adv).
m_form(node4_4, vozidle).         const(vozidle).
m_lemma(node4_4, vozidlo).         const(vozidlo).
m_tag(node4_4, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node4_4,'n'). const('n'). m_tag1(node4_4,'n'). const('n'). m_tag2(node4_4,'n'). const('n'). m_tag3(node4_4,'s'). const('s'). m_tag4(node4_4,'6'). const('6'). m_tag10(node4_4,'a'). const('a'). 
%%%%%%%% node4_5 %%%%%%%%%%%%%%%%%%%
node(node4_5).
a_afun(node4_5, pred).         const(pred).
m_form(node4_5, cestovaly).         const(cestovaly).
m_lemma(node4_5, cestovat__t).         const(cestovat__t).
m_tag(node4_5, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node4_5,'v'). const('v'). m_tag1(node4_5,'p'). const('p'). m_tag2(node4_5,'t'). const('t'). m_tag3(node4_5,'p'). const('p'). m_tag7(node4_5,'x'). const('x'). m_tag8(node4_5,'r'). const('r'). m_tag10(node4_5,'a'). const('a'). m_tag11(node4_5,'a'). const('a'). 
%%%%%%%% node4_6 %%%%%%%%%%%%%%%%%%%
node(node4_6).
functor(node4_6, act).         const(act).
gram_sempos(node4_6, n_denot).         const(n_denot).
id(node4_6, t_plzensky63162_txt_001_p1s3a4).         const(t_plzensky63162_txt_001_p1s3a4).
t_lemma(node4_6, osoba).         const(osoba).
%%%%%%%% node4_7 %%%%%%%%%%%%%%%%%%%
node(node4_7).
functor(node4_7, rstr).         const(rstr).
gram_sempos(node4_7, adj_quant_def).         const(adj_quant_def).
id(node4_7, t_plzensky63162_txt_001_p1s3a5).         const(t_plzensky63162_txt_001_p1s3a5).
t_lemma(node4_7, dva).         const(dva).
%%%%%%%% node4_8 %%%%%%%%%%%%%%%%%%%
node(node4_8).
a_afun(node4_8, atr).         const(atr).
m_form(node4_8, dve).         const(dve).
m_lemma(node4_8, dva_2).         const(dva_2).
m_tag(node4_8, clhp1__________).         const(clhp1__________).
m_tag0(node4_8,'c'). const('c'). m_tag1(node4_8,'l'). const('l'). m_tag2(node4_8,'h'). const('h'). m_tag3(node4_8,'p'). const('p'). m_tag4(node4_8,'1'). const('1'). 
%%%%%%%% node4_9 %%%%%%%%%%%%%%%%%%%
node(node4_9).
a_afun(node4_9, sb).         const(sb).
m_form(node4_9, osoby).         const(osoby).
m_lemma(node4_9, osoba).         const(osoba).
m_tag(node4_9, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node4_9,'n'). const('n'). m_tag1(node4_9,'n'). const('n'). m_tag2(node4_9,'f'). const('f'). m_tag3(node4_9,'p'). const('p'). m_tag4(node4_9,'1'). const('1'). m_tag10(node4_9,'a'). const('a'). 
%%%%%%%% node4_10 %%%%%%%%%%%%%%%%%%%
node(node4_10).
functor(node4_10, conj).         const(conj).
id(node4_10, t_plzensky63162_txt_001_p1s3a6).         const(t_plzensky63162_txt_001_p1s3a6).
t_lemma(node4_10, a).         const(a).
%%%%%%%% node4_11 %%%%%%%%%%%%%%%%%%%
node(node4_11).
functor(node4_11, rstr).         const(rstr).
gram_sempos(node4_11, v).         const(v).
id(node4_11, t_plzensky63162_txt_001_p1s3a9).         const(t_plzensky63162_txt_001_p1s3a9).
t_lemma(node4_11, zranit).         const(zranit).
%%%%%%%% node4_12 %%%%%%%%%%%%%%%%%%%
node(node4_12).
functor(node4_12, act).         const(act).
id(node4_12, t_plzensky63162_txt_001_p1s3a18).         const(t_plzensky63162_txt_001_p1s3a18).
t_lemma(node4_12, x_gen).         const(x_gen).
%%%%%%%% node4_13 %%%%%%%%%%%%%%%%%%%
node(node4_13).
functor(node4_13, pat).         const(pat).
gram_sempos(node4_13, n_denot).         const(n_denot).
id(node4_13, t_plzensky63162_txt_001_p1s3a8).         const(t_plzensky63162_txt_001_p1s3a8).
t_lemma(node4_13, ridic).         const(ridic).
%%%%%%%% node4_14 %%%%%%%%%%%%%%%%%%%
node(node4_14).
a_afun(node4_14, atr).         const(atr).
m_form(node4_14, ridic).         const(ridic).
m_lemma(node4_14, ridic).         const(ridic).
m_tag(node4_14, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node4_14,'n'). const('n'). m_tag1(node4_14,'n'). const('n'). m_tag2(node4_14,'m'). const('m'). m_tag3(node4_14,'s'). const('s'). m_tag4(node4_14,'1'). const('1'). m_tag10(node4_14,'a'). const('a'). 
%%%%%%%% node4_15 %%%%%%%%%%%%%%%%%%%
node(node4_15).
functor(node4_15, mann).         const(mann).
gram_sempos(node4_15, adj_denot).         const(adj_denot).
id(node4_15, t_plzensky63162_txt_001_p1s3a11).         const(t_plzensky63162_txt_001_p1s3a11).
t_lemma(node4_15, lehky).         const(lehky).
%%%%%%%% node4_16 %%%%%%%%%%%%%%%%%%%
node(node4_16).
a_afun(node4_16, adv).         const(adv).
m_form(node4_16, lehce).         const(lehce).
m_lemma(node4_16, lehce).         const(lehce).
m_tag(node4_16, dg_______1a____).         const(dg_______1a____).
m_tag0(node4_16,'d'). const('d'). m_tag1(node4_16,'g'). const('g'). m_tag9(node4_16,'1'). const('1'). m_tag10(node4_16,'a'). const('a'). 
%%%%%%%% node4_17 %%%%%%%%%%%%%%%%%%%
node(node4_17).
a_afun(node4_17, auxv).         const(auxv).
m_form(node4_17, byl).         const(byl).
m_lemma(node4_17, byt).         const(byt).
m_tag(node4_17, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node4_17,'v'). const('v'). m_tag1(node4_17,'p'). const('p'). m_tag2(node4_17,'y'). const('y'). m_tag3(node4_17,'s'). const('s'). m_tag7(node4_17,'x'). const('x'). m_tag8(node4_17,'r'). const('r'). m_tag10(node4_17,'a'). const('a'). m_tag11(node4_17,'a'). const('a'). 
%%%%%%%% node4_18 %%%%%%%%%%%%%%%%%%%
node(node4_18).
a_afun(node4_18, atr).         const(atr).
m_form(node4_18, zranen).         const(zranen).
m_lemma(node4_18, zranit__w).         const(zranit__w).
m_tag(node4_18, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node4_18,'v'). const('v'). m_tag1(node4_18,'s'). const('s'). m_tag2(node4_18,'y'). const('y'). m_tag3(node4_18,'s'). const('s'). m_tag7(node4_18,'x'). const('x'). m_tag8(node4_18,'x'). const('x'). m_tag10(node4_18,'a'). const('a'). m_tag11(node4_18,'p'). const('p'). 
%%%%%%%% node4_19 %%%%%%%%%%%%%%%%%%%
node(node4_19).
a_afun(node4_19, coord).         const(coord).
m_form(node4_19, a).         const(a).
m_lemma(node4_19, a_1).         const(a_1).
m_tag(node4_19, j______________).         const(j______________).
m_tag0(node4_19,'j'). const('j'). m_tag1(node4_19,'^'). const('^'). 
%%%%%%%% node4_20 %%%%%%%%%%%%%%%%%%%
node(node4_20).
functor(node4_20, rstr).         const(rstr).
gram_sempos(node4_20, v).         const(v).
id(node4_20, t_plzensky63162_txt_001_p1s3a12).         const(t_plzensky63162_txt_001_p1s3a12).
t_lemma(node4_20, prevzit).         const(prevzit).
%%%%%%%% node4_21 %%%%%%%%%%%%%%%%%%%
node(node4_21).
functor(node4_21, dir3).         const(dir3).
gram_sempos(node4_21, n_denot).         const(n_denot).
id(node4_21, t_plzensky63162_txt_001_p1s3a14).         const(t_plzensky63162_txt_001_p1s3a14).
t_lemma(node4_21, pece).         const(pece).
%%%%%%%% node4_22 %%%%%%%%%%%%%%%%%%%
node(node4_22).
functor(node4_22, app).         const(app).
gram_sempos(node4_22, n_pron_def_pers).         const(n_pron_def_pers).
id(node4_22, t_plzensky63162_txt_001_p1s3a15).         const(t_plzensky63162_txt_001_p1s3a15).
t_lemma(node4_22, x_perspron).         const(x_perspron).
%%%%%%%% node4_23 %%%%%%%%%%%%%%%%%%%
node(node4_23).
a_afun(node4_23, atr).         const(atr).
m_form(node4_23, sve).         const(sve).
m_lemma(node4_23, svuj_1___privlast__).         const(svuj_1___privlast__).
m_tag(node4_23, p8fs2_________1).         const(p8fs2_________1).
m_tag0(node4_23,'p'). const('p'). m_tag1(node4_23,'8'). const('8'). m_tag2(node4_23,'f'). const('f'). m_tag3(node4_23,'s'). const('s'). m_tag4(node4_23,'2'). const('2'). m_tag14(node4_23,'1'). const('1'). 
%%%%%%%% node4_24 %%%%%%%%%%%%%%%%%%%
node(node4_24).
a_afun(node4_24, auxp).         const(auxp).
m_form(node4_24, do).         const(do).
m_lemma(node4_24, do_1).         const(do_1).
m_tag(node4_24, rr__2__________).         const(rr__2__________).
m_tag0(node4_24,'r'). const('r'). m_tag1(node4_24,'r'). const('r'). m_tag4(node4_24,'2'). const('2'). 
%%%%%%%% node4_25 %%%%%%%%%%%%%%%%%%%
node(node4_25).
a_afun(node4_25, adv).         const(adv).
m_form(node4_25, pece).         const(pece).
m_lemma(node4_25, pece).         const(pece).
m_tag(node4_25, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node4_25,'n'). const('n'). m_tag1(node4_25,'n'). const('n'). m_tag2(node4_25,'f'). const('f'). m_tag3(node4_25,'s'). const('s'). m_tag4(node4_25,'2'). const('2'). m_tag10(node4_25,'a'). const('a'). 
%%%%%%%% node4_26 %%%%%%%%%%%%%%%%%%%
node(node4_26).
functor(node4_26, pat).         const(pat).
gram_sempos(node4_26, n_pron_def_pers).         const(n_pron_def_pers).
id(node4_26, t_plzensky63162_txt_001_p1s3a16).         const(t_plzensky63162_txt_001_p1s3a16).
t_lemma(node4_26, x_perspron).         const(x_perspron).
%%%%%%%% node4_27 %%%%%%%%%%%%%%%%%%%
node(node4_27).
a_afun(node4_27, obj).         const(obj).
m_form(node4_27, ho).         const(ho).
m_lemma(node4_27, on_1).         const(on_1).
m_tag(node4_27, phzs4__3_______).         const(phzs4__3_______).
m_tag0(node4_27,'p'). const('p'). m_tag1(node4_27,'h'). const('h'). m_tag2(node4_27,'z'). const('z'). m_tag3(node4_27,'s'). const('s'). m_tag4(node4_27,'4'). const('4'). m_tag7(node4_27,'3'). const('3'). 
%%%%%%%% node4_28 %%%%%%%%%%%%%%%%%%%
node(node4_28).
a_afun(node4_28, atr).         const(atr).
m_form(node4_28, prevzala).         const(prevzala).
m_lemma(node4_28, prevzit___pr__od_nekoho_vec__zodpovednost____).         const(prevzit___pr__od_nekoho_vec__zodpovednost____).
m_tag(node4_28, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node4_28,'v'). const('v'). m_tag1(node4_28,'p'). const('p'). m_tag2(node4_28,'q'). const('q'). m_tag3(node4_28,'w'). const('w'). m_tag7(node4_28,'x'). const('x'). m_tag8(node4_28,'r'). const('r'). m_tag10(node4_28,'a'). const('a'). m_tag11(node4_28,'a'). const('a'). 
%%%%%%%% node4_29 %%%%%%%%%%%%%%%%%%%
node(node4_29).
functor(node4_29, act).         const(act).
gram_sempos(node4_29, n_denot).         const(n_denot).
id(node4_29, t_plzensky63162_txt_001_p1s3a17).         const(t_plzensky63162_txt_001_p1s3a17).
t_lemma(node4_29, zzs).         const(zzs).
%%%%%%%% node4_30 %%%%%%%%%%%%%%%%%%%
node(node4_30).
a_afun(node4_30, sb).         const(sb).
m_form(node4_30, zzs).         const(zzs).
m_lemma(node4_30, zzs).         const(zzs).
m_tag(node4_30, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node4_30,'n'). const('n'). m_tag1(node4_30,'n'). const('n'). m_tag2(node4_30,'f'). const('f'). m_tag3(node4_30,'x'). const('x'). m_tag4(node4_30,'x'). const('x'). m_tag10(node4_30,'a'). const('a'). 
edge(node4_0, node4_1).
edge(node4_1, node4_2).
edge(node4_2, node4_3).
edge(node4_2, node4_4).
edge(node4_1, node4_5).
edge(node4_1, node4_6).
edge(node4_6, node4_7).
edge(node4_7, node4_8).
edge(node4_6, node4_9).
edge(node4_6, node4_10).
edge(node4_10, node4_11).
edge(node4_11, node4_12).
edge(node4_11, node4_13).
edge(node4_13, node4_14).
edge(node4_11, node4_15).
edge(node4_15, node4_16).
edge(node4_11, node4_17).
edge(node4_11, node4_18).
edge(node4_10, node4_19).
edge(node4_10, node4_20).
edge(node4_20, node4_21).
edge(node4_21, node4_22).
edge(node4_22, node4_23).
edge(node4_21, node4_24).
edge(node4_21, node4_25).
edge(node4_20, node4_26).
edge(node4_26, node4_27).
edge(node4_20, node4_28).
edge(node4_20, node4_29).
edge(node4_29, node4_30).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byla zranena jedna osoba. 
tree_root(node5_0).
%%%%%%%% node5_0 %%%%%%%%%%%%%%%%%%%
node(node5_0).
id(node5_0, t_plzensky72795_txt_001_p2s3).         const(t_plzensky72795_txt_001_p2s3).
%%%%%%%% node5_1 %%%%%%%%%%%%%%%%%%%
node(node5_1).
functor(node5_1, pred).         const(pred).
gram_sempos(node5_1, v).         const(v).
id(node5_1, t_plzensky72795_txt_001_p2s3a1).         const(t_plzensky72795_txt_001_p2s3a1).
t_lemma(node5_1, zranit).         const(zranit).
%%%%%%%% node5_2 %%%%%%%%%%%%%%%%%%%
node(node5_2).
functor(node5_2, act).         const(act).
id(node5_2, t_plzensky72795_txt_001_p2s3a7).         const(t_plzensky72795_txt_001_p2s3a7).
t_lemma(node5_2, x_gen).         const(x_gen).
%%%%%%%% node5_3 %%%%%%%%%%%%%%%%%%%
node(node5_3).
functor(node5_3, twhen).         const(twhen).
gram_sempos(node5_3, n_denot).         const(n_denot).
id(node5_3, t_plzensky72795_txt_001_p2s3a3).         const(t_plzensky72795_txt_001_p2s3a3).
t_lemma(node5_3, nehoda).         const(nehoda).
%%%%%%%% node5_4 %%%%%%%%%%%%%%%%%%%
node(node5_4).
a_afun(node5_4, auxp).         const(auxp).
m_form(node5_4, pri).         const(pri).
m_lemma(node5_4, pri_1).         const(pri_1).
m_tag(node5_4, rr__6__________).         const(rr__6__________).
m_tag0(node5_4,'r'). const('r'). m_tag1(node5_4,'r'). const('r'). m_tag4(node5_4,'6'). const('6'). 
%%%%%%%% node5_5 %%%%%%%%%%%%%%%%%%%
node(node5_5).
a_afun(node5_5, adv).         const(adv).
m_form(node5_5, nehode).         const(nehode).
m_lemma(node5_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node5_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node5_5,'n'). const('n'). m_tag1(node5_5,'n'). const('n'). m_tag2(node5_5,'f'). const('f'). m_tag3(node5_5,'s'). const('s'). m_tag4(node5_5,'6'). const('6'). m_tag10(node5_5,'a'). const('a'). 
%%%%%%%% node5_6 %%%%%%%%%%%%%%%%%%%
node(node5_6).
a_afun(node5_6, auxv).         const(auxv).
m_form(node5_6, byla).         const(byla).
m_lemma(node5_6, byt).         const(byt).
m_tag(node5_6, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node5_6,'v'). const('v'). m_tag1(node5_6,'p'). const('p'). m_tag2(node5_6,'q'). const('q'). m_tag3(node5_6,'w'). const('w'). m_tag7(node5_6,'x'). const('x'). m_tag8(node5_6,'r'). const('r'). m_tag10(node5_6,'a'). const('a'). m_tag11(node5_6,'a'). const('a'). 
%%%%%%%% node5_7 %%%%%%%%%%%%%%%%%%%
node(node5_7).
a_afun(node5_7, pred).         const(pred).
m_form(node5_7, zranena).         const(zranena).
m_lemma(node5_7, zranit__w).         const(zranit__w).
m_tag(node5_7, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node5_7,'v'). const('v'). m_tag1(node5_7,'s'). const('s'). m_tag2(node5_7,'q'). const('q'). m_tag3(node5_7,'w'). const('w'). m_tag7(node5_7,'x'). const('x'). m_tag8(node5_7,'x'). const('x'). m_tag10(node5_7,'a'). const('a'). m_tag11(node5_7,'p'). const('p'). 
%%%%%%%% node5_8 %%%%%%%%%%%%%%%%%%%
node(node5_8).
functor(node5_8, pat).         const(pat).
gram_sempos(node5_8, n_denot).         const(n_denot).
id(node5_8, t_plzensky72795_txt_001_p2s3a5).         const(t_plzensky72795_txt_001_p2s3a5).
t_lemma(node5_8, osoba).         const(osoba).
%%%%%%%% node5_9 %%%%%%%%%%%%%%%%%%%
node(node5_9).
functor(node5_9, rstr).         const(rstr).
gram_sempos(node5_9, adj_quant_def).         const(adj_quant_def).
id(node5_9, t_plzensky72795_txt_001_p2s3a6).         const(t_plzensky72795_txt_001_p2s3a6).
t_lemma(node5_9, jeden).         const(jeden).
%%%%%%%% node5_10 %%%%%%%%%%%%%%%%%%%
node(node5_10).
a_afun(node5_10, atr).         const(atr).
m_form(node5_10, jedna).         const(jedna).
m_lemma(node5_10, jeden_1).         const(jeden_1).
m_tag(node5_10, clfs1__________).         const(clfs1__________).
m_tag0(node5_10,'c'). const('c'). m_tag1(node5_10,'l'). const('l'). m_tag2(node5_10,'f'). const('f'). m_tag3(node5_10,'s'). const('s'). m_tag4(node5_10,'1'). const('1'). 
%%%%%%%% node5_11 %%%%%%%%%%%%%%%%%%%
node(node5_11).
a_afun(node5_11, sb).         const(sb).
m_form(node5_11, osoba).         const(osoba).
m_lemma(node5_11, osoba).         const(osoba).
m_tag(node5_11, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node5_11,'n'). const('n'). m_tag1(node5_11,'n'). const('n'). m_tag2(node5_11,'f'). const('f'). m_tag3(node5_11,'s'). const('s'). m_tag4(node5_11,'1'). const('1'). m_tag10(node5_11,'a'). const('a'). 
edge(node5_0, node5_1).
edge(node5_1, node5_2).
edge(node5_1, node5_3).
edge(node5_3, node5_4).
edge(node5_3, node5_5).
edge(node5_1, node5_6).
edge(node5_1, node5_7).
edge(node5_1, node5_8).
edge(node5_8, node5_9).
edge(node5_9, node5_10).
edge(node5_8, node5_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode nebyl nikdo zranen. 
tree_root(node6_0).
%%%%%%%% node6_0 %%%%%%%%%%%%%%%%%%%
node(node6_0).
id(node6_0, t_plzensky57010_txt_001_p3s3).         const(t_plzensky57010_txt_001_p3s3).
%%%%%%%% node6_1 %%%%%%%%%%%%%%%%%%%
node(node6_1).
functor(node6_1, pred).         const(pred).
gram_sempos(node6_1, v).         const(v).
id(node6_1, t_plzensky57010_txt_001_p3s3a1).         const(t_plzensky57010_txt_001_p3s3a1).
t_lemma(node6_1, zranit).         const(zranit).
%%%%%%%% node6_2 %%%%%%%%%%%%%%%%%%%
node(node6_2).
functor(node6_2, act).         const(act).
id(node6_2, t_plzensky57010_txt_001_p3s3a6).         const(t_plzensky57010_txt_001_p3s3a6).
t_lemma(node6_2, x_gen).         const(x_gen).
%%%%%%%% node6_3 %%%%%%%%%%%%%%%%%%%
node(node6_3).
functor(node6_3, twhen).         const(twhen).
gram_sempos(node6_3, n_denot).         const(n_denot).
id(node6_3, t_plzensky57010_txt_001_p3s3a3).         const(t_plzensky57010_txt_001_p3s3a3).
t_lemma(node6_3, nehoda).         const(nehoda).
%%%%%%%% node6_4 %%%%%%%%%%%%%%%%%%%
node(node6_4).
a_afun(node6_4, auxp).         const(auxp).
m_form(node6_4, pri).         const(pri).
m_lemma(node6_4, pri_1).         const(pri_1).
m_tag(node6_4, rr__6__________).         const(rr__6__________).
m_tag0(node6_4,'r'). const('r'). m_tag1(node6_4,'r'). const('r'). m_tag4(node6_4,'6'). const('6'). 
%%%%%%%% node6_5 %%%%%%%%%%%%%%%%%%%
node(node6_5).
a_afun(node6_5, adv).         const(adv).
m_form(node6_5, nehode).         const(nehode).
m_lemma(node6_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node6_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node6_5,'n'). const('n'). m_tag1(node6_5,'n'). const('n'). m_tag2(node6_5,'f'). const('f'). m_tag3(node6_5,'s'). const('s'). m_tag4(node6_5,'6'). const('6'). m_tag10(node6_5,'a'). const('a'). 
%%%%%%%% node6_6 %%%%%%%%%%%%%%%%%%%
node(node6_6).
functor(node6_6, pat).         const(pat).
gram_sempos(node6_6, n_pron_indef).         const(n_pron_indef).
id(node6_6, t_plzensky57010_txt_001_p3s3a5).         const(t_plzensky57010_txt_001_p3s3a5).
t_lemma(node6_6, kdo).         const(kdo).
%%%%%%%% node6_7 %%%%%%%%%%%%%%%%%%%
node(node6_7).
a_afun(node6_7, sb).         const(sb).
m_form(node6_7, nikdo).         const(nikdo).
m_lemma(node6_7, nikdo).         const(nikdo).
m_tag(node6_7, pwm_1__________).         const(pwm_1__________).
m_tag0(node6_7,'p'). const('p'). m_tag1(node6_7,'w'). const('w'). m_tag2(node6_7,'m'). const('m'). m_tag4(node6_7,'1'). const('1'). 
%%%%%%%% node6_8 %%%%%%%%%%%%%%%%%%%
node(node6_8).
a_afun(node6_8, auxv).         const(auxv).
m_form(node6_8, nebyl).         const(nebyl).
m_lemma(node6_8, byt).         const(byt).
m_tag(node6_8, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node6_8,'v'). const('v'). m_tag1(node6_8,'p'). const('p'). m_tag2(node6_8,'y'). const('y'). m_tag3(node6_8,'s'). const('s'). m_tag7(node6_8,'x'). const('x'). m_tag8(node6_8,'r'). const('r'). m_tag10(node6_8,'n'). const('n'). m_tag11(node6_8,'a'). const('a'). 
%%%%%%%% node6_9 %%%%%%%%%%%%%%%%%%%
node(node6_9).
a_afun(node6_9, pred).         const(pred).
m_form(node6_9, zranen).         const(zranen).
m_lemma(node6_9, zranit__w).         const(zranit__w).
m_tag(node6_9, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node6_9,'v'). const('v'). m_tag1(node6_9,'s'). const('s'). m_tag2(node6_9,'y'). const('y'). m_tag3(node6_9,'s'). const('s'). m_tag7(node6_9,'x'). const('x'). m_tag8(node6_9,'x'). const('x'). m_tag10(node6_9,'a'). const('a'). m_tag11(node6_9,'p'). const('p'). 
edge(node6_0, node6_1).
edge(node6_1, node6_2).
edge(node6_1, node6_3).
edge(node6_3, node6_4).
edge(node6_3, node6_5).
edge(node6_1, node6_6).
edge(node6_6, node6_7).
edge(node6_1, node6_8).
edge(node6_1, node6_9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vazne zranen byl i ridic druheho automobilu. 
tree_root(node7_0).
%%%%%%%% node7_0 %%%%%%%%%%%%%%%%%%%
node(node7_0).
id(node7_0, t_plzensky60375_txt_001_p1s6).         const(t_plzensky60375_txt_001_p1s6).
%%%%%%%% node7_1 %%%%%%%%%%%%%%%%%%%
node(node7_1).
functor(node7_1, pred).         const(pred).
gram_sempos(node7_1, v).         const(v).
id(node7_1, t_plzensky60375_txt_001_p1s6a1).         const(t_plzensky60375_txt_001_p1s6a1).
t_lemma(node7_1, zranit).         const(zranit).
%%%%%%%% node7_2 %%%%%%%%%%%%%%%%%%%
node(node7_2).
functor(node7_2, act).         const(act).
id(node7_2, t_plzensky60375_txt_001_p1s6a8).         const(t_plzensky60375_txt_001_p1s6a8).
t_lemma(node7_2, x_gen).         const(x_gen).
%%%%%%%% node7_3 %%%%%%%%%%%%%%%%%%%
node(node7_3).
functor(node7_3, mann).         const(mann).
gram_sempos(node7_3, adj_denot).         const(adj_denot).
id(node7_3, t_plzensky60375_txt_001_p1s6a2).         const(t_plzensky60375_txt_001_p1s6a2).
t_lemma(node7_3, vazny).         const(vazny).
%%%%%%%% node7_4 %%%%%%%%%%%%%%%%%%%
node(node7_4).
a_afun(node7_4, adv).         const(adv).
m_form(node7_4, vazne).         const(vazne).
m_lemma(node7_4, vazne____1y_).         const(vazne____1y_).
m_tag(node7_4, dg_______1a____).         const(dg_______1a____).
m_tag0(node7_4,'d'). const('d'). m_tag1(node7_4,'g'). const('g'). m_tag9(node7_4,'1'). const('1'). m_tag10(node7_4,'a'). const('a'). 
%%%%%%%% node7_5 %%%%%%%%%%%%%%%%%%%
node(node7_5).
a_afun(node7_5, pred).         const(pred).
m_form(node7_5, zranen).         const(zranen).
m_lemma(node7_5, zranit__w).         const(zranit__w).
m_tag(node7_5, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node7_5,'v'). const('v'). m_tag1(node7_5,'s'). const('s'). m_tag2(node7_5,'y'). const('y'). m_tag3(node7_5,'s'). const('s'). m_tag7(node7_5,'x'). const('x'). m_tag8(node7_5,'x'). const('x'). m_tag10(node7_5,'a'). const('a'). m_tag11(node7_5,'p'). const('p'). 
%%%%%%%% node7_6 %%%%%%%%%%%%%%%%%%%
node(node7_6).
a_afun(node7_6, auxv).         const(auxv).
m_form(node7_6, byl).         const(byl).
m_lemma(node7_6, byt).         const(byt).
m_tag(node7_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node7_6,'v'). const('v'). m_tag1(node7_6,'p'). const('p'). m_tag2(node7_6,'y'). const('y'). m_tag3(node7_6,'s'). const('s'). m_tag7(node7_6,'x'). const('x'). m_tag8(node7_6,'r'). const('r'). m_tag10(node7_6,'a'). const('a'). m_tag11(node7_6,'a'). const('a'). 
%%%%%%%% node7_7 %%%%%%%%%%%%%%%%%%%
node(node7_7).
functor(node7_7, pat).         const(pat).
gram_sempos(node7_7, n_denot).         const(n_denot).
id(node7_7, t_plzensky60375_txt_001_p1s6a4).         const(t_plzensky60375_txt_001_p1s6a4).
t_lemma(node7_7, ridic).         const(ridic).
%%%%%%%% node7_8 %%%%%%%%%%%%%%%%%%%
node(node7_8).
functor(node7_8, conj).         const(conj).
id(node7_8, t_plzensky60375_txt_001_p1s6a5).         const(t_plzensky60375_txt_001_p1s6a5).
t_lemma(node7_8, i).         const(i).
%%%%%%%% node7_9 %%%%%%%%%%%%%%%%%%%
node(node7_9).
a_afun(node7_9, coord).         const(coord).
m_form(node7_9, i).         const(i).
m_lemma(node7_9, i_1).         const(i_1).
m_tag(node7_9, j______________).         const(j______________).
m_tag0(node7_9,'j'). const('j'). m_tag1(node7_9,'^'). const('^'). 
%%%%%%%% node7_10 %%%%%%%%%%%%%%%%%%%
node(node7_10).
a_afun(node7_10, sb).         const(sb).
m_form(node7_10, ridic).         const(ridic).
m_lemma(node7_10, ridic).         const(ridic).
m_tag(node7_10, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node7_10,'n'). const('n'). m_tag1(node7_10,'n'). const('n'). m_tag2(node7_10,'m'). const('m'). m_tag3(node7_10,'s'). const('s'). m_tag4(node7_10,'1'). const('1'). m_tag10(node7_10,'a'). const('a'). 
%%%%%%%% node7_11 %%%%%%%%%%%%%%%%%%%
node(node7_11).
functor(node7_11, app).         const(app).
gram_sempos(node7_11, n_denot).         const(n_denot).
id(node7_11, t_plzensky60375_txt_001_p1s6a6).         const(t_plzensky60375_txt_001_p1s6a6).
t_lemma(node7_11, automobil).         const(automobil).
%%%%%%%% node7_12 %%%%%%%%%%%%%%%%%%%
node(node7_12).
functor(node7_12, rstr).         const(rstr).
gram_sempos(node7_12, adj_quant_def).         const(adj_quant_def).
id(node7_12, t_plzensky60375_txt_001_p1s6a7).         const(t_plzensky60375_txt_001_p1s6a7).
t_lemma(node7_12, dva).         const(dva).
%%%%%%%% node7_13 %%%%%%%%%%%%%%%%%%%
node(node7_13).
a_afun(node7_13, atr).         const(atr).
m_form(node7_13, druheho).         const(druheho).
m_lemma(node7_13, druhy_1___jiny_).         const(druhy_1___jiny_).
m_tag(node7_13, aais2____1a____).         const(aais2____1a____).
m_tag0(node7_13,'a'). const('a'). m_tag1(node7_13,'a'). const('a'). m_tag2(node7_13,'i'). const('i'). m_tag3(node7_13,'s'). const('s'). m_tag4(node7_13,'2'). const('2'). m_tag9(node7_13,'1'). const('1'). m_tag10(node7_13,'a'). const('a'). 
%%%%%%%% node7_14 %%%%%%%%%%%%%%%%%%%
node(node7_14).
a_afun(node7_14, atr).         const(atr).
m_form(node7_14, automobilu).         const(automobilu).
m_lemma(node7_14, automobil).         const(automobil).
m_tag(node7_14, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node7_14,'n'). const('n'). m_tag1(node7_14,'n'). const('n'). m_tag2(node7_14,'i'). const('i'). m_tag3(node7_14,'s'). const('s'). m_tag4(node7_14,'2'). const('2'). m_tag10(node7_14,'a'). const('a'). 
edge(node7_0, node7_1).
edge(node7_1, node7_2).
edge(node7_1, node7_3).
edge(node7_3, node7_4).
edge(node7_1, node7_5).
edge(node7_1, node7_6).
edge(node7_1, node7_7).
edge(node7_7, node7_8).
edge(node7_8, node7_9).
edge(node7_7, node7_10).
edge(node7_7, node7_11).
edge(node7_11, node7_12).
edge(node7_12, node7_13).
edge(node7_11, node7_14).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nehodu neprezil spolujezdec z bmw. 
tree_root(node8_0).
%%%%%%%% node8_0 %%%%%%%%%%%%%%%%%%%
node(node8_0).
id(node8_0, t_plzensky60375_txt_001_p1s8).         const(t_plzensky60375_txt_001_p1s8).
%%%%%%%% node8_1 %%%%%%%%%%%%%%%%%%%
node(node8_1).
functor(node8_1, pred).         const(pred).
gram_sempos(node8_1, v).         const(v).
id(node8_1, t_plzensky60375_txt_001_p1s8a1).         const(t_plzensky60375_txt_001_p1s8a1).
t_lemma(node8_1, prezit).         const(prezit).
%%%%%%%% node8_2 %%%%%%%%%%%%%%%%%%%
node(node8_2).
functor(node8_2, rhem).         const(rhem).
id(node8_2, t_plzensky60375_txt_001_p1s8a6).         const(t_plzensky60375_txt_001_p1s8a6).
t_lemma(node8_2, x_neg).         const(x_neg).
%%%%%%%% node8_3 %%%%%%%%%%%%%%%%%%%
node(node8_3).
functor(node8_3, pat).         const(pat).
gram_sempos(node8_3, n_denot).         const(n_denot).
id(node8_3, t_plzensky60375_txt_001_p1s8a2).         const(t_plzensky60375_txt_001_p1s8a2).
t_lemma(node8_3, nehoda).         const(nehoda).
%%%%%%%% node8_4 %%%%%%%%%%%%%%%%%%%
node(node8_4).
a_afun(node8_4, obj).         const(obj).
m_form(node8_4, nehodu).         const(nehodu).
m_lemma(node8_4, nehoda__s).         const(nehoda__s).
m_tag(node8_4, nnms4_____a____).         const(nnms4_____a____).
m_tag0(node8_4,'n'). const('n'). m_tag1(node8_4,'n'). const('n'). m_tag2(node8_4,'m'). const('m'). m_tag3(node8_4,'s'). const('s'). m_tag4(node8_4,'4'). const('4'). m_tag10(node8_4,'a'). const('a'). 
%%%%%%%% node8_5 %%%%%%%%%%%%%%%%%%%
node(node8_5).
a_afun(node8_5, pred).         const(pred).
m_form(node8_5, neprezil).         const(neprezil).
m_lemma(node8_5, prezit).         const(prezit).
m_tag(node8_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node8_5,'v'). const('v'). m_tag1(node8_5,'p'). const('p'). m_tag2(node8_5,'y'). const('y'). m_tag3(node8_5,'s'). const('s'). m_tag7(node8_5,'x'). const('x'). m_tag8(node8_5,'r'). const('r'). m_tag10(node8_5,'n'). const('n'). m_tag11(node8_5,'a'). const('a'). 
%%%%%%%% node8_6 %%%%%%%%%%%%%%%%%%%
node(node8_6).
functor(node8_6, act).         const(act).
gram_sempos(node8_6, n_denot).         const(n_denot).
id(node8_6, t_plzensky60375_txt_001_p1s8a3).         const(t_plzensky60375_txt_001_p1s8a3).
t_lemma(node8_6, spolujezdec).         const(spolujezdec).
%%%%%%%% node8_7 %%%%%%%%%%%%%%%%%%%
node(node8_7).
a_afun(node8_7, sb).         const(sb).
m_form(node8_7, spolujezdec).         const(spolujezdec).
m_lemma(node8_7, spolujezdec).         const(spolujezdec).
m_tag(node8_7, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node8_7,'n'). const('n'). m_tag1(node8_7,'n'). const('n'). m_tag2(node8_7,'m'). const('m'). m_tag3(node8_7,'s'). const('s'). m_tag4(node8_7,'1'). const('1'). m_tag10(node8_7,'a'). const('a'). 
%%%%%%%% node8_8 %%%%%%%%%%%%%%%%%%%
node(node8_8).
functor(node8_8, dir1).         const(dir1).
gram_sempos(node8_8, n_denot).         const(n_denot).
id(node8_8, t_plzensky60375_txt_001_p1s8a5).         const(t_plzensky60375_txt_001_p1s8a5).
t_lemma(node8_8, bmw).         const(bmw).
%%%%%%%% node8_9 %%%%%%%%%%%%%%%%%%%
node(node8_9).
a_afun(node8_9, auxp).         const(auxp).
m_form(node8_9, z).         const(z).
m_lemma(node8_9, z_1).         const(z_1).
m_tag(node8_9, rr__2__________).         const(rr__2__________).
m_tag0(node8_9,'r'). const('r'). m_tag1(node8_9,'r'). const('r'). m_tag4(node8_9,'2'). const('2'). 
%%%%%%%% node8_10 %%%%%%%%%%%%%%%%%%%
node(node8_10).
a_afun(node8_10, atr).         const(atr).
m_form(node8_10, bmw).         const(bmw).
m_lemma(node8_10, bmw_1__b__k).         const(bmw_1__b__k).
m_tag(node8_10, nnnxx_____a____).         const(nnnxx_____a____).
m_tag0(node8_10,'n'). const('n'). m_tag1(node8_10,'n'). const('n'). m_tag2(node8_10,'n'). const('n'). m_tag3(node8_10,'x'). const('x'). m_tag4(node8_10,'x'). const('x'). m_tag10(node8_10,'a'). const('a'). 
edge(node8_0, node8_1).
edge(node8_1, node8_2).
edge(node8_1, node8_3).
edge(node8_3, node8_4).
edge(node8_1, node8_5).
edge(node8_1, node8_6).
edge(node8_6, node8_7).
edge(node8_6, node8_8).
edge(node8_8, node8_9).
edge(node8_8, node8_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl usmrcen sedmactyricetilety ridic osobniho vozidla. 
tree_root(node9_0).
%%%%%%%% node9_0 %%%%%%%%%%%%%%%%%%%
node(node9_0).
id(node9_0, t_plzensky72977_txt_001_p1s2).         const(t_plzensky72977_txt_001_p1s2).
%%%%%%%% node9_1 %%%%%%%%%%%%%%%%%%%
node(node9_1).
functor(node9_1, pred).         const(pred).
gram_sempos(node9_1, v).         const(v).
id(node9_1, t_plzensky72977_txt_001_p1s2a1).         const(t_plzensky72977_txt_001_p1s2a1).
t_lemma(node9_1, usmrtit).         const(usmrtit).
%%%%%%%% node9_2 %%%%%%%%%%%%%%%%%%%
node(node9_2).
functor(node9_2, act).         const(act).
id(node9_2, t_plzensky72977_txt_001_p1s2a9).         const(t_plzensky72977_txt_001_p1s2a9).
t_lemma(node9_2, x_gen).         const(x_gen).
%%%%%%%% node9_3 %%%%%%%%%%%%%%%%%%%
node(node9_3).
functor(node9_3, twhen).         const(twhen).
gram_sempos(node9_3, n_denot).         const(n_denot).
id(node9_3, t_plzensky72977_txt_001_p1s2a3).         const(t_plzensky72977_txt_001_p1s2a3).
t_lemma(node9_3, nehoda).         const(nehoda).
%%%%%%%% node9_4 %%%%%%%%%%%%%%%%%%%
node(node9_4).
a_afun(node9_4, auxp).         const(auxp).
m_form(node9_4, pri).         const(pri).
m_lemma(node9_4, pri_1).         const(pri_1).
m_tag(node9_4, rr__6__________).         const(rr__6__________).
m_tag0(node9_4,'r'). const('r'). m_tag1(node9_4,'r'). const('r'). m_tag4(node9_4,'6'). const('6'). 
%%%%%%%% node9_5 %%%%%%%%%%%%%%%%%%%
node(node9_5).
a_afun(node9_5, adv).         const(adv).
m_form(node9_5, nehode).         const(nehode).
m_lemma(node9_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node9_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node9_5,'n'). const('n'). m_tag1(node9_5,'n'). const('n'). m_tag2(node9_5,'f'). const('f'). m_tag3(node9_5,'s'). const('s'). m_tag4(node9_5,'6'). const('6'). m_tag10(node9_5,'a'). const('a'). 
%%%%%%%% node9_6 %%%%%%%%%%%%%%%%%%%
node(node9_6).
a_afun(node9_6, auxv).         const(auxv).
m_form(node9_6, byl).         const(byl).
m_lemma(node9_6, byt).         const(byt).
m_tag(node9_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node9_6,'v'). const('v'). m_tag1(node9_6,'p'). const('p'). m_tag2(node9_6,'y'). const('y'). m_tag3(node9_6,'s'). const('s'). m_tag7(node9_6,'x'). const('x'). m_tag8(node9_6,'r'). const('r'). m_tag10(node9_6,'a'). const('a'). m_tag11(node9_6,'a'). const('a'). 
%%%%%%%% node9_7 %%%%%%%%%%%%%%%%%%%
node(node9_7).
a_afun(node9_7, pred).         const(pred).
m_form(node9_7, usmrcen).         const(usmrcen).
m_lemma(node9_7, usmrtit__w).         const(usmrtit__w).
m_tag(node9_7, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node9_7,'v'). const('v'). m_tag1(node9_7,'s'). const('s'). m_tag2(node9_7,'y'). const('y'). m_tag3(node9_7,'s'). const('s'). m_tag7(node9_7,'x'). const('x'). m_tag8(node9_7,'x'). const('x'). m_tag10(node9_7,'a'). const('a'). m_tag11(node9_7,'p'). const('p'). 
%%%%%%%% node9_8 %%%%%%%%%%%%%%%%%%%
node(node9_8).
functor(node9_8, pat).         const(pat).
gram_sempos(node9_8, n_denot).         const(n_denot).
id(node9_8, t_plzensky72977_txt_001_p1s2a5).         const(t_plzensky72977_txt_001_p1s2a5).
t_lemma(node9_8, ridic).         const(ridic).
%%%%%%%% node9_9 %%%%%%%%%%%%%%%%%%%
node(node9_9).
functor(node9_9, rstr).         const(rstr).
gram_sempos(node9_9, adj_denot).         const(adj_denot).
id(node9_9, t_plzensky72977_txt_001_p1s2a6).         const(t_plzensky72977_txt_001_p1s2a6).
t_lemma(node9_9, sedmactyricetilety).         const(sedmactyricetilety).
%%%%%%%% node9_10 %%%%%%%%%%%%%%%%%%%
node(node9_10).
a_afun(node9_10, atr).         const(atr).
m_form(node9_10, sedmactyricetilety).         const(sedmactyricetilety).
m_lemma(node9_10, sedmactyricetilety).         const(sedmactyricetilety).
m_tag(node9_10, aams1____1a____).         const(aams1____1a____).
m_tag0(node9_10,'a'). const('a'). m_tag1(node9_10,'a'). const('a'). m_tag2(node9_10,'m'). const('m'). m_tag3(node9_10,'s'). const('s'). m_tag4(node9_10,'1'). const('1'). m_tag9(node9_10,'1'). const('1'). m_tag10(node9_10,'a'). const('a'). 
%%%%%%%% node9_11 %%%%%%%%%%%%%%%%%%%
node(node9_11).
a_afun(node9_11, sb).         const(sb).
m_form(node9_11, ridic).         const(ridic).
m_lemma(node9_11, ridic).         const(ridic).
m_tag(node9_11, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node9_11,'n'). const('n'). m_tag1(node9_11,'n'). const('n'). m_tag2(node9_11,'m'). const('m'). m_tag3(node9_11,'s'). const('s'). m_tag4(node9_11,'1'). const('1'). m_tag10(node9_11,'a'). const('a'). 
%%%%%%%% node9_12 %%%%%%%%%%%%%%%%%%%
node(node9_12).
functor(node9_12, app).         const(app).
gram_sempos(node9_12, n_denot).         const(n_denot).
id(node9_12, t_plzensky72977_txt_001_p1s2a7).         const(t_plzensky72977_txt_001_p1s2a7).
t_lemma(node9_12, vozidlo).         const(vozidlo).
%%%%%%%% node9_13 %%%%%%%%%%%%%%%%%%%
node(node9_13).
functor(node9_13, rstr).         const(rstr).
gram_sempos(node9_13, adj_denot).         const(adj_denot).
id(node9_13, t_plzensky72977_txt_001_p1s2a8).         const(t_plzensky72977_txt_001_p1s2a8).
t_lemma(node9_13, osobni).         const(osobni).
%%%%%%%% node9_14 %%%%%%%%%%%%%%%%%%%
node(node9_14).
a_afun(node9_14, atr).         const(atr).
m_form(node9_14, osobniho).         const(osobniho).
m_lemma(node9_14, osobni).         const(osobni).
m_tag(node9_14, aans2____1a____).         const(aans2____1a____).
m_tag0(node9_14,'a'). const('a'). m_tag1(node9_14,'a'). const('a'). m_tag2(node9_14,'n'). const('n'). m_tag3(node9_14,'s'). const('s'). m_tag4(node9_14,'2'). const('2'). m_tag9(node9_14,'1'). const('1'). m_tag10(node9_14,'a'). const('a'). 
%%%%%%%% node9_15 %%%%%%%%%%%%%%%%%%%
node(node9_15).
a_afun(node9_15, atr).         const(atr).
m_form(node9_15, vozidla).         const(vozidla).
m_lemma(node9_15, vozidlo).         const(vozidlo).
m_tag(node9_15, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node9_15,'n'). const('n'). m_tag1(node9_15,'n'). const('n'). m_tag2(node9_15,'n'). const('n'). m_tag3(node9_15,'s'). const('s'). m_tag4(node9_15,'2'). const('2'). m_tag10(node9_15,'a'). const('a'). 
edge(node9_0, node9_1).
edge(node9_1, node9_2).
edge(node9_1, node9_3).
edge(node9_3, node9_4).
edge(node9_3, node9_5).
edge(node9_1, node9_6).
edge(node9_1, node9_7).
edge(node9_1, node9_8).
edge(node9_8, node9_9).
edge(node9_9, node9_10).
edge(node9_8, node9_11).
edge(node9_8, node9_12).
edge(node9_12, node9_13).
edge(node9_13, node9_14).
edge(node9_12, node9_15).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridic vozidla nebyl zranen. 
tree_root(node10_0).
%%%%%%%% node10_0 %%%%%%%%%%%%%%%%%%%
node(node10_0).
id(node10_0, t_plzensky57806_txt_001_p2s3).         const(t_plzensky57806_txt_001_p2s3).
%%%%%%%% node10_1 %%%%%%%%%%%%%%%%%%%
node(node10_1).
functor(node10_1, pred).         const(pred).
gram_sempos(node10_1, v).         const(v).
id(node10_1, t_plzensky57806_txt_001_p2s3a1).         const(t_plzensky57806_txt_001_p2s3a1).
t_lemma(node10_1, zranit).         const(zranit).
%%%%%%%% node10_2 %%%%%%%%%%%%%%%%%%%
node(node10_2).
functor(node10_2, act).         const(act).
id(node10_2, t_plzensky57806_txt_001_p2s3a4).         const(t_plzensky57806_txt_001_p2s3a4).
t_lemma(node10_2, x_gen).         const(x_gen).
%%%%%%%% node10_3 %%%%%%%%%%%%%%%%%%%
node(node10_3).
functor(node10_3, pat).         const(pat).
gram_sempos(node10_3, n_denot).         const(n_denot).
id(node10_3, t_plzensky57806_txt_001_p2s3a2).         const(t_plzensky57806_txt_001_p2s3a2).
t_lemma(node10_3, ridic).         const(ridic).
%%%%%%%% node10_4 %%%%%%%%%%%%%%%%%%%
node(node10_4).
a_afun(node10_4, sb).         const(sb).
m_form(node10_4, ridic).         const(ridic).
m_lemma(node10_4, ridic).         const(ridic).
m_tag(node10_4, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node10_4,'n'). const('n'). m_tag1(node10_4,'n'). const('n'). m_tag2(node10_4,'m'). const('m'). m_tag3(node10_4,'s'). const('s'). m_tag4(node10_4,'1'). const('1'). m_tag10(node10_4,'a'). const('a'). 
%%%%%%%% node10_5 %%%%%%%%%%%%%%%%%%%
node(node10_5).
functor(node10_5, app).         const(app).
gram_sempos(node10_5, n_denot).         const(n_denot).
id(node10_5, t_plzensky57806_txt_001_p2s3a3).         const(t_plzensky57806_txt_001_p2s3a3).
t_lemma(node10_5, vozidlo).         const(vozidlo).
%%%%%%%% node10_6 %%%%%%%%%%%%%%%%%%%
node(node10_6).
a_afun(node10_6, atr).         const(atr).
m_form(node10_6, vozidla).         const(vozidla).
m_lemma(node10_6, vozidlo).         const(vozidlo).
m_tag(node10_6, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node10_6,'n'). const('n'). m_tag1(node10_6,'n'). const('n'). m_tag2(node10_6,'n'). const('n'). m_tag3(node10_6,'s'). const('s'). m_tag4(node10_6,'2'). const('2'). m_tag10(node10_6,'a'). const('a'). 
%%%%%%%% node10_7 %%%%%%%%%%%%%%%%%%%
node(node10_7).
a_afun(node10_7, auxv).         const(auxv).
m_form(node10_7, nebyl).         const(nebyl).
m_lemma(node10_7, byt).         const(byt).
m_tag(node10_7, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node10_7,'v'). const('v'). m_tag1(node10_7,'p'). const('p'). m_tag2(node10_7,'y'). const('y'). m_tag3(node10_7,'s'). const('s'). m_tag7(node10_7,'x'). const('x'). m_tag8(node10_7,'r'). const('r'). m_tag10(node10_7,'n'). const('n'). m_tag11(node10_7,'a'). const('a'). 
%%%%%%%% node10_8 %%%%%%%%%%%%%%%%%%%
node(node10_8).
a_afun(node10_8, pred).         const(pred).
m_form(node10_8, zranen).         const(zranen).
m_lemma(node10_8, zranit__w).         const(zranit__w).
m_tag(node10_8, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node10_8,'v'). const('v'). m_tag1(node10_8,'s'). const('s'). m_tag2(node10_8,'y'). const('y'). m_tag3(node10_8,'s'). const('s'). m_tag7(node10_8,'x'). const('x'). m_tag8(node10_8,'x'). const('x'). m_tag10(node10_8,'a'). const('a'). m_tag11(node10_8,'p'). const('p'). 
edge(node10_0, node10_1).
edge(node10_1, node10_2).
edge(node10_1, node10_3).
edge(node10_3, node10_4).
edge(node10_3, node10_5).
edge(node10_5, node10_6).
edge(node10_1, node10_7).
edge(node10_1, node10_8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridicka nebyla zranena. 
tree_root(node11_0).
%%%%%%%% node11_0 %%%%%%%%%%%%%%%%%%%
node(node11_0).
id(node11_0, t_plzensky57806_txt_001_p2s40).         const(t_plzensky57806_txt_001_p2s40).
%%%%%%%% node11_1 %%%%%%%%%%%%%%%%%%%
node(node11_1).
functor(node11_1, pred).         const(pred).
gram_sempos(node11_1, v).         const(v).
id(node11_1, t_plzensky57806_txt_001_p2s40a1).         const(t_plzensky57806_txt_001_p2s40a1).
t_lemma(node11_1, zranit).         const(zranit).
%%%%%%%% node11_2 %%%%%%%%%%%%%%%%%%%
node(node11_2).
functor(node11_2, act).         const(act).
id(node11_2, t_plzensky57806_txt_001_p2s40a3).         const(t_plzensky57806_txt_001_p2s40a3).
t_lemma(node11_2, x_gen).         const(x_gen).
%%%%%%%% node11_3 %%%%%%%%%%%%%%%%%%%
node(node11_3).
functor(node11_3, pat).         const(pat).
gram_sempos(node11_3, n_denot).         const(n_denot).
id(node11_3, t_plzensky57806_txt_001_p2s40a2).         const(t_plzensky57806_txt_001_p2s40a2).
t_lemma(node11_3, ridicka).         const(ridicka).
%%%%%%%% node11_4 %%%%%%%%%%%%%%%%%%%
node(node11_4).
a_afun(node11_4, sb).         const(sb).
m_form(node11_4, ridicka).         const(ridicka).
m_lemma(node11_4, ridicka____2_).         const(ridicka____2_).
m_tag(node11_4, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node11_4,'n'). const('n'). m_tag1(node11_4,'n'). const('n'). m_tag2(node11_4,'f'). const('f'). m_tag3(node11_4,'s'). const('s'). m_tag4(node11_4,'1'). const('1'). m_tag10(node11_4,'a'). const('a'). 
%%%%%%%% node11_5 %%%%%%%%%%%%%%%%%%%
node(node11_5).
a_afun(node11_5, auxv).         const(auxv).
m_form(node11_5, nebyla).         const(nebyla).
m_lemma(node11_5, byt).         const(byt).
m_tag(node11_5, vpqw___xr_na___).         const(vpqw___xr_na___).
m_tag0(node11_5,'v'). const('v'). m_tag1(node11_5,'p'). const('p'). m_tag2(node11_5,'q'). const('q'). m_tag3(node11_5,'w'). const('w'). m_tag7(node11_5,'x'). const('x'). m_tag8(node11_5,'r'). const('r'). m_tag10(node11_5,'n'). const('n'). m_tag11(node11_5,'a'). const('a'). 
%%%%%%%% node11_6 %%%%%%%%%%%%%%%%%%%
node(node11_6).
a_afun(node11_6, pred).         const(pred).
m_form(node11_6, zranena).         const(zranena).
m_lemma(node11_6, zranit__w).         const(zranit__w).
m_tag(node11_6, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node11_6,'v'). const('v'). m_tag1(node11_6,'s'). const('s'). m_tag2(node11_6,'q'). const('q'). m_tag3(node11_6,'w'). const('w'). m_tag7(node11_6,'x'). const('x'). m_tag8(node11_6,'x'). const('x'). m_tag10(node11_6,'a'). const('a'). m_tag11(node11_6,'p'). const('p'). 
edge(node11_0, node11_1).
edge(node11_1, node11_2).
edge(node11_1, node11_3).
edge(node11_3, node11_4).
edge(node11_1, node11_5).
edge(node11_1, node11_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v dobe prijezdu hasicu byla jedna zranena osoba v peci rzr, druha nebyla zranena. 
tree_root(node12_0).
%%%%%%%% node12_0 %%%%%%%%%%%%%%%%%%%
node(node12_0).
id(node12_0, t_plzensky51802_txt_001_p6s2).         const(t_plzensky51802_txt_001_p6s2).
%%%%%%%% node12_1 %%%%%%%%%%%%%%%%%%%
node(node12_1).
functor(node12_1, pred).         const(pred).
gram_sempos(node12_1, v).         const(v).
id(node12_1, t_plzensky51802_txt_001_p6s2a14).         const(t_plzensky51802_txt_001_p6s2a14).
t_lemma(node12_1, zranit).         const(zranit).
%%%%%%%% node12_2 %%%%%%%%%%%%%%%%%%%
node(node12_2).
functor(node12_2, act).         const(act).
id(node12_2, t_plzensky51802_txt_001_p6s2a15).         const(t_plzensky51802_txt_001_p6s2a15).
t_lemma(node12_2, x_gen).         const(x_gen).
%%%%%%%% node12_3 %%%%%%%%%%%%%%%%%%%
node(node12_3).
functor(node12_3, twhen).         const(twhen).
gram_sempos(node12_3, n_denot).         const(n_denot).
id(node12_3, t_plzensky51802_txt_001_p6s2a4).         const(t_plzensky51802_txt_001_p6s2a4).
t_lemma(node12_3, prijezd).         const(prijezd).
%%%%%%%% node12_4 %%%%%%%%%%%%%%%%%%%
node(node12_4).
a_afun(node12_4, auxp).         const(auxp).
m_form(node12_4, v).         const(v).
m_lemma(node12_4, v_1).         const(v_1).
m_tag(node12_4, rr__6__________).         const(rr__6__________).
m_tag0(node12_4,'r'). const('r'). m_tag1(node12_4,'r'). const('r'). m_tag4(node12_4,'6'). const('6'). 
%%%%%%%% node12_5 %%%%%%%%%%%%%%%%%%%
node(node12_5).
a_afun(node12_5, adv).         const(adv).
m_form(node12_5, dobe).         const(dobe).
m_lemma(node12_5, doba).         const(doba).
m_tag(node12_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node12_5,'n'). const('n'). m_tag1(node12_5,'n'). const('n'). m_tag2(node12_5,'f'). const('f'). m_tag3(node12_5,'s'). const('s'). m_tag4(node12_5,'6'). const('6'). m_tag10(node12_5,'a'). const('a'). 
%%%%%%%% node12_6 %%%%%%%%%%%%%%%%%%%
node(node12_6).
a_afun(node12_6, atr).         const(atr).
m_form(node12_6, prijezdu).         const(prijezdu).
m_lemma(node12_6, prijezd).         const(prijezd).
m_tag(node12_6, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node12_6,'n'). const('n'). m_tag1(node12_6,'n'). const('n'). m_tag2(node12_6,'i'). const('i'). m_tag3(node12_6,'s'). const('s'). m_tag4(node12_6,'2'). const('2'). m_tag10(node12_6,'a'). const('a'). 
%%%%%%%% node12_7 %%%%%%%%%%%%%%%%%%%
node(node12_7).
functor(node12_7, act).         const(act).
gram_sempos(node12_7, n_denot).         const(n_denot).
id(node12_7, t_plzensky51802_txt_001_p6s2a5).         const(t_plzensky51802_txt_001_p6s2a5).
t_lemma(node12_7, hasic).         const(hasic).
%%%%%%%% node12_8 %%%%%%%%%%%%%%%%%%%
node(node12_8).
a_afun(node12_8, atr).         const(atr).
m_form(node12_8, hasicu).         const(hasicu).
m_lemma(node12_8, hasic).         const(hasic).
m_tag(node12_8, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node12_8,'n'). const('n'). m_tag1(node12_8,'n'). const('n'). m_tag2(node12_8,'m'). const('m'). m_tag3(node12_8,'p'). const('p'). m_tag4(node12_8,'2'). const('2'). m_tag10(node12_8,'a'). const('a'). 
%%%%%%%% node12_9 %%%%%%%%%%%%%%%%%%%
node(node12_9).
functor(node12_9, pat).         const(pat).
gram_sempos(node12_9, n_denot).         const(n_denot).
id(node12_9, t_plzensky51802_txt_001_p6s2a6).         const(t_plzensky51802_txt_001_p6s2a6).
t_lemma(node12_9, osoba).         const(osoba).
%%%%%%%% node12_10 %%%%%%%%%%%%%%%%%%%
node(node12_10).
functor(node12_10, rstr).         const(rstr).
gram_sempos(node12_10, adj_quant_def).         const(adj_quant_def).
id(node12_10, t_plzensky51802_txt_001_p6s2a7).         const(t_plzensky51802_txt_001_p6s2a7).
t_lemma(node12_10, jeden).         const(jeden).
%%%%%%%% node12_11 %%%%%%%%%%%%%%%%%%%
node(node12_11).
a_afun(node12_11, atr).         const(atr).
m_form(node12_11, jedna).         const(jedna).
m_lemma(node12_11, jeden_1).         const(jeden_1).
m_tag(node12_11, clfs1__________).         const(clfs1__________).
m_tag0(node12_11,'c'). const('c'). m_tag1(node12_11,'l'). const('l'). m_tag2(node12_11,'f'). const('f'). m_tag3(node12_11,'s'). const('s'). m_tag4(node12_11,'1'). const('1'). 
%%%%%%%% node12_12 %%%%%%%%%%%%%%%%%%%
node(node12_12).
functor(node12_12, rstr).         const(rstr).
gram_sempos(node12_12, adj_denot).         const(adj_denot).
id(node12_12, t_plzensky51802_txt_001_p6s2a8).         const(t_plzensky51802_txt_001_p6s2a8).
t_lemma(node12_12, zraneny).         const(zraneny).
%%%%%%%% node12_13 %%%%%%%%%%%%%%%%%%%
node(node12_13).
a_afun(node12_13, atr).         const(atr).
m_form(node12_13, zranena).         const(zranena).
m_lemma(node12_13, zraneny____3it_).         const(zraneny____3it_).
m_tag(node12_13, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node12_13,'a'). const('a'). m_tag1(node12_13,'a'). const('a'). m_tag2(node12_13,'f'). const('f'). m_tag3(node12_13,'s'). const('s'). m_tag4(node12_13,'1'). const('1'). m_tag9(node12_13,'1'). const('1'). m_tag10(node12_13,'a'). const('a'). 
%%%%%%%% node12_14 %%%%%%%%%%%%%%%%%%%
node(node12_14).
a_afun(node12_14, sb).         const(sb).
m_form(node12_14, osoba).         const(osoba).
m_lemma(node12_14, osoba).         const(osoba).
m_tag(node12_14, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node12_14,'n'). const('n'). m_tag1(node12_14,'n'). const('n'). m_tag2(node12_14,'f'). const('f'). m_tag3(node12_14,'s'). const('s'). m_tag4(node12_14,'1'). const('1'). m_tag10(node12_14,'a'). const('a'). 
%%%%%%%% node12_15 %%%%%%%%%%%%%%%%%%%
node(node12_15).
functor(node12_15, rstr).         const(rstr).
id(node12_15, t_plzensky51802_txt_001_p6s2a9).         const(t_plzensky51802_txt_001_p6s2a9).
t_lemma(node12_15, x_comma).         const(x_comma).
%%%%%%%% node12_16 %%%%%%%%%%%%%%%%%%%
node(node12_16).
functor(node12_16, loc).         const(loc).
gram_sempos(node12_16, n_denot).         const(n_denot).
id(node12_16, t_plzensky51802_txt_001_p6s2a11).         const(t_plzensky51802_txt_001_p6s2a11).
t_lemma(node12_16, pece).         const(pece).
%%%%%%%% node12_17 %%%%%%%%%%%%%%%%%%%
node(node12_17).
a_afun(node12_17, auxp).         const(auxp).
m_form(node12_17, v).         const(v).
m_lemma(node12_17, v_1).         const(v_1).
m_tag(node12_17, rr__6__________).         const(rr__6__________).
m_tag0(node12_17,'r'). const('r'). m_tag1(node12_17,'r'). const('r'). m_tag4(node12_17,'6'). const('6'). 
%%%%%%%% node12_18 %%%%%%%%%%%%%%%%%%%
node(node12_18).
a_afun(node12_18, adv).         const(adv).
m_form(node12_18, peci).         const(peci).
m_lemma(node12_18, pece).         const(pece).
m_tag(node12_18, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node12_18,'n'). const('n'). m_tag1(node12_18,'n'). const('n'). m_tag2(node12_18,'f'). const('f'). m_tag3(node12_18,'s'). const('s'). m_tag4(node12_18,'6'). const('6'). m_tag10(node12_18,'a'). const('a'). 
%%%%%%%% node12_19 %%%%%%%%%%%%%%%%%%%
node(node12_19).
functor(node12_19, act).         const(act).
gram_sempos(node12_19, n_denot).         const(n_denot).
id(node12_19, t_plzensky51802_txt_001_p6s2a12).         const(t_plzensky51802_txt_001_p6s2a12).
t_lemma(node12_19, rzr).         const(rzr).
%%%%%%%% node12_20 %%%%%%%%%%%%%%%%%%%
node(node12_20).
a_afun(node12_20, atr).         const(atr).
m_form(node12_20, rzr).         const(rzr).
m_lemma(node12_20, rzr).         const(rzr).
m_tag(node12_20, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node12_20,'n'). const('n'). m_tag1(node12_20,'n'). const('n'). m_tag2(node12_20,'f'). const('f'). m_tag3(node12_20,'x'). const('x'). m_tag4(node12_20,'x'). const('x'). m_tag10(node12_20,'a'). const('a'). 
%%%%%%%% node12_21 %%%%%%%%%%%%%%%%%%%
node(node12_21).
a_afun(node12_21, auxx).         const(auxx).
m_form(node12_21, x_).         const(x_).
m_lemma(node12_21, x_).         const(x_).
m_tag(node12_21, z______________).         const(z______________).
m_tag0(node12_21,'z'). const('z'). m_tag1(node12_21,':'). const(':'). 
%%%%%%%% node12_22 %%%%%%%%%%%%%%%%%%%
node(node12_22).
functor(node12_22, rstr).         const(rstr).
gram_sempos(node12_22, adj_quant_def).         const(adj_quant_def).
id(node12_22, t_plzensky51802_txt_001_p6s2a13).         const(t_plzensky51802_txt_001_p6s2a13).
t_lemma(node12_22, dva).         const(dva).
%%%%%%%% node12_23 %%%%%%%%%%%%%%%%%%%
node(node12_23).
a_afun(node12_23, pnom).         const(pnom).
m_form(node12_23, druha).         const(druha).
m_lemma(node12_23, druhy_1___jiny_).         const(druhy_1___jiny_).
m_tag(node12_23, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node12_23,'a'). const('a'). m_tag1(node12_23,'a'). const('a'). m_tag2(node12_23,'f'). const('f'). m_tag3(node12_23,'s'). const('s'). m_tag4(node12_23,'1'). const('1'). m_tag9(node12_23,'1'). const('1'). m_tag10(node12_23,'a'). const('a'). 
%%%%%%%% node12_24 %%%%%%%%%%%%%%%%%%%
node(node12_24).
a_afun(node12_24, pred).         const(pred).
m_form(node12_24, byla).         const(byla).
m_lemma(node12_24, byt).         const(byt).
m_tag(node12_24, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node12_24,'v'). const('v'). m_tag1(node12_24,'p'). const('p'). m_tag2(node12_24,'q'). const('q'). m_tag3(node12_24,'w'). const('w'). m_tag7(node12_24,'x'). const('x'). m_tag8(node12_24,'r'). const('r'). m_tag10(node12_24,'a'). const('a'). m_tag11(node12_24,'a'). const('a'). 
%%%%%%%% node12_25 %%%%%%%%%%%%%%%%%%%
node(node12_25).
a_afun(node12_25, auxv).         const(auxv).
m_form(node12_25, nebyla).         const(nebyla).
m_lemma(node12_25, byt).         const(byt).
m_tag(node12_25, vpqw___xr_na___).         const(vpqw___xr_na___).
m_tag0(node12_25,'v'). const('v'). m_tag1(node12_25,'p'). const('p'). m_tag2(node12_25,'q'). const('q'). m_tag3(node12_25,'w'). const('w'). m_tag7(node12_25,'x'). const('x'). m_tag8(node12_25,'r'). const('r'). m_tag10(node12_25,'n'). const('n'). m_tag11(node12_25,'a'). const('a'). 
%%%%%%%% node12_26 %%%%%%%%%%%%%%%%%%%
node(node12_26).
a_afun(node12_26, pnom).         const(pnom).
m_form(node12_26, zranena).         const(zranena).
m_lemma(node12_26, zranit__w).         const(zranit__w).
m_tag(node12_26, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node12_26,'v'). const('v'). m_tag1(node12_26,'s'). const('s'). m_tag2(node12_26,'q'). const('q'). m_tag3(node12_26,'w'). const('w'). m_tag7(node12_26,'x'). const('x'). m_tag8(node12_26,'x'). const('x'). m_tag10(node12_26,'a'). const('a'). m_tag11(node12_26,'p'). const('p'). 
edge(node12_0, node12_1).
edge(node12_1, node12_2).
edge(node12_1, node12_3).
edge(node12_3, node12_4).
edge(node12_3, node12_5).
edge(node12_3, node12_6).
edge(node12_3, node12_7).
edge(node12_7, node12_8).
edge(node12_1, node12_9).
edge(node12_9, node12_10).
edge(node12_10, node12_11).
edge(node12_9, node12_12).
edge(node12_12, node12_13).
edge(node12_9, node12_14).
edge(node12_1, node12_15).
edge(node12_15, node12_16).
edge(node12_16, node12_17).
edge(node12_16, node12_18).
edge(node12_16, node12_19).
edge(node12_19, node12_20).
edge(node12_15, node12_21).
edge(node12_15, node12_22).
edge(node12_22, node12_23).
edge(node12_1, node12_24).
edge(node12_1, node12_25).
edge(node12_1, node12_26).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byla zranena spolujezdkyne a hasici ji poskytli predlekarskou pomoc. 
tree_root(node13_0).
%%%%%%%% node13_0 %%%%%%%%%%%%%%%%%%%
node(node13_0).
id(node13_0, t_plzensky69694_txt_001_p3s4).         const(t_plzensky69694_txt_001_p3s4).
%%%%%%%% node13_1 %%%%%%%%%%%%%%%%%%%
node(node13_1).
functor(node13_1, conj).         const(conj).
id(node13_1, t_plzensky69694_txt_001_p3s4a1).         const(t_plzensky69694_txt_001_p3s4a1).
t_lemma(node13_1, a).         const(a).
%%%%%%%% node13_2 %%%%%%%%%%%%%%%%%%%
node(node13_2).
functor(node13_2, pred).         const(pred).
gram_sempos(node13_2, v).         const(v).
id(node13_2, t_plzensky69694_txt_001_p3s4a2).         const(t_plzensky69694_txt_001_p3s4a2).
t_lemma(node13_2, zranit).         const(zranit).
%%%%%%%% node13_3 %%%%%%%%%%%%%%%%%%%
node(node13_3).
functor(node13_3, act).         const(act).
id(node13_3, t_plzensky69694_txt_001_p3s4a12).         const(t_plzensky69694_txt_001_p3s4a12).
t_lemma(node13_3, x_gen).         const(x_gen).
%%%%%%%% node13_4 %%%%%%%%%%%%%%%%%%%
node(node13_4).
functor(node13_4, twhen).         const(twhen).
gram_sempos(node13_4, n_denot).         const(n_denot).
id(node13_4, t_plzensky69694_txt_001_p3s4a4).         const(t_plzensky69694_txt_001_p3s4a4).
t_lemma(node13_4, nehoda).         const(nehoda).
%%%%%%%% node13_5 %%%%%%%%%%%%%%%%%%%
node(node13_5).
a_afun(node13_5, auxp).         const(auxp).
m_form(node13_5, pri).         const(pri).
m_lemma(node13_5, pri_1).         const(pri_1).
m_tag(node13_5, rr__6__________).         const(rr__6__________).
m_tag0(node13_5,'r'). const('r'). m_tag1(node13_5,'r'). const('r'). m_tag4(node13_5,'6'). const('6'). 
%%%%%%%% node13_6 %%%%%%%%%%%%%%%%%%%
node(node13_6).
a_afun(node13_6, adv).         const(adv).
m_form(node13_6, nehode).         const(nehode).
m_lemma(node13_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node13_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node13_6,'n'). const('n'). m_tag1(node13_6,'n'). const('n'). m_tag2(node13_6,'f'). const('f'). m_tag3(node13_6,'s'). const('s'). m_tag4(node13_6,'6'). const('6'). m_tag10(node13_6,'a'). const('a'). 
%%%%%%%% node13_7 %%%%%%%%%%%%%%%%%%%
node(node13_7).
a_afun(node13_7, auxv).         const(auxv).
m_form(node13_7, byla).         const(byla).
m_lemma(node13_7, byt).         const(byt).
m_tag(node13_7, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node13_7,'v'). const('v'). m_tag1(node13_7,'p'). const('p'). m_tag2(node13_7,'q'). const('q'). m_tag3(node13_7,'w'). const('w'). m_tag7(node13_7,'x'). const('x'). m_tag8(node13_7,'r'). const('r'). m_tag10(node13_7,'a'). const('a'). m_tag11(node13_7,'a'). const('a'). 
%%%%%%%% node13_8 %%%%%%%%%%%%%%%%%%%
node(node13_8).
a_afun(node13_8, pred).         const(pred).
m_form(node13_8, zranena).         const(zranena).
m_lemma(node13_8, zranit__w).         const(zranit__w).
m_tag(node13_8, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node13_8,'v'). const('v'). m_tag1(node13_8,'s'). const('s'). m_tag2(node13_8,'q'). const('q'). m_tag3(node13_8,'w'). const('w'). m_tag7(node13_8,'x'). const('x'). m_tag8(node13_8,'x'). const('x'). m_tag10(node13_8,'a'). const('a'). m_tag11(node13_8,'p'). const('p'). 
%%%%%%%% node13_9 %%%%%%%%%%%%%%%%%%%
node(node13_9).
functor(node13_9, pat).         const(pat).
gram_sempos(node13_9, n_denot).         const(n_denot).
id(node13_9, t_plzensky69694_txt_001_p3s4a6).         const(t_plzensky69694_txt_001_p3s4a6).
t_lemma(node13_9, spolujezdkyne).         const(spolujezdkyne).
%%%%%%%% node13_10 %%%%%%%%%%%%%%%%%%%
node(node13_10).
a_afun(node13_10, sb).         const(sb).
m_form(node13_10, spolujezdkyne).         const(spolujezdkyne).
m_lemma(node13_10, spolujezdkyne____4ec_).         const(spolujezdkyne____4ec_).
m_tag(node13_10, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node13_10,'n'). const('n'). m_tag1(node13_10,'n'). const('n'). m_tag2(node13_10,'f'). const('f'). m_tag3(node13_10,'s'). const('s'). m_tag4(node13_10,'1'). const('1'). m_tag10(node13_10,'a'). const('a'). 
%%%%%%%% node13_11 %%%%%%%%%%%%%%%%%%%
node(node13_11).
a_afun(node13_11, coord).         const(coord).
m_form(node13_11, a).         const(a).
m_lemma(node13_11, a_1).         const(a_1).
m_tag(node13_11, j______________).         const(j______________).
m_tag0(node13_11,'j'). const('j'). m_tag1(node13_11,'^'). const('^'). 
%%%%%%%% node13_12 %%%%%%%%%%%%%%%%%%%
node(node13_12).
functor(node13_12, caus).         const(caus).
gram_sempos(node13_12, v).         const(v).
id(node13_12, t_plzensky69694_txt_001_p3s4a7).         const(t_plzensky69694_txt_001_p3s4a7).
t_lemma(node13_12, poskytnout).         const(poskytnout).
%%%%%%%% node13_13 %%%%%%%%%%%%%%%%%%%
node(node13_13).
functor(node13_13, act).         const(act).
gram_sempos(node13_13, n_denot).         const(n_denot).
id(node13_13, t_plzensky69694_txt_001_p3s4a8).         const(t_plzensky69694_txt_001_p3s4a8).
t_lemma(node13_13, hasic).         const(hasic).
%%%%%%%% node13_14 %%%%%%%%%%%%%%%%%%%
node(node13_14).
a_afun(node13_14, sb).         const(sb).
m_form(node13_14, hasici).         const(hasici).
m_lemma(node13_14, hasic).         const(hasic).
m_tag(node13_14, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node13_14,'n'). const('n'). m_tag1(node13_14,'n'). const('n'). m_tag2(node13_14,'m'). const('m'). m_tag3(node13_14,'p'). const('p'). m_tag4(node13_14,'1'). const('1'). m_tag10(node13_14,'a'). const('a'). 
%%%%%%%% node13_15 %%%%%%%%%%%%%%%%%%%
node(node13_15).
functor(node13_15, addr).         const(addr).
gram_sempos(node13_15, n_pron_def_pers).         const(n_pron_def_pers).
id(node13_15, t_plzensky69694_txt_001_p3s4a9).         const(t_plzensky69694_txt_001_p3s4a9).
t_lemma(node13_15, x_perspron).         const(x_perspron).
%%%%%%%% node13_16 %%%%%%%%%%%%%%%%%%%
node(node13_16).
a_afun(node13_16, obj).         const(obj).
m_form(node13_16, ji).         const(ji).
m_lemma(node13_16, on_1___ona_).         const(on_1___ona_).
m_tag(node13_16, ppfs3__3_______).         const(ppfs3__3_______).
m_tag0(node13_16,'p'). const('p'). m_tag1(node13_16,'p'). const('p'). m_tag2(node13_16,'f'). const('f'). m_tag3(node13_16,'s'). const('s'). m_tag4(node13_16,'3'). const('3'). m_tag7(node13_16,'3'). const('3'). 
%%%%%%%% node13_17 %%%%%%%%%%%%%%%%%%%
node(node13_17).
a_afun(node13_17, pred).         const(pred).
m_form(node13_17, poskytli).         const(poskytli).
m_lemma(node13_17, poskytnout__w).         const(poskytnout__w).
m_tag(node13_17, vpmp___xr_aa__1).         const(vpmp___xr_aa__1).
m_tag0(node13_17,'v'). const('v'). m_tag1(node13_17,'p'). const('p'). m_tag2(node13_17,'m'). const('m'). m_tag3(node13_17,'p'). const('p'). m_tag7(node13_17,'x'). const('x'). m_tag8(node13_17,'r'). const('r'). m_tag10(node13_17,'a'). const('a'). m_tag11(node13_17,'a'). const('a'). m_tag14(node13_17,'1'). const('1'). 
%%%%%%%% node13_18 %%%%%%%%%%%%%%%%%%%
node(node13_18).
functor(node13_18, cphr).         const(cphr).
gram_sempos(node13_18, n_denot).         const(n_denot).
id(node13_18, t_plzensky69694_txt_001_p3s4a10).         const(t_plzensky69694_txt_001_p3s4a10).
t_lemma(node13_18, pomoc).         const(pomoc).
%%%%%%%% node13_19 %%%%%%%%%%%%%%%%%%%
node(node13_19).
functor(node13_19, rstr).         const(rstr).
gram_sempos(node13_19, adj_denot).         const(adj_denot).
id(node13_19, t_plzensky69694_txt_001_p3s4a11).         const(t_plzensky69694_txt_001_p3s4a11).
t_lemma(node13_19, predlekarsky).         const(predlekarsky).
%%%%%%%% node13_20 %%%%%%%%%%%%%%%%%%%
node(node13_20).
a_afun(node13_20, atr).         const(atr).
m_form(node13_20, predlekarskou).         const(predlekarskou).
m_lemma(node13_20, predlekarsky).         const(predlekarsky).
m_tag(node13_20, aafs4____1a____).         const(aafs4____1a____).
m_tag0(node13_20,'a'). const('a'). m_tag1(node13_20,'a'). const('a'). m_tag2(node13_20,'f'). const('f'). m_tag3(node13_20,'s'). const('s'). m_tag4(node13_20,'4'). const('4'). m_tag9(node13_20,'1'). const('1'). m_tag10(node13_20,'a'). const('a'). 
%%%%%%%% node13_21 %%%%%%%%%%%%%%%%%%%
node(node13_21).
a_afun(node13_21, obj).         const(obj).
m_form(node13_21, pomoc).         const(pomoc).
m_lemma(node13_21, pomoc).         const(pomoc).
m_tag(node13_21, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node13_21,'n'). const('n'). m_tag1(node13_21,'n'). const('n'). m_tag2(node13_21,'f'). const('f'). m_tag3(node13_21,'s'). const('s'). m_tag4(node13_21,'4'). const('4'). m_tag10(node13_21,'a'). const('a'). 
edge(node13_0, node13_1).
edge(node13_1, node13_2).
edge(node13_2, node13_3).
edge(node13_2, node13_4).
edge(node13_4, node13_5).
edge(node13_4, node13_6).
edge(node13_2, node13_7).
edge(node13_2, node13_8).
edge(node13_2, node13_9).
edge(node13_9, node13_10).
edge(node13_1, node13_11).
edge(node13_1, node13_12).
edge(node13_12, node13_13).
edge(node13_13, node13_14).
edge(node13_12, node13_15).
edge(node13_15, node13_16).
edge(node13_12, node13_17).
edge(node13_12, node13_18).
edge(node13_18, node13_19).
edge(node13_19, node13_20).
edge(node13_18, node13_21).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby. 
tree_root(node14_0).
%%%%%%%% node14_0 %%%%%%%%%%%%%%%%%%%
node(node14_0).
id(node14_0, t_plzensky69694_txt_001_p4s2).         const(t_plzensky69694_txt_001_p4s2).
%%%%%%%% node14_1 %%%%%%%%%%%%%%%%%%%
node(node14_1).
functor(node14_1, pred).         const(pred).
gram_sempos(node14_1, v).         const(v).
id(node14_1, t_plzensky69694_txt_001_p4s2a1).         const(t_plzensky69694_txt_001_p4s2a1).
t_lemma(node14_1, zranit).         const(zranit).
%%%%%%%% node14_2 %%%%%%%%%%%%%%%%%%%
node(node14_2).
functor(node14_2, act).         const(act).
id(node14_2, t_plzensky69694_txt_001_p4s2a7).         const(t_plzensky69694_txt_001_p4s2a7).
t_lemma(node14_2, x_gen).         const(x_gen).
%%%%%%%% node14_3 %%%%%%%%%%%%%%%%%%%
node(node14_3).
functor(node14_3, twhen).         const(twhen).
gram_sempos(node14_3, n_denot).         const(n_denot).
id(node14_3, t_plzensky69694_txt_001_p4s2a3).         const(t_plzensky69694_txt_001_p4s2a3).
t_lemma(node14_3, nehoda).         const(nehoda).
%%%%%%%% node14_4 %%%%%%%%%%%%%%%%%%%
node(node14_4).
a_afun(node14_4, auxp).         const(auxp).
m_form(node14_4, pri).         const(pri).
m_lemma(node14_4, pri_1).         const(pri_1).
m_tag(node14_4, rr__6__________).         const(rr__6__________).
m_tag0(node14_4,'r'). const('r'). m_tag1(node14_4,'r'). const('r'). m_tag4(node14_4,'6'). const('6'). 
%%%%%%%% node14_5 %%%%%%%%%%%%%%%%%%%
node(node14_5).
a_afun(node14_5, adv).         const(adv).
m_form(node14_5, nehode).         const(nehode).
m_lemma(node14_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node14_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node14_5,'n'). const('n'). m_tag1(node14_5,'n'). const('n'). m_tag2(node14_5,'f'). const('f'). m_tag3(node14_5,'s'). const('s'). m_tag4(node14_5,'6'). const('6'). m_tag10(node14_5,'a'). const('a'). 
%%%%%%%% node14_6 %%%%%%%%%%%%%%%%%%%
node(node14_6).
a_afun(node14_6, auxv).         const(auxv).
m_form(node14_6, byly).         const(byly).
m_lemma(node14_6, byt).         const(byt).
m_tag(node14_6, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node14_6,'v'). const('v'). m_tag1(node14_6,'p'). const('p'). m_tag2(node14_6,'t'). const('t'). m_tag3(node14_6,'p'). const('p'). m_tag7(node14_6,'x'). const('x'). m_tag8(node14_6,'r'). const('r'). m_tag10(node14_6,'a'). const('a'). m_tag11(node14_6,'a'). const('a'). 
%%%%%%%% node14_7 %%%%%%%%%%%%%%%%%%%
node(node14_7).
a_afun(node14_7, pred).         const(pred).
m_form(node14_7, zraneny).         const(zraneny).
m_lemma(node14_7, zranit__w).         const(zranit__w).
m_tag(node14_7, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node14_7,'v'). const('v'). m_tag1(node14_7,'s'). const('s'). m_tag2(node14_7,'t'). const('t'). m_tag3(node14_7,'p'). const('p'). m_tag7(node14_7,'x'). const('x'). m_tag8(node14_7,'x'). const('x'). m_tag10(node14_7,'a'). const('a'). m_tag11(node14_7,'p'). const('p'). 
%%%%%%%% node14_8 %%%%%%%%%%%%%%%%%%%
node(node14_8).
functor(node14_8, pat).         const(pat).
gram_sempos(node14_8, n_denot).         const(n_denot).
id(node14_8, t_plzensky69694_txt_001_p4s2a5).         const(t_plzensky69694_txt_001_p4s2a5).
t_lemma(node14_8, osoba).         const(osoba).
%%%%%%%% node14_9 %%%%%%%%%%%%%%%%%%%
node(node14_9).
functor(node14_9, rstr).         const(rstr).
gram_sempos(node14_9, adj_quant_def).         const(adj_quant_def).
id(node14_9, t_plzensky69694_txt_001_p4s2a6).         const(t_plzensky69694_txt_001_p4s2a6).
t_lemma(node14_9, dva).         const(dva).
%%%%%%%% node14_10 %%%%%%%%%%%%%%%%%%%
node(node14_10).
a_afun(node14_10, atr).         const(atr).
m_form(node14_10, dve).         const(dve).
m_lemma(node14_10, dva_2).         const(dva_2).
m_tag(node14_10, clhp1__________).         const(clhp1__________).
m_tag0(node14_10,'c'). const('c'). m_tag1(node14_10,'l'). const('l'). m_tag2(node14_10,'h'). const('h'). m_tag3(node14_10,'p'). const('p'). m_tag4(node14_10,'1'). const('1'). 
%%%%%%%% node14_11 %%%%%%%%%%%%%%%%%%%
node(node14_11).
a_afun(node14_11, sb).         const(sb).
m_form(node14_11, osoby).         const(osoby).
m_lemma(node14_11, osoba).         const(osoba).
m_tag(node14_11, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node14_11,'n'). const('n'). m_tag1(node14_11,'n'). const('n'). m_tag2(node14_11,'f'). const('f'). m_tag3(node14_11,'p'). const('p'). m_tag4(node14_11,'1'). const('1'). m_tag10(node14_11,'a'). const('a'). 
edge(node14_0, node14_1).
edge(node14_1, node14_2).
edge(node14_1, node14_3).
edge(node14_3, node14_4).
edge(node14_3, node14_5).
edge(node14_1, node14_6).
edge(node14_1, node14_7).
edge(node14_1, node14_8).
edge(node14_8, node14_9).
edge(node14_9, node14_10).
edge(node14_8, node14_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridic druheho vozidla nebyl zranen. 
tree_root(node15_0).
%%%%%%%% node15_0 %%%%%%%%%%%%%%%%%%%
node(node15_0).
id(node15_0, t_plzensky71843_txt_001_p1s7).         const(t_plzensky71843_txt_001_p1s7).
%%%%%%%% node15_1 %%%%%%%%%%%%%%%%%%%
node(node15_1).
functor(node15_1, pred).         const(pred).
gram_sempos(node15_1, v).         const(v).
id(node15_1, t_plzensky71843_txt_001_p1s7a1).         const(t_plzensky71843_txt_001_p1s7a1).
t_lemma(node15_1, zranit).         const(zranit).
%%%%%%%% node15_2 %%%%%%%%%%%%%%%%%%%
node(node15_2).
functor(node15_2, act).         const(act).
id(node15_2, t_plzensky71843_txt_001_p1s7a5).         const(t_plzensky71843_txt_001_p1s7a5).
t_lemma(node15_2, x_gen).         const(x_gen).
%%%%%%%% node15_3 %%%%%%%%%%%%%%%%%%%
node(node15_3).
functor(node15_3, pat).         const(pat).
gram_sempos(node15_3, n_denot).         const(n_denot).
id(node15_3, t_plzensky71843_txt_001_p1s7a2).         const(t_plzensky71843_txt_001_p1s7a2).
t_lemma(node15_3, ridic).         const(ridic).
%%%%%%%% node15_4 %%%%%%%%%%%%%%%%%%%
node(node15_4).
a_afun(node15_4, sb).         const(sb).
m_form(node15_4, ridic).         const(ridic).
m_lemma(node15_4, ridic).         const(ridic).
m_tag(node15_4, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node15_4,'n'). const('n'). m_tag1(node15_4,'n'). const('n'). m_tag2(node15_4,'m'). const('m'). m_tag3(node15_4,'s'). const('s'). m_tag4(node15_4,'1'). const('1'). m_tag10(node15_4,'a'). const('a'). 
%%%%%%%% node15_5 %%%%%%%%%%%%%%%%%%%
node(node15_5).
functor(node15_5, app).         const(app).
gram_sempos(node15_5, n_denot).         const(n_denot).
id(node15_5, t_plzensky71843_txt_001_p1s7a3).         const(t_plzensky71843_txt_001_p1s7a3).
t_lemma(node15_5, vozidlo).         const(vozidlo).
%%%%%%%% node15_6 %%%%%%%%%%%%%%%%%%%
node(node15_6).
functor(node15_6, rstr).         const(rstr).
gram_sempos(node15_6, adj_quant_def).         const(adj_quant_def).
id(node15_6, t_plzensky71843_txt_001_p1s7a4).         const(t_plzensky71843_txt_001_p1s7a4).
t_lemma(node15_6, dva).         const(dva).
%%%%%%%% node15_7 %%%%%%%%%%%%%%%%%%%
node(node15_7).
a_afun(node15_7, atr).         const(atr).
m_form(node15_7, druheho).         const(druheho).
m_lemma(node15_7, druhy_1___jiny_).         const(druhy_1___jiny_).
m_tag(node15_7, aans2____1a____).         const(aans2____1a____).
m_tag0(node15_7,'a'). const('a'). m_tag1(node15_7,'a'). const('a'). m_tag2(node15_7,'n'). const('n'). m_tag3(node15_7,'s'). const('s'). m_tag4(node15_7,'2'). const('2'). m_tag9(node15_7,'1'). const('1'). m_tag10(node15_7,'a'). const('a'). 
%%%%%%%% node15_8 %%%%%%%%%%%%%%%%%%%
node(node15_8).
a_afun(node15_8, atr).         const(atr).
m_form(node15_8, vozidla).         const(vozidla).
m_lemma(node15_8, vozidlo).         const(vozidlo).
m_tag(node15_8, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node15_8,'n'). const('n'). m_tag1(node15_8,'n'). const('n'). m_tag2(node15_8,'n'). const('n'). m_tag3(node15_8,'s'). const('s'). m_tag4(node15_8,'2'). const('2'). m_tag10(node15_8,'a'). const('a'). 
%%%%%%%% node15_9 %%%%%%%%%%%%%%%%%%%
node(node15_9).
a_afun(node15_9, auxv).         const(auxv).
m_form(node15_9, nebyl).         const(nebyl).
m_lemma(node15_9, byt).         const(byt).
m_tag(node15_9, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node15_9,'v'). const('v'). m_tag1(node15_9,'p'). const('p'). m_tag2(node15_9,'y'). const('y'). m_tag3(node15_9,'s'). const('s'). m_tag7(node15_9,'x'). const('x'). m_tag8(node15_9,'r'). const('r'). m_tag10(node15_9,'n'). const('n'). m_tag11(node15_9,'a'). const('a'). 
%%%%%%%% node15_10 %%%%%%%%%%%%%%%%%%%
node(node15_10).
a_afun(node15_10, pred).         const(pred).
m_form(node15_10, zranen).         const(zranen).
m_lemma(node15_10, zranit__w).         const(zranit__w).
m_tag(node15_10, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node15_10,'v'). const('v'). m_tag1(node15_10,'s'). const('s'). m_tag2(node15_10,'y'). const('y'). m_tag3(node15_10,'s'). const('s'). m_tag7(node15_10,'x'). const('x'). m_tag8(node15_10,'x'). const('x'). m_tag10(node15_10,'a'). const('a'). m_tag11(node15_10,'p'). const('p'). 
edge(node15_0, node15_1).
edge(node15_1, node15_2).
edge(node15_1, node15_3).
edge(node15_3, node15_4).
edge(node15_3, node15_5).
edge(node15_5, node15_6).
edge(node15_6, node15_7).
edge(node15_5, node15_8).
edge(node15_1, node15_9).
edge(node15_1, node15_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl zranen jeden ridic a do pece ho prevzala zzs. 
tree_root(node16_0).
%%%%%%%% node16_0 %%%%%%%%%%%%%%%%%%%
node(node16_0).
id(node16_0, t_plzensky58562_txt_001_p3s3).         const(t_plzensky58562_txt_001_p3s3).
%%%%%%%% node16_1 %%%%%%%%%%%%%%%%%%%
node(node16_1).
functor(node16_1, conj).         const(conj).
id(node16_1, t_plzensky58562_txt_001_p3s3a1).         const(t_plzensky58562_txt_001_p3s3a1).
t_lemma(node16_1, a).         const(a).
%%%%%%%% node16_2 %%%%%%%%%%%%%%%%%%%
node(node16_2).
functor(node16_2, pred).         const(pred).
gram_sempos(node16_2, v).         const(v).
id(node16_2, t_plzensky58562_txt_001_p3s3a2).         const(t_plzensky58562_txt_001_p3s3a2).
t_lemma(node16_2, zranit).         const(zranit).
%%%%%%%% node16_3 %%%%%%%%%%%%%%%%%%%
node(node16_3).
functor(node16_3, act).         const(act).
id(node16_3, t_plzensky58562_txt_001_p3s3a13).         const(t_plzensky58562_txt_001_p3s3a13).
t_lemma(node16_3, x_gen).         const(x_gen).
%%%%%%%% node16_4 %%%%%%%%%%%%%%%%%%%
node(node16_4).
functor(node16_4, twhen).         const(twhen).
gram_sempos(node16_4, n_denot).         const(n_denot).
id(node16_4, t_plzensky58562_txt_001_p3s3a4).         const(t_plzensky58562_txt_001_p3s3a4).
t_lemma(node16_4, nehoda).         const(nehoda).
%%%%%%%% node16_5 %%%%%%%%%%%%%%%%%%%
node(node16_5).
a_afun(node16_5, auxp).         const(auxp).
m_form(node16_5, pri).         const(pri).
m_lemma(node16_5, pri_1).         const(pri_1).
m_tag(node16_5, rr__6__________).         const(rr__6__________).
m_tag0(node16_5,'r'). const('r'). m_tag1(node16_5,'r'). const('r'). m_tag4(node16_5,'6'). const('6'). 
%%%%%%%% node16_6 %%%%%%%%%%%%%%%%%%%
node(node16_6).
a_afun(node16_6, adv).         const(adv).
m_form(node16_6, nehode).         const(nehode).
m_lemma(node16_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node16_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node16_6,'n'). const('n'). m_tag1(node16_6,'n'). const('n'). m_tag2(node16_6,'f'). const('f'). m_tag3(node16_6,'s'). const('s'). m_tag4(node16_6,'6'). const('6'). m_tag10(node16_6,'a'). const('a'). 
%%%%%%%% node16_7 %%%%%%%%%%%%%%%%%%%
node(node16_7).
a_afun(node16_7, auxv).         const(auxv).
m_form(node16_7, byl).         const(byl).
m_lemma(node16_7, byt).         const(byt).
m_tag(node16_7, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node16_7,'v'). const('v'). m_tag1(node16_7,'p'). const('p'). m_tag2(node16_7,'y'). const('y'). m_tag3(node16_7,'s'). const('s'). m_tag7(node16_7,'x'). const('x'). m_tag8(node16_7,'r'). const('r'). m_tag10(node16_7,'a'). const('a'). m_tag11(node16_7,'a'). const('a'). 
%%%%%%%% node16_8 %%%%%%%%%%%%%%%%%%%
node(node16_8).
a_afun(node16_8, pred).         const(pred).
m_form(node16_8, zranen).         const(zranen).
m_lemma(node16_8, zranit__w).         const(zranit__w).
m_tag(node16_8, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node16_8,'v'). const('v'). m_tag1(node16_8,'s'). const('s'). m_tag2(node16_8,'y'). const('y'). m_tag3(node16_8,'s'). const('s'). m_tag7(node16_8,'x'). const('x'). m_tag8(node16_8,'x'). const('x'). m_tag10(node16_8,'a'). const('a'). m_tag11(node16_8,'p'). const('p'). 
%%%%%%%% node16_9 %%%%%%%%%%%%%%%%%%%
node(node16_9).
functor(node16_9, pat).         const(pat).
gram_sempos(node16_9, n_denot).         const(n_denot).
id(node16_9, t_plzensky58562_txt_001_p3s3a6).         const(t_plzensky58562_txt_001_p3s3a6).
t_lemma(node16_9, ridic).         const(ridic).
%%%%%%%% node16_10 %%%%%%%%%%%%%%%%%%%
node(node16_10).
functor(node16_10, rstr).         const(rstr).
gram_sempos(node16_10, adj_quant_def).         const(adj_quant_def).
id(node16_10, t_plzensky58562_txt_001_p3s3a7).         const(t_plzensky58562_txt_001_p3s3a7).
t_lemma(node16_10, jeden).         const(jeden).
%%%%%%%% node16_11 %%%%%%%%%%%%%%%%%%%
node(node16_11).
a_afun(node16_11, atr).         const(atr).
m_form(node16_11, jeden).         const(jeden).
m_lemma(node16_11, jeden_1).         const(jeden_1).
m_tag(node16_11, clys1__________).         const(clys1__________).
m_tag0(node16_11,'c'). const('c'). m_tag1(node16_11,'l'). const('l'). m_tag2(node16_11,'y'). const('y'). m_tag3(node16_11,'s'). const('s'). m_tag4(node16_11,'1'). const('1'). 
%%%%%%%% node16_12 %%%%%%%%%%%%%%%%%%%
node(node16_12).
a_afun(node16_12, sb).         const(sb).
m_form(node16_12, ridic).         const(ridic).
m_lemma(node16_12, ridic).         const(ridic).
m_tag(node16_12, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node16_12,'n'). const('n'). m_tag1(node16_12,'n'). const('n'). m_tag2(node16_12,'m'). const('m'). m_tag3(node16_12,'s'). const('s'). m_tag4(node16_12,'1'). const('1'). m_tag10(node16_12,'a'). const('a'). 
%%%%%%%% node16_13 %%%%%%%%%%%%%%%%%%%
node(node16_13).
a_afun(node16_13, coord).         const(coord).
m_form(node16_13, a).         const(a).
m_lemma(node16_13, a_1).         const(a_1).
m_tag(node16_13, j______________).         const(j______________).
m_tag0(node16_13,'j'). const('j'). m_tag1(node16_13,'^'). const('^'). 
%%%%%%%% node16_14 %%%%%%%%%%%%%%%%%%%
node(node16_14).
functor(node16_14, pred).         const(pred).
gram_sempos(node16_14, v).         const(v).
id(node16_14, t_plzensky58562_txt_001_p3s3a8).         const(t_plzensky58562_txt_001_p3s3a8).
t_lemma(node16_14, prevzit).         const(prevzit).
%%%%%%%% node16_15 %%%%%%%%%%%%%%%%%%%
node(node16_15).
functor(node16_15, dir3).         const(dir3).
gram_sempos(node16_15, n_denot).         const(n_denot).
id(node16_15, t_plzensky58562_txt_001_p3s3a10).         const(t_plzensky58562_txt_001_p3s3a10).
t_lemma(node16_15, pece).         const(pece).
%%%%%%%% node16_16 %%%%%%%%%%%%%%%%%%%
node(node16_16).
a_afun(node16_16, auxp).         const(auxp).
m_form(node16_16, do).         const(do).
m_lemma(node16_16, do_1).         const(do_1).
m_tag(node16_16, rr__2__________).         const(rr__2__________).
m_tag0(node16_16,'r'). const('r'). m_tag1(node16_16,'r'). const('r'). m_tag4(node16_16,'2'). const('2'). 
%%%%%%%% node16_17 %%%%%%%%%%%%%%%%%%%
node(node16_17).
a_afun(node16_17, adv).         const(adv).
m_form(node16_17, pece).         const(pece).
m_lemma(node16_17, pece).         const(pece).
m_tag(node16_17, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node16_17,'n'). const('n'). m_tag1(node16_17,'n'). const('n'). m_tag2(node16_17,'f'). const('f'). m_tag3(node16_17,'s'). const('s'). m_tag4(node16_17,'2'). const('2'). m_tag10(node16_17,'a'). const('a'). 
%%%%%%%% node16_18 %%%%%%%%%%%%%%%%%%%
node(node16_18).
functor(node16_18, pat).         const(pat).
gram_sempos(node16_18, n_pron_def_pers).         const(n_pron_def_pers).
id(node16_18, t_plzensky58562_txt_001_p3s3a11).         const(t_plzensky58562_txt_001_p3s3a11).
t_lemma(node16_18, x_perspron).         const(x_perspron).
%%%%%%%% node16_19 %%%%%%%%%%%%%%%%%%%
node(node16_19).
a_afun(node16_19, obj).         const(obj).
m_form(node16_19, ho).         const(ho).
m_lemma(node16_19, on_1).         const(on_1).
m_tag(node16_19, phzs4__3_______).         const(phzs4__3_______).
m_tag0(node16_19,'p'). const('p'). m_tag1(node16_19,'h'). const('h'). m_tag2(node16_19,'z'). const('z'). m_tag3(node16_19,'s'). const('s'). m_tag4(node16_19,'4'). const('4'). m_tag7(node16_19,'3'). const('3'). 
%%%%%%%% node16_20 %%%%%%%%%%%%%%%%%%%
node(node16_20).
a_afun(node16_20, pred).         const(pred).
m_form(node16_20, prevzala).         const(prevzala).
m_lemma(node16_20, prevzit___pr__od_nekoho_vec__zodpovednost____).         const(prevzit___pr__od_nekoho_vec__zodpovednost____).
m_tag(node16_20, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node16_20,'v'). const('v'). m_tag1(node16_20,'p'). const('p'). m_tag2(node16_20,'q'). const('q'). m_tag3(node16_20,'w'). const('w'). m_tag7(node16_20,'x'). const('x'). m_tag8(node16_20,'r'). const('r'). m_tag10(node16_20,'a'). const('a'). m_tag11(node16_20,'a'). const('a'). 
%%%%%%%% node16_21 %%%%%%%%%%%%%%%%%%%
node(node16_21).
functor(node16_21, act).         const(act).
gram_sempos(node16_21, n_denot).         const(n_denot).
id(node16_21, t_plzensky58562_txt_001_p3s3a12).         const(t_plzensky58562_txt_001_p3s3a12).
t_lemma(node16_21, zzs).         const(zzs).
%%%%%%%% node16_22 %%%%%%%%%%%%%%%%%%%
node(node16_22).
a_afun(node16_22, sb).         const(sb).
m_form(node16_22, zzs).         const(zzs).
m_lemma(node16_22, zzs).         const(zzs).
m_tag(node16_22, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node16_22,'n'). const('n'). m_tag1(node16_22,'n'). const('n'). m_tag2(node16_22,'f'). const('f'). m_tag3(node16_22,'x'). const('x'). m_tag4(node16_22,'x'). const('x'). m_tag10(node16_22,'a'). const('a'). 
edge(node16_0, node16_1).
edge(node16_1, node16_2).
edge(node16_2, node16_3).
edge(node16_2, node16_4).
edge(node16_4, node16_5).
edge(node16_4, node16_6).
edge(node16_2, node16_7).
edge(node16_2, node16_8).
edge(node16_2, node16_9).
edge(node16_9, node16_10).
edge(node16_10, node16_11).
edge(node16_9, node16_12).
edge(node16_1, node16_13).
edge(node16_1, node16_14).
edge(node16_14, node16_15).
edge(node16_15, node16_16).
edge(node16_15, node16_17).
edge(node16_14, node16_18).
edge(node16_18, node16_19).
edge(node16_14, node16_20).
edge(node16_14, node16_21).
edge(node16_21, node16_22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byla zranena jedna osoba. 
tree_root(node17_0).
%%%%%%%% node17_0 %%%%%%%%%%%%%%%%%%%
node(node17_0).
id(node17_0, t_plzensky72261_txt_001_p14s2).         const(t_plzensky72261_txt_001_p14s2).
%%%%%%%% node17_1 %%%%%%%%%%%%%%%%%%%
node(node17_1).
functor(node17_1, pred).         const(pred).
gram_sempos(node17_1, v).         const(v).
id(node17_1, t_plzensky72261_txt_001_p14s2a1).         const(t_plzensky72261_txt_001_p14s2a1).
t_lemma(node17_1, zranit).         const(zranit).
%%%%%%%% node17_2 %%%%%%%%%%%%%%%%%%%
node(node17_2).
functor(node17_2, act).         const(act).
id(node17_2, t_plzensky72261_txt_001_p14s2a7).         const(t_plzensky72261_txt_001_p14s2a7).
t_lemma(node17_2, x_gen).         const(x_gen).
%%%%%%%% node17_3 %%%%%%%%%%%%%%%%%%%
node(node17_3).
functor(node17_3, twhen).         const(twhen).
gram_sempos(node17_3, n_denot).         const(n_denot).
id(node17_3, t_plzensky72261_txt_001_p14s2a3).         const(t_plzensky72261_txt_001_p14s2a3).
t_lemma(node17_3, nehoda).         const(nehoda).
%%%%%%%% node17_4 %%%%%%%%%%%%%%%%%%%
node(node17_4).
a_afun(node17_4, auxp).         const(auxp).
m_form(node17_4, pri).         const(pri).
m_lemma(node17_4, pri_1).         const(pri_1).
m_tag(node17_4, rr__6__________).         const(rr__6__________).
m_tag0(node17_4,'r'). const('r'). m_tag1(node17_4,'r'). const('r'). m_tag4(node17_4,'6'). const('6'). 
%%%%%%%% node17_5 %%%%%%%%%%%%%%%%%%%
node(node17_5).
a_afun(node17_5, adv).         const(adv).
m_form(node17_5, nehode).         const(nehode).
m_lemma(node17_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node17_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node17_5,'n'). const('n'). m_tag1(node17_5,'n'). const('n'). m_tag2(node17_5,'f'). const('f'). m_tag3(node17_5,'s'). const('s'). m_tag4(node17_5,'6'). const('6'). m_tag10(node17_5,'a'). const('a'). 
%%%%%%%% node17_6 %%%%%%%%%%%%%%%%%%%
node(node17_6).
a_afun(node17_6, auxv).         const(auxv).
m_form(node17_6, byla).         const(byla).
m_lemma(node17_6, byt).         const(byt).
m_tag(node17_6, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node17_6,'v'). const('v'). m_tag1(node17_6,'p'). const('p'). m_tag2(node17_6,'q'). const('q'). m_tag3(node17_6,'w'). const('w'). m_tag7(node17_6,'x'). const('x'). m_tag8(node17_6,'r'). const('r'). m_tag10(node17_6,'a'). const('a'). m_tag11(node17_6,'a'). const('a'). 
%%%%%%%% node17_7 %%%%%%%%%%%%%%%%%%%
node(node17_7).
a_afun(node17_7, pred).         const(pred).
m_form(node17_7, zranena).         const(zranena).
m_lemma(node17_7, zranit__w).         const(zranit__w).
m_tag(node17_7, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node17_7,'v'). const('v'). m_tag1(node17_7,'s'). const('s'). m_tag2(node17_7,'q'). const('q'). m_tag3(node17_7,'w'). const('w'). m_tag7(node17_7,'x'). const('x'). m_tag8(node17_7,'x'). const('x'). m_tag10(node17_7,'a'). const('a'). m_tag11(node17_7,'p'). const('p'). 
%%%%%%%% node17_8 %%%%%%%%%%%%%%%%%%%
node(node17_8).
functor(node17_8, pat).         const(pat).
gram_sempos(node17_8, n_denot).         const(n_denot).
id(node17_8, t_plzensky72261_txt_001_p14s2a5).         const(t_plzensky72261_txt_001_p14s2a5).
t_lemma(node17_8, osoba).         const(osoba).
%%%%%%%% node17_9 %%%%%%%%%%%%%%%%%%%
node(node17_9).
functor(node17_9, rstr).         const(rstr).
gram_sempos(node17_9, adj_quant_def).         const(adj_quant_def).
id(node17_9, t_plzensky72261_txt_001_p14s2a6).         const(t_plzensky72261_txt_001_p14s2a6).
t_lemma(node17_9, jeden).         const(jeden).
%%%%%%%% node17_10 %%%%%%%%%%%%%%%%%%%
node(node17_10).
a_afun(node17_10, atr).         const(atr).
m_form(node17_10, jedna).         const(jedna).
m_lemma(node17_10, jeden_1).         const(jeden_1).
m_tag(node17_10, clfs1__________).         const(clfs1__________).
m_tag0(node17_10,'c'). const('c'). m_tag1(node17_10,'l'). const('l'). m_tag2(node17_10,'f'). const('f'). m_tag3(node17_10,'s'). const('s'). m_tag4(node17_10,'1'). const('1'). 
%%%%%%%% node17_11 %%%%%%%%%%%%%%%%%%%
node(node17_11).
a_afun(node17_11, sb).         const(sb).
m_form(node17_11, osoba).         const(osoba).
m_lemma(node17_11, osoba).         const(osoba).
m_tag(node17_11, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node17_11,'n'). const('n'). m_tag1(node17_11,'n'). const('n'). m_tag2(node17_11,'f'). const('f'). m_tag3(node17_11,'s'). const('s'). m_tag4(node17_11,'1'). const('1'). m_tag10(node17_11,'a'). const('a'). 
edge(node17_0, node17_1).
edge(node17_1, node17_2).
edge(node17_1, node17_3).
edge(node17_3, node17_4).
edge(node17_3, node17_5).
edge(node17_1, node17_6).
edge(node17_1, node17_7).
edge(node17_1, node17_8).
edge(node17_8, node17_9).
edge(node17_9, node17_10).
edge(node17_8, node17_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node18_0).
%%%%%%%% node18_0 %%%%%%%%%%%%%%%%%%%
node(node18_0).
id(node18_0, t_plzensky72261_txt_001_p15s5).         const(t_plzensky72261_txt_001_p15s5).
%%%%%%%% node18_1 %%%%%%%%%%%%%%%%%%%
node(node18_1).
functor(node18_1, pred).         const(pred).
gram_sempos(node18_1, v).         const(v).
id(node18_1, t_plzensky72261_txt_001_p15s5a1).         const(t_plzensky72261_txt_001_p15s5a1).
t_lemma(node18_1, zranit).         const(zranit).
%%%%%%%% node18_2 %%%%%%%%%%%%%%%%%%%
node(node18_2).
functor(node18_2, act).         const(act).
id(node18_2, t_plzensky72261_txt_001_p15s5a3).         const(t_plzensky72261_txt_001_p15s5a3).
t_lemma(node18_2, x_gen).         const(x_gen).
%%%%%%%% node18_3 %%%%%%%%%%%%%%%%%%%
node(node18_3).
functor(node18_3, pat).         const(pat).
gram_sempos(node18_3, n_pron_indef).         const(n_pron_indef).
id(node18_3, t_plzensky72261_txt_001_p15s5a2).         const(t_plzensky72261_txt_001_p15s5a2).
t_lemma(node18_3, kdo).         const(kdo).
%%%%%%%% node18_4 %%%%%%%%%%%%%%%%%%%
node(node18_4).
a_afun(node18_4, sb).         const(sb).
m_form(node18_4, nikdo).         const(nikdo).
m_lemma(node18_4, nikdo).         const(nikdo).
m_tag(node18_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node18_4,'p'). const('p'). m_tag1(node18_4,'w'). const('w'). m_tag2(node18_4,'m'). const('m'). m_tag4(node18_4,'1'). const('1'). 
%%%%%%%% node18_5 %%%%%%%%%%%%%%%%%%%
node(node18_5).
a_afun(node18_5, auxv).         const(auxv).
m_form(node18_5, nebyl).         const(nebyl).
m_lemma(node18_5, byt).         const(byt).
m_tag(node18_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node18_5,'v'). const('v'). m_tag1(node18_5,'p'). const('p'). m_tag2(node18_5,'y'). const('y'). m_tag3(node18_5,'s'). const('s'). m_tag7(node18_5,'x'). const('x'). m_tag8(node18_5,'r'). const('r'). m_tag10(node18_5,'n'). const('n'). m_tag11(node18_5,'a'). const('a'). 
%%%%%%%% node18_6 %%%%%%%%%%%%%%%%%%%
node(node18_6).
a_afun(node18_6, pred).         const(pred).
m_form(node18_6, zranen).         const(zranen).
m_lemma(node18_6, zranit__w).         const(zranit__w).
m_tag(node18_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node18_6,'v'). const('v'). m_tag1(node18_6,'s'). const('s'). m_tag2(node18_6,'y'). const('y'). m_tag3(node18_6,'s'). const('s'). m_tag7(node18_6,'x'). const('x'). m_tag8(node18_6,'x'). const('x'). m_tag10(node18_6,'a'). const('a'). m_tag11(node18_6,'p'). const('p'). 
edge(node18_0, node18_1).
edge(node18_1, node18_2).
edge(node18_1, node18_3).
edge(node18_3, node18_4).
edge(node18_1, node18_5).
edge(node18_1, node18_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z peti zranenych osob byly dve osoby zraneny tezce a tri lehce. 
tree_root(node19_0).
%%%%%%%% node19_0 %%%%%%%%%%%%%%%%%%%
node(node19_0).
id(node19_0, t_plzensky71760_txt_001_p2s7).         const(t_plzensky71760_txt_001_p2s7).
%%%%%%%% node19_1 %%%%%%%%%%%%%%%%%%%
node(node19_1).
functor(node19_1, conj).         const(conj).
id(node19_1, t_plzensky71760_txt_001_p2s7a1).         const(t_plzensky71760_txt_001_p2s7a1).
t_lemma(node19_1, a).         const(a).
%%%%%%%% node19_2 %%%%%%%%%%%%%%%%%%%
node(node19_2).
functor(node19_2, pred).         const(pred).
gram_sempos(node19_2, v).         const(v).
id(node19_2, t_plzensky71760_txt_001_p2s7a2).         const(t_plzensky71760_txt_001_p2s7a2).
t_lemma(node19_2, zranit).         const(zranit).
%%%%%%%% node19_3 %%%%%%%%%%%%%%%%%%%
node(node19_3).
functor(node19_3, act).         const(act).
id(node19_3, t_plzensky71760_txt_001_p2s7a13).         const(t_plzensky71760_txt_001_p2s7a13).
t_lemma(node19_3, x_gen).         const(x_gen).
%%%%%%%% node19_4 %%%%%%%%%%%%%%%%%%%
node(node19_4).
functor(node19_4, dir1).         const(dir1).
gram_sempos(node19_4, n_denot).         const(n_denot).
id(node19_4, t_plzensky71760_txt_001_p2s7a4).         const(t_plzensky71760_txt_001_p2s7a4).
t_lemma(node19_4, osoba).         const(osoba).
%%%%%%%% node19_5 %%%%%%%%%%%%%%%%%%%
node(node19_5).
functor(node19_5, rstr).         const(rstr).
gram_sempos(node19_5, adj_quant_def).         const(adj_quant_def).
id(node19_5, t_plzensky71760_txt_001_p2s7a5).         const(t_plzensky71760_txt_001_p2s7a5).
t_lemma(node19_5, pet).         const(pet).
%%%%%%%% node19_6 %%%%%%%%%%%%%%%%%%%
node(node19_6).
a_afun(node19_6, atr).         const(atr).
m_form(node19_6, peti).         const(peti).
m_lemma(node19_6, pet_1_5).         const(pet_1_5).
m_tag(node19_6, cn_p2__________).         const(cn_p2__________).
m_tag0(node19_6,'c'). const('c'). m_tag1(node19_6,'n'). const('n'). m_tag3(node19_6,'p'). const('p'). m_tag4(node19_6,'2'). const('2'). 
%%%%%%%% node19_7 %%%%%%%%%%%%%%%%%%%
node(node19_7).
functor(node19_7, rstr).         const(rstr).
gram_sempos(node19_7, adj_denot).         const(adj_denot).
id(node19_7, t_plzensky71760_txt_001_p2s7a6).         const(t_plzensky71760_txt_001_p2s7a6).
t_lemma(node19_7, zraneny).         const(zraneny).
%%%%%%%% node19_8 %%%%%%%%%%%%%%%%%%%
node(node19_8).
a_afun(node19_8, atr).         const(atr).
m_form(node19_8, zranenych).         const(zranenych).
m_lemma(node19_8, zraneny____3it_).         const(zraneny____3it_).
m_tag(node19_8, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node19_8,'a'). const('a'). m_tag1(node19_8,'a'). const('a'). m_tag2(node19_8,'f'). const('f'). m_tag3(node19_8,'p'). const('p'). m_tag4(node19_8,'2'). const('2'). m_tag9(node19_8,'1'). const('1'). m_tag10(node19_8,'a'). const('a'). 
%%%%%%%% node19_9 %%%%%%%%%%%%%%%%%%%
node(node19_9).
a_afun(node19_9, auxp).         const(auxp).
m_form(node19_9, z).         const(z).
m_lemma(node19_9, z_1).         const(z_1).
m_tag(node19_9, rr__2__________).         const(rr__2__________).
m_tag0(node19_9,'r'). const('r'). m_tag1(node19_9,'r'). const('r'). m_tag4(node19_9,'2'). const('2'). 
%%%%%%%% node19_10 %%%%%%%%%%%%%%%%%%%
node(node19_10).
a_afun(node19_10, adv).         const(adv).
m_form(node19_10, osob).         const(osob).
m_lemma(node19_10, osoba).         const(osoba).
m_tag(node19_10, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node19_10,'n'). const('n'). m_tag1(node19_10,'n'). const('n'). m_tag2(node19_10,'f'). const('f'). m_tag3(node19_10,'p'). const('p'). m_tag4(node19_10,'2'). const('2'). m_tag10(node19_10,'a'). const('a'). 
%%%%%%%% node19_11 %%%%%%%%%%%%%%%%%%%
node(node19_11).
functor(node19_11, pat).         const(pat).
gram_sempos(node19_11, n_denot).         const(n_denot).
id(node19_11, t_plzensky71760_txt_001_p2s7a8).         const(t_plzensky71760_txt_001_p2s7a8).
t_lemma(node19_11, osoba).         const(osoba).
%%%%%%%% node19_12 %%%%%%%%%%%%%%%%%%%
node(node19_12).
functor(node19_12, rstr).         const(rstr).
gram_sempos(node19_12, adj_quant_def).         const(adj_quant_def).
id(node19_12, t_plzensky71760_txt_001_p2s7a9).         const(t_plzensky71760_txt_001_p2s7a9).
t_lemma(node19_12, dva).         const(dva).
%%%%%%%% node19_13 %%%%%%%%%%%%%%%%%%%
node(node19_13).
a_afun(node19_13, atr).         const(atr).
m_form(node19_13, dve).         const(dve).
m_lemma(node19_13, dva_2).         const(dva_2).
m_tag(node19_13, clhp1__________).         const(clhp1__________).
m_tag0(node19_13,'c'). const('c'). m_tag1(node19_13,'l'). const('l'). m_tag2(node19_13,'h'). const('h'). m_tag3(node19_13,'p'). const('p'). m_tag4(node19_13,'1'). const('1'). 
%%%%%%%% node19_14 %%%%%%%%%%%%%%%%%%%
node(node19_14).
a_afun(node19_14, sb).         const(sb).
m_form(node19_14, osoby).         const(osoby).
m_lemma(node19_14, osoba).         const(osoba).
m_tag(node19_14, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node19_14,'n'). const('n'). m_tag1(node19_14,'n'). const('n'). m_tag2(node19_14,'f'). const('f'). m_tag3(node19_14,'p'). const('p'). m_tag4(node19_14,'1'). const('1'). m_tag10(node19_14,'a'). const('a'). 
%%%%%%%% node19_15 %%%%%%%%%%%%%%%%%%%
node(node19_15).
a_afun(node19_15, auxv).         const(auxv).
m_form(node19_15, byly).         const(byly).
m_lemma(node19_15, byt).         const(byt).
m_tag(node19_15, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node19_15,'v'). const('v'). m_tag1(node19_15,'p'). const('p'). m_tag2(node19_15,'t'). const('t'). m_tag3(node19_15,'p'). const('p'). m_tag7(node19_15,'x'). const('x'). m_tag8(node19_15,'r'). const('r'). m_tag10(node19_15,'a'). const('a'). m_tag11(node19_15,'a'). const('a'). 
%%%%%%%% node19_16 %%%%%%%%%%%%%%%%%%%
node(node19_16).
a_afun(node19_16, pred).         const(pred).
m_form(node19_16, zraneny).         const(zraneny).
m_lemma(node19_16, zranit__w).         const(zranit__w).
m_tag(node19_16, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node19_16,'v'). const('v'). m_tag1(node19_16,'s'). const('s'). m_tag2(node19_16,'t'). const('t'). m_tag3(node19_16,'p'). const('p'). m_tag7(node19_16,'x'). const('x'). m_tag8(node19_16,'x'). const('x'). m_tag10(node19_16,'a'). const('a'). m_tag11(node19_16,'p'). const('p'). 
%%%%%%%% node19_17 %%%%%%%%%%%%%%%%%%%
node(node19_17).
functor(node19_17, mann).         const(mann).
gram_sempos(node19_17, adj_denot).         const(adj_denot).
id(node19_17, t_plzensky71760_txt_001_p2s7a10).         const(t_plzensky71760_txt_001_p2s7a10).
t_lemma(node19_17, tezky).         const(tezky).
%%%%%%%% node19_18 %%%%%%%%%%%%%%%%%%%
node(node19_18).
a_afun(node19_18, adv).         const(adv).
m_form(node19_18, tezce).         const(tezce).
m_lemma(node19_18, tezce).         const(tezce).
m_tag(node19_18, dg_______1a____).         const(dg_______1a____).
m_tag0(node19_18,'d'). const('d'). m_tag1(node19_18,'g'). const('g'). m_tag9(node19_18,'1'). const('1'). m_tag10(node19_18,'a'). const('a'). 
%%%%%%%% node19_19 %%%%%%%%%%%%%%%%%%%
node(node19_19).
a_afun(node19_19, coord).         const(coord).
m_form(node19_19, a).         const(a).
m_lemma(node19_19, a_1).         const(a_1).
m_tag(node19_19, j______________).         const(j______________).
m_tag0(node19_19,'j'). const('j'). m_tag1(node19_19,'^'). const('^'). 
%%%%%%%% node19_20 %%%%%%%%%%%%%%%%%%%
node(node19_20).
functor(node19_20, rstr).         const(rstr).
gram_sempos(node19_20, adj_quant_def).         const(adj_quant_def).
id(node19_20, t_plzensky71760_txt_001_p2s7a11).         const(t_plzensky71760_txt_001_p2s7a11).
t_lemma(node19_20, tri).         const(tri).
%%%%%%%% node19_21 %%%%%%%%%%%%%%%%%%%
node(node19_21).
a_afun(node19_21, exd).         const(exd).
m_form(node19_21, tri).         const(tri).
m_lemma(node19_21, tri_3).         const(tri_3).
m_tag(node19_21, clxp1__________).         const(clxp1__________).
m_tag0(node19_21,'c'). const('c'). m_tag1(node19_21,'l'). const('l'). m_tag2(node19_21,'x'). const('x'). m_tag3(node19_21,'p'). const('p'). m_tag4(node19_21,'1'). const('1'). 
%%%%%%%% node19_22 %%%%%%%%%%%%%%%%%%%
node(node19_22).
functor(node19_22, twhen).         const(twhen).
gram_sempos(node19_22, adj_denot).         const(adj_denot).
id(node19_22, t_plzensky71760_txt_001_p2s7a12).         const(t_plzensky71760_txt_001_p2s7a12).
t_lemma(node19_22, lehky).         const(lehky).
%%%%%%%% node19_23 %%%%%%%%%%%%%%%%%%%
node(node19_23).
a_afun(node19_23, exd).         const(exd).
m_form(node19_23, lehce).         const(lehce).
m_lemma(node19_23, lehce).         const(lehce).
m_tag(node19_23, dg_______1a____).         const(dg_______1a____).
m_tag0(node19_23,'d'). const('d'). m_tag1(node19_23,'g'). const('g'). m_tag9(node19_23,'1'). const('1'). m_tag10(node19_23,'a'). const('a'). 
edge(node19_0, node19_1).
edge(node19_1, node19_2).
edge(node19_2, node19_3).
edge(node19_2, node19_4).
edge(node19_4, node19_5).
edge(node19_5, node19_6).
edge(node19_4, node19_7).
edge(node19_7, node19_8).
edge(node19_4, node19_9).
edge(node19_4, node19_10).
edge(node19_2, node19_11).
edge(node19_11, node19_12).
edge(node19_12, node19_13).
edge(node19_11, node19_14).
edge(node19_2, node19_15).
edge(node19_2, node19_16).
edge(node19_2, node19_17).
edge(node19_17, node19_18).
edge(node19_1, node19_19).
edge(node19_1, node19_20).
edge(node19_20, node19_21).
edge(node19_1, node19_22).
edge(node19_22, node19_23).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri pozarech od pocatku roku byly dve osoby usmrceny a sestnact osob zraneno. 
tree_root(node20_0).
%%%%%%%% node20_0 %%%%%%%%%%%%%%%%%%%
node(node20_0).
id(node20_0, t_plzensky48663_txt_001_p2s2).         const(t_plzensky48663_txt_001_p2s2).
%%%%%%%% node20_1 %%%%%%%%%%%%%%%%%%%
node(node20_1).
functor(node20_1, conj).         const(conj).
id(node20_1, t_plzensky48663_txt_001_p2s2a1).         const(t_plzensky48663_txt_001_p2s2a1).
t_lemma(node20_1, a).         const(a).
%%%%%%%% node20_2 %%%%%%%%%%%%%%%%%%%
node(node20_2).
functor(node20_2, twhen).         const(twhen).
gram_sempos(node20_2, n_denot).         const(n_denot).
id(node20_2, t_plzensky48663_txt_001_p2s2a3).         const(t_plzensky48663_txt_001_p2s2a3).
t_lemma(node20_2, pozar).         const(pozar).
%%%%%%%% node20_3 %%%%%%%%%%%%%%%%%%%
node(node20_3).
a_afun(node20_3, auxp).         const(auxp).
m_form(node20_3, pri).         const(pri).
m_lemma(node20_3, pri_1).         const(pri_1).
m_tag(node20_3, rr__6__________).         const(rr__6__________).
m_tag0(node20_3,'r'). const('r'). m_tag1(node20_3,'r'). const('r'). m_tag4(node20_3,'6'). const('6'). 
%%%%%%%% node20_4 %%%%%%%%%%%%%%%%%%%
node(node20_4).
a_afun(node20_4, exd).         const(exd).
m_form(node20_4, pozarech).         const(pozarech).
m_lemma(node20_4, pozar).         const(pozar).
m_tag(node20_4, nnip6_____a____).         const(nnip6_____a____).
m_tag0(node20_4,'n'). const('n'). m_tag1(node20_4,'n'). const('n'). m_tag2(node20_4,'i'). const('i'). m_tag3(node20_4,'p'). const('p'). m_tag4(node20_4,'6'). const('6'). m_tag10(node20_4,'a'). const('a'). 
%%%%%%%% node20_5 %%%%%%%%%%%%%%%%%%%
node(node20_5).
functor(node20_5, tsin).         const(tsin).
gram_sempos(node20_5, n_denot).         const(n_denot).
id(node20_5, t_plzensky48663_txt_001_p2s2a5).         const(t_plzensky48663_txt_001_p2s2a5).
t_lemma(node20_5, pocatek).         const(pocatek).
%%%%%%%% node20_6 %%%%%%%%%%%%%%%%%%%
node(node20_6).
a_afun(node20_6, auxp).         const(auxp).
m_form(node20_6, od).         const(od).
m_lemma(node20_6, od_1).         const(od_1).
m_tag(node20_6, rr__2__________).         const(rr__2__________).
m_tag0(node20_6,'r'). const('r'). m_tag1(node20_6,'r'). const('r'). m_tag4(node20_6,'2'). const('2'). 
%%%%%%%% node20_7 %%%%%%%%%%%%%%%%%%%
node(node20_7).
a_afun(node20_7, exd).         const(exd).
m_form(node20_7, pocatku).         const(pocatku).
m_lemma(node20_7, pocatek).         const(pocatek).
m_tag(node20_7, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node20_7,'n'). const('n'). m_tag1(node20_7,'n'). const('n'). m_tag2(node20_7,'i'). const('i'). m_tag3(node20_7,'s'). const('s'). m_tag4(node20_7,'2'). const('2'). m_tag10(node20_7,'a'). const('a'). 
%%%%%%%% node20_8 %%%%%%%%%%%%%%%%%%%
node(node20_8).
functor(node20_8, app).         const(app).
gram_sempos(node20_8, n_denot).         const(n_denot).
id(node20_8, t_plzensky48663_txt_001_p2s2a6).         const(t_plzensky48663_txt_001_p2s2a6).
t_lemma(node20_8, rok).         const(rok).
%%%%%%%% node20_9 %%%%%%%%%%%%%%%%%%%
node(node20_9).
a_afun(node20_9, atr).         const(atr).
m_form(node20_9, roku).         const(roku).
m_lemma(node20_9, rok).         const(rok).
m_tag(node20_9, nnis2_____a___1).         const(nnis2_____a___1).
m_tag0(node20_9,'n'). const('n'). m_tag1(node20_9,'n'). const('n'). m_tag2(node20_9,'i'). const('i'). m_tag3(node20_9,'s'). const('s'). m_tag4(node20_9,'2'). const('2'). m_tag10(node20_9,'a'). const('a'). m_tag14(node20_9,'1'). const('1'). 
%%%%%%%% node20_10 %%%%%%%%%%%%%%%%%%%
node(node20_10).
functor(node20_10, pred).         const(pred).
gram_sempos(node20_10, v).         const(v).
id(node20_10, t_plzensky48663_txt_001_p2s2a7).         const(t_plzensky48663_txt_001_p2s2a7).
t_lemma(node20_10, byt).         const(byt).
%%%%%%%% node20_11 %%%%%%%%%%%%%%%%%%%
node(node20_11).
a_afun(node20_11, pred).         const(pred).
m_form(node20_11, byly).         const(byly).
m_lemma(node20_11, byt).         const(byt).
m_tag(node20_11, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node20_11,'v'). const('v'). m_tag1(node20_11,'p'). const('p'). m_tag2(node20_11,'t'). const('t'). m_tag3(node20_11,'p'). const('p'). m_tag7(node20_11,'x'). const('x'). m_tag8(node20_11,'r'). const('r'). m_tag10(node20_11,'a'). const('a'). m_tag11(node20_11,'a'). const('a'). 
%%%%%%%% node20_12 %%%%%%%%%%%%%%%%%%%
node(node20_12).
functor(node20_12, act).         const(act).
gram_sempos(node20_12, n_denot).         const(n_denot).
id(node20_12, t_plzensky48663_txt_001_p2s2a8).         const(t_plzensky48663_txt_001_p2s2a8).
t_lemma(node20_12, osoba).         const(osoba).
%%%%%%%% node20_13 %%%%%%%%%%%%%%%%%%%
node(node20_13).
functor(node20_13, rstr).         const(rstr).
gram_sempos(node20_13, adj_quant_def).         const(adj_quant_def).
id(node20_13, t_plzensky48663_txt_001_p2s2a9).         const(t_plzensky48663_txt_001_p2s2a9).
t_lemma(node20_13, dva).         const(dva).
%%%%%%%% node20_14 %%%%%%%%%%%%%%%%%%%
node(node20_14).
a_afun(node20_14, atr).         const(atr).
m_form(node20_14, dve).         const(dve).
m_lemma(node20_14, dva_2).         const(dva_2).
m_tag(node20_14, clhp1__________).         const(clhp1__________).
m_tag0(node20_14,'c'). const('c'). m_tag1(node20_14,'l'). const('l'). m_tag2(node20_14,'h'). const('h'). m_tag3(node20_14,'p'). const('p'). m_tag4(node20_14,'1'). const('1'). 
%%%%%%%% node20_15 %%%%%%%%%%%%%%%%%%%
node(node20_15).
a_afun(node20_15, sb).         const(sb).
m_form(node20_15, osoby).         const(osoby).
m_lemma(node20_15, osoba).         const(osoba).
m_tag(node20_15, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node20_15,'n'). const('n'). m_tag1(node20_15,'n'). const('n'). m_tag2(node20_15,'f'). const('f'). m_tag3(node20_15,'p'). const('p'). m_tag4(node20_15,'1'). const('1'). m_tag10(node20_15,'a'). const('a'). 
%%%%%%%% node20_16 %%%%%%%%%%%%%%%%%%%
node(node20_16).
functor(node20_16, pred).         const(pred).
gram_sempos(node20_16, v).         const(v).
id(node20_16, t_plzensky48663_txt_001_p2s2a10).         const(t_plzensky48663_txt_001_p2s2a10).
t_lemma(node20_16, usmrtit).         const(usmrtit).
%%%%%%%% node20_17 %%%%%%%%%%%%%%%%%%%
node(node20_17).
functor(node20_17, pat).         const(pat).
gram_sempos(node20_17, n_pron_def_pers).         const(n_pron_def_pers).
id(node20_17, t_plzensky48663_txt_001_p2s2a14).         const(t_plzensky48663_txt_001_p2s2a14).
t_lemma(node20_17, x_cor).         const(x_cor).
%%%%%%%% node20_18 %%%%%%%%%%%%%%%%%%%
node(node20_18).
a_afun(node20_18, pred).         const(pred).
m_form(node20_18, usmrceny).         const(usmrceny).
m_lemma(node20_18, usmrtit__w).         const(usmrtit__w).
m_tag(node20_18, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node20_18,'v'). const('v'). m_tag1(node20_18,'s'). const('s'). m_tag2(node20_18,'t'). const('t'). m_tag3(node20_18,'p'). const('p'). m_tag7(node20_18,'x'). const('x'). m_tag8(node20_18,'x'). const('x'). m_tag10(node20_18,'a'). const('a'). m_tag11(node20_18,'p'). const('p'). 
%%%%%%%% node20_19 %%%%%%%%%%%%%%%%%%%
node(node20_19).
a_afun(node20_19, coord).         const(coord).
m_form(node20_19, a).         const(a).
m_lemma(node20_19, a_1).         const(a_1).
m_tag(node20_19, j______________).         const(j______________).
m_tag0(node20_19,'j'). const('j'). m_tag1(node20_19,'^'). const('^'). 
%%%%%%%% node20_20 %%%%%%%%%%%%%%%%%%%
node(node20_20).
functor(node20_20, pred).         const(pred).
gram_sempos(node20_20, v).         const(v).
id(node20_20, t_plzensky48663_txt_001_p2s2a11).         const(t_plzensky48663_txt_001_p2s2a11).
t_lemma(node20_20, zranit).         const(zranit).
%%%%%%%% node20_21 %%%%%%%%%%%%%%%%%%%
node(node20_21).
functor(node20_21, pat).         const(pat).
gram_sempos(node20_21, adj_quant_def).         const(adj_quant_def).
id(node20_21, t_plzensky48663_txt_001_p2s2a12).         const(t_plzensky48663_txt_001_p2s2a12).
t_lemma(node20_21, sestnact).         const(sestnact).
%%%%%%%% node20_22 %%%%%%%%%%%%%%%%%%%
node(node20_22).
a_afun(node20_22, sb).         const(sb).
m_form(node20_22, sestnact).         const(sestnact).
m_lemma(node20_22, sestnact_16).         const(sestnact_16).
m_tag(node20_22, cn_s1__________).         const(cn_s1__________).
m_tag0(node20_22,'c'). const('c'). m_tag1(node20_22,'n'). const('n'). m_tag3(node20_22,'s'). const('s'). m_tag4(node20_22,'1'). const('1'). 
%%%%%%%% node20_23 %%%%%%%%%%%%%%%%%%%
node(node20_23).
functor(node20_23, act).         const(act).
gram_sempos(node20_23, n_denot).         const(n_denot).
id(node20_23, t_plzensky48663_txt_001_p2s2a13).         const(t_plzensky48663_txt_001_p2s2a13).
t_lemma(node20_23, osoba).         const(osoba).
%%%%%%%% node20_24 %%%%%%%%%%%%%%%%%%%
node(node20_24).
a_afun(node20_24, atr).         const(atr).
m_form(node20_24, osob).         const(osob).
m_lemma(node20_24, osoba).         const(osoba).
m_tag(node20_24, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node20_24,'n'). const('n'). m_tag1(node20_24,'n'). const('n'). m_tag2(node20_24,'f'). const('f'). m_tag3(node20_24,'p'). const('p'). m_tag4(node20_24,'2'). const('2'). m_tag10(node20_24,'a'). const('a'). 
%%%%%%%% node20_25 %%%%%%%%%%%%%%%%%%%
node(node20_25).
a_afun(node20_25, pred).         const(pred).
m_form(node20_25, zraneno).         const(zraneno).
m_lemma(node20_25, zranit__w).         const(zranit__w).
m_tag(node20_25, vsns___xx_ap___).         const(vsns___xx_ap___).
m_tag0(node20_25,'v'). const('v'). m_tag1(node20_25,'s'). const('s'). m_tag2(node20_25,'n'). const('n'). m_tag3(node20_25,'s'). const('s'). m_tag7(node20_25,'x'). const('x'). m_tag8(node20_25,'x'). const('x'). m_tag10(node20_25,'a'). const('a'). m_tag11(node20_25,'p'). const('p'). 
edge(node20_0, node20_1).
edge(node20_1, node20_2).
edge(node20_2, node20_3).
edge(node20_2, node20_4).
edge(node20_1, node20_5).
edge(node20_5, node20_6).
edge(node20_5, node20_7).
edge(node20_5, node20_8).
edge(node20_8, node20_9).
edge(node20_1, node20_10).
edge(node20_10, node20_11).
edge(node20_1, node20_12).
edge(node20_12, node20_13).
edge(node20_13, node20_14).
edge(node20_12, node20_15).
edge(node20_1, node20_16).
edge(node20_16, node20_17).
edge(node20_16, node20_18).
edge(node20_1, node20_19).
edge(node20_1, node20_20).
edge(node20_20, node20_21).
edge(node20_21, node20_22).
edge(node20_21, node20_23).
edge(node20_23, node20_24).
edge(node20_20, node20_25).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri dopravnich nehodach, u kterych hasici zasahovali, bylo usmrceno 333 osob a 4988 osob bylo zraneno. 
tree_root(node21_0).
%%%%%%%% node21_0 %%%%%%%%%%%%%%%%%%%
node(node21_0).
id(node21_0, t_plzensky61718_txt_001_p3s3).         const(t_plzensky61718_txt_001_p3s3).
%%%%%%%% node21_1 %%%%%%%%%%%%%%%%%%%
node(node21_1).
functor(node21_1, conj).         const(conj).
id(node21_1, t_plzensky61718_txt_001_p3s3a1).         const(t_plzensky61718_txt_001_p3s3a1).
t_lemma(node21_1, a).         const(a).
%%%%%%%% node21_2 %%%%%%%%%%%%%%%%%%%
node(node21_2).
functor(node21_2, pat).         const(pat).
gram_sempos(node21_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node21_2, t_plzensky61718_txt_001_p3s3a20).         const(t_plzensky61718_txt_001_p3s3a20).
t_lemma(node21_2, x_perspron).         const(x_perspron).
%%%%%%%% node21_3 %%%%%%%%%%%%%%%%%%%
node(node21_3).
functor(node21_3, pred).         const(pred).
gram_sempos(node21_3, v).         const(v).
id(node21_3, t_plzensky61718_txt_001_p3s3a2).         const(t_plzensky61718_txt_001_p3s3a2).
t_lemma(node21_3, usmrtit).         const(usmrtit).
%%%%%%%% node21_4 %%%%%%%%%%%%%%%%%%%
node(node21_4).
functor(node21_4, twhen).         const(twhen).
gram_sempos(node21_4, n_denot).         const(n_denot).
id(node21_4, t_plzensky61718_txt_001_p3s3a4).         const(t_plzensky61718_txt_001_p3s3a4).
t_lemma(node21_4, nehoda).         const(nehoda).
%%%%%%%% node21_5 %%%%%%%%%%%%%%%%%%%
node(node21_5).
functor(node21_5, rstr).         const(rstr).
gram_sempos(node21_5, adj_denot).         const(adj_denot).
id(node21_5, t_plzensky61718_txt_001_p3s3a5).         const(t_plzensky61718_txt_001_p3s3a5).
t_lemma(node21_5, dopravni).         const(dopravni).
%%%%%%%% node21_6 %%%%%%%%%%%%%%%%%%%
node(node21_6).
a_afun(node21_6, atr).         const(atr).
m_form(node21_6, dopravnich).         const(dopravnich).
m_lemma(node21_6, dopravni).         const(dopravni).
m_tag(node21_6, aafp6____1a____).         const(aafp6____1a____).
m_tag0(node21_6,'a'). const('a'). m_tag1(node21_6,'a'). const('a'). m_tag2(node21_6,'f'). const('f'). m_tag3(node21_6,'p'). const('p'). m_tag4(node21_6,'6'). const('6'). m_tag9(node21_6,'1'). const('1'). m_tag10(node21_6,'a'). const('a'). 
%%%%%%%% node21_7 %%%%%%%%%%%%%%%%%%%
node(node21_7).
a_afun(node21_7, auxp).         const(auxp).
m_form(node21_7, pri).         const(pri).
m_lemma(node21_7, pri_1).         const(pri_1).
m_tag(node21_7, rr__6__________).         const(rr__6__________).
m_tag0(node21_7,'r'). const('r'). m_tag1(node21_7,'r'). const('r'). m_tag4(node21_7,'6'). const('6'). 
%%%%%%%% node21_8 %%%%%%%%%%%%%%%%%%%
node(node21_8).
a_afun(node21_8, adv).         const(adv).
m_form(node21_8, nehodach).         const(nehodach).
m_lemma(node21_8, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node21_8, nnfp6_____a____).         const(nnfp6_____a____).
m_tag0(node21_8,'n'). const('n'). m_tag1(node21_8,'n'). const('n'). m_tag2(node21_8,'f'). const('f'). m_tag3(node21_8,'p'). const('p'). m_tag4(node21_8,'6'). const('6'). m_tag10(node21_8,'a'). const('a'). 
%%%%%%%% node21_9 %%%%%%%%%%%%%%%%%%%
node(node21_9).
functor(node21_9, rstr).         const(rstr).
gram_sempos(node21_9, v).         const(v).
id(node21_9, t_plzensky61718_txt_001_p3s3a6).         const(t_plzensky61718_txt_001_p3s3a6).
t_lemma(node21_9, zasahovat).         const(zasahovat).
%%%%%%%% node21_10 %%%%%%%%%%%%%%%%%%%
node(node21_10).
functor(node21_10, pat).         const(pat).
id(node21_10, t_plzensky61718_txt_001_p3s3a19).         const(t_plzensky61718_txt_001_p3s3a19).
t_lemma(node21_10, x_gen).         const(x_gen).
%%%%%%%% node21_11 %%%%%%%%%%%%%%%%%%%
node(node21_11).
functor(node21_11, loc).         const(loc).
gram_sempos(node21_11, n_pron_indef).         const(n_pron_indef).
id(node21_11, t_plzensky61718_txt_001_p3s3a9).         const(t_plzensky61718_txt_001_p3s3a9).
t_lemma(node21_11, ktery).         const(ktery).
%%%%%%%% node21_12 %%%%%%%%%%%%%%%%%%%
node(node21_12).
a_afun(node21_12, auxp).         const(auxp).
m_form(node21_12, u).         const(u).
m_lemma(node21_12, u_1).         const(u_1).
m_tag(node21_12, rr__2__________).         const(rr__2__________).
m_tag0(node21_12,'r'). const('r'). m_tag1(node21_12,'r'). const('r'). m_tag4(node21_12,'2'). const('2'). 
%%%%%%%% node21_13 %%%%%%%%%%%%%%%%%%%
node(node21_13).
a_afun(node21_13, adv).         const(adv).
m_form(node21_13, kterych).         const(kterych).
m_lemma(node21_13, ktery).         const(ktery).
m_tag(node21_13, p4xp2__________).         const(p4xp2__________).
m_tag0(node21_13,'p'). const('p'). m_tag1(node21_13,'4'). const('4'). m_tag2(node21_13,'x'). const('x'). m_tag3(node21_13,'p'). const('p'). m_tag4(node21_13,'2'). const('2'). 
%%%%%%%% node21_14 %%%%%%%%%%%%%%%%%%%
node(node21_14).
functor(node21_14, act).         const(act).
gram_sempos(node21_14, n_denot).         const(n_denot).
id(node21_14, t_plzensky61718_txt_001_p3s3a10).         const(t_plzensky61718_txt_001_p3s3a10).
t_lemma(node21_14, hasic).         const(hasic).
%%%%%%%% node21_15 %%%%%%%%%%%%%%%%%%%
node(node21_15).
a_afun(node21_15, sb).         const(sb).
m_form(node21_15, hasici).         const(hasici).
m_lemma(node21_15, hasic).         const(hasic).
m_tag(node21_15, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node21_15,'n'). const('n'). m_tag1(node21_15,'n'). const('n'). m_tag2(node21_15,'m'). const('m'). m_tag3(node21_15,'p'). const('p'). m_tag4(node21_15,'1'). const('1'). m_tag10(node21_15,'a'). const('a'). 
%%%%%%%% node21_16 %%%%%%%%%%%%%%%%%%%
node(node21_16).
a_afun(node21_16, atr).         const(atr).
m_form(node21_16, zasahovali).         const(zasahovali).
m_lemma(node21_16, zasahovat__t).         const(zasahovat__t).
m_tag(node21_16, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node21_16,'v'). const('v'). m_tag1(node21_16,'p'). const('p'). m_tag2(node21_16,'m'). const('m'). m_tag3(node21_16,'p'). const('p'). m_tag7(node21_16,'x'). const('x'). m_tag8(node21_16,'r'). const('r'). m_tag10(node21_16,'a'). const('a'). m_tag11(node21_16,'a'). const('a'). 
%%%%%%%% node21_17 %%%%%%%%%%%%%%%%%%%
node(node21_17).
a_afun(node21_17, auxv).         const(auxv).
m_form(node21_17, bylo).         const(bylo).
m_lemma(node21_17, byt).         const(byt).
m_tag(node21_17, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node21_17,'v'). const('v'). m_tag1(node21_17,'p'). const('p'). m_tag2(node21_17,'n'). const('n'). m_tag3(node21_17,'s'). const('s'). m_tag7(node21_17,'x'). const('x'). m_tag8(node21_17,'r'). const('r'). m_tag10(node21_17,'a'). const('a'). m_tag11(node21_17,'a'). const('a'). 
%%%%%%%% node21_18 %%%%%%%%%%%%%%%%%%%
node(node21_18).
a_afun(node21_18, pred).         const(pred).
m_form(node21_18, usmrceno).         const(usmrceno).
m_lemma(node21_18, usmrtit__w).         const(usmrtit__w).
m_tag(node21_18, vsns___xx_ap___).         const(vsns___xx_ap___).
m_tag0(node21_18,'v'). const('v'). m_tag1(node21_18,'s'). const('s'). m_tag2(node21_18,'n'). const('n'). m_tag3(node21_18,'s'). const('s'). m_tag7(node21_18,'x'). const('x'). m_tag8(node21_18,'x'). const('x'). m_tag10(node21_18,'a'). const('a'). m_tag11(node21_18,'p'). const('p'). 
%%%%%%%% node21_19 %%%%%%%%%%%%%%%%%%%
node(node21_19).
functor(node21_19, act).         const(act).
gram_sempos(node21_19, n_denot).         const(n_denot).
id(node21_19, t_plzensky61718_txt_001_p3s3a14).         const(t_plzensky61718_txt_001_p3s3a14).
t_lemma(node21_19, osoba).         const(osoba).
%%%%%%%% node21_20 %%%%%%%%%%%%%%%%%%%
node(node21_20).
functor(node21_20, rstr).         const(rstr).
gram_sempos(node21_20, adj_quant_def).         const(adj_quant_def).
id(node21_20, t_plzensky61718_txt_001_p3s3a13).         const(t_plzensky61718_txt_001_p3s3a13).
t_lemma(node21_20, 333).         const(333).
%%%%%%%% node21_21 %%%%%%%%%%%%%%%%%%%
node(node21_21).
a_afun(node21_21, sb).         const(sb).
m_form(node21_21, 333).         const(333).
m_lemma(node21_21, 333).         const(333).
m_tag(node21_21, c=_____________).         const(c=_____________).
m_tag0(node21_21,'c'). const('c'). m_tag1(node21_21,'='). const('='). 
%%%%%%%% node21_22 %%%%%%%%%%%%%%%%%%%
node(node21_22).
a_afun(node21_22, atr).         const(atr).
m_form(node21_22, osob).         const(osob).
m_lemma(node21_22, osoba).         const(osoba).
m_tag(node21_22, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node21_22,'n'). const('n'). m_tag1(node21_22,'n'). const('n'). m_tag2(node21_22,'f'). const('f'). m_tag3(node21_22,'p'). const('p'). m_tag4(node21_22,'2'). const('2'). m_tag10(node21_22,'a'). const('a'). 
%%%%%%%% node21_23 %%%%%%%%%%%%%%%%%%%
node(node21_23).
a_afun(node21_23, coord).         const(coord).
m_form(node21_23, a).         const(a).
m_lemma(node21_23, a_1).         const(a_1).
m_tag(node21_23, j______________).         const(j______________).
m_tag0(node21_23,'j'). const('j'). m_tag1(node21_23,'^'). const('^'). 
%%%%%%%% node21_24 %%%%%%%%%%%%%%%%%%%
node(node21_24).
functor(node21_24, pred).         const(pred).
gram_sempos(node21_24, v).         const(v).
id(node21_24, t_plzensky61718_txt_001_p3s3a15).         const(t_plzensky61718_txt_001_p3s3a15).
t_lemma(node21_24, zranit).         const(zranit).
%%%%%%%% node21_25 %%%%%%%%%%%%%%%%%%%
node(node21_25).
functor(node21_25, act).         const(act).
gram_sempos(node21_25, n_denot).         const(n_denot).
id(node21_25, t_plzensky61718_txt_001_p3s3a17).         const(t_plzensky61718_txt_001_p3s3a17).
t_lemma(node21_25, osoba).         const(osoba).
%%%%%%%% node21_26 %%%%%%%%%%%%%%%%%%%
node(node21_26).
functor(node21_26, rstr).         const(rstr).
gram_sempos(node21_26, adj_quant_def).         const(adj_quant_def).
id(node21_26, t_plzensky61718_txt_001_p3s3a16).         const(t_plzensky61718_txt_001_p3s3a16).
t_lemma(node21_26, 4988).         const(4988).
%%%%%%%% node21_27 %%%%%%%%%%%%%%%%%%%
node(node21_27).
a_afun(node21_27, sb).         const(sb).
m_form(node21_27, 4988).         const(4988).
m_lemma(node21_27, 4988).         const(4988).
m_tag(node21_27, c=_____________).         const(c=_____________).
m_tag0(node21_27,'c'). const('c'). m_tag1(node21_27,'='). const('='). 
%%%%%%%% node21_28 %%%%%%%%%%%%%%%%%%%
node(node21_28).
a_afun(node21_28, atr).         const(atr).
m_form(node21_28, osob).         const(osob).
m_lemma(node21_28, osoba).         const(osoba).
m_tag(node21_28, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node21_28,'n'). const('n'). m_tag1(node21_28,'n'). const('n'). m_tag2(node21_28,'f'). const('f'). m_tag3(node21_28,'p'). const('p'). m_tag4(node21_28,'2'). const('2'). m_tag10(node21_28,'a'). const('a'). 
%%%%%%%% node21_29 %%%%%%%%%%%%%%%%%%%
node(node21_29).
a_afun(node21_29, auxv).         const(auxv).
m_form(node21_29, bylo).         const(bylo).
m_lemma(node21_29, byt).         const(byt).
m_tag(node21_29, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node21_29,'v'). const('v'). m_tag1(node21_29,'p'). const('p'). m_tag2(node21_29,'n'). const('n'). m_tag3(node21_29,'s'). const('s'). m_tag7(node21_29,'x'). const('x'). m_tag8(node21_29,'r'). const('r'). m_tag10(node21_29,'a'). const('a'). m_tag11(node21_29,'a'). const('a'). 
%%%%%%%% node21_30 %%%%%%%%%%%%%%%%%%%
node(node21_30).
a_afun(node21_30, pred).         const(pred).
m_form(node21_30, zraneno).         const(zraneno).
m_lemma(node21_30, zranit__w).         const(zranit__w).
m_tag(node21_30, vsns___xx_ap___).         const(vsns___xx_ap___).
m_tag0(node21_30,'v'). const('v'). m_tag1(node21_30,'s'). const('s'). m_tag2(node21_30,'n'). const('n'). m_tag3(node21_30,'s'). const('s'). m_tag7(node21_30,'x'). const('x'). m_tag8(node21_30,'x'). const('x'). m_tag10(node21_30,'a'). const('a'). m_tag11(node21_30,'p'). const('p'). 
edge(node21_0, node21_1).
edge(node21_1, node21_2).
edge(node21_1, node21_3).
edge(node21_3, node21_4).
edge(node21_4, node21_5).
edge(node21_5, node21_6).
edge(node21_4, node21_7).
edge(node21_4, node21_8).
edge(node21_4, node21_9).
edge(node21_9, node21_10).
edge(node21_9, node21_11).
edge(node21_11, node21_12).
edge(node21_11, node21_13).
edge(node21_9, node21_14).
edge(node21_14, node21_15).
edge(node21_9, node21_16).
edge(node21_3, node21_17).
edge(node21_3, node21_18).
edge(node21_3, node21_19).
edge(node21_19, node21_20).
edge(node21_20, node21_21).
edge(node21_19, node21_22).
edge(node21_1, node21_23).
edge(node21_1, node21_24).
edge(node21_24, node21_25).
edge(node21_25, node21_26).
edge(node21_26, node21_27).
edge(node21_25, node21_28).
edge(node21_24, node21_29).
edge(node21_24, node21_30).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve dospele osoby a dve deti z automobilu. 
tree_root(node22_0).
%%%%%%%% node22_0 %%%%%%%%%%%%%%%%%%%
node(node22_0).
id(node22_0, t_plzensky56858_txt_001_p3s3).         const(t_plzensky56858_txt_001_p3s3).
%%%%%%%% node22_1 %%%%%%%%%%%%%%%%%%%
node(node22_1).
functor(node22_1, pred).         const(pred).
gram_sempos(node22_1, v).         const(v).
id(node22_1, t_plzensky56858_txt_001_p3s3a1).         const(t_plzensky56858_txt_001_p3s3a1).
t_lemma(node22_1, zranit).         const(zranit).
%%%%%%%% node22_2 %%%%%%%%%%%%%%%%%%%
node(node22_2).
functor(node22_2, act).         const(act).
id(node22_2, t_plzensky56858_txt_001_p3s3a13).         const(t_plzensky56858_txt_001_p3s3a13).
t_lemma(node22_2, x_gen).         const(x_gen).
%%%%%%%% node22_3 %%%%%%%%%%%%%%%%%%%
node(node22_3).
functor(node22_3, twhen).         const(twhen).
gram_sempos(node22_3, n_denot).         const(n_denot).
id(node22_3, t_plzensky56858_txt_001_p3s3a3).         const(t_plzensky56858_txt_001_p3s3a3).
t_lemma(node22_3, nehoda).         const(nehoda).
%%%%%%%% node22_4 %%%%%%%%%%%%%%%%%%%
node(node22_4).
a_afun(node22_4, auxp).         const(auxp).
m_form(node22_4, pri).         const(pri).
m_lemma(node22_4, pri_1).         const(pri_1).
m_tag(node22_4, rr__6__________).         const(rr__6__________).
m_tag0(node22_4,'r'). const('r'). m_tag1(node22_4,'r'). const('r'). m_tag4(node22_4,'6'). const('6'). 
%%%%%%%% node22_5 %%%%%%%%%%%%%%%%%%%
node(node22_5).
a_afun(node22_5, adv).         const(adv).
m_form(node22_5, nehode).         const(nehode).
m_lemma(node22_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node22_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node22_5,'n'). const('n'). m_tag1(node22_5,'n'). const('n'). m_tag2(node22_5,'f'). const('f'). m_tag3(node22_5,'s'). const('s'). m_tag4(node22_5,'6'). const('6'). m_tag10(node22_5,'a'). const('a'). 
%%%%%%%% node22_6 %%%%%%%%%%%%%%%%%%%
node(node22_6).
a_afun(node22_6, auxv).         const(auxv).
m_form(node22_6, byly).         const(byly).
m_lemma(node22_6, byt).         const(byt).
m_tag(node22_6, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node22_6,'v'). const('v'). m_tag1(node22_6,'p'). const('p'). m_tag2(node22_6,'t'). const('t'). m_tag3(node22_6,'p'). const('p'). m_tag7(node22_6,'x'). const('x'). m_tag8(node22_6,'r'). const('r'). m_tag10(node22_6,'a'). const('a'). m_tag11(node22_6,'a'). const('a'). 
%%%%%%%% node22_7 %%%%%%%%%%%%%%%%%%%
node(node22_7).
a_afun(node22_7, pred).         const(pred).
m_form(node22_7, zraneny).         const(zraneny).
m_lemma(node22_7, zranit__w).         const(zranit__w).
m_tag(node22_7, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node22_7,'v'). const('v'). m_tag1(node22_7,'s'). const('s'). m_tag2(node22_7,'t'). const('t'). m_tag3(node22_7,'p'). const('p'). m_tag7(node22_7,'x'). const('x'). m_tag8(node22_7,'x'). const('x'). m_tag10(node22_7,'a'). const('a'). m_tag11(node22_7,'p'). const('p'). 
%%%%%%%% node22_8 %%%%%%%%%%%%%%%%%%%
node(node22_8).
functor(node22_8, conj).         const(conj).
id(node22_8, t_plzensky56858_txt_001_p3s3a5).         const(t_plzensky56858_txt_001_p3s3a5).
t_lemma(node22_8, a).         const(a).
%%%%%%%% node22_9 %%%%%%%%%%%%%%%%%%%
node(node22_9).
functor(node22_9, pat).         const(pat).
gram_sempos(node22_9, n_denot).         const(n_denot).
id(node22_9, t_plzensky56858_txt_001_p3s3a6).         const(t_plzensky56858_txt_001_p3s3a6).
t_lemma(node22_9, osoba).         const(osoba).
%%%%%%%% node22_10 %%%%%%%%%%%%%%%%%%%
node(node22_10).
functor(node22_10, rstr).         const(rstr).
gram_sempos(node22_10, adj_quant_def).         const(adj_quant_def).
id(node22_10, t_plzensky56858_txt_001_p3s3a7).         const(t_plzensky56858_txt_001_p3s3a7).
t_lemma(node22_10, dva).         const(dva).
%%%%%%%% node22_11 %%%%%%%%%%%%%%%%%%%
node(node22_11).
a_afun(node22_11, atr).         const(atr).
m_form(node22_11, dve).         const(dve).
m_lemma(node22_11, dva_2).         const(dva_2).
m_tag(node22_11, clhp1__________).         const(clhp1__________).
m_tag0(node22_11,'c'). const('c'). m_tag1(node22_11,'l'). const('l'). m_tag2(node22_11,'h'). const('h'). m_tag3(node22_11,'p'). const('p'). m_tag4(node22_11,'1'). const('1'). 
%%%%%%%% node22_12 %%%%%%%%%%%%%%%%%%%
node(node22_12).
functor(node22_12, rstr).         const(rstr).
gram_sempos(node22_12, adj_denot).         const(adj_denot).
id(node22_12, t_plzensky56858_txt_001_p3s3a8).         const(t_plzensky56858_txt_001_p3s3a8).
t_lemma(node22_12, dospely).         const(dospely).
%%%%%%%% node22_13 %%%%%%%%%%%%%%%%%%%
node(node22_13).
a_afun(node22_13, atr).         const(atr).
m_form(node22_13, dospele).         const(dospele).
m_lemma(node22_13, dospely_1).         const(dospely_1).
m_tag(node22_13, aafp1____1a____).         const(aafp1____1a____).
m_tag0(node22_13,'a'). const('a'). m_tag1(node22_13,'a'). const('a'). m_tag2(node22_13,'f'). const('f'). m_tag3(node22_13,'p'). const('p'). m_tag4(node22_13,'1'). const('1'). m_tag9(node22_13,'1'). const('1'). m_tag10(node22_13,'a'). const('a'). 
%%%%%%%% node22_14 %%%%%%%%%%%%%%%%%%%
node(node22_14).
a_afun(node22_14, sb).         const(sb).
m_form(node22_14, osoby).         const(osoby).
m_lemma(node22_14, osoba).         const(osoba).
m_tag(node22_14, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node22_14,'n'). const('n'). m_tag1(node22_14,'n'). const('n'). m_tag2(node22_14,'f'). const('f'). m_tag3(node22_14,'p'). const('p'). m_tag4(node22_14,'1'). const('1'). m_tag10(node22_14,'a'). const('a'). 
%%%%%%%% node22_15 %%%%%%%%%%%%%%%%%%%
node(node22_15).
a_afun(node22_15, coord).         const(coord).
m_form(node22_15, a).         const(a).
m_lemma(node22_15, a_1).         const(a_1).
m_tag(node22_15, j______________).         const(j______________).
m_tag0(node22_15,'j'). const('j'). m_tag1(node22_15,'^'). const('^'). 
%%%%%%%% node22_16 %%%%%%%%%%%%%%%%%%%
node(node22_16).
functor(node22_16, pat).         const(pat).
gram_sempos(node22_16, n_denot).         const(n_denot).
id(node22_16, t_plzensky56858_txt_001_p3s3a9).         const(t_plzensky56858_txt_001_p3s3a9).
t_lemma(node22_16, dite).         const(dite).
%%%%%%%% node22_17 %%%%%%%%%%%%%%%%%%%
node(node22_17).
functor(node22_17, rstr).         const(rstr).
gram_sempos(node22_17, adj_quant_def).         const(adj_quant_def).
id(node22_17, t_plzensky56858_txt_001_p3s3a10).         const(t_plzensky56858_txt_001_p3s3a10).
t_lemma(node22_17, dva).         const(dva).
%%%%%%%% node22_18 %%%%%%%%%%%%%%%%%%%
node(node22_18).
a_afun(node22_18, atr).         const(atr).
m_form(node22_18, dve).         const(dve).
m_lemma(node22_18, dva_2).         const(dva_2).
m_tag(node22_18, clhp1__________).         const(clhp1__________).
m_tag0(node22_18,'c'). const('c'). m_tag1(node22_18,'l'). const('l'). m_tag2(node22_18,'h'). const('h'). m_tag3(node22_18,'p'). const('p'). m_tag4(node22_18,'1'). const('1'). 
%%%%%%%% node22_19 %%%%%%%%%%%%%%%%%%%
node(node22_19).
a_afun(node22_19, sb).         const(sb).
m_form(node22_19, deti).         const(deti).
m_lemma(node22_19, dite).         const(dite).
m_tag(node22_19, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node22_19,'n'). const('n'). m_tag1(node22_19,'n'). const('n'). m_tag2(node22_19,'f'). const('f'). m_tag3(node22_19,'p'). const('p'). m_tag4(node22_19,'1'). const('1'). m_tag10(node22_19,'a'). const('a'). 
%%%%%%%% node22_20 %%%%%%%%%%%%%%%%%%%
node(node22_20).
functor(node22_20, dir1).         const(dir1).
gram_sempos(node22_20, n_denot).         const(n_denot).
id(node22_20, t_plzensky56858_txt_001_p3s3a12).         const(t_plzensky56858_txt_001_p3s3a12).
t_lemma(node22_20, automobil).         const(automobil).
%%%%%%%% node22_21 %%%%%%%%%%%%%%%%%%%
node(node22_21).
a_afun(node22_21, auxp).         const(auxp).
m_form(node22_21, z).         const(z).
m_lemma(node22_21, z_1).         const(z_1).
m_tag(node22_21, rr__2__________).         const(rr__2__________).
m_tag0(node22_21,'r'). const('r'). m_tag1(node22_21,'r'). const('r'). m_tag4(node22_21,'2'). const('2'). 
%%%%%%%% node22_22 %%%%%%%%%%%%%%%%%%%
node(node22_22).
a_afun(node22_22, atr).         const(atr).
m_form(node22_22, automobilu).         const(automobilu).
m_lemma(node22_22, automobil).         const(automobil).
m_tag(node22_22, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node22_22,'n'). const('n'). m_tag1(node22_22,'n'). const('n'). m_tag2(node22_22,'i'). const('i'). m_tag3(node22_22,'s'). const('s'). m_tag4(node22_22,'2'). const('2'). m_tag10(node22_22,'a'). const('a'). 
edge(node22_0, node22_1).
edge(node22_1, node22_2).
edge(node22_1, node22_3).
edge(node22_3, node22_4).
edge(node22_3, node22_5).
edge(node22_1, node22_6).
edge(node22_1, node22_7).
edge(node22_1, node22_8).
edge(node22_8, node22_9).
edge(node22_9, node22_10).
edge(node22_10, node22_11).
edge(node22_9, node22_12).
edge(node22_12, node22_13).
edge(node22_9, node22_14).
edge(node22_8, node22_15).
edge(node22_8, node22_16).
edge(node22_16, node22_17).
edge(node22_17, node22_18).
edge(node22_16, node22_19).
edge(node22_16, node22_20).
edge(node22_20, node22_21).
edge(node22_20, node22_22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby, z toho jedna tezce. 
tree_root(node23_0).
%%%%%%%% node23_0 %%%%%%%%%%%%%%%%%%%
node(node23_0).
id(node23_0, t_plzensky58020_txt_001_p1s2).         const(t_plzensky58020_txt_001_p1s2).
%%%%%%%% node23_1 %%%%%%%%%%%%%%%%%%%
node(node23_1).
functor(node23_1, conj).         const(conj).
id(node23_1, t_plzensky58020_txt_001_p1s2a1).         const(t_plzensky58020_txt_001_p1s2a1).
t_lemma(node23_1, x_comma).         const(x_comma).
%%%%%%%% node23_2 %%%%%%%%%%%%%%%%%%%
node(node23_2).
functor(node23_2, pred).         const(pred).
gram_sempos(node23_2, v).         const(v).
id(node23_2, t_plzensky58020_txt_001_p1s2a2).         const(t_plzensky58020_txt_001_p1s2a2).
t_lemma(node23_2, zranit).         const(zranit).
%%%%%%%% node23_3 %%%%%%%%%%%%%%%%%%%
node(node23_3).
functor(node23_3, act).         const(act).
id(node23_3, t_plzensky58020_txt_001_p1s2a12).         const(t_plzensky58020_txt_001_p1s2a12).
t_lemma(node23_3, x_gen).         const(x_gen).
%%%%%%%% node23_4 %%%%%%%%%%%%%%%%%%%
node(node23_4).
functor(node23_4, twhen).         const(twhen).
gram_sempos(node23_4, n_denot).         const(n_denot).
id(node23_4, t_plzensky58020_txt_001_p1s2a4).         const(t_plzensky58020_txt_001_p1s2a4).
t_lemma(node23_4, nehoda).         const(nehoda).
%%%%%%%% node23_5 %%%%%%%%%%%%%%%%%%%
node(node23_5).
a_afun(node23_5, auxp).         const(auxp).
m_form(node23_5, pri).         const(pri).
m_lemma(node23_5, pri_1).         const(pri_1).
m_tag(node23_5, rr__6__________).         const(rr__6__________).
m_tag0(node23_5,'r'). const('r'). m_tag1(node23_5,'r'). const('r'). m_tag4(node23_5,'6'). const('6'). 
%%%%%%%% node23_6 %%%%%%%%%%%%%%%%%%%
node(node23_6).
a_afun(node23_6, adv).         const(adv).
m_form(node23_6, nehode).         const(nehode).
m_lemma(node23_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node23_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node23_6,'n'). const('n'). m_tag1(node23_6,'n'). const('n'). m_tag2(node23_6,'f'). const('f'). m_tag3(node23_6,'s'). const('s'). m_tag4(node23_6,'6'). const('6'). m_tag10(node23_6,'a'). const('a'). 
%%%%%%%% node23_7 %%%%%%%%%%%%%%%%%%%
node(node23_7).
a_afun(node23_7, auxv).         const(auxv).
m_form(node23_7, byly).         const(byly).
m_lemma(node23_7, byt).         const(byt).
m_tag(node23_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node23_7,'v'). const('v'). m_tag1(node23_7,'p'). const('p'). m_tag2(node23_7,'t'). const('t'). m_tag3(node23_7,'p'). const('p'). m_tag7(node23_7,'x'). const('x'). m_tag8(node23_7,'r'). const('r'). m_tag10(node23_7,'a'). const('a'). m_tag11(node23_7,'a'). const('a'). 
%%%%%%%% node23_8 %%%%%%%%%%%%%%%%%%%
node(node23_8).
a_afun(node23_8, pred).         const(pred).
m_form(node23_8, zraneny).         const(zraneny).
m_lemma(node23_8, zranit__w).         const(zranit__w).
m_tag(node23_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node23_8,'v'). const('v'). m_tag1(node23_8,'s'). const('s'). m_tag2(node23_8,'t'). const('t'). m_tag3(node23_8,'p'). const('p'). m_tag7(node23_8,'x'). const('x'). m_tag8(node23_8,'x'). const('x'). m_tag10(node23_8,'a'). const('a'). m_tag11(node23_8,'p'). const('p'). 
%%%%%%%% node23_9 %%%%%%%%%%%%%%%%%%%
node(node23_9).
functor(node23_9, pat).         const(pat).
gram_sempos(node23_9, n_denot).         const(n_denot).
id(node23_9, t_plzensky58020_txt_001_p1s2a6).         const(t_plzensky58020_txt_001_p1s2a6).
t_lemma(node23_9, osoba).         const(osoba).
%%%%%%%% node23_10 %%%%%%%%%%%%%%%%%%%
node(node23_10).
functor(node23_10, rstr).         const(rstr).
gram_sempos(node23_10, adj_quant_def).         const(adj_quant_def).
id(node23_10, t_plzensky58020_txt_001_p1s2a7).         const(t_plzensky58020_txt_001_p1s2a7).
t_lemma(node23_10, dva).         const(dva).
%%%%%%%% node23_11 %%%%%%%%%%%%%%%%%%%
node(node23_11).
a_afun(node23_11, atr).         const(atr).
m_form(node23_11, dve).         const(dve).
m_lemma(node23_11, dva_2).         const(dva_2).
m_tag(node23_11, clhp1__________).         const(clhp1__________).
m_tag0(node23_11,'c'). const('c'). m_tag1(node23_11,'l'). const('l'). m_tag2(node23_11,'h'). const('h'). m_tag3(node23_11,'p'). const('p'). m_tag4(node23_11,'1'). const('1'). 
%%%%%%%% node23_12 %%%%%%%%%%%%%%%%%%%
node(node23_12).
a_afun(node23_12, sb).         const(sb).
m_form(node23_12, osoby).         const(osoby).
m_lemma(node23_12, osoba).         const(osoba).
m_tag(node23_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node23_12,'n'). const('n'). m_tag1(node23_12,'n'). const('n'). m_tag2(node23_12,'f'). const('f'). m_tag3(node23_12,'p'). const('p'). m_tag4(node23_12,'1'). const('1'). m_tag10(node23_12,'a'). const('a'). 
%%%%%%%% node23_13 %%%%%%%%%%%%%%%%%%%
node(node23_13).
a_afun(node23_13, coord).         const(coord).
m_form(node23_13, x_).         const(x_).
m_lemma(node23_13, x_).         const(x_).
m_tag(node23_13, z______________).         const(z______________).
m_tag0(node23_13,'z'). const('z'). m_tag1(node23_13,':'). const(':'). 
%%%%%%%% node23_14 %%%%%%%%%%%%%%%%%%%
node(node23_14).
functor(node23_14, dir1).         const(dir1).
gram_sempos(node23_14, n_pron_def_demon).         const(n_pron_def_demon).
id(node23_14, t_plzensky58020_txt_001_p1s2a9).         const(t_plzensky58020_txt_001_p1s2a9).
t_lemma(node23_14, ten).         const(ten).
%%%%%%%% node23_15 %%%%%%%%%%%%%%%%%%%
node(node23_15).
a_afun(node23_15, auxp).         const(auxp).
m_form(node23_15, z).         const(z).
m_lemma(node23_15, z_1).         const(z_1).
m_tag(node23_15, rr__2__________).         const(rr__2__________).
m_tag0(node23_15,'r'). const('r'). m_tag1(node23_15,'r'). const('r'). m_tag4(node23_15,'2'). const('2'). 
%%%%%%%% node23_16 %%%%%%%%%%%%%%%%%%%
node(node23_16).
a_afun(node23_16, exd).         const(exd).
m_form(node23_16, toho).         const(toho).
m_lemma(node23_16, ten).         const(ten).
m_tag(node23_16, pdzs2__________).         const(pdzs2__________).
m_tag0(node23_16,'p'). const('p'). m_tag1(node23_16,'d'). const('d'). m_tag2(node23_16,'z'). const('z'). m_tag3(node23_16,'s'). const('s'). m_tag4(node23_16,'2'). const('2'). 
%%%%%%%% node23_17 %%%%%%%%%%%%%%%%%%%
node(node23_17).
functor(node23_17, rstr).         const(rstr).
gram_sempos(node23_17, n_quant_def).         const(n_quant_def).
id(node23_17, t_plzensky58020_txt_001_p1s2a10).         const(t_plzensky58020_txt_001_p1s2a10).
t_lemma(node23_17, jeden).         const(jeden).
%%%%%%%% node23_18 %%%%%%%%%%%%%%%%%%%
node(node23_18).
a_afun(node23_18, exd).         const(exd).
m_form(node23_18, jedna).         const(jedna).
m_lemma(node23_18, jeden_1).         const(jeden_1).
m_tag(node23_18, clfs1__________).         const(clfs1__________).
m_tag0(node23_18,'c'). const('c'). m_tag1(node23_18,'l'). const('l'). m_tag2(node23_18,'f'). const('f'). m_tag3(node23_18,'s'). const('s'). m_tag4(node23_18,'1'). const('1'). 
%%%%%%%% node23_19 %%%%%%%%%%%%%%%%%%%
node(node23_19).
functor(node23_19, twhen).         const(twhen).
gram_sempos(node23_19, adj_denot).         const(adj_denot).
id(node23_19, t_plzensky58020_txt_001_p1s2a11).         const(t_plzensky58020_txt_001_p1s2a11).
t_lemma(node23_19, tezky).         const(tezky).
%%%%%%%% node23_20 %%%%%%%%%%%%%%%%%%%
node(node23_20).
a_afun(node23_20, exd).         const(exd).
m_form(node23_20, tezce).         const(tezce).
m_lemma(node23_20, tezce).         const(tezce).
m_tag(node23_20, dg_______1a____).         const(dg_______1a____).
m_tag0(node23_20,'d'). const('d'). m_tag1(node23_20,'g'). const('g'). m_tag9(node23_20,'1'). const('1'). m_tag10(node23_20,'a'). const('a'). 
edge(node23_0, node23_1).
edge(node23_1, node23_2).
edge(node23_2, node23_3).
edge(node23_2, node23_4).
edge(node23_4, node23_5).
edge(node23_4, node23_6).
edge(node23_2, node23_7).
edge(node23_2, node23_8).
edge(node23_2, node23_9).
edge(node23_9, node23_10).
edge(node23_10, node23_11).
edge(node23_9, node23_12).
edge(node23_1, node23_13).
edge(node23_1, node23_14).
edge(node23_14, node23_15).
edge(node23_14, node23_16).
edge(node23_1, node23_17).
edge(node23_17, node23_18).
edge(node23_1, node23_19).
edge(node23_19, node23_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby, z toho jedna tezce. 
tree_root(node24_0).
%%%%%%%% node24_0 %%%%%%%%%%%%%%%%%%%
node(node24_0).
id(node24_0, t_plzensky58020_txt_001_p1s4).         const(t_plzensky58020_txt_001_p1s4).
%%%%%%%% node24_1 %%%%%%%%%%%%%%%%%%%
node(node24_1).
functor(node24_1, conj).         const(conj).
id(node24_1, t_plzensky58020_txt_001_p1s4a1).         const(t_plzensky58020_txt_001_p1s4a1).
t_lemma(node24_1, x_comma).         const(x_comma).
%%%%%%%% node24_2 %%%%%%%%%%%%%%%%%%%
node(node24_2).
functor(node24_2, pred).         const(pred).
gram_sempos(node24_2, v).         const(v).
id(node24_2, t_plzensky58020_txt_001_p1s4a2).         const(t_plzensky58020_txt_001_p1s4a2).
t_lemma(node24_2, zranit).         const(zranit).
%%%%%%%% node24_3 %%%%%%%%%%%%%%%%%%%
node(node24_3).
functor(node24_3, act).         const(act).
id(node24_3, t_plzensky58020_txt_001_p1s4a12).         const(t_plzensky58020_txt_001_p1s4a12).
t_lemma(node24_3, x_gen).         const(x_gen).
%%%%%%%% node24_4 %%%%%%%%%%%%%%%%%%%
node(node24_4).
functor(node24_4, twhen).         const(twhen).
gram_sempos(node24_4, n_denot).         const(n_denot).
id(node24_4, t_plzensky58020_txt_001_p1s4a4).         const(t_plzensky58020_txt_001_p1s4a4).
t_lemma(node24_4, nehoda).         const(nehoda).
%%%%%%%% node24_5 %%%%%%%%%%%%%%%%%%%
node(node24_5).
a_afun(node24_5, auxp).         const(auxp).
m_form(node24_5, pri).         const(pri).
m_lemma(node24_5, pri_1).         const(pri_1).
m_tag(node24_5, rr__6__________).         const(rr__6__________).
m_tag0(node24_5,'r'). const('r'). m_tag1(node24_5,'r'). const('r'). m_tag4(node24_5,'6'). const('6'). 
%%%%%%%% node24_6 %%%%%%%%%%%%%%%%%%%
node(node24_6).
a_afun(node24_6, adv).         const(adv).
m_form(node24_6, nehode).         const(nehode).
m_lemma(node24_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node24_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node24_6,'n'). const('n'). m_tag1(node24_6,'n'). const('n'). m_tag2(node24_6,'f'). const('f'). m_tag3(node24_6,'s'). const('s'). m_tag4(node24_6,'6'). const('6'). m_tag10(node24_6,'a'). const('a'). 
%%%%%%%% node24_7 %%%%%%%%%%%%%%%%%%%
node(node24_7).
a_afun(node24_7, auxv).         const(auxv).
m_form(node24_7, byly).         const(byly).
m_lemma(node24_7, byt).         const(byt).
m_tag(node24_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node24_7,'v'). const('v'). m_tag1(node24_7,'p'). const('p'). m_tag2(node24_7,'t'). const('t'). m_tag3(node24_7,'p'). const('p'). m_tag7(node24_7,'x'). const('x'). m_tag8(node24_7,'r'). const('r'). m_tag10(node24_7,'a'). const('a'). m_tag11(node24_7,'a'). const('a'). 
%%%%%%%% node24_8 %%%%%%%%%%%%%%%%%%%
node(node24_8).
a_afun(node24_8, pred).         const(pred).
m_form(node24_8, zraneny).         const(zraneny).
m_lemma(node24_8, zranit__w).         const(zranit__w).
m_tag(node24_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node24_8,'v'). const('v'). m_tag1(node24_8,'s'). const('s'). m_tag2(node24_8,'t'). const('t'). m_tag3(node24_8,'p'). const('p'). m_tag7(node24_8,'x'). const('x'). m_tag8(node24_8,'x'). const('x'). m_tag10(node24_8,'a'). const('a'). m_tag11(node24_8,'p'). const('p'). 
%%%%%%%% node24_9 %%%%%%%%%%%%%%%%%%%
node(node24_9).
functor(node24_9, pat).         const(pat).
gram_sempos(node24_9, n_denot).         const(n_denot).
id(node24_9, t_plzensky58020_txt_001_p1s4a6).         const(t_plzensky58020_txt_001_p1s4a6).
t_lemma(node24_9, osoba).         const(osoba).
%%%%%%%% node24_10 %%%%%%%%%%%%%%%%%%%
node(node24_10).
functor(node24_10, rstr).         const(rstr).
gram_sempos(node24_10, adj_quant_def).         const(adj_quant_def).
id(node24_10, t_plzensky58020_txt_001_p1s4a7).         const(t_plzensky58020_txt_001_p1s4a7).
t_lemma(node24_10, dva).         const(dva).
%%%%%%%% node24_11 %%%%%%%%%%%%%%%%%%%
node(node24_11).
a_afun(node24_11, atr).         const(atr).
m_form(node24_11, dve).         const(dve).
m_lemma(node24_11, dva_2).         const(dva_2).
m_tag(node24_11, clhp1__________).         const(clhp1__________).
m_tag0(node24_11,'c'). const('c'). m_tag1(node24_11,'l'). const('l'). m_tag2(node24_11,'h'). const('h'). m_tag3(node24_11,'p'). const('p'). m_tag4(node24_11,'1'). const('1'). 
%%%%%%%% node24_12 %%%%%%%%%%%%%%%%%%%
node(node24_12).
a_afun(node24_12, sb).         const(sb).
m_form(node24_12, osoby).         const(osoby).
m_lemma(node24_12, osoba).         const(osoba).
m_tag(node24_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node24_12,'n'). const('n'). m_tag1(node24_12,'n'). const('n'). m_tag2(node24_12,'f'). const('f'). m_tag3(node24_12,'p'). const('p'). m_tag4(node24_12,'1'). const('1'). m_tag10(node24_12,'a'). const('a'). 
%%%%%%%% node24_13 %%%%%%%%%%%%%%%%%%%
node(node24_13).
a_afun(node24_13, coord).         const(coord).
m_form(node24_13, x_).         const(x_).
m_lemma(node24_13, x_).         const(x_).
m_tag(node24_13, z______________).         const(z______________).
m_tag0(node24_13,'z'). const('z'). m_tag1(node24_13,':'). const(':'). 
%%%%%%%% node24_14 %%%%%%%%%%%%%%%%%%%
node(node24_14).
functor(node24_14, dir1).         const(dir1).
gram_sempos(node24_14, n_pron_def_demon).         const(n_pron_def_demon).
id(node24_14, t_plzensky58020_txt_001_p1s4a9).         const(t_plzensky58020_txt_001_p1s4a9).
t_lemma(node24_14, ten).         const(ten).
%%%%%%%% node24_15 %%%%%%%%%%%%%%%%%%%
node(node24_15).
a_afun(node24_15, auxp).         const(auxp).
m_form(node24_15, z).         const(z).
m_lemma(node24_15, z_1).         const(z_1).
m_tag(node24_15, rr__2__________).         const(rr__2__________).
m_tag0(node24_15,'r'). const('r'). m_tag1(node24_15,'r'). const('r'). m_tag4(node24_15,'2'). const('2'). 
%%%%%%%% node24_16 %%%%%%%%%%%%%%%%%%%
node(node24_16).
a_afun(node24_16, exd).         const(exd).
m_form(node24_16, toho).         const(toho).
m_lemma(node24_16, ten).         const(ten).
m_tag(node24_16, pdzs2__________).         const(pdzs2__________).
m_tag0(node24_16,'p'). const('p'). m_tag1(node24_16,'d'). const('d'). m_tag2(node24_16,'z'). const('z'). m_tag3(node24_16,'s'). const('s'). m_tag4(node24_16,'2'). const('2'). 
%%%%%%%% node24_17 %%%%%%%%%%%%%%%%%%%
node(node24_17).
functor(node24_17, rstr).         const(rstr).
gram_sempos(node24_17, n_quant_def).         const(n_quant_def).
id(node24_17, t_plzensky58020_txt_001_p1s4a10).         const(t_plzensky58020_txt_001_p1s4a10).
t_lemma(node24_17, jeden).         const(jeden).
%%%%%%%% node24_18 %%%%%%%%%%%%%%%%%%%
node(node24_18).
a_afun(node24_18, exd).         const(exd).
m_form(node24_18, jedna).         const(jedna).
m_lemma(node24_18, jeden_1).         const(jeden_1).
m_tag(node24_18, clfs1__________).         const(clfs1__________).
m_tag0(node24_18,'c'). const('c'). m_tag1(node24_18,'l'). const('l'). m_tag2(node24_18,'f'). const('f'). m_tag3(node24_18,'s'). const('s'). m_tag4(node24_18,'1'). const('1'). 
%%%%%%%% node24_19 %%%%%%%%%%%%%%%%%%%
node(node24_19).
functor(node24_19, twhen).         const(twhen).
gram_sempos(node24_19, adj_denot).         const(adj_denot).
id(node24_19, t_plzensky58020_txt_001_p1s4a11).         const(t_plzensky58020_txt_001_p1s4a11).
t_lemma(node24_19, tezky).         const(tezky).
%%%%%%%% node24_20 %%%%%%%%%%%%%%%%%%%
node(node24_20).
a_afun(node24_20, exd).         const(exd).
m_form(node24_20, tezce).         const(tezce).
m_lemma(node24_20, tezce).         const(tezce).
m_tag(node24_20, dg_______1a____).         const(dg_______1a____).
m_tag0(node24_20,'d'). const('d'). m_tag1(node24_20,'g'). const('g'). m_tag9(node24_20,'1'). const('1'). m_tag10(node24_20,'a'). const('a'). 
edge(node24_0, node24_1).
edge(node24_1, node24_2).
edge(node24_2, node24_3).
edge(node24_2, node24_4).
edge(node24_4, node24_5).
edge(node24_4, node24_6).
edge(node24_2, node24_7).
edge(node24_2, node24_8).
edge(node24_2, node24_9).
edge(node24_9, node24_10).
edge(node24_10, node24_11).
edge(node24_9, node24_12).
edge(node24_1, node24_13).
edge(node24_1, node24_14).
edge(node24_14, node24_15).
edge(node24_14, node24_16).
edge(node24_1, node24_17).
edge(node24_17, node24_18).
edge(node24_1, node24_19).
edge(node24_19, node24_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridic vozidla audi nebyl zranen. 
tree_root(node25_0).
%%%%%%%% node25_0 %%%%%%%%%%%%%%%%%%%
node(node25_0).
id(node25_0, t_plzensky72928_txt_001_p1s6).         const(t_plzensky72928_txt_001_p1s6).
%%%%%%%% node25_1 %%%%%%%%%%%%%%%%%%%
node(node25_1).
functor(node25_1, pred).         const(pred).
gram_sempos(node25_1, v).         const(v).
id(node25_1, t_plzensky72928_txt_001_p1s6a1).         const(t_plzensky72928_txt_001_p1s6a1).
t_lemma(node25_1, zranit).         const(zranit).
%%%%%%%% node25_2 %%%%%%%%%%%%%%%%%%%
node(node25_2).
functor(node25_2, act).         const(act).
id(node25_2, t_plzensky72928_txt_001_p1s6a5).         const(t_plzensky72928_txt_001_p1s6a5).
t_lemma(node25_2, x_gen).         const(x_gen).
%%%%%%%% node25_3 %%%%%%%%%%%%%%%%%%%
node(node25_3).
functor(node25_3, pat).         const(pat).
gram_sempos(node25_3, n_denot).         const(n_denot).
id(node25_3, t_plzensky72928_txt_001_p1s6a2).         const(t_plzensky72928_txt_001_p1s6a2).
t_lemma(node25_3, ridic).         const(ridic).
%%%%%%%% node25_4 %%%%%%%%%%%%%%%%%%%
node(node25_4).
a_afun(node25_4, sb).         const(sb).
m_form(node25_4, ridic).         const(ridic).
m_lemma(node25_4, ridic).         const(ridic).
m_tag(node25_4, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node25_4,'n'). const('n'). m_tag1(node25_4,'n'). const('n'). m_tag2(node25_4,'m'). const('m'). m_tag3(node25_4,'s'). const('s'). m_tag4(node25_4,'1'). const('1'). m_tag10(node25_4,'a'). const('a'). 
%%%%%%%% node25_5 %%%%%%%%%%%%%%%%%%%
node(node25_5).
functor(node25_5, app).         const(app).
gram_sempos(node25_5, n_denot).         const(n_denot).
id(node25_5, t_plzensky72928_txt_001_p1s6a3).         const(t_plzensky72928_txt_001_p1s6a3).
t_lemma(node25_5, vozidlo).         const(vozidlo).
%%%%%%%% node25_6 %%%%%%%%%%%%%%%%%%%
node(node25_6).
a_afun(node25_6, atr).         const(atr).
m_form(node25_6, vozidla).         const(vozidla).
m_lemma(node25_6, vozidlo).         const(vozidlo).
m_tag(node25_6, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node25_6,'n'). const('n'). m_tag1(node25_6,'n'). const('n'). m_tag2(node25_6,'n'). const('n'). m_tag3(node25_6,'s'). const('s'). m_tag4(node25_6,'2'). const('2'). m_tag10(node25_6,'a'). const('a'). 
%%%%%%%% node25_7 %%%%%%%%%%%%%%%%%%%
node(node25_7).
functor(node25_7, id).         const(id).
gram_sempos(node25_7, n_denot).         const(n_denot).
id(node25_7, t_plzensky72928_txt_001_p1s6a4).         const(t_plzensky72928_txt_001_p1s6a4).
t_lemma(node25_7, audi).         const(audi).
%%%%%%%% node25_8 %%%%%%%%%%%%%%%%%%%
node(node25_8).
a_afun(node25_8, atr).         const(atr).
m_form(node25_8, audi).         const(audi).
m_lemma(node25_8, audi_1__k).         const(audi_1__k).
m_tag(node25_8, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node25_8,'n'). const('n'). m_tag1(node25_8,'n'). const('n'). m_tag2(node25_8,'f'). const('f'). m_tag3(node25_8,'x'). const('x'). m_tag4(node25_8,'x'). const('x'). m_tag10(node25_8,'a'). const('a'). 
%%%%%%%% node25_9 %%%%%%%%%%%%%%%%%%%
node(node25_9).
a_afun(node25_9, auxv).         const(auxv).
m_form(node25_9, nebyl).         const(nebyl).
m_lemma(node25_9, byt).         const(byt).
m_tag(node25_9, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node25_9,'v'). const('v'). m_tag1(node25_9,'p'). const('p'). m_tag2(node25_9,'y'). const('y'). m_tag3(node25_9,'s'). const('s'). m_tag7(node25_9,'x'). const('x'). m_tag8(node25_9,'r'). const('r'). m_tag10(node25_9,'n'). const('n'). m_tag11(node25_9,'a'). const('a'). 
%%%%%%%% node25_10 %%%%%%%%%%%%%%%%%%%
node(node25_10).
a_afun(node25_10, pred).         const(pred).
m_form(node25_10, zranen).         const(zranen).
m_lemma(node25_10, zranit__w).         const(zranit__w).
m_tag(node25_10, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node25_10,'v'). const('v'). m_tag1(node25_10,'s'). const('s'). m_tag2(node25_10,'y'). const('y'). m_tag3(node25_10,'s'). const('s'). m_tag7(node25_10,'x'). const('x'). m_tag8(node25_10,'x'). const('x'). m_tag10(node25_10,'a'). const('a'). m_tag11(node25_10,'p'). const('p'). 
edge(node25_0, node25_1).
edge(node25_1, node25_2).
edge(node25_1, node25_3).
edge(node25_3, node25_4).
edge(node25_3, node25_5).
edge(node25_5, node25_6).
edge(node25_5, node25_7).
edge(node25_7, node25_8).
edge(node25_1, node25_9).
edge(node25_1, node25_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vzhledem k tomu, ze o nejdulezitejsich patecnich, sobotnich a casti nedelnich udalosti byla verejnost jiz informovana v clancich ,,hasice zamestnaly dva velke pozary", ,,cyklistka srazena osobnim automobilem zranenim podlehla" a ,,pri nehode mezi obcemi cernovice a nemnenice zahynul ridic", budu se venovat pouze nekterym nedelnim udalostem. 
tree_root(node26_0).
%%%%%%%% node26_0 %%%%%%%%%%%%%%%%%%%
node(node26_0).
id(node26_0, t_plzensky57870_txt_001_p1s1).         const(t_plzensky57870_txt_001_p1s1).
%%%%%%%% node26_1 %%%%%%%%%%%%%%%%%%%
node(node26_1).
functor(node26_1, pred).         const(pred).
gram_sempos(node26_1, v).         const(v).
id(node26_1, t_plzensky57870_txt_001_p1s1a1).         const(t_plzensky57870_txt_001_p1s1a1).
t_lemma(node26_1, podlehnout).         const(podlehnout).
%%%%%%%% node26_2 %%%%%%%%%%%%%%%%%%%
node(node26_2).
functor(node26_2, pat).         const(pat).
id(node26_2, t_plzensky57870_txt_001_p1s1a61).         const(t_plzensky57870_txt_001_p1s1a61).
t_lemma(node26_2, x_gen).         const(x_gen).
%%%%%%%% node26_3 %%%%%%%%%%%%%%%%%%%
node(node26_3).
functor(node26_3, rstr).         const(rstr).
id(node26_3, t_plzensky57870_txt_001_p1s1a7).         const(t_plzensky57870_txt_001_p1s1a7).
t_lemma(node26_3, x_comma).         const(x_comma).
%%%%%%%% node26_4 %%%%%%%%%%%%%%%%%%%
node(node26_4).
functor(node26_4, rstr).         const(rstr).
gram_sempos(node26_4, v).         const(v).
id(node26_4, t_plzensky57870_txt_001_p1s1a8).         const(t_plzensky57870_txt_001_p1s1a8).
t_lemma(node26_4, informovat).         const(informovat).
%%%%%%%% node26_5 %%%%%%%%%%%%%%%%%%%
node(node26_5).
functor(node26_5, pat).         const(pat).
gram_sempos(node26_5, n_pron_def_pers).         const(n_pron_def_pers).
id(node26_5, t_plzensky57870_txt_001_p1s1a63).         const(t_plzensky57870_txt_001_p1s1a63).
t_lemma(node26_5, x_perspron).         const(x_perspron).
%%%%%%%% node26_6 %%%%%%%%%%%%%%%%%%%
node(node26_6).
functor(node26_6, act).         const(act).
id(node26_6, t_plzensky57870_txt_001_p1s1a62).         const(t_plzensky57870_txt_001_p1s1a62).
t_lemma(node26_6, x_gen).         const(x_gen).
%%%%%%%% node26_7 %%%%%%%%%%%%%%%%%%%
node(node26_7).
functor(node26_7, apps).         const(apps).
id(node26_7, t_plzensky57870_txt_001_p1s1a10).         const(t_plzensky57870_txt_001_p1s1a10).
t_lemma(node26_7, x_comma).         const(x_comma).
%%%%%%%% node26_8 %%%%%%%%%%%%%%%%%%%
node(node26_8).
functor(node26_8, rstr).         const(rstr).
gram_sempos(node26_8, adj_denot).         const(adj_denot).
id(node26_8, t_plzensky57870_txt_001_p1s1a11).         const(t_plzensky57870_txt_001_p1s1a11).
t_lemma(node26_8, dulezity).         const(dulezity).
%%%%%%%% node26_9 %%%%%%%%%%%%%%%%%%%
node(node26_9).
a_afun(node26_9, auxp).         const(auxp).
m_form(node26_9, o).         const(o).
m_lemma(node26_9, o_1).         const(o_1).
m_tag(node26_9, rr__6__________).         const(rr__6__________).
m_tag0(node26_9,'r'). const('r'). m_tag1(node26_9,'r'). const('r'). m_tag4(node26_9,'6'). const('6'). 
%%%%%%%% node26_10 %%%%%%%%%%%%%%%%%%%
node(node26_10).
a_afun(node26_10, sb).         const(sb).
m_form(node26_10, nejdulezitejsich).         const(nejdulezitejsich).
m_lemma(node26_10, dulezity).         const(dulezity).
m_tag(node26_10, aafp6____3a____).         const(aafp6____3a____).
m_tag0(node26_10,'a'). const('a'). m_tag1(node26_10,'a'). const('a'). m_tag2(node26_10,'f'). const('f'). m_tag3(node26_10,'p'). const('p'). m_tag4(node26_10,'6'). const('6'). m_tag9(node26_10,'3'). const('3'). m_tag10(node26_10,'a'). const('a'). 
%%%%%%%% node26_11 %%%%%%%%%%%%%%%%%%%
node(node26_11).
functor(node26_11, rstr).         const(rstr).
gram_sempos(node26_11, adj_denot).         const(adj_denot).
id(node26_11, t_plzensky57870_txt_001_p1s1a12).         const(t_plzensky57870_txt_001_p1s1a12).
t_lemma(node26_11, patecni).         const(patecni).
%%%%%%%% node26_12 %%%%%%%%%%%%%%%%%%%
node(node26_12).
a_afun(node26_12, auxp).         const(auxp).
m_form(node26_12, o).         const(o).
m_lemma(node26_12, o_1).         const(o_1).
m_tag(node26_12, rr__6__________).         const(rr__6__________).
m_tag0(node26_12,'r'). const('r'). m_tag1(node26_12,'r'). const('r'). m_tag4(node26_12,'6'). const('6'). 
%%%%%%%% node26_13 %%%%%%%%%%%%%%%%%%%
node(node26_13).
a_afun(node26_13, sb).         const(sb).
m_form(node26_13, patecnich).         const(patecnich).
m_lemma(node26_13, patecni).         const(patecni).
m_tag(node26_13, aafp6____1a____).         const(aafp6____1a____).
m_tag0(node26_13,'a'). const('a'). m_tag1(node26_13,'a'). const('a'). m_tag2(node26_13,'f'). const('f'). m_tag3(node26_13,'p'). const('p'). m_tag4(node26_13,'6'). const('6'). m_tag9(node26_13,'1'). const('1'). m_tag10(node26_13,'a'). const('a'). 
%%%%%%%% node26_14 %%%%%%%%%%%%%%%%%%%
node(node26_14).
a_afun(node26_14, auxx).         const(auxx).
m_form(node26_14, x_).         const(x_).
m_lemma(node26_14, x_).         const(x_).
m_tag(node26_14, z______________).         const(z______________).
m_tag0(node26_14,'z'). const('z'). m_tag1(node26_14,':'). const(':'). 
%%%%%%%% node26_15 %%%%%%%%%%%%%%%%%%%
node(node26_15).
functor(node26_15, mat).         const(mat).
gram_sempos(node26_15, n_denot_neg).         const(n_denot_neg).
id(node26_15, t_plzensky57870_txt_001_p1s1a16).         const(t_plzensky57870_txt_001_p1s1a16).
t_lemma(node26_15, udalost).         const(udalost).
%%%%%%%% node26_16 %%%%%%%%%%%%%%%%%%%
node(node26_16).
functor(node26_16, rstr).         const(rstr).
gram_sempos(node26_16, adj_denot).         const(adj_denot).
id(node26_16, t_plzensky57870_txt_001_p1s1a13).         const(t_plzensky57870_txt_001_p1s1a13).
t_lemma(node26_16, sobotni).         const(sobotni).
%%%%%%%% node26_17 %%%%%%%%%%%%%%%%%%%
node(node26_17).
a_afun(node26_17, auxp).         const(auxp).
m_form(node26_17, o).         const(o).
m_lemma(node26_17, o_1).         const(o_1).
m_tag(node26_17, rr__6__________).         const(rr__6__________).
m_tag0(node26_17,'r'). const('r'). m_tag1(node26_17,'r'). const('r'). m_tag4(node26_17,'6'). const('6'). 
%%%%%%%% node26_18 %%%%%%%%%%%%%%%%%%%
node(node26_18).
a_afun(node26_18, sb).         const(sb).
m_form(node26_18, sobotnich).         const(sobotnich).
m_lemma(node26_18, sobotni).         const(sobotni).
m_tag(node26_18, aafp6____1a____).         const(aafp6____1a____).
m_tag0(node26_18,'a'). const('a'). m_tag1(node26_18,'a'). const('a'). m_tag2(node26_18,'f'). const('f'). m_tag3(node26_18,'p'). const('p'). m_tag4(node26_18,'6'). const('6'). m_tag9(node26_18,'1'). const('1'). m_tag10(node26_18,'a'). const('a'). 
%%%%%%%% node26_19 %%%%%%%%%%%%%%%%%%%
node(node26_19).
functor(node26_19, conj).         const(conj).
id(node26_19, t_plzensky57870_txt_001_p1s1a15).         const(t_plzensky57870_txt_001_p1s1a15).
t_lemma(node26_19, a).         const(a).
%%%%%%%% node26_20 %%%%%%%%%%%%%%%%%%%
node(node26_20).
a_afun(node26_20, coord).         const(coord).
m_form(node26_20, a).         const(a).
m_lemma(node26_20, a_1).         const(a_1).
m_tag(node26_20, j______________).         const(j______________).
m_tag0(node26_20,'j'). const('j'). m_tag1(node26_20,'^'). const('^'). 
%%%%%%%% node26_21 %%%%%%%%%%%%%%%%%%%
node(node26_21).
functor(node26_21, rstr).         const(rstr).
gram_sempos(node26_21, adj_denot).         const(adj_denot).
id(node26_21, t_plzensky57870_txt_001_p1s1a17).         const(t_plzensky57870_txt_001_p1s1a17).
t_lemma(node26_21, nedelni).         const(nedelni).
%%%%%%%% node26_22 %%%%%%%%%%%%%%%%%%%
node(node26_22).
a_afun(node26_22, atr).         const(atr).
m_form(node26_22, nedelnich).         const(nedelnich).
m_lemma(node26_22, nedelni).         const(nedelni).
m_tag(node26_22, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node26_22,'a'). const('a'). m_tag1(node26_22,'a'). const('a'). m_tag2(node26_22,'f'). const('f'). m_tag3(node26_22,'p'). const('p'). m_tag4(node26_22,'2'). const('2'). m_tag9(node26_22,'1'). const('1'). m_tag10(node26_22,'a'). const('a'). 
%%%%%%%% node26_23 %%%%%%%%%%%%%%%%%%%
node(node26_23).
a_afun(node26_23, auxp).         const(auxp).
m_form(node26_23, casti).         const(casti).
m_lemma(node26_23, cast).         const(cast).
m_tag(node26_23, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node26_23,'n'). const('n'). m_tag1(node26_23,'n'). const('n'). m_tag2(node26_23,'f'). const('f'). m_tag3(node26_23,'s'). const('s'). m_tag4(node26_23,'6'). const('6'). m_tag10(node26_23,'a'). const('a'). 
%%%%%%%% node26_24 %%%%%%%%%%%%%%%%%%%
node(node26_24).
a_afun(node26_24, atr).         const(atr).
m_form(node26_24, udalosti).         const(udalosti).
m_lemma(node26_24, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node26_24, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node26_24,'n'). const('n'). m_tag1(node26_24,'n'). const('n'). m_tag2(node26_24,'f'). const('f'). m_tag3(node26_24,'p'). const('p'). m_tag4(node26_24,'2'). const('2'). m_tag10(node26_24,'a'). const('a'). 
%%%%%%%% node26_25 %%%%%%%%%%%%%%%%%%%
node(node26_25).
functor(node26_25, addr).         const(addr).
gram_sempos(node26_25, n_denot_neg).         const(n_denot_neg).
id(node26_25, t_plzensky57870_txt_001_p1s1a19).         const(t_plzensky57870_txt_001_p1s1a19).
t_lemma(node26_25, verejnost).         const(verejnost).
%%%%%%%% node26_26 %%%%%%%%%%%%%%%%%%%
node(node26_26).
a_afun(node26_26, sb).         const(sb).
m_form(node26_26, verejnost).         const(verejnost).
m_lemma(node26_26, verejnost____3y_).         const(verejnost____3y_).
m_tag(node26_26, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node26_26,'n'). const('n'). m_tag1(node26_26,'n'). const('n'). m_tag2(node26_26,'f'). const('f'). m_tag3(node26_26,'s'). const('s'). m_tag4(node26_26,'1'). const('1'). m_tag10(node26_26,'a'). const('a'). 
%%%%%%%% node26_27 %%%%%%%%%%%%%%%%%%%
node(node26_27).
functor(node26_27, twhen).         const(twhen).
gram_sempos(node26_27, adv_denot_ngrad_nneg).         const(adv_denot_ngrad_nneg).
id(node26_27, t_plzensky57870_txt_001_p1s1a20).         const(t_plzensky57870_txt_001_p1s1a20).
t_lemma(node26_27, jiz).         const(jiz).
%%%%%%%% node26_28 %%%%%%%%%%%%%%%%%%%
node(node26_28).
a_afun(node26_28, adv).         const(adv).
m_form(node26_28, jiz).         const(jiz).
m_lemma(node26_28, jiz).         const(jiz).
m_tag(node26_28, db_____________).         const(db_____________).
m_tag0(node26_28,'d'). const('d'). m_tag1(node26_28,'b'). const('b'). 
%%%%%%%% node26_29 %%%%%%%%%%%%%%%%%%%
node(node26_29).
a_afun(node26_29, auxv).         const(auxv).
m_form(node26_29, byla).         const(byla).
m_lemma(node26_29, byt).         const(byt).
m_tag(node26_29, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node26_29,'v'). const('v'). m_tag1(node26_29,'p'). const('p'). m_tag2(node26_29,'q'). const('q'). m_tag3(node26_29,'w'). const('w'). m_tag7(node26_29,'x'). const('x'). m_tag8(node26_29,'r'). const('r'). m_tag10(node26_29,'a'). const('a'). m_tag11(node26_29,'a'). const('a'). 
%%%%%%%% node26_30 %%%%%%%%%%%%%%%%%%%
node(node26_30).
a_afun(node26_30, atr).         const(atr).
m_form(node26_30, informovana).         const(informovana).
m_lemma(node26_30, informovat__t__w).         const(informovat__t__w).
m_tag(node26_30, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node26_30,'v'). const('v'). m_tag1(node26_30,'s'). const('s'). m_tag2(node26_30,'q'). const('q'). m_tag3(node26_30,'w'). const('w'). m_tag7(node26_30,'x'). const('x'). m_tag8(node26_30,'x'). const('x'). m_tag10(node26_30,'a'). const('a'). m_tag11(node26_30,'p'). const('p'). 
%%%%%%%% node26_31 %%%%%%%%%%%%%%%%%%%
node(node26_31).
functor(node26_31, loc).         const(loc).
gram_sempos(node26_31, n_denot).         const(n_denot).
id(node26_31, t_plzensky57870_txt_001_p1s1a22).         const(t_plzensky57870_txt_001_p1s1a22).
t_lemma(node26_31, clanek).         const(clanek).
%%%%%%%% node26_32 %%%%%%%%%%%%%%%%%%%
node(node26_32).
a_afun(node26_32, auxp).         const(auxp).
m_form(node26_32, v).         const(v).
m_lemma(node26_32, v_1).         const(v_1).
m_tag(node26_32, rr__6__________).         const(rr__6__________).
m_tag0(node26_32,'r'). const('r'). m_tag1(node26_32,'r'). const('r'). m_tag4(node26_32,'6'). const('6'). 
%%%%%%%% node26_33 %%%%%%%%%%%%%%%%%%%
node(node26_33).
a_afun(node26_33, adv).         const(adv).
m_form(node26_33, clancich).         const(clancich).
m_lemma(node26_33, clanek).         const(clanek).
m_tag(node26_33, nnip6_____a____).         const(nnip6_____a____).
m_tag0(node26_33,'n'). const('n'). m_tag1(node26_33,'n'). const('n'). m_tag2(node26_33,'i'). const('i'). m_tag3(node26_33,'p'). const('p'). m_tag4(node26_33,'6'). const('6'). m_tag10(node26_33,'a'). const('a'). 
%%%%%%%% node26_34 %%%%%%%%%%%%%%%%%%%
node(node26_34).
a_afun(node26_34, auxp).         const(auxp).
m_form(node26_34, vzhledem).         const(vzhledem).
m_lemma(node26_34, vzhledem).         const(vzhledem).
m_tag(node26_34, rf_____________).         const(rf_____________).
m_tag0(node26_34,'r'). const('r'). m_tag1(node26_34,'f'). const('f'). 
%%%%%%%% node26_35 %%%%%%%%%%%%%%%%%%%
node(node26_35).
a_afun(node26_35, auxp).         const(auxp).
m_form(node26_35, k).         const(k).
m_lemma(node26_35, k_1).         const(k_1).
m_tag(node26_35, rr__3__________).         const(rr__3__________).
m_tag0(node26_35,'r'). const('r'). m_tag1(node26_35,'r'). const('r'). m_tag4(node26_35,'3'). const('3'). 
%%%%%%%% node26_36 %%%%%%%%%%%%%%%%%%%
node(node26_36).
a_afun(node26_36, adv).         const(adv).
m_form(node26_36, tomu).         const(tomu).
m_lemma(node26_36, ten).         const(ten).
m_tag(node26_36, pdzs3__________).         const(pdzs3__________).
m_tag0(node26_36,'p'). const('p'). m_tag1(node26_36,'d'). const('d'). m_tag2(node26_36,'z'). const('z'). m_tag3(node26_36,'s'). const('s'). m_tag4(node26_36,'3'). const('3'). 
%%%%%%%% node26_37 %%%%%%%%%%%%%%%%%%%
node(node26_37).
a_afun(node26_37, auxc).         const(auxc).
m_form(node26_37, ze).         const(ze).
m_lemma(node26_37, ze).         const(ze).
m_tag(node26_37, j______________).         const(j______________).
m_tag0(node26_37,'j'). const('j'). m_tag1(node26_37,','). const(','). 
%%%%%%%% node26_38 %%%%%%%%%%%%%%%%%%%
node(node26_38).
a_afun(node26_38, auxx).         const(auxx).
m_form(node26_38, x_).         const(x_).
m_lemma(node26_38, x_).         const(x_).
m_tag(node26_38, z______________).         const(z______________).
m_tag0(node26_38,'z'). const('z'). m_tag1(node26_38,':'). const(':'). 
%%%%%%%% node26_39 %%%%%%%%%%%%%%%%%%%
node(node26_39).
functor(node26_39, rstr).         const(rstr).
gram_sempos(node26_39, v).         const(v).
id(node26_39, t_plzensky57870_txt_001_p1s1a24).         const(t_plzensky57870_txt_001_p1s1a24).
t_lemma(node26_39, zamestnat).         const(zamestnat).
%%%%%%%% node26_40 %%%%%%%%%%%%%%%%%%%
node(node26_40).
functor(node26_40, pat).         const(pat).
gram_sempos(node26_40, n_denot).         const(n_denot).
id(node26_40, t_plzensky57870_txt_001_p1s1a25).         const(t_plzensky57870_txt_001_p1s1a25).
t_lemma(node26_40, hasic).         const(hasic).
%%%%%%%% node26_41 %%%%%%%%%%%%%%%%%%%
node(node26_41).
a_afun(node26_41, obj).         const(obj).
m_form(node26_41, hasice).         const(hasice).
m_lemma(node26_41, hasic).         const(hasic).
m_tag(node26_41, nnmp4_____a____).         const(nnmp4_____a____).
m_tag0(node26_41,'n'). const('n'). m_tag1(node26_41,'n'). const('n'). m_tag2(node26_41,'m'). const('m'). m_tag3(node26_41,'p'). const('p'). m_tag4(node26_41,'4'). const('4'). m_tag10(node26_41,'a'). const('a'). 
%%%%%%%% node26_42 %%%%%%%%%%%%%%%%%%%
node(node26_42).
a_afun(node26_42, atr).         const(atr).
m_form(node26_42, zamestnaly).         const(zamestnaly).
m_lemma(node26_42, zamestnat_1__w___vseob__vyznam__cinnost__zamestnani_).         const(zamestnat_1__w___vseob__vyznam__cinnost__zamestnani_).
m_tag(node26_42, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node26_42,'v'). const('v'). m_tag1(node26_42,'p'). const('p'). m_tag2(node26_42,'t'). const('t'). m_tag3(node26_42,'p'). const('p'). m_tag7(node26_42,'x'). const('x'). m_tag8(node26_42,'r'). const('r'). m_tag10(node26_42,'a'). const('a'). m_tag11(node26_42,'a'). const('a'). 
%%%%%%%% node26_43 %%%%%%%%%%%%%%%%%%%
node(node26_43).
functor(node26_43, act).         const(act).
gram_sempos(node26_43, n_denot).         const(n_denot).
id(node26_43, t_plzensky57870_txt_001_p1s1a26).         const(t_plzensky57870_txt_001_p1s1a26).
t_lemma(node26_43, pozar).         const(pozar).
%%%%%%%% node26_44 %%%%%%%%%%%%%%%%%%%
node(node26_44).
functor(node26_44, rstr).         const(rstr).
gram_sempos(node26_44, adj_quant_def).         const(adj_quant_def).
id(node26_44, t_plzensky57870_txt_001_p1s1a27).         const(t_plzensky57870_txt_001_p1s1a27).
t_lemma(node26_44, dva).         const(dva).
%%%%%%%% node26_45 %%%%%%%%%%%%%%%%%%%
node(node26_45).
a_afun(node26_45, atr).         const(atr).
m_form(node26_45, dva).         const(dva).
m_lemma(node26_45, dva_2).         const(dva_2).
m_tag(node26_45, clyp1__________).         const(clyp1__________).
m_tag0(node26_45,'c'). const('c'). m_tag1(node26_45,'l'). const('l'). m_tag2(node26_45,'y'). const('y'). m_tag3(node26_45,'p'). const('p'). m_tag4(node26_45,'1'). const('1'). 
%%%%%%%% node26_46 %%%%%%%%%%%%%%%%%%%
node(node26_46).
functor(node26_46, rstr).         const(rstr).
gram_sempos(node26_46, adj_denot).         const(adj_denot).
id(node26_46, t_plzensky57870_txt_001_p1s1a28).         const(t_plzensky57870_txt_001_p1s1a28).
t_lemma(node26_46, velky).         const(velky).
%%%%%%%% node26_47 %%%%%%%%%%%%%%%%%%%
node(node26_47).
a_afun(node26_47, atr).         const(atr).
m_form(node26_47, velke).         const(velke).
m_lemma(node26_47, velky).         const(velky).
m_tag(node26_47, aaip1____1a____).         const(aaip1____1a____).
m_tag0(node26_47,'a'). const('a'). m_tag1(node26_47,'a'). const('a'). m_tag2(node26_47,'i'). const('i'). m_tag3(node26_47,'p'). const('p'). m_tag4(node26_47,'1'). const('1'). m_tag9(node26_47,'1'). const('1'). m_tag10(node26_47,'a'). const('a'). 
%%%%%%%% node26_48 %%%%%%%%%%%%%%%%%%%
node(node26_48).
a_afun(node26_48, sb).         const(sb).
m_form(node26_48, pozary).         const(pozary).
m_lemma(node26_48, pozar).         const(pozar).
m_tag(node26_48, nnip1_____a____).         const(nnip1_____a____).
m_tag0(node26_48,'n'). const('n'). m_tag1(node26_48,'n'). const('n'). m_tag2(node26_48,'i'). const('i'). m_tag3(node26_48,'p'). const('p'). m_tag4(node26_48,'1'). const('1'). m_tag10(node26_48,'a'). const('a'). 
%%%%%%%% node26_49 %%%%%%%%%%%%%%%%%%%
node(node26_49).
functor(node26_49, rstr).         const(rstr).
id(node26_49, t_plzensky57870_txt_001_p1s1a29).         const(t_plzensky57870_txt_001_p1s1a29).
t_lemma(node26_49, x_).         const(x_).
%%%%%%%% node26_50 %%%%%%%%%%%%%%%%%%%
node(node26_50).
a_afun(node26_50, auxg).         const(auxg).
m_form(node26_50, x_).         const(x_).
m_lemma(node26_50, x_).         const(x_).
m_tag(node26_50, z______________).         const(z______________).
m_tag0(node26_50,'z'). const('z'). m_tag1(node26_50,':'). const(':'). 
%%%%%%%% node26_51 %%%%%%%%%%%%%%%%%%%
node(node26_51).
functor(node26_51, act).         const(act).
gram_sempos(node26_51, n_denot).         const(n_denot).
id(node26_51, t_plzensky57870_txt_001_p1s1a33).         const(t_plzensky57870_txt_001_p1s1a33).
t_lemma(node26_51, cyklistka).         const(cyklistka).
%%%%%%%% node26_52 %%%%%%%%%%%%%%%%%%%
node(node26_52).
a_afun(node26_52, sb).         const(sb).
m_form(node26_52, cyklistka).         const(cyklistka).
m_lemma(node26_52, cyklistka____2a_).         const(cyklistka____2a_).
m_tag(node26_52, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node26_52,'n'). const('n'). m_tag1(node26_52,'n'). const('n'). m_tag2(node26_52,'f'). const('f'). m_tag3(node26_52,'s'). const('s'). m_tag4(node26_52,'1'). const('1'). m_tag10(node26_52,'a'). const('a'). 
%%%%%%%% node26_53 %%%%%%%%%%%%%%%%%%%
node(node26_53).
functor(node26_53, rstr).         const(rstr).
gram_sempos(node26_53, adj_denot).         const(adj_denot).
id(node26_53, t_plzensky57870_txt_001_p1s1a34).         const(t_plzensky57870_txt_001_p1s1a34).
t_lemma(node26_53, srazeny).         const(srazeny).
%%%%%%%% node26_54 %%%%%%%%%%%%%%%%%%%
node(node26_54).
a_afun(node26_54, atr).         const(atr).
m_form(node26_54, srazena).         const(srazena).
m_lemma(node26_54, srazeny____4zit_).         const(srazeny____4zit_).
m_tag(node26_54, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node26_54,'a'). const('a'). m_tag1(node26_54,'a'). const('a'). m_tag2(node26_54,'f'). const('f'). m_tag3(node26_54,'s'). const('s'). m_tag4(node26_54,'1'). const('1'). m_tag9(node26_54,'1'). const('1'). m_tag10(node26_54,'a'). const('a'). 
%%%%%%%% node26_55 %%%%%%%%%%%%%%%%%%%
node(node26_55).
functor(node26_55, act).         const(act).
gram_sempos(node26_55, n_denot).         const(n_denot).
id(node26_55, t_plzensky57870_txt_001_p1s1a35).         const(t_plzensky57870_txt_001_p1s1a35).
t_lemma(node26_55, automobil).         const(automobil).
%%%%%%%% node26_56 %%%%%%%%%%%%%%%%%%%
node(node26_56).
functor(node26_56, rstr).         const(rstr).
gram_sempos(node26_56, adj_denot).         const(adj_denot).
id(node26_56, t_plzensky57870_txt_001_p1s1a36).         const(t_plzensky57870_txt_001_p1s1a36).
t_lemma(node26_56, osobni).         const(osobni).
%%%%%%%% node26_57 %%%%%%%%%%%%%%%%%%%
node(node26_57).
a_afun(node26_57, atr).         const(atr).
m_form(node26_57, osobnim).         const(osobnim).
m_lemma(node26_57, osobni).         const(osobni).
m_tag(node26_57, aais7____1a____).         const(aais7____1a____).
m_tag0(node26_57,'a'). const('a'). m_tag1(node26_57,'a'). const('a'). m_tag2(node26_57,'i'). const('i'). m_tag3(node26_57,'s'). const('s'). m_tag4(node26_57,'7'). const('7'). m_tag9(node26_57,'1'). const('1'). m_tag10(node26_57,'a'). const('a'). 
%%%%%%%% node26_58 %%%%%%%%%%%%%%%%%%%
node(node26_58).
a_afun(node26_58, obj).         const(obj).
m_form(node26_58, automobilem).         const(automobilem).
m_lemma(node26_58, automobil).         const(automobil).
m_tag(node26_58, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node26_58,'n'). const('n'). m_tag1(node26_58,'n'). const('n'). m_tag2(node26_58,'i'). const('i'). m_tag3(node26_58,'s'). const('s'). m_tag4(node26_58,'7'). const('7'). m_tag10(node26_58,'a'). const('a'). 
%%%%%%%% node26_59 %%%%%%%%%%%%%%%%%%%
node(node26_59).
functor(node26_59, means).         const(means).
gram_sempos(node26_59, n_denot_neg).         const(n_denot_neg).
id(node26_59, t_plzensky57870_txt_001_p1s1a37).         const(t_plzensky57870_txt_001_p1s1a37).
t_lemma(node26_59, zraneni).         const(zraneni).
%%%%%%%% node26_60 %%%%%%%%%%%%%%%%%%%
node(node26_60).
functor(node26_60, act).         const(act).
id(node26_60, t_plzensky57870_txt_001_p1s1a64).         const(t_plzensky57870_txt_001_p1s1a64).
t_lemma(node26_60, x_gen).         const(x_gen).
%%%%%%%% node26_61 %%%%%%%%%%%%%%%%%%%
node(node26_61).
a_afun(node26_61, adv).         const(adv).
m_form(node26_61, zranenim).         const(zranenim).
m_lemma(node26_61, zraneni____3it_).         const(zraneni____3it_).
m_tag(node26_61, nnns7_____a____).         const(nnns7_____a____).
m_tag0(node26_61,'n'). const('n'). m_tag1(node26_61,'n'). const('n'). m_tag2(node26_61,'n'). const('n'). m_tag3(node26_61,'s'). const('s'). m_tag4(node26_61,'7'). const('7'). m_tag10(node26_61,'a'). const('a'). 
%%%%%%%% node26_62 %%%%%%%%%%%%%%%%%%%
node(node26_62).
a_afun(node26_62, pred).         const(pred).
m_form(node26_62, podlehla).         const(podlehla).
m_lemma(node26_62, podlehnout__w).         const(podlehnout__w).
m_tag(node26_62, vpqw___xr_aa__1).         const(vpqw___xr_aa__1).
m_tag0(node26_62,'v'). const('v'). m_tag1(node26_62,'p'). const('p'). m_tag2(node26_62,'q'). const('q'). m_tag3(node26_62,'w'). const('w'). m_tag7(node26_62,'x'). const('x'). m_tag8(node26_62,'r'). const('r'). m_tag10(node26_62,'a'). const('a'). m_tag11(node26_62,'a'). const('a'). m_tag14(node26_62,'1'). const('1'). 
%%%%%%%% node26_63 %%%%%%%%%%%%%%%%%%%
node(node26_63).
functor(node26_63, rstr).         const(rstr).
id(node26_63, t_plzensky57870_txt_001_p1s1a38).         const(t_plzensky57870_txt_001_p1s1a38).
t_lemma(node26_63, x_comma).         const(x_comma).
%%%%%%%% node26_64 %%%%%%%%%%%%%%%%%%%
node(node26_64).
functor(node26_64, rstr).         const(rstr).
id(node26_64, t_plzensky57870_txt_001_p1s1a39).         const(t_plzensky57870_txt_001_p1s1a39).
t_lemma(node26_64, x_).         const(x_).
%%%%%%%% node26_65 %%%%%%%%%%%%%%%%%%%
node(node26_65).
a_afun(node26_65, auxg).         const(auxg).
m_form(node26_65, x_).         const(x_).
m_lemma(node26_65, x_).         const(x_).
m_tag(node26_65, z______________).         const(z______________).
m_tag0(node26_65,'z'). const('z'). m_tag1(node26_65,':'). const(':'). 
%%%%%%%% node26_66 %%%%%%%%%%%%%%%%%%%
node(node26_66).
functor(node26_66, rstr).         const(rstr).
id(node26_66, t_plzensky57870_txt_001_p1s1a40).         const(t_plzensky57870_txt_001_p1s1a40).
t_lemma(node26_66, a).         const(a).
%%%%%%%% node26_67 %%%%%%%%%%%%%%%%%%%
node(node26_67).
a_afun(node26_67, coord).         const(coord).
m_form(node26_67, a).         const(a).
m_lemma(node26_67, a_1).         const(a_1).
m_tag(node26_67, j______________).         const(j______________).
m_tag0(node26_67,'j'). const('j'). m_tag1(node26_67,'^'). const('^'). 
%%%%%%%% node26_68 %%%%%%%%%%%%%%%%%%%
node(node26_68).
functor(node26_68, eff).         const(eff).
gram_sempos(node26_68, v).         const(v).
id(node26_68, t_plzensky57870_txt_001_p1s1a43).         const(t_plzensky57870_txt_001_p1s1a43).
t_lemma(node26_68, zahynout).         const(zahynout).
%%%%%%%% node26_69 %%%%%%%%%%%%%%%%%%%
node(node26_69).
functor(node26_69, twhen).         const(twhen).
gram_sempos(node26_69, n_denot).         const(n_denot).
id(node26_69, t_plzensky57870_txt_001_p1s1a45).         const(t_plzensky57870_txt_001_p1s1a45).
t_lemma(node26_69, nehoda).         const(nehoda).
%%%%%%%% node26_70 %%%%%%%%%%%%%%%%%%%
node(node26_70).
functor(node26_70, act).         const(act).
id(node26_70, t_plzensky57870_txt_001_p1s1a65).         const(t_plzensky57870_txt_001_p1s1a65).
t_lemma(node26_70, x_gen).         const(x_gen).
%%%%%%%% node26_71 %%%%%%%%%%%%%%%%%%%
node(node26_71).
a_afun(node26_71, auxp).         const(auxp).
m_form(node26_71, pri).         const(pri).
m_lemma(node26_71, pri_1).         const(pri_1).
m_tag(node26_71, rr__6__________).         const(rr__6__________).
m_tag0(node26_71,'r'). const('r'). m_tag1(node26_71,'r'). const('r'). m_tag4(node26_71,'6'). const('6'). 
%%%%%%%% node26_72 %%%%%%%%%%%%%%%%%%%
node(node26_72).
a_afun(node26_72, adv).         const(adv).
m_form(node26_72, nehode).         const(nehode).
m_lemma(node26_72, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node26_72, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node26_72,'n'). const('n'). m_tag1(node26_72,'n'). const('n'). m_tag2(node26_72,'f'). const('f'). m_tag3(node26_72,'s'). const('s'). m_tag4(node26_72,'6'). const('6'). m_tag10(node26_72,'a'). const('a'). 
%%%%%%%% node26_73 %%%%%%%%%%%%%%%%%%%
node(node26_73).
functor(node26_73, conj).         const(conj).
id(node26_73, t_plzensky57870_txt_001_p1s1a48).         const(t_plzensky57870_txt_001_p1s1a48).
t_lemma(node26_73, a).         const(a).
%%%%%%%% node26_74 %%%%%%%%%%%%%%%%%%%
node(node26_74).
functor(node26_74, loc).         const(loc).
gram_sempos(node26_74, n_denot).         const(n_denot).
id(node26_74, t_plzensky57870_txt_001_p1s1a47).         const(t_plzensky57870_txt_001_p1s1a47).
t_lemma(node26_74, obec).         const(obec).
%%%%%%%% node26_75 %%%%%%%%%%%%%%%%%%%
node(node26_75).
a_afun(node26_75, auxp).         const(auxp).
m_form(node26_75, mezi).         const(mezi).
m_lemma(node26_75, mezi_1).         const(mezi_1).
m_tag(node26_75, rr__7__________).         const(rr__7__________).
m_tag0(node26_75,'r'). const('r'). m_tag1(node26_75,'r'). const('r'). m_tag4(node26_75,'7'). const('7'). 
%%%%%%%% node26_76 %%%%%%%%%%%%%%%%%%%
node(node26_76).
a_afun(node26_76, atr).         const(atr).
m_form(node26_76, obcemi).         const(obcemi).
m_lemma(node26_76, obec).         const(obec).
m_tag(node26_76, nnfp7_____a____).         const(nnfp7_____a____).
m_tag0(node26_76,'n'). const('n'). m_tag1(node26_76,'n'). const('n'). m_tag2(node26_76,'f'). const('f'). m_tag3(node26_76,'p'). const('p'). m_tag4(node26_76,'7'). const('7'). m_tag10(node26_76,'a'). const('a'). 
%%%%%%%% node26_77 %%%%%%%%%%%%%%%%%%%
node(node26_77).
functor(node26_77, rstr).         const(rstr).
gram_sempos(node26_77, n_denot).         const(n_denot).
id(node26_77, t_plzensky57870_txt_001_p1s1a50).         const(t_plzensky57870_txt_001_p1s1a50).
t_lemma(node26_77, nemnenice).         const(nemnenice).
%%%%%%%% node26_78 %%%%%%%%%%%%%%%%%%%
node(node26_78).
a_afun(node26_78, atr).         const(atr).
m_form(node26_78, nemnenice).         const(nemnenice).
m_lemma(node26_78, nemnenice__g).         const(nemnenice__g).
m_tag(node26_78, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node26_78,'n'). const('n'). m_tag1(node26_78,'n'). const('n'). m_tag2(node26_78,'f'). const('f'). m_tag3(node26_78,'p'). const('p'). m_tag4(node26_78,'1'). const('1'). m_tag10(node26_78,'a'). const('a'). 
%%%%%%%% node26_79 %%%%%%%%%%%%%%%%%%%
node(node26_79).
a_afun(node26_79, coord).         const(coord).
m_form(node26_79, a).         const(a).
m_lemma(node26_79, a_1).         const(a_1).
m_tag(node26_79, j______________).         const(j______________).
m_tag0(node26_79,'j'). const('j'). m_tag1(node26_79,'^'). const('^'). 
%%%%%%%% node26_80 %%%%%%%%%%%%%%%%%%%
node(node26_80).
functor(node26_80, act).         const(act).
gram_sempos(node26_80, n_denot).         const(n_denot).
id(node26_80, t_plzensky57870_txt_001_p1s1a60).         const(t_plzensky57870_txt_001_p1s1a60).
t_lemma(node26_80, obec).         const(obec).
%%%%%%%% node26_81 %%%%%%%%%%%%%%%%%%%
node(node26_81).
functor(node26_81, rstr).         const(rstr).
gram_sempos(node26_81, n_denot).         const(n_denot).
id(node26_81, t_plzensky57870_txt_001_p1s1a49).         const(t_plzensky57870_txt_001_p1s1a49).
t_lemma(node26_81, cernovice).         const(cernovice).
%%%%%%%% node26_82 %%%%%%%%%%%%%%%%%%%
node(node26_82).
a_afun(node26_82, atr).         const(atr).
m_form(node26_82, cernovice).         const(cernovice).
m_lemma(node26_82, cernovice__g).         const(cernovice__g).
m_tag(node26_82, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node26_82,'n'). const('n'). m_tag1(node26_82,'n'). const('n'). m_tag2(node26_82,'f'). const('f'). m_tag3(node26_82,'p'). const('p'). m_tag4(node26_82,'1'). const('1'). m_tag10(node26_82,'a'). const('a'). 
%%%%%%%% node26_83 %%%%%%%%%%%%%%%%%%%
node(node26_83).
a_afun(node26_83, auxp).         const(auxp).
m_form(node26_83, mezi).         const(mezi).
m_lemma(node26_83, mezi_1).         const(mezi_1).
m_tag(node26_83, rr__7__________).         const(rr__7__________).
m_tag0(node26_83,'r'). const('r'). m_tag1(node26_83,'r'). const('r'). m_tag4(node26_83,'7'). const('7'). 
%%%%%%%% node26_84 %%%%%%%%%%%%%%%%%%%
node(node26_84).
a_afun(node26_84, atr).         const(atr).
m_form(node26_84, obcemi).         const(obcemi).
m_lemma(node26_84, obec).         const(obec).
m_tag(node26_84, nnfp7_____a____).         const(nnfp7_____a____).
m_tag0(node26_84,'n'). const('n'). m_tag1(node26_84,'n'). const('n'). m_tag2(node26_84,'f'). const('f'). m_tag3(node26_84,'p'). const('p'). m_tag4(node26_84,'7'). const('7'). m_tag10(node26_84,'a'). const('a'). 
%%%%%%%% node26_85 %%%%%%%%%%%%%%%%%%%
node(node26_85).
a_afun(node26_85, obj).         const(obj).
m_form(node26_85, zahynul).         const(zahynul).
m_lemma(node26_85, zahynout).         const(zahynout).
m_tag(node26_85, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node26_85,'v'). const('v'). m_tag1(node26_85,'p'). const('p'). m_tag2(node26_85,'y'). const('y'). m_tag3(node26_85,'s'). const('s'). m_tag7(node26_85,'x'). const('x'). m_tag8(node26_85,'r'). const('r'). m_tag10(node26_85,'a'). const('a'). m_tag11(node26_85,'a'). const('a'). 
%%%%%%%% node26_86 %%%%%%%%%%%%%%%%%%%
node(node26_86).
functor(node26_86, act).         const(act).
gram_sempos(node26_86, n_denot).         const(n_denot).
id(node26_86, t_plzensky57870_txt_001_p1s1a51).         const(t_plzensky57870_txt_001_p1s1a51).
t_lemma(node26_86, ridic).         const(ridic).
%%%%%%%% node26_87 %%%%%%%%%%%%%%%%%%%
node(node26_87).
a_afun(node26_87, sb).         const(sb).
m_form(node26_87, ridic).         const(ridic).
m_lemma(node26_87, ridic).         const(ridic).
m_tag(node26_87, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node26_87,'n'). const('n'). m_tag1(node26_87,'n'). const('n'). m_tag2(node26_87,'m'). const('m'). m_tag3(node26_87,'s'). const('s'). m_tag4(node26_87,'1'). const('1'). m_tag10(node26_87,'a'). const('a'). 
%%%%%%%% node26_88 %%%%%%%%%%%%%%%%%%%
node(node26_88).
a_afun(node26_88, auxx).         const(auxx).
m_form(node26_88, x_).         const(x_).
m_lemma(node26_88, x_).         const(x_).
m_tag(node26_88, z______________).         const(z______________).
m_tag0(node26_88,'z'). const('z'). m_tag1(node26_88,':'). const(':'). 
%%%%%%%% node26_89 %%%%%%%%%%%%%%%%%%%
node(node26_89).
functor(node26_89, rstr).         const(rstr).
gram_sempos(node26_89, v).         const(v).
id(node26_89, t_plzensky57870_txt_001_p1s1a53).         const(t_plzensky57870_txt_001_p1s1a53).
t_lemma(node26_89, venovat_se).         const(venovat_se).
%%%%%%%% node26_90 %%%%%%%%%%%%%%%%%%%
node(node26_90).
functor(node26_90, act).         const(act).
id(node26_90, t_plzensky57870_txt_001_p1s1a66).         const(t_plzensky57870_txt_001_p1s1a66).
t_lemma(node26_90, x_perspron).         const(x_perspron).
%%%%%%%% node26_91 %%%%%%%%%%%%%%%%%%%
node(node26_91).
a_afun(node26_91, auxv).         const(auxv).
m_form(node26_91, budu).         const(budu).
m_lemma(node26_91, byt).         const(byt).
m_tag(node26_91, vb_s___1f_aa___).         const(vb_s___1f_aa___).
m_tag0(node26_91,'v'). const('v'). m_tag1(node26_91,'b'). const('b'). m_tag3(node26_91,'s'). const('s'). m_tag7(node26_91,'1'). const('1'). m_tag8(node26_91,'f'). const('f'). m_tag10(node26_91,'a'). const('a'). m_tag11(node26_91,'a'). const('a'). 
%%%%%%%% node26_92 %%%%%%%%%%%%%%%%%%%
node(node26_92).
a_afun(node26_92, auxt).         const(auxt).
m_form(node26_92, se).         const(se).
m_lemma(node26_92, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node26_92, p7_x4__________).         const(p7_x4__________).
m_tag0(node26_92,'p'). const('p'). m_tag1(node26_92,'7'). const('7'). m_tag3(node26_92,'x'). const('x'). m_tag4(node26_92,'4'). const('4'). 
%%%%%%%% node26_93 %%%%%%%%%%%%%%%%%%%
node(node26_93).
a_afun(node26_93, obj).         const(obj).
m_form(node26_93, venovat).         const(venovat).
m_lemma(node26_93, venovat__t).         const(venovat__t).
m_tag(node26_93, vf________a____).         const(vf________a____).
m_tag0(node26_93,'v'). const('v'). m_tag1(node26_93,'f'). const('f'). m_tag10(node26_93,'a'). const('a'). 
%%%%%%%% node26_94 %%%%%%%%%%%%%%%%%%%
node(node26_94).
functor(node26_94, pat).         const(pat).
gram_sempos(node26_94, n_denot_neg).         const(n_denot_neg).
id(node26_94, t_plzensky57870_txt_001_p1s1a56).         const(t_plzensky57870_txt_001_p1s1a56).
t_lemma(node26_94, udalost).         const(udalost).
%%%%%%%% node26_95 %%%%%%%%%%%%%%%%%%%
node(node26_95).
functor(node26_95, rstr).         const(rstr).
gram_sempos(node26_95, adj_pron_indef).         const(adj_pron_indef).
id(node26_95, t_plzensky57870_txt_001_p1s1a57).         const(t_plzensky57870_txt_001_p1s1a57).
t_lemma(node26_95, ktery).         const(ktery).
%%%%%%%% node26_96 %%%%%%%%%%%%%%%%%%%
node(node26_96).
functor(node26_96, rhem).         const(rhem).
id(node26_96, t_plzensky57870_txt_001_p1s1a58).         const(t_plzensky57870_txt_001_p1s1a58).
t_lemma(node26_96, pouze).         const(pouze).
%%%%%%%% node26_97 %%%%%%%%%%%%%%%%%%%
node(node26_97).
a_afun(node26_97, auxz).         const(auxz).
m_form(node26_97, pouze).         const(pouze).
m_lemma(node26_97, pouze).         const(pouze).
m_tag(node26_97, db_____________).         const(db_____________).
m_tag0(node26_97,'d'). const('d'). m_tag1(node26_97,'b'). const('b'). 
%%%%%%%% node26_98 %%%%%%%%%%%%%%%%%%%
node(node26_98).
a_afun(node26_98, atr).         const(atr).
m_form(node26_98, nekterym).         const(nekterym).
m_lemma(node26_98, nektery).         const(nektery).
m_tag(node26_98, pzxp3__________).         const(pzxp3__________).
m_tag0(node26_98,'p'). const('p'). m_tag1(node26_98,'z'). const('z'). m_tag2(node26_98,'x'). const('x'). m_tag3(node26_98,'p'). const('p'). m_tag4(node26_98,'3'). const('3'). 
%%%%%%%% node26_99 %%%%%%%%%%%%%%%%%%%
node(node26_99).
functor(node26_99, rstr).         const(rstr).
gram_sempos(node26_99, adj_denot).         const(adj_denot).
id(node26_99, t_plzensky57870_txt_001_p1s1a59).         const(t_plzensky57870_txt_001_p1s1a59).
t_lemma(node26_99, nedelni).         const(nedelni).
%%%%%%%% node26_100 %%%%%%%%%%%%%%%%%%%
node(node26_100).
a_afun(node26_100, atr).         const(atr).
m_form(node26_100, nedelnim).         const(nedelnim).
m_lemma(node26_100, nedelni).         const(nedelni).
m_tag(node26_100, aafp3____1a____).         const(aafp3____1a____).
m_tag0(node26_100,'a'). const('a'). m_tag1(node26_100,'a'). const('a'). m_tag2(node26_100,'f'). const('f'). m_tag3(node26_100,'p'). const('p'). m_tag4(node26_100,'3'). const('3'). m_tag9(node26_100,'1'). const('1'). m_tag10(node26_100,'a'). const('a'). 
%%%%%%%% node26_101 %%%%%%%%%%%%%%%%%%%
node(node26_101).
a_afun(node26_101, obj).         const(obj).
m_form(node26_101, udalostem).         const(udalostem).
m_lemma(node26_101, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node26_101, nnfp3_____a____).         const(nnfp3_____a____).
m_tag0(node26_101,'n'). const('n'). m_tag1(node26_101,'n'). const('n'). m_tag2(node26_101,'f'). const('f'). m_tag3(node26_101,'p'). const('p'). m_tag4(node26_101,'3'). const('3'). m_tag10(node26_101,'a'). const('a'). 
edge(node26_0, node26_1).
edge(node26_1, node26_2).
edge(node26_1, node26_3).
edge(node26_3, node26_4).
edge(node26_4, node26_5).
edge(node26_4, node26_6).
edge(node26_4, node26_7).
edge(node26_7, node26_8).
edge(node26_8, node26_9).
edge(node26_8, node26_10).
edge(node26_7, node26_11).
edge(node26_11, node26_12).
edge(node26_11, node26_13).
edge(node26_7, node26_14).
edge(node26_7, node26_15).
edge(node26_15, node26_16).
edge(node26_16, node26_17).
edge(node26_16, node26_18).
edge(node26_15, node26_19).
edge(node26_19, node26_20).
edge(node26_15, node26_21).
edge(node26_21, node26_22).
edge(node26_15, node26_23).
edge(node26_15, node26_24).
edge(node26_4, node26_25).
edge(node26_25, node26_26).
edge(node26_4, node26_27).
edge(node26_27, node26_28).
edge(node26_4, node26_29).
edge(node26_4, node26_30).
edge(node26_4, node26_31).
edge(node26_31, node26_32).
edge(node26_31, node26_33).
edge(node26_3, node26_34).
edge(node26_3, node26_35).
edge(node26_3, node26_36).
edge(node26_3, node26_37).
edge(node26_3, node26_38).
edge(node26_3, node26_39).
edge(node26_39, node26_40).
edge(node26_40, node26_41).
edge(node26_39, node26_42).
edge(node26_39, node26_43).
edge(node26_43, node26_44).
edge(node26_44, node26_45).
edge(node26_43, node26_46).
edge(node26_46, node26_47).
edge(node26_43, node26_48).
edge(node26_3, node26_49).
edge(node26_49, node26_50).
edge(node26_1, node26_51).
edge(node26_51, node26_52).
edge(node26_51, node26_53).
edge(node26_53, node26_54).
edge(node26_53, node26_55).
edge(node26_55, node26_56).
edge(node26_56, node26_57).
edge(node26_55, node26_58).
edge(node26_1, node26_59).
edge(node26_59, node26_60).
edge(node26_59, node26_61).
edge(node26_1, node26_62).
edge(node26_1, node26_63).
edge(node26_63, node26_64).
edge(node26_64, node26_65).
edge(node26_63, node26_66).
edge(node26_66, node26_67).
edge(node26_63, node26_68).
edge(node26_68, node26_69).
edge(node26_69, node26_70).
edge(node26_69, node26_71).
edge(node26_69, node26_72).
edge(node26_69, node26_73).
edge(node26_73, node26_74).
edge(node26_74, node26_75).
edge(node26_74, node26_76).
edge(node26_74, node26_77).
edge(node26_77, node26_78).
edge(node26_73, node26_79).
edge(node26_73, node26_80).
edge(node26_80, node26_81).
edge(node26_81, node26_82).
edge(node26_80, node26_83).
edge(node26_80, node26_84).
edge(node26_68, node26_85).
edge(node26_68, node26_86).
edge(node26_86, node26_87).
edge(node26_63, node26_88).
edge(node26_63, node26_89).
edge(node26_89, node26_90).
edge(node26_89, node26_91).
edge(node26_89, node26_92).
edge(node26_89, node26_93).
edge(node26_89, node26_94).
edge(node26_94, node26_95).
edge(node26_95, node26_96).
edge(node26_96, node26_97).
edge(node26_95, node26_98).
edge(node26_94, node26_99).
edge(node26_99, node26_100).
edge(node26_94, node26_101).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zahynuly pri nich dve osoby. 
tree_root(node27_0).
%%%%%%%% node27_0 %%%%%%%%%%%%%%%%%%%
node(node27_0).
id(node27_0, t_plzensky57870_txt_001_p8s2).         const(t_plzensky57870_txt_001_p8s2).
%%%%%%%% node27_1 %%%%%%%%%%%%%%%%%%%
node(node27_1).
functor(node27_1, pred).         const(pred).
gram_sempos(node27_1, v).         const(v).
id(node27_1, t_plzensky57870_txt_001_p8s2a1).         const(t_plzensky57870_txt_001_p8s2a1).
t_lemma(node27_1, zahynout).         const(zahynout).
%%%%%%%% node27_2 %%%%%%%%%%%%%%%%%%%
node(node27_2).
a_afun(node27_2, pred).         const(pred).
m_form(node27_2, zahynuly).         const(zahynuly).
m_lemma(node27_2, zahynout).         const(zahynout).
m_tag(node27_2, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node27_2,'v'). const('v'). m_tag1(node27_2,'p'). const('p'). m_tag2(node27_2,'t'). const('t'). m_tag3(node27_2,'p'). const('p'). m_tag7(node27_2,'x'). const('x'). m_tag8(node27_2,'r'). const('r'). m_tag10(node27_2,'a'). const('a'). m_tag11(node27_2,'a'). const('a'). 
%%%%%%%% node27_3 %%%%%%%%%%%%%%%%%%%
node(node27_3).
functor(node27_3, twhen).         const(twhen).
gram_sempos(node27_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node27_3, t_plzensky57870_txt_001_p8s2a3).         const(t_plzensky57870_txt_001_p8s2a3).
t_lemma(node27_3, x_perspron).         const(x_perspron).
%%%%%%%% node27_4 %%%%%%%%%%%%%%%%%%%
node(node27_4).
a_afun(node27_4, auxp).         const(auxp).
m_form(node27_4, pri).         const(pri).
m_lemma(node27_4, pri_1).         const(pri_1).
m_tag(node27_4, rr__6__________).         const(rr__6__________).
m_tag0(node27_4,'r'). const('r'). m_tag1(node27_4,'r'). const('r'). m_tag4(node27_4,'6'). const('6'). 
%%%%%%%% node27_5 %%%%%%%%%%%%%%%%%%%
node(node27_5).
a_afun(node27_5, adv).         const(adv).
m_form(node27_5, nich).         const(nich).
m_lemma(node27_5, on_1).         const(on_1).
m_tag(node27_5, p5xp6__3_______).         const(p5xp6__3_______).
m_tag0(node27_5,'p'). const('p'). m_tag1(node27_5,'5'). const('5'). m_tag2(node27_5,'x'). const('x'). m_tag3(node27_5,'p'). const('p'). m_tag4(node27_5,'6'). const('6'). m_tag7(node27_5,'3'). const('3'). 
%%%%%%%% node27_6 %%%%%%%%%%%%%%%%%%%
node(node27_6).
functor(node27_6, act).         const(act).
gram_sempos(node27_6, n_denot).         const(n_denot).
id(node27_6, t_plzensky57870_txt_001_p8s2a4).         const(t_plzensky57870_txt_001_p8s2a4).
t_lemma(node27_6, osoba).         const(osoba).
%%%%%%%% node27_7 %%%%%%%%%%%%%%%%%%%
node(node27_7).
functor(node27_7, rstr).         const(rstr).
gram_sempos(node27_7, adj_quant_def).         const(adj_quant_def).
id(node27_7, t_plzensky57870_txt_001_p8s2a5).         const(t_plzensky57870_txt_001_p8s2a5).
t_lemma(node27_7, dva).         const(dva).
%%%%%%%% node27_8 %%%%%%%%%%%%%%%%%%%
node(node27_8).
a_afun(node27_8, atr).         const(atr).
m_form(node27_8, dve).         const(dve).
m_lemma(node27_8, dva_2).         const(dva_2).
m_tag(node27_8, clhp1__________).         const(clhp1__________).
m_tag0(node27_8,'c'). const('c'). m_tag1(node27_8,'l'). const('l'). m_tag2(node27_8,'h'). const('h'). m_tag3(node27_8,'p'). const('p'). m_tag4(node27_8,'1'). const('1'). 
%%%%%%%% node27_9 %%%%%%%%%%%%%%%%%%%
node(node27_9).
a_afun(node27_9, sb).         const(sb).
m_form(node27_9, osoby).         const(osoby).
m_lemma(node27_9, osoba).         const(osoba).
m_tag(node27_9, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node27_9,'n'). const('n'). m_tag1(node27_9,'n'). const('n'). m_tag2(node27_9,'f'). const('f'). m_tag3(node27_9,'p'). const('p'). m_tag4(node27_9,'1'). const('1'). m_tag10(node27_9,'a'). const('a'). 
edge(node27_0, node27_1).
edge(node27_1, node27_2).
edge(node27_1, node27_3).
edge(node27_3, node27_4).
edge(node27_3, node27_5).
edge(node27_1, node27_6).
edge(node27_6, node27_7).
edge(node27_7, node27_8).
edge(node27_6, node27_9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl usmrcen muz v osobnim automobilu. 
tree_root(node28_0).
%%%%%%%% node28_0 %%%%%%%%%%%%%%%%%%%
node(node28_0).
id(node28_0, t_plzensky62815_txt_001_p1s4).         const(t_plzensky62815_txt_001_p1s4).
%%%%%%%% node28_1 %%%%%%%%%%%%%%%%%%%
node(node28_1).
functor(node28_1, pred).         const(pred).
gram_sempos(node28_1, v).         const(v).
id(node28_1, t_plzensky62815_txt_001_p1s4a1).         const(t_plzensky62815_txt_001_p1s4a1).
t_lemma(node28_1, usmrtit).         const(usmrtit).
%%%%%%%% node28_2 %%%%%%%%%%%%%%%%%%%
node(node28_2).
functor(node28_2, act).         const(act).
id(node28_2, t_plzensky62815_txt_001_p1s4a9).         const(t_plzensky62815_txt_001_p1s4a9).
t_lemma(node28_2, x_gen).         const(x_gen).
%%%%%%%% node28_3 %%%%%%%%%%%%%%%%%%%
node(node28_3).
functor(node28_3, twhen).         const(twhen).
gram_sempos(node28_3, n_denot).         const(n_denot).
id(node28_3, t_plzensky62815_txt_001_p1s4a3).         const(t_plzensky62815_txt_001_p1s4a3).
t_lemma(node28_3, nehoda).         const(nehoda).
%%%%%%%% node28_4 %%%%%%%%%%%%%%%%%%%
node(node28_4).
a_afun(node28_4, auxp).         const(auxp).
m_form(node28_4, pri).         const(pri).
m_lemma(node28_4, pri_1).         const(pri_1).
m_tag(node28_4, rr__6__________).         const(rr__6__________).
m_tag0(node28_4,'r'). const('r'). m_tag1(node28_4,'r'). const('r'). m_tag4(node28_4,'6'). const('6'). 
%%%%%%%% node28_5 %%%%%%%%%%%%%%%%%%%
node(node28_5).
a_afun(node28_5, adv).         const(adv).
m_form(node28_5, nehode).         const(nehode).
m_lemma(node28_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node28_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node28_5,'n'). const('n'). m_tag1(node28_5,'n'). const('n'). m_tag2(node28_5,'f'). const('f'). m_tag3(node28_5,'s'). const('s'). m_tag4(node28_5,'6'). const('6'). m_tag10(node28_5,'a'). const('a'). 
%%%%%%%% node28_6 %%%%%%%%%%%%%%%%%%%
node(node28_6).
a_afun(node28_6, auxv).         const(auxv).
m_form(node28_6, byl).         const(byl).
m_lemma(node28_6, byt).         const(byt).
m_tag(node28_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node28_6,'v'). const('v'). m_tag1(node28_6,'p'). const('p'). m_tag2(node28_6,'y'). const('y'). m_tag3(node28_6,'s'). const('s'). m_tag7(node28_6,'x'). const('x'). m_tag8(node28_6,'r'). const('r'). m_tag10(node28_6,'a'). const('a'). m_tag11(node28_6,'a'). const('a'). 
%%%%%%%% node28_7 %%%%%%%%%%%%%%%%%%%
node(node28_7).
a_afun(node28_7, pred).         const(pred).
m_form(node28_7, usmrcen).         const(usmrcen).
m_lemma(node28_7, usmrtit__w).         const(usmrtit__w).
m_tag(node28_7, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node28_7,'v'). const('v'). m_tag1(node28_7,'s'). const('s'). m_tag2(node28_7,'y'). const('y'). m_tag3(node28_7,'s'). const('s'). m_tag7(node28_7,'x'). const('x'). m_tag8(node28_7,'x'). const('x'). m_tag10(node28_7,'a'). const('a'). m_tag11(node28_7,'p'). const('p'). 
%%%%%%%% node28_8 %%%%%%%%%%%%%%%%%%%
node(node28_8).
functor(node28_8, pat).         const(pat).
gram_sempos(node28_8, n_denot).         const(n_denot).
id(node28_8, t_plzensky62815_txt_001_p1s4a5).         const(t_plzensky62815_txt_001_p1s4a5).
t_lemma(node28_8, muz).         const(muz).
%%%%%%%% node28_9 %%%%%%%%%%%%%%%%%%%
node(node28_9).
a_afun(node28_9, sb).         const(sb).
m_form(node28_9, muz).         const(muz).
m_lemma(node28_9, muz).         const(muz).
m_tag(node28_9, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node28_9,'n'). const('n'). m_tag1(node28_9,'n'). const('n'). m_tag2(node28_9,'m'). const('m'). m_tag3(node28_9,'s'). const('s'). m_tag4(node28_9,'1'). const('1'). m_tag10(node28_9,'a'). const('a'). 
%%%%%%%% node28_10 %%%%%%%%%%%%%%%%%%%
node(node28_10).
functor(node28_10, loc).         const(loc).
gram_sempos(node28_10, n_denot).         const(n_denot).
id(node28_10, t_plzensky62815_txt_001_p1s4a7).         const(t_plzensky62815_txt_001_p1s4a7).
t_lemma(node28_10, automobil).         const(automobil).
%%%%%%%% node28_11 %%%%%%%%%%%%%%%%%%%
node(node28_11).
functor(node28_11, rstr).         const(rstr).
gram_sempos(node28_11, adj_denot).         const(adj_denot).
id(node28_11, t_plzensky62815_txt_001_p1s4a8).         const(t_plzensky62815_txt_001_p1s4a8).
t_lemma(node28_11, osobni).         const(osobni).
%%%%%%%% node28_12 %%%%%%%%%%%%%%%%%%%
node(node28_12).
a_afun(node28_12, atr).         const(atr).
m_form(node28_12, osobnim).         const(osobnim).
m_lemma(node28_12, osobni).         const(osobni).
m_tag(node28_12, aais6____1a____).         const(aais6____1a____).
m_tag0(node28_12,'a'). const('a'). m_tag1(node28_12,'a'). const('a'). m_tag2(node28_12,'i'). const('i'). m_tag3(node28_12,'s'). const('s'). m_tag4(node28_12,'6'). const('6'). m_tag9(node28_12,'1'). const('1'). m_tag10(node28_12,'a'). const('a'). 
%%%%%%%% node28_13 %%%%%%%%%%%%%%%%%%%
node(node28_13).
a_afun(node28_13, auxp).         const(auxp).
m_form(node28_13, v).         const(v).
m_lemma(node28_13, v_1).         const(v_1).
m_tag(node28_13, rr__6__________).         const(rr__6__________).
m_tag0(node28_13,'r'). const('r'). m_tag1(node28_13,'r'). const('r'). m_tag4(node28_13,'6'). const('6'). 
%%%%%%%% node28_14 %%%%%%%%%%%%%%%%%%%
node(node28_14).
a_afun(node28_14, atr).         const(atr).
m_form(node28_14, automobilu).         const(automobilu).
m_lemma(node28_14, automobil).         const(automobil).
m_tag(node28_14, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node28_14,'n'). const('n'). m_tag1(node28_14,'n'). const('n'). m_tag2(node28_14,'i'). const('i'). m_tag3(node28_14,'s'). const('s'). m_tag4(node28_14,'6'). const('6'). m_tag10(node28_14,'a'). const('a'). 
edge(node28_0, node28_1).
edge(node28_1, node28_2).
edge(node28_1, node28_3).
edge(node28_3, node28_4).
edge(node28_3, node28_5).
edge(node28_1, node28_6).
edge(node28_1, node28_7).
edge(node28_1, node28_8).
edge(node28_8, node28_9).
edge(node28_8, node28_10).
edge(node28_10, node28_11).
edge(node28_11, node28_12).
edge(node28_10, node28_13).
edge(node28_10, node28_14).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri druhe nehode byla tezce zranena jedna osoba a na misto byl povolan vrtulnik lzs. 
tree_root(node29_0).
%%%%%%%% node29_0 %%%%%%%%%%%%%%%%%%%
node(node29_0).
id(node29_0, t_plzensky62815_txt_001_p1s12).         const(t_plzensky62815_txt_001_p1s12).
%%%%%%%% node29_1 %%%%%%%%%%%%%%%%%%%
node(node29_1).
functor(node29_1, conj).         const(conj).
id(node29_1, t_plzensky62815_txt_001_p1s12a1).         const(t_plzensky62815_txt_001_p1s12a1).
t_lemma(node29_1, a).         const(a).
%%%%%%%% node29_2 %%%%%%%%%%%%%%%%%%%
node(node29_2).
functor(node29_2, act).         const(act).
id(node29_2, t_plzensky62815_txt_001_p1s12a16).         const(t_plzensky62815_txt_001_p1s12a16).
t_lemma(node29_2, x_gen).         const(x_gen).
%%%%%%%% node29_3 %%%%%%%%%%%%%%%%%%%
node(node29_3).
functor(node29_3, pred).         const(pred).
gram_sempos(node29_3, v).         const(v).
id(node29_3, t_plzensky62815_txt_001_p1s12a2).         const(t_plzensky62815_txt_001_p1s12a2).
t_lemma(node29_3, zranit).         const(zranit).
%%%%%%%% node29_4 %%%%%%%%%%%%%%%%%%%
node(node29_4).
functor(node29_4, twhen).         const(twhen).
gram_sempos(node29_4, n_denot).         const(n_denot).
id(node29_4, t_plzensky62815_txt_001_p1s12a4).         const(t_plzensky62815_txt_001_p1s12a4).
t_lemma(node29_4, nehoda).         const(nehoda).
%%%%%%%% node29_5 %%%%%%%%%%%%%%%%%%%
node(node29_5).
functor(node29_5, rstr).         const(rstr).
gram_sempos(node29_5, adj_quant_def).         const(adj_quant_def).
id(node29_5, t_plzensky62815_txt_001_p1s12a5).         const(t_plzensky62815_txt_001_p1s12a5).
t_lemma(node29_5, dva).         const(dva).
%%%%%%%% node29_6 %%%%%%%%%%%%%%%%%%%
node(node29_6).
a_afun(node29_6, atr).         const(atr).
m_form(node29_6, druhe).         const(druhe).
m_lemma(node29_6, druhy_2).         const(druhy_2).
m_tag(node29_6, crfs6__________).         const(crfs6__________).
m_tag0(node29_6,'c'). const('c'). m_tag1(node29_6,'r'). const('r'). m_tag2(node29_6,'f'). const('f'). m_tag3(node29_6,'s'). const('s'). m_tag4(node29_6,'6'). const('6'). 
%%%%%%%% node29_7 %%%%%%%%%%%%%%%%%%%
node(node29_7).
a_afun(node29_7, auxp).         const(auxp).
m_form(node29_7, pri).         const(pri).
m_lemma(node29_7, pri_1).         const(pri_1).
m_tag(node29_7, rr__6__________).         const(rr__6__________).
m_tag0(node29_7,'r'). const('r'). m_tag1(node29_7,'r'). const('r'). m_tag4(node29_7,'6'). const('6'). 
%%%%%%%% node29_8 %%%%%%%%%%%%%%%%%%%
node(node29_8).
a_afun(node29_8, adv).         const(adv).
m_form(node29_8, nehode).         const(nehode).
m_lemma(node29_8, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node29_8, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node29_8,'n'). const('n'). m_tag1(node29_8,'n'). const('n'). m_tag2(node29_8,'f'). const('f'). m_tag3(node29_8,'s'). const('s'). m_tag4(node29_8,'6'). const('6'). m_tag10(node29_8,'a'). const('a'). 
%%%%%%%% node29_9 %%%%%%%%%%%%%%%%%%%
node(node29_9).
functor(node29_9, mann).         const(mann).
gram_sempos(node29_9, adj_denot).         const(adj_denot).
id(node29_9, t_plzensky62815_txt_001_p1s12a7).         const(t_plzensky62815_txt_001_p1s12a7).
t_lemma(node29_9, tezky).         const(tezky).
%%%%%%%% node29_10 %%%%%%%%%%%%%%%%%%%
node(node29_10).
a_afun(node29_10, adv).         const(adv).
m_form(node29_10, tezce).         const(tezce).
m_lemma(node29_10, tezce).         const(tezce).
m_tag(node29_10, dg_______1a____).         const(dg_______1a____).
m_tag0(node29_10,'d'). const('d'). m_tag1(node29_10,'g'). const('g'). m_tag9(node29_10,'1'). const('1'). m_tag10(node29_10,'a'). const('a'). 
%%%%%%%% node29_11 %%%%%%%%%%%%%%%%%%%
node(node29_11).
a_afun(node29_11, auxv).         const(auxv).
m_form(node29_11, byla).         const(byla).
m_lemma(node29_11, byt).         const(byt).
m_tag(node29_11, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node29_11,'v'). const('v'). m_tag1(node29_11,'p'). const('p'). m_tag2(node29_11,'q'). const('q'). m_tag3(node29_11,'w'). const('w'). m_tag7(node29_11,'x'). const('x'). m_tag8(node29_11,'r'). const('r'). m_tag10(node29_11,'a'). const('a'). m_tag11(node29_11,'a'). const('a'). 
%%%%%%%% node29_12 %%%%%%%%%%%%%%%%%%%
node(node29_12).
a_afun(node29_12, pred).         const(pred).
m_form(node29_12, zranena).         const(zranena).
m_lemma(node29_12, zranit__w).         const(zranit__w).
m_tag(node29_12, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node29_12,'v'). const('v'). m_tag1(node29_12,'s'). const('s'). m_tag2(node29_12,'q'). const('q'). m_tag3(node29_12,'w'). const('w'). m_tag7(node29_12,'x'). const('x'). m_tag8(node29_12,'x'). const('x'). m_tag10(node29_12,'a'). const('a'). m_tag11(node29_12,'p'). const('p'). 
%%%%%%%% node29_13 %%%%%%%%%%%%%%%%%%%
node(node29_13).
functor(node29_13, pat).         const(pat).
gram_sempos(node29_13, n_denot).         const(n_denot).
id(node29_13, t_plzensky62815_txt_001_p1s12a8).         const(t_plzensky62815_txt_001_p1s12a8).
t_lemma(node29_13, osoba).         const(osoba).
%%%%%%%% node29_14 %%%%%%%%%%%%%%%%%%%
node(node29_14).
functor(node29_14, rstr).         const(rstr).
gram_sempos(node29_14, adj_quant_def).         const(adj_quant_def).
id(node29_14, t_plzensky62815_txt_001_p1s12a9).         const(t_plzensky62815_txt_001_p1s12a9).
t_lemma(node29_14, jeden).         const(jeden).
%%%%%%%% node29_15 %%%%%%%%%%%%%%%%%%%
node(node29_15).
a_afun(node29_15, atr).         const(atr).
m_form(node29_15, jedna).         const(jedna).
m_lemma(node29_15, jeden_1).         const(jeden_1).
m_tag(node29_15, clfs1__________).         const(clfs1__________).
m_tag0(node29_15,'c'). const('c'). m_tag1(node29_15,'l'). const('l'). m_tag2(node29_15,'f'). const('f'). m_tag3(node29_15,'s'). const('s'). m_tag4(node29_15,'1'). const('1'). 
%%%%%%%% node29_16 %%%%%%%%%%%%%%%%%%%
node(node29_16).
a_afun(node29_16, sb).         const(sb).
m_form(node29_16, osoba).         const(osoba).
m_lemma(node29_16, osoba).         const(osoba).
m_tag(node29_16, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node29_16,'n'). const('n'). m_tag1(node29_16,'n'). const('n'). m_tag2(node29_16,'f'). const('f'). m_tag3(node29_16,'s'). const('s'). m_tag4(node29_16,'1'). const('1'). m_tag10(node29_16,'a'). const('a'). 
%%%%%%%% node29_17 %%%%%%%%%%%%%%%%%%%
node(node29_17).
a_afun(node29_17, coord).         const(coord).
m_form(node29_17, a).         const(a).
m_lemma(node29_17, a_1).         const(a_1).
m_tag(node29_17, j______________).         const(j______________).
m_tag0(node29_17,'j'). const('j'). m_tag1(node29_17,'^'). const('^'). 
%%%%%%%% node29_18 %%%%%%%%%%%%%%%%%%%
node(node29_18).
functor(node29_18, pred).         const(pred).
gram_sempos(node29_18, v).         const(v).
id(node29_18, t_plzensky62815_txt_001_p1s12a10).         const(t_plzensky62815_txt_001_p1s12a10).
t_lemma(node29_18, povolat).         const(povolat).
%%%%%%%% node29_19 %%%%%%%%%%%%%%%%%%%
node(node29_19).
functor(node29_19, dir3).         const(dir3).
gram_sempos(node29_19, n_denot).         const(n_denot).
id(node29_19, t_plzensky62815_txt_001_p1s12a12).         const(t_plzensky62815_txt_001_p1s12a12).
t_lemma(node29_19, misto).         const(misto).
%%%%%%%% node29_20 %%%%%%%%%%%%%%%%%%%
node(node29_20).
a_afun(node29_20, auxp).         const(auxp).
m_form(node29_20, na).         const(na).
m_lemma(node29_20, na_1).         const(na_1).
m_tag(node29_20, rr__4__________).         const(rr__4__________).
m_tag0(node29_20,'r'). const('r'). m_tag1(node29_20,'r'). const('r'). m_tag4(node29_20,'4'). const('4'). 
%%%%%%%% node29_21 %%%%%%%%%%%%%%%%%%%
node(node29_21).
a_afun(node29_21, adv).         const(adv).
m_form(node29_21, misto).         const(misto).
m_lemma(node29_21, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node29_21, nnns4_____a____).         const(nnns4_____a____).
m_tag0(node29_21,'n'). const('n'). m_tag1(node29_21,'n'). const('n'). m_tag2(node29_21,'n'). const('n'). m_tag3(node29_21,'s'). const('s'). m_tag4(node29_21,'4'). const('4'). m_tag10(node29_21,'a'). const('a'). 
%%%%%%%% node29_22 %%%%%%%%%%%%%%%%%%%
node(node29_22).
a_afun(node29_22, auxv).         const(auxv).
m_form(node29_22, byl).         const(byl).
m_lemma(node29_22, byt).         const(byt).
m_tag(node29_22, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node29_22,'v'). const('v'). m_tag1(node29_22,'p'). const('p'). m_tag2(node29_22,'y'). const('y'). m_tag3(node29_22,'s'). const('s'). m_tag7(node29_22,'x'). const('x'). m_tag8(node29_22,'r'). const('r'). m_tag10(node29_22,'a'). const('a'). m_tag11(node29_22,'a'). const('a'). 
%%%%%%%% node29_23 %%%%%%%%%%%%%%%%%%%
node(node29_23).
a_afun(node29_23, pred).         const(pred).
m_form(node29_23, povolan).         const(povolan).
m_lemma(node29_23, povolat__w).         const(povolat__w).
m_tag(node29_23, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node29_23,'v'). const('v'). m_tag1(node29_23,'s'). const('s'). m_tag2(node29_23,'y'). const('y'). m_tag3(node29_23,'s'). const('s'). m_tag7(node29_23,'x'). const('x'). m_tag8(node29_23,'x'). const('x'). m_tag10(node29_23,'a'). const('a'). m_tag11(node29_23,'p'). const('p'). 
%%%%%%%% node29_24 %%%%%%%%%%%%%%%%%%%
node(node29_24).
functor(node29_24, pat).         const(pat).
gram_sempos(node29_24, n_denot).         const(n_denot).
id(node29_24, t_plzensky62815_txt_001_p1s12a14).         const(t_plzensky62815_txt_001_p1s12a14).
t_lemma(node29_24, lzs).         const(lzs).
%%%%%%%% node29_25 %%%%%%%%%%%%%%%%%%%
node(node29_25).
functor(node29_25, rstr).         const(rstr).
gram_sempos(node29_25, n_denot).         const(n_denot).
id(node29_25, t_plzensky62815_txt_001_p1s12a15).         const(t_plzensky62815_txt_001_p1s12a15).
t_lemma(node29_25, vrtulnik).         const(vrtulnik).
%%%%%%%% node29_26 %%%%%%%%%%%%%%%%%%%
node(node29_26).
a_afun(node29_26, atr).         const(atr).
m_form(node29_26, vrtulnik).         const(vrtulnik).
m_lemma(node29_26, vrtulnik).         const(vrtulnik).
m_tag(node29_26, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node29_26,'n'). const('n'). m_tag1(node29_26,'n'). const('n'). m_tag2(node29_26,'i'). const('i'). m_tag3(node29_26,'s'). const('s'). m_tag4(node29_26,'1'). const('1'). m_tag10(node29_26,'a'). const('a'). 
%%%%%%%% node29_27 %%%%%%%%%%%%%%%%%%%
node(node29_27).
a_afun(node29_27, sb).         const(sb).
m_form(node29_27, lzs).         const(lzs).
m_lemma(node29_27, lzs).         const(lzs).
m_tag(node29_27, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node29_27,'n'). const('n'). m_tag1(node29_27,'n'). const('n'). m_tag2(node29_27,'m'). const('m'). m_tag3(node29_27,'s'). const('s'). m_tag4(node29_27,'1'). const('1'). m_tag10(node29_27,'a'). const('a'). 
edge(node29_0, node29_1).
edge(node29_1, node29_2).
edge(node29_1, node29_3).
edge(node29_3, node29_4).
edge(node29_4, node29_5).
edge(node29_5, node29_6).
edge(node29_4, node29_7).
edge(node29_4, node29_8).
edge(node29_3, node29_9).
edge(node29_9, node29_10).
edge(node29_3, node29_11).
edge(node29_3, node29_12).
edge(node29_3, node29_13).
edge(node29_13, node29_14).
edge(node29_14, node29_15).
edge(node29_13, node29_16).
edge(node29_1, node29_17).
edge(node29_1, node29_18).
edge(node29_18, node29_19).
edge(node29_19, node29_20).
edge(node29_19, node29_21).
edge(node29_18, node29_22).
edge(node29_18, node29_23).
edge(node29_18, node29_24).
edge(node29_24, node29_25).
edge(node29_25, node29_26).
edge(node29_24, node29_27).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby, z toho jedna tezce. 
tree_root(node30_0).
%%%%%%%% node30_0 %%%%%%%%%%%%%%%%%%%
node(node30_0).
id(node30_0, t_plzensky59310_txt_001_p11s2).         const(t_plzensky59310_txt_001_p11s2).
%%%%%%%% node30_1 %%%%%%%%%%%%%%%%%%%
node(node30_1).
functor(node30_1, conj).         const(conj).
id(node30_1, t_plzensky59310_txt_001_p11s2a1).         const(t_plzensky59310_txt_001_p11s2a1).
t_lemma(node30_1, x_comma).         const(x_comma).
%%%%%%%% node30_2 %%%%%%%%%%%%%%%%%%%
node(node30_2).
functor(node30_2, pred).         const(pred).
gram_sempos(node30_2, v).         const(v).
id(node30_2, t_plzensky59310_txt_001_p11s2a2).         const(t_plzensky59310_txt_001_p11s2a2).
t_lemma(node30_2, zranit).         const(zranit).
%%%%%%%% node30_3 %%%%%%%%%%%%%%%%%%%
node(node30_3).
functor(node30_3, act).         const(act).
id(node30_3, t_plzensky59310_txt_001_p11s2a12).         const(t_plzensky59310_txt_001_p11s2a12).
t_lemma(node30_3, x_gen).         const(x_gen).
%%%%%%%% node30_4 %%%%%%%%%%%%%%%%%%%
node(node30_4).
functor(node30_4, twhen).         const(twhen).
gram_sempos(node30_4, n_denot).         const(n_denot).
id(node30_4, t_plzensky59310_txt_001_p11s2a4).         const(t_plzensky59310_txt_001_p11s2a4).
t_lemma(node30_4, nehoda).         const(nehoda).
%%%%%%%% node30_5 %%%%%%%%%%%%%%%%%%%
node(node30_5).
a_afun(node30_5, auxp).         const(auxp).
m_form(node30_5, pri).         const(pri).
m_lemma(node30_5, pri_1).         const(pri_1).
m_tag(node30_5, rr__6__________).         const(rr__6__________).
m_tag0(node30_5,'r'). const('r'). m_tag1(node30_5,'r'). const('r'). m_tag4(node30_5,'6'). const('6'). 
%%%%%%%% node30_6 %%%%%%%%%%%%%%%%%%%
node(node30_6).
a_afun(node30_6, adv).         const(adv).
m_form(node30_6, nehode).         const(nehode).
m_lemma(node30_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node30_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node30_6,'n'). const('n'). m_tag1(node30_6,'n'). const('n'). m_tag2(node30_6,'f'). const('f'). m_tag3(node30_6,'s'). const('s'). m_tag4(node30_6,'6'). const('6'). m_tag10(node30_6,'a'). const('a'). 
%%%%%%%% node30_7 %%%%%%%%%%%%%%%%%%%
node(node30_7).
a_afun(node30_7, auxv).         const(auxv).
m_form(node30_7, byly).         const(byly).
m_lemma(node30_7, byt).         const(byt).
m_tag(node30_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node30_7,'v'). const('v'). m_tag1(node30_7,'p'). const('p'). m_tag2(node30_7,'t'). const('t'). m_tag3(node30_7,'p'). const('p'). m_tag7(node30_7,'x'). const('x'). m_tag8(node30_7,'r'). const('r'). m_tag10(node30_7,'a'). const('a'). m_tag11(node30_7,'a'). const('a'). 
%%%%%%%% node30_8 %%%%%%%%%%%%%%%%%%%
node(node30_8).
a_afun(node30_8, pred).         const(pred).
m_form(node30_8, zraneny).         const(zraneny).
m_lemma(node30_8, zranit__w).         const(zranit__w).
m_tag(node30_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node30_8,'v'). const('v'). m_tag1(node30_8,'s'). const('s'). m_tag2(node30_8,'t'). const('t'). m_tag3(node30_8,'p'). const('p'). m_tag7(node30_8,'x'). const('x'). m_tag8(node30_8,'x'). const('x'). m_tag10(node30_8,'a'). const('a'). m_tag11(node30_8,'p'). const('p'). 
%%%%%%%% node30_9 %%%%%%%%%%%%%%%%%%%
node(node30_9).
functor(node30_9, pat).         const(pat).
gram_sempos(node30_9, n_denot).         const(n_denot).
id(node30_9, t_plzensky59310_txt_001_p11s2a6).         const(t_plzensky59310_txt_001_p11s2a6).
t_lemma(node30_9, osoba).         const(osoba).
%%%%%%%% node30_10 %%%%%%%%%%%%%%%%%%%
node(node30_10).
functor(node30_10, rstr).         const(rstr).
gram_sempos(node30_10, adj_quant_def).         const(adj_quant_def).
id(node30_10, t_plzensky59310_txt_001_p11s2a7).         const(t_plzensky59310_txt_001_p11s2a7).
t_lemma(node30_10, dva).         const(dva).
%%%%%%%% node30_11 %%%%%%%%%%%%%%%%%%%
node(node30_11).
a_afun(node30_11, atr).         const(atr).
m_form(node30_11, dve).         const(dve).
m_lemma(node30_11, dva_2).         const(dva_2).
m_tag(node30_11, clhp1__________).         const(clhp1__________).
m_tag0(node30_11,'c'). const('c'). m_tag1(node30_11,'l'). const('l'). m_tag2(node30_11,'h'). const('h'). m_tag3(node30_11,'p'). const('p'). m_tag4(node30_11,'1'). const('1'). 
%%%%%%%% node30_12 %%%%%%%%%%%%%%%%%%%
node(node30_12).
a_afun(node30_12, sb).         const(sb).
m_form(node30_12, osoby).         const(osoby).
m_lemma(node30_12, osoba).         const(osoba).
m_tag(node30_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node30_12,'n'). const('n'). m_tag1(node30_12,'n'). const('n'). m_tag2(node30_12,'f'). const('f'). m_tag3(node30_12,'p'). const('p'). m_tag4(node30_12,'1'). const('1'). m_tag10(node30_12,'a'). const('a'). 
%%%%%%%% node30_13 %%%%%%%%%%%%%%%%%%%
node(node30_13).
a_afun(node30_13, coord).         const(coord).
m_form(node30_13, x_).         const(x_).
m_lemma(node30_13, x_).         const(x_).
m_tag(node30_13, z______________).         const(z______________).
m_tag0(node30_13,'z'). const('z'). m_tag1(node30_13,':'). const(':'). 
%%%%%%%% node30_14 %%%%%%%%%%%%%%%%%%%
node(node30_14).
functor(node30_14, dir1).         const(dir1).
gram_sempos(node30_14, n_pron_def_demon).         const(n_pron_def_demon).
id(node30_14, t_plzensky59310_txt_001_p11s2a9).         const(t_plzensky59310_txt_001_p11s2a9).
t_lemma(node30_14, ten).         const(ten).
%%%%%%%% node30_15 %%%%%%%%%%%%%%%%%%%
node(node30_15).
a_afun(node30_15, auxp).         const(auxp).
m_form(node30_15, z).         const(z).
m_lemma(node30_15, z_1).         const(z_1).
m_tag(node30_15, rr__2__________).         const(rr__2__________).
m_tag0(node30_15,'r'). const('r'). m_tag1(node30_15,'r'). const('r'). m_tag4(node30_15,'2'). const('2'). 
%%%%%%%% node30_16 %%%%%%%%%%%%%%%%%%%
node(node30_16).
a_afun(node30_16, exd).         const(exd).
m_form(node30_16, toho).         const(toho).
m_lemma(node30_16, ten).         const(ten).
m_tag(node30_16, pdzs2__________).         const(pdzs2__________).
m_tag0(node30_16,'p'). const('p'). m_tag1(node30_16,'d'). const('d'). m_tag2(node30_16,'z'). const('z'). m_tag3(node30_16,'s'). const('s'). m_tag4(node30_16,'2'). const('2'). 
%%%%%%%% node30_17 %%%%%%%%%%%%%%%%%%%
node(node30_17).
functor(node30_17, rstr).         const(rstr).
gram_sempos(node30_17, n_quant_def).         const(n_quant_def).
id(node30_17, t_plzensky59310_txt_001_p11s2a10).         const(t_plzensky59310_txt_001_p11s2a10).
t_lemma(node30_17, jeden).         const(jeden).
%%%%%%%% node30_18 %%%%%%%%%%%%%%%%%%%
node(node30_18).
a_afun(node30_18, exd).         const(exd).
m_form(node30_18, jedna).         const(jedna).
m_lemma(node30_18, jeden_1).         const(jeden_1).
m_tag(node30_18, clfs1__________).         const(clfs1__________).
m_tag0(node30_18,'c'). const('c'). m_tag1(node30_18,'l'). const('l'). m_tag2(node30_18,'f'). const('f'). m_tag3(node30_18,'s'). const('s'). m_tag4(node30_18,'1'). const('1'). 
%%%%%%%% node30_19 %%%%%%%%%%%%%%%%%%%
node(node30_19).
functor(node30_19, twhen).         const(twhen).
gram_sempos(node30_19, adj_denot).         const(adj_denot).
id(node30_19, t_plzensky59310_txt_001_p11s2a11).         const(t_plzensky59310_txt_001_p11s2a11).
t_lemma(node30_19, tezky).         const(tezky).
%%%%%%%% node30_20 %%%%%%%%%%%%%%%%%%%
node(node30_20).
a_afun(node30_20, exd).         const(exd).
m_form(node30_20, tezce).         const(tezce).
m_lemma(node30_20, tezce).         const(tezce).
m_tag(node30_20, dg_______1a____).         const(dg_______1a____).
m_tag0(node30_20,'d'). const('d'). m_tag1(node30_20,'g'). const('g'). m_tag9(node30_20,'1'). const('1'). m_tag10(node30_20,'a'). const('a'). 
edge(node30_0, node30_1).
edge(node30_1, node30_2).
edge(node30_2, node30_3).
edge(node30_2, node30_4).
edge(node30_4, node30_5).
edge(node30_4, node30_6).
edge(node30_2, node30_7).
edge(node30_2, node30_8).
edge(node30_2, node30_9).
edge(node30_9, node30_10).
edge(node30_10, node30_11).
edge(node30_9, node30_12).
edge(node30_1, node30_13).
edge(node30_1, node30_14).
edge(node30_14, node30_15).
edge(node30_14, node30_16).
edge(node30_1, node30_17).
edge(node30_17, node30_18).
edge(node30_1, node30_19).
edge(node30_19, node30_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% muz pozdeji zemrel. 
tree_root(node31_0).
%%%%%%%% node31_0 %%%%%%%%%%%%%%%%%%%
node(node31_0).
id(node31_0, t_plzensky69691_txt_001_p2s4).         const(t_plzensky69691_txt_001_p2s4).
%%%%%%%% node31_1 %%%%%%%%%%%%%%%%%%%
node(node31_1).
functor(node31_1, pred).         const(pred).
gram_sempos(node31_1, v).         const(v).
id(node31_1, t_plzensky69691_txt_001_p2s4a1).         const(t_plzensky69691_txt_001_p2s4a1).
t_lemma(node31_1, zemrit).         const(zemrit).
%%%%%%%% node31_2 %%%%%%%%%%%%%%%%%%%
node(node31_2).
functor(node31_2, act).         const(act).
gram_sempos(node31_2, n_denot).         const(n_denot).
id(node31_2, t_plzensky69691_txt_001_p2s4a2).         const(t_plzensky69691_txt_001_p2s4a2).
t_lemma(node31_2, muz).         const(muz).
%%%%%%%% node31_3 %%%%%%%%%%%%%%%%%%%
node(node31_3).
a_afun(node31_3, sb).         const(sb).
m_form(node31_3, muz).         const(muz).
m_lemma(node31_3, muz).         const(muz).
m_tag(node31_3, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node31_3,'n'). const('n'). m_tag1(node31_3,'n'). const('n'). m_tag2(node31_3,'m'). const('m'). m_tag3(node31_3,'s'). const('s'). m_tag4(node31_3,'1'). const('1'). m_tag10(node31_3,'a'). const('a'). 
%%%%%%%% node31_4 %%%%%%%%%%%%%%%%%%%
node(node31_4).
functor(node31_4, twhen).         const(twhen).
gram_sempos(node31_4, adv_denot_grad_nneg).         const(adv_denot_grad_nneg).
id(node31_4, t_plzensky69691_txt_001_p2s4a3).         const(t_plzensky69691_txt_001_p2s4a3).
t_lemma(node31_4, pozde).         const(pozde).
%%%%%%%% node31_5 %%%%%%%%%%%%%%%%%%%
node(node31_5).
a_afun(node31_5, adv).         const(adv).
m_form(node31_5, pozdeji).         const(pozdeji).
m_lemma(node31_5, pozde).         const(pozde).
m_tag(node31_5, dg_______2a____).         const(dg_______2a____).
m_tag0(node31_5,'d'). const('d'). m_tag1(node31_5,'g'). const('g'). m_tag9(node31_5,'2'). const('2'). m_tag10(node31_5,'a'). const('a'). 
%%%%%%%% node31_6 %%%%%%%%%%%%%%%%%%%
node(node31_6).
a_afun(node31_6, pred).         const(pred).
m_form(node31_6, zemrel).         const(zemrel).
m_lemma(node31_6, zemrit).         const(zemrit).
m_tag(node31_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node31_6,'v'). const('v'). m_tag1(node31_6,'p'). const('p'). m_tag2(node31_6,'y'). const('y'). m_tag3(node31_6,'s'). const('s'). m_tag7(node31_6,'x'). const('x'). m_tag8(node31_6,'r'). const('r'). m_tag10(node31_6,'a'). const('a'). m_tag11(node31_6,'a'). const('a'). 
edge(node31_0, node31_1).
edge(node31_1, node31_2).
edge(node31_2, node31_3).
edge(node31_1, node31_4).
edge(node31_4, node31_5).
edge(node31_1, node31_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node32_0).
%%%%%%%% node32_0 %%%%%%%%%%%%%%%%%%%
node(node32_0).
id(node32_0, t_plzensky70461_txt_001_p1s12).         const(t_plzensky70461_txt_001_p1s12).
%%%%%%%% node32_1 %%%%%%%%%%%%%%%%%%%
node(node32_1).
functor(node32_1, pred).         const(pred).
gram_sempos(node32_1, v).         const(v).
id(node32_1, t_plzensky70461_txt_001_p1s12a1).         const(t_plzensky70461_txt_001_p1s12a1).
t_lemma(node32_1, zranit).         const(zranit).
%%%%%%%% node32_2 %%%%%%%%%%%%%%%%%%%
node(node32_2).
functor(node32_2, act).         const(act).
id(node32_2, t_plzensky70461_txt_001_p1s12a3).         const(t_plzensky70461_txt_001_p1s12a3).
t_lemma(node32_2, x_gen).         const(x_gen).
%%%%%%%% node32_3 %%%%%%%%%%%%%%%%%%%
node(node32_3).
functor(node32_3, pat).         const(pat).
gram_sempos(node32_3, n_pron_indef).         const(n_pron_indef).
id(node32_3, t_plzensky70461_txt_001_p1s12a2).         const(t_plzensky70461_txt_001_p1s12a2).
t_lemma(node32_3, kdo).         const(kdo).
%%%%%%%% node32_4 %%%%%%%%%%%%%%%%%%%
node(node32_4).
a_afun(node32_4, sb).         const(sb).
m_form(node32_4, nikdo).         const(nikdo).
m_lemma(node32_4, nikdo).         const(nikdo).
m_tag(node32_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node32_4,'p'). const('p'). m_tag1(node32_4,'w'). const('w'). m_tag2(node32_4,'m'). const('m'). m_tag4(node32_4,'1'). const('1'). 
%%%%%%%% node32_5 %%%%%%%%%%%%%%%%%%%
node(node32_5).
a_afun(node32_5, auxv).         const(auxv).
m_form(node32_5, nebyl).         const(nebyl).
m_lemma(node32_5, byt).         const(byt).
m_tag(node32_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node32_5,'v'). const('v'). m_tag1(node32_5,'p'). const('p'). m_tag2(node32_5,'y'). const('y'). m_tag3(node32_5,'s'). const('s'). m_tag7(node32_5,'x'). const('x'). m_tag8(node32_5,'r'). const('r'). m_tag10(node32_5,'n'). const('n'). m_tag11(node32_5,'a'). const('a'). 
%%%%%%%% node32_6 %%%%%%%%%%%%%%%%%%%
node(node32_6).
a_afun(node32_6, pred).         const(pred).
m_form(node32_6, zranen).         const(zranen).
m_lemma(node32_6, zranit__w).         const(zranit__w).
m_tag(node32_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node32_6,'v'). const('v'). m_tag1(node32_6,'s'). const('s'). m_tag2(node32_6,'y'). const('y'). m_tag3(node32_6,'s'). const('s'). m_tag7(node32_6,'x'). const('x'). m_tag8(node32_6,'x'). const('x'). m_tag10(node32_6,'a'). const('a'). m_tag11(node32_6,'p'). const('p'). 
edge(node32_0, node32_1).
edge(node32_1, node32_2).
edge(node32_1, node32_3).
edge(node32_3, node32_4).
edge(node32_1, node32_5).
edge(node32_1, node32_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node33_0).
%%%%%%%% node33_0 %%%%%%%%%%%%%%%%%%%
node(node33_0).
id(node33_0, t_plzensky49244_txt_001_p1s2).         const(t_plzensky49244_txt_001_p1s2).
%%%%%%%% node33_1 %%%%%%%%%%%%%%%%%%%
node(node33_1).
functor(node33_1, pred).         const(pred).
gram_sempos(node33_1, v).         const(v).
id(node33_1, t_plzensky49244_txt_001_p1s2a1).         const(t_plzensky49244_txt_001_p1s2a1).
t_lemma(node33_1, zranit).         const(zranit).
%%%%%%%% node33_2 %%%%%%%%%%%%%%%%%%%
node(node33_2).
functor(node33_2, act).         const(act).
id(node33_2, t_plzensky49244_txt_001_p1s2a3).         const(t_plzensky49244_txt_001_p1s2a3).
t_lemma(node33_2, x_gen).         const(x_gen).
%%%%%%%% node33_3 %%%%%%%%%%%%%%%%%%%
node(node33_3).
functor(node33_3, pat).         const(pat).
gram_sempos(node33_3, n_pron_indef).         const(n_pron_indef).
id(node33_3, t_plzensky49244_txt_001_p1s2a2).         const(t_plzensky49244_txt_001_p1s2a2).
t_lemma(node33_3, kdo).         const(kdo).
%%%%%%%% node33_4 %%%%%%%%%%%%%%%%%%%
node(node33_4).
a_afun(node33_4, sb).         const(sb).
m_form(node33_4, nikdo).         const(nikdo).
m_lemma(node33_4, nikdo).         const(nikdo).
m_tag(node33_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node33_4,'p'). const('p'). m_tag1(node33_4,'w'). const('w'). m_tag2(node33_4,'m'). const('m'). m_tag4(node33_4,'1'). const('1'). 
%%%%%%%% node33_5 %%%%%%%%%%%%%%%%%%%
node(node33_5).
a_afun(node33_5, auxv).         const(auxv).
m_form(node33_5, nebyl).         const(nebyl).
m_lemma(node33_5, byt).         const(byt).
m_tag(node33_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node33_5,'v'). const('v'). m_tag1(node33_5,'p'). const('p'). m_tag2(node33_5,'y'). const('y'). m_tag3(node33_5,'s'). const('s'). m_tag7(node33_5,'x'). const('x'). m_tag8(node33_5,'r'). const('r'). m_tag10(node33_5,'n'). const('n'). m_tag11(node33_5,'a'). const('a'). 
%%%%%%%% node33_6 %%%%%%%%%%%%%%%%%%%
node(node33_6).
a_afun(node33_6, pred).         const(pred).
m_form(node33_6, zranen).         const(zranen).
m_lemma(node33_6, zranit__w).         const(zranit__w).
m_tag(node33_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node33_6,'v'). const('v'). m_tag1(node33_6,'s'). const('s'). m_tag2(node33_6,'y'). const('y'). m_tag3(node33_6,'s'). const('s'). m_tag7(node33_6,'x'). const('x'). m_tag8(node33_6,'x'). const('x'). m_tag10(node33_6,'a'). const('a'). m_tag11(node33_6,'p'). const('p'). 
edge(node33_0, node33_1).
edge(node33_1, node33_2).
edge(node33_1, node33_3).
edge(node33_3, node33_4).
edge(node33_1, node33_5).
edge(node33_1, node33_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridicka vozidla nebyla nastesti zranena. 
tree_root(node34_0).
%%%%%%%% node34_0 %%%%%%%%%%%%%%%%%%%
node(node34_0).
id(node34_0, t_plzensky49244_txt_001_p1s8).         const(t_plzensky49244_txt_001_p1s8).
%%%%%%%% node34_1 %%%%%%%%%%%%%%%%%%%
node(node34_1).
functor(node34_1, pred).         const(pred).
gram_sempos(node34_1, v).         const(v).
id(node34_1, t_plzensky49244_txt_001_p1s8a1).         const(t_plzensky49244_txt_001_p1s8a1).
t_lemma(node34_1, zranit).         const(zranit).
%%%%%%%% node34_2 %%%%%%%%%%%%%%%%%%%
node(node34_2).
functor(node34_2, act).         const(act).
id(node34_2, t_plzensky49244_txt_001_p1s8a6).         const(t_plzensky49244_txt_001_p1s8a6).
t_lemma(node34_2, x_gen).         const(x_gen).
%%%%%%%% node34_3 %%%%%%%%%%%%%%%%%%%
node(node34_3).
functor(node34_3, pat).         const(pat).
gram_sempos(node34_3, n_denot).         const(n_denot).
id(node34_3, t_plzensky49244_txt_001_p1s8a2).         const(t_plzensky49244_txt_001_p1s8a2).
t_lemma(node34_3, ridicka).         const(ridicka).
%%%%%%%% node34_4 %%%%%%%%%%%%%%%%%%%
node(node34_4).
a_afun(node34_4, sb).         const(sb).
m_form(node34_4, ridicka).         const(ridicka).
m_lemma(node34_4, ridicka____2_).         const(ridicka____2_).
m_tag(node34_4, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node34_4,'n'). const('n'). m_tag1(node34_4,'n'). const('n'). m_tag2(node34_4,'f'). const('f'). m_tag3(node34_4,'s'). const('s'). m_tag4(node34_4,'1'). const('1'). m_tag10(node34_4,'a'). const('a'). 
%%%%%%%% node34_5 %%%%%%%%%%%%%%%%%%%
node(node34_5).
functor(node34_5, app).         const(app).
gram_sempos(node34_5, n_denot).         const(n_denot).
id(node34_5, t_plzensky49244_txt_001_p1s8a3).         const(t_plzensky49244_txt_001_p1s8a3).
t_lemma(node34_5, vozidlo).         const(vozidlo).
%%%%%%%% node34_6 %%%%%%%%%%%%%%%%%%%
node(node34_6).
a_afun(node34_6, atr).         const(atr).
m_form(node34_6, vozidla).         const(vozidla).
m_lemma(node34_6, vozidlo).         const(vozidlo).
m_tag(node34_6, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node34_6,'n'). const('n'). m_tag1(node34_6,'n'). const('n'). m_tag2(node34_6,'n'). const('n'). m_tag3(node34_6,'s'). const('s'). m_tag4(node34_6,'2'). const('2'). m_tag10(node34_6,'a'). const('a'). 
%%%%%%%% node34_7 %%%%%%%%%%%%%%%%%%%
node(node34_7).
functor(node34_7, att).         const(att).
id(node34_7, t_plzensky49244_txt_001_p1s8a5).         const(t_plzensky49244_txt_001_p1s8a5).
t_lemma(node34_7, nastesti).         const(nastesti).
%%%%%%%% node34_8 %%%%%%%%%%%%%%%%%%%
node(node34_8).
a_afun(node34_8, adv).         const(adv).
m_form(node34_8, nastesti).         const(nastesti).
m_lemma(node34_8, nastesti).         const(nastesti).
m_tag(node34_8, db_____________).         const(db_____________).
m_tag0(node34_8,'d'). const('d'). m_tag1(node34_8,'b'). const('b'). 
%%%%%%%% node34_9 %%%%%%%%%%%%%%%%%%%
node(node34_9).
a_afun(node34_9, auxv).         const(auxv).
m_form(node34_9, nebyla).         const(nebyla).
m_lemma(node34_9, byt).         const(byt).
m_tag(node34_9, vpqw___xr_na___).         const(vpqw___xr_na___).
m_tag0(node34_9,'v'). const('v'). m_tag1(node34_9,'p'). const('p'). m_tag2(node34_9,'q'). const('q'). m_tag3(node34_9,'w'). const('w'). m_tag7(node34_9,'x'). const('x'). m_tag8(node34_9,'r'). const('r'). m_tag10(node34_9,'n'). const('n'). m_tag11(node34_9,'a'). const('a'). 
%%%%%%%% node34_10 %%%%%%%%%%%%%%%%%%%
node(node34_10).
a_afun(node34_10, pred).         const(pred).
m_form(node34_10, zranena).         const(zranena).
m_lemma(node34_10, zranit__w).         const(zranit__w).
m_tag(node34_10, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node34_10,'v'). const('v'). m_tag1(node34_10,'s'). const('s'). m_tag2(node34_10,'q'). const('q'). m_tag3(node34_10,'w'). const('w'). m_tag7(node34_10,'x'). const('x'). m_tag8(node34_10,'x'). const('x'). m_tag10(node34_10,'a'). const('a'). m_tag11(node34_10,'p'). const('p'). 
edge(node34_0, node34_1).
edge(node34_1, node34_2).
edge(node34_1, node34_3).
edge(node34_3, node34_4).
edge(node34_3, node34_5).
edge(node34_5, node34_6).
edge(node34_1, node34_7).
edge(node34_7, node34_8).
edge(node34_1, node34_9).
edge(node34_1, node34_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri pozaru byl zranen muz, ktery vyskocil z okna v podkrovi. 
tree_root(node35_0).
%%%%%%%% node35_0 %%%%%%%%%%%%%%%%%%%
node(node35_0).
id(node35_0, t_plzensky78857_txt_001_p1s7).         const(t_plzensky78857_txt_001_p1s7).
%%%%%%%% node35_1 %%%%%%%%%%%%%%%%%%%
node(node35_1).
functor(node35_1, pred).         const(pred).
gram_sempos(node35_1, v).         const(v).
id(node35_1, t_plzensky78857_txt_001_p1s7a1).         const(t_plzensky78857_txt_001_p1s7a1).
t_lemma(node35_1, zranit).         const(zranit).
%%%%%%%% node35_2 %%%%%%%%%%%%%%%%%%%
node(node35_2).
functor(node35_2, act).         const(act).
id(node35_2, t_plzensky78857_txt_001_p1s7a13).         const(t_plzensky78857_txt_001_p1s7a13).
t_lemma(node35_2, x_gen).         const(x_gen).
%%%%%%%% node35_3 %%%%%%%%%%%%%%%%%%%
node(node35_3).
functor(node35_3, twhen).         const(twhen).
gram_sempos(node35_3, n_denot).         const(n_denot).
id(node35_3, t_plzensky78857_txt_001_p1s7a3).         const(t_plzensky78857_txt_001_p1s7a3).
t_lemma(node35_3, pozar).         const(pozar).
%%%%%%%% node35_4 %%%%%%%%%%%%%%%%%%%
node(node35_4).
a_afun(node35_4, auxp).         const(auxp).
m_form(node35_4, pri).         const(pri).
m_lemma(node35_4, pri_1).         const(pri_1).
m_tag(node35_4, rr__6__________).         const(rr__6__________).
m_tag0(node35_4,'r'). const('r'). m_tag1(node35_4,'r'). const('r'). m_tag4(node35_4,'6'). const('6'). 
%%%%%%%% node35_5 %%%%%%%%%%%%%%%%%%%
node(node35_5).
a_afun(node35_5, adv).         const(adv).
m_form(node35_5, pozaru).         const(pozaru).
m_lemma(node35_5, pozar).         const(pozar).
m_tag(node35_5, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node35_5,'n'). const('n'). m_tag1(node35_5,'n'). const('n'). m_tag2(node35_5,'i'). const('i'). m_tag3(node35_5,'s'). const('s'). m_tag4(node35_5,'6'). const('6'). m_tag10(node35_5,'a'). const('a'). 
%%%%%%%% node35_6 %%%%%%%%%%%%%%%%%%%
node(node35_6).
a_afun(node35_6, auxv).         const(auxv).
m_form(node35_6, byl).         const(byl).
m_lemma(node35_6, byt).         const(byt).
m_tag(node35_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node35_6,'v'). const('v'). m_tag1(node35_6,'p'). const('p'). m_tag2(node35_6,'y'). const('y'). m_tag3(node35_6,'s'). const('s'). m_tag7(node35_6,'x'). const('x'). m_tag8(node35_6,'r'). const('r'). m_tag10(node35_6,'a'). const('a'). m_tag11(node35_6,'a'). const('a'). 
%%%%%%%% node35_7 %%%%%%%%%%%%%%%%%%%
node(node35_7).
a_afun(node35_7, pred).         const(pred).
m_form(node35_7, zranen).         const(zranen).
m_lemma(node35_7, zranit__w).         const(zranit__w).
m_tag(node35_7, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node35_7,'v'). const('v'). m_tag1(node35_7,'s'). const('s'). m_tag2(node35_7,'y'). const('y'). m_tag3(node35_7,'s'). const('s'). m_tag7(node35_7,'x'). const('x'). m_tag8(node35_7,'x'). const('x'). m_tag10(node35_7,'a'). const('a'). m_tag11(node35_7,'p'). const('p'). 
%%%%%%%% node35_8 %%%%%%%%%%%%%%%%%%%
node(node35_8).
functor(node35_8, pat).         const(pat).
gram_sempos(node35_8, n_denot).         const(n_denot).
id(node35_8, t_plzensky78857_txt_001_p1s7a5).         const(t_plzensky78857_txt_001_p1s7a5).
t_lemma(node35_8, muz).         const(muz).
%%%%%%%% node35_9 %%%%%%%%%%%%%%%%%%%
node(node35_9).
a_afun(node35_9, sb).         const(sb).
m_form(node35_9, muz).         const(muz).
m_lemma(node35_9, muz).         const(muz).
m_tag(node35_9, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node35_9,'n'). const('n'). m_tag1(node35_9,'n'). const('n'). m_tag2(node35_9,'m'). const('m'). m_tag3(node35_9,'s'). const('s'). m_tag4(node35_9,'1'). const('1'). m_tag10(node35_9,'a'). const('a'). 
%%%%%%%% node35_10 %%%%%%%%%%%%%%%%%%%
node(node35_10).
functor(node35_10, rstr).         const(rstr).
gram_sempos(node35_10, v).         const(v).
id(node35_10, t_plzensky78857_txt_001_p1s7a6).         const(t_plzensky78857_txt_001_p1s7a6).
t_lemma(node35_10, vyskocit).         const(vyskocit).
%%%%%%%% node35_11 %%%%%%%%%%%%%%%%%%%
node(node35_11).
functor(node35_11, act).         const(act).
gram_sempos(node35_11, n_pron_indef).         const(n_pron_indef).
id(node35_11, t_plzensky78857_txt_001_p1s7a8).         const(t_plzensky78857_txt_001_p1s7a8).
t_lemma(node35_11, ktery).         const(ktery).
%%%%%%%% node35_12 %%%%%%%%%%%%%%%%%%%
node(node35_12).
a_afun(node35_12, sb).         const(sb).
m_form(node35_12, ktery).         const(ktery).
m_lemma(node35_12, ktery).         const(ktery).
m_tag(node35_12, p4ys1__________).         const(p4ys1__________).
m_tag0(node35_12,'p'). const('p'). m_tag1(node35_12,'4'). const('4'). m_tag2(node35_12,'y'). const('y'). m_tag3(node35_12,'s'). const('s'). m_tag4(node35_12,'1'). const('1'). 
%%%%%%%% node35_13 %%%%%%%%%%%%%%%%%%%
node(node35_13).
a_afun(node35_13, atr).         const(atr).
m_form(node35_13, vyskocil).         const(vyskocil).
m_lemma(node35_13, vyskocit__w).         const(vyskocit__w).
m_tag(node35_13, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node35_13,'v'). const('v'). m_tag1(node35_13,'p'). const('p'). m_tag2(node35_13,'y'). const('y'). m_tag3(node35_13,'s'). const('s'). m_tag7(node35_13,'x'). const('x'). m_tag8(node35_13,'r'). const('r'). m_tag10(node35_13,'a'). const('a'). m_tag11(node35_13,'a'). const('a'). 
%%%%%%%% node35_14 %%%%%%%%%%%%%%%%%%%
node(node35_14).
functor(node35_14, dir1).         const(dir1).
gram_sempos(node35_14, n_denot).         const(n_denot).
id(node35_14, t_plzensky78857_txt_001_p1s7a10).         const(t_plzensky78857_txt_001_p1s7a10).
t_lemma(node35_14, okno).         const(okno).
%%%%%%%% node35_15 %%%%%%%%%%%%%%%%%%%
node(node35_15).
a_afun(node35_15, auxp).         const(auxp).
m_form(node35_15, z).         const(z).
m_lemma(node35_15, z_1).         const(z_1).
m_tag(node35_15, rr__2__________).         const(rr__2__________).
m_tag0(node35_15,'r'). const('r'). m_tag1(node35_15,'r'). const('r'). m_tag4(node35_15,'2'). const('2'). 
%%%%%%%% node35_16 %%%%%%%%%%%%%%%%%%%
node(node35_16).
a_afun(node35_16, adv).         const(adv).
m_form(node35_16, okna).         const(okna).
m_lemma(node35_16, okno).         const(okno).
m_tag(node35_16, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node35_16,'n'). const('n'). m_tag1(node35_16,'n'). const('n'). m_tag2(node35_16,'n'). const('n'). m_tag3(node35_16,'s'). const('s'). m_tag4(node35_16,'2'). const('2'). m_tag10(node35_16,'a'). const('a'). 
%%%%%%%% node35_17 %%%%%%%%%%%%%%%%%%%
node(node35_17).
functor(node35_17, loc).         const(loc).
gram_sempos(node35_17, n_denot).         const(n_denot).
id(node35_17, t_plzensky78857_txt_001_p1s7a12).         const(t_plzensky78857_txt_001_p1s7a12).
t_lemma(node35_17, podkrovi).         const(podkrovi).
%%%%%%%% node35_18 %%%%%%%%%%%%%%%%%%%
node(node35_18).
a_afun(node35_18, auxp).         const(auxp).
m_form(node35_18, v).         const(v).
m_lemma(node35_18, v_1).         const(v_1).
m_tag(node35_18, rr__6__________).         const(rr__6__________).
m_tag0(node35_18,'r'). const('r'). m_tag1(node35_18,'r'). const('r'). m_tag4(node35_18,'6'). const('6'). 
%%%%%%%% node35_19 %%%%%%%%%%%%%%%%%%%
node(node35_19).
a_afun(node35_19, adv).         const(adv).
m_form(node35_19, podkrovi).         const(podkrovi).
m_lemma(node35_19, podkrovi).         const(podkrovi).
m_tag(node35_19, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node35_19,'n'). const('n'). m_tag1(node35_19,'n'). const('n'). m_tag2(node35_19,'n'). const('n'). m_tag3(node35_19,'s'). const('s'). m_tag4(node35_19,'6'). const('6'). m_tag10(node35_19,'a'). const('a'). 
edge(node35_0, node35_1).
edge(node35_1, node35_2).
edge(node35_1, node35_3).
edge(node35_3, node35_4).
edge(node35_3, node35_5).
edge(node35_1, node35_6).
edge(node35_1, node35_7).
edge(node35_1, node35_8).
edge(node35_8, node35_9).
edge(node35_8, node35_10).
edge(node35_10, node35_11).
edge(node35_11, node35_12).
edge(node35_10, node35_13).
edge(node35_10, node35_14).
edge(node35_14, node35_15).
edge(node35_14, node35_16).
edge(node35_10, node35_17).
edge(node35_17, node35_18).
edge(node35_17, node35_19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny tri osoby, z toho jedna tezce. 
tree_root(node36_0).
%%%%%%%% node36_0 %%%%%%%%%%%%%%%%%%%
node(node36_0).
id(node36_0, t_plzensky60412_txt_001_p1s2).         const(t_plzensky60412_txt_001_p1s2).
%%%%%%%% node36_1 %%%%%%%%%%%%%%%%%%%
node(node36_1).
functor(node36_1, conj).         const(conj).
id(node36_1, t_plzensky60412_txt_001_p1s2a1).         const(t_plzensky60412_txt_001_p1s2a1).
t_lemma(node36_1, x_comma).         const(x_comma).
%%%%%%%% node36_2 %%%%%%%%%%%%%%%%%%%
node(node36_2).
functor(node36_2, pred).         const(pred).
gram_sempos(node36_2, v).         const(v).
id(node36_2, t_plzensky60412_txt_001_p1s2a2).         const(t_plzensky60412_txt_001_p1s2a2).
t_lemma(node36_2, zranit).         const(zranit).
%%%%%%%% node36_3 %%%%%%%%%%%%%%%%%%%
node(node36_3).
functor(node36_3, act).         const(act).
id(node36_3, t_plzensky60412_txt_001_p1s2a12).         const(t_plzensky60412_txt_001_p1s2a12).
t_lemma(node36_3, x_gen).         const(x_gen).
%%%%%%%% node36_4 %%%%%%%%%%%%%%%%%%%
node(node36_4).
functor(node36_4, twhen).         const(twhen).
gram_sempos(node36_4, n_denot).         const(n_denot).
id(node36_4, t_plzensky60412_txt_001_p1s2a4).         const(t_plzensky60412_txt_001_p1s2a4).
t_lemma(node36_4, nehoda).         const(nehoda).
%%%%%%%% node36_5 %%%%%%%%%%%%%%%%%%%
node(node36_5).
a_afun(node36_5, auxp).         const(auxp).
m_form(node36_5, pri).         const(pri).
m_lemma(node36_5, pri_1).         const(pri_1).
m_tag(node36_5, rr__6__________).         const(rr__6__________).
m_tag0(node36_5,'r'). const('r'). m_tag1(node36_5,'r'). const('r'). m_tag4(node36_5,'6'). const('6'). 
%%%%%%%% node36_6 %%%%%%%%%%%%%%%%%%%
node(node36_6).
a_afun(node36_6, adv).         const(adv).
m_form(node36_6, nehode).         const(nehode).
m_lemma(node36_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node36_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node36_6,'n'). const('n'). m_tag1(node36_6,'n'). const('n'). m_tag2(node36_6,'f'). const('f'). m_tag3(node36_6,'s'). const('s'). m_tag4(node36_6,'6'). const('6'). m_tag10(node36_6,'a'). const('a'). 
%%%%%%%% node36_7 %%%%%%%%%%%%%%%%%%%
node(node36_7).
a_afun(node36_7, auxv).         const(auxv).
m_form(node36_7, byly).         const(byly).
m_lemma(node36_7, byt).         const(byt).
m_tag(node36_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node36_7,'v'). const('v'). m_tag1(node36_7,'p'). const('p'). m_tag2(node36_7,'t'). const('t'). m_tag3(node36_7,'p'). const('p'). m_tag7(node36_7,'x'). const('x'). m_tag8(node36_7,'r'). const('r'). m_tag10(node36_7,'a'). const('a'). m_tag11(node36_7,'a'). const('a'). 
%%%%%%%% node36_8 %%%%%%%%%%%%%%%%%%%
node(node36_8).
a_afun(node36_8, pred).         const(pred).
m_form(node36_8, zraneny).         const(zraneny).
m_lemma(node36_8, zranit__w).         const(zranit__w).
m_tag(node36_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node36_8,'v'). const('v'). m_tag1(node36_8,'s'). const('s'). m_tag2(node36_8,'t'). const('t'). m_tag3(node36_8,'p'). const('p'). m_tag7(node36_8,'x'). const('x'). m_tag8(node36_8,'x'). const('x'). m_tag10(node36_8,'a'). const('a'). m_tag11(node36_8,'p'). const('p'). 
%%%%%%%% node36_9 %%%%%%%%%%%%%%%%%%%
node(node36_9).
functor(node36_9, pat).         const(pat).
gram_sempos(node36_9, n_denot).         const(n_denot).
id(node36_9, t_plzensky60412_txt_001_p1s2a6).         const(t_plzensky60412_txt_001_p1s2a6).
t_lemma(node36_9, osoba).         const(osoba).
%%%%%%%% node36_10 %%%%%%%%%%%%%%%%%%%
node(node36_10).
functor(node36_10, rstr).         const(rstr).
gram_sempos(node36_10, adj_quant_def).         const(adj_quant_def).
id(node36_10, t_plzensky60412_txt_001_p1s2a7).         const(t_plzensky60412_txt_001_p1s2a7).
t_lemma(node36_10, tri).         const(tri).
%%%%%%%% node36_11 %%%%%%%%%%%%%%%%%%%
node(node36_11).
a_afun(node36_11, atr).         const(atr).
m_form(node36_11, tri).         const(tri).
m_lemma(node36_11, tri_3).         const(tri_3).
m_tag(node36_11, clxp1__________).         const(clxp1__________).
m_tag0(node36_11,'c'). const('c'). m_tag1(node36_11,'l'). const('l'). m_tag2(node36_11,'x'). const('x'). m_tag3(node36_11,'p'). const('p'). m_tag4(node36_11,'1'). const('1'). 
%%%%%%%% node36_12 %%%%%%%%%%%%%%%%%%%
node(node36_12).
a_afun(node36_12, sb).         const(sb).
m_form(node36_12, osoby).         const(osoby).
m_lemma(node36_12, osoba).         const(osoba).
m_tag(node36_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node36_12,'n'). const('n'). m_tag1(node36_12,'n'). const('n'). m_tag2(node36_12,'f'). const('f'). m_tag3(node36_12,'p'). const('p'). m_tag4(node36_12,'1'). const('1'). m_tag10(node36_12,'a'). const('a'). 
%%%%%%%% node36_13 %%%%%%%%%%%%%%%%%%%
node(node36_13).
a_afun(node36_13, coord).         const(coord).
m_form(node36_13, x_).         const(x_).
m_lemma(node36_13, x_).         const(x_).
m_tag(node36_13, z______________).         const(z______________).
m_tag0(node36_13,'z'). const('z'). m_tag1(node36_13,':'). const(':'). 
%%%%%%%% node36_14 %%%%%%%%%%%%%%%%%%%
node(node36_14).
functor(node36_14, dir1).         const(dir1).
gram_sempos(node36_14, n_pron_def_demon).         const(n_pron_def_demon).
id(node36_14, t_plzensky60412_txt_001_p1s2a9).         const(t_plzensky60412_txt_001_p1s2a9).
t_lemma(node36_14, ten).         const(ten).
%%%%%%%% node36_15 %%%%%%%%%%%%%%%%%%%
node(node36_15).
a_afun(node36_15, auxp).         const(auxp).
m_form(node36_15, z).         const(z).
m_lemma(node36_15, z_1).         const(z_1).
m_tag(node36_15, rr__2__________).         const(rr__2__________).
m_tag0(node36_15,'r'). const('r'). m_tag1(node36_15,'r'). const('r'). m_tag4(node36_15,'2'). const('2'). 
%%%%%%%% node36_16 %%%%%%%%%%%%%%%%%%%
node(node36_16).
a_afun(node36_16, exd).         const(exd).
m_form(node36_16, toho).         const(toho).
m_lemma(node36_16, ten).         const(ten).
m_tag(node36_16, pdzs2__________).         const(pdzs2__________).
m_tag0(node36_16,'p'). const('p'). m_tag1(node36_16,'d'). const('d'). m_tag2(node36_16,'z'). const('z'). m_tag3(node36_16,'s'). const('s'). m_tag4(node36_16,'2'). const('2'). 
%%%%%%%% node36_17 %%%%%%%%%%%%%%%%%%%
node(node36_17).
functor(node36_17, rstr).         const(rstr).
gram_sempos(node36_17, n_quant_def).         const(n_quant_def).
id(node36_17, t_plzensky60412_txt_001_p1s2a10).         const(t_plzensky60412_txt_001_p1s2a10).
t_lemma(node36_17, jeden).         const(jeden).
%%%%%%%% node36_18 %%%%%%%%%%%%%%%%%%%
node(node36_18).
a_afun(node36_18, exd).         const(exd).
m_form(node36_18, jedna).         const(jedna).
m_lemma(node36_18, jeden_1).         const(jeden_1).
m_tag(node36_18, clfs1__________).         const(clfs1__________).
m_tag0(node36_18,'c'). const('c'). m_tag1(node36_18,'l'). const('l'). m_tag2(node36_18,'f'). const('f'). m_tag3(node36_18,'s'). const('s'). m_tag4(node36_18,'1'). const('1'). 
%%%%%%%% node36_19 %%%%%%%%%%%%%%%%%%%
node(node36_19).
functor(node36_19, twhen).         const(twhen).
gram_sempos(node36_19, adj_denot).         const(adj_denot).
id(node36_19, t_plzensky60412_txt_001_p1s2a11).         const(t_plzensky60412_txt_001_p1s2a11).
t_lemma(node36_19, tezky).         const(tezky).
%%%%%%%% node36_20 %%%%%%%%%%%%%%%%%%%
node(node36_20).
a_afun(node36_20, exd).         const(exd).
m_form(node36_20, tezce).         const(tezce).
m_lemma(node36_20, tezce).         const(tezce).
m_tag(node36_20, dg_______1a____).         const(dg_______1a____).
m_tag0(node36_20,'d'). const('d'). m_tag1(node36_20,'g'). const('g'). m_tag9(node36_20,'1'). const('1'). m_tag10(node36_20,'a'). const('a'). 
edge(node36_0, node36_1).
edge(node36_1, node36_2).
edge(node36_2, node36_3).
edge(node36_2, node36_4).
edge(node36_4, node36_5).
edge(node36_4, node36_6).
edge(node36_2, node36_7).
edge(node36_2, node36_8).
edge(node36_2, node36_9).
edge(node36_9, node36_10).
edge(node36_10, node36_11).
edge(node36_9, node36_12).
edge(node36_1, node36_13).
edge(node36_1, node36_14).
edge(node36_14, node36_15).
edge(node36_14, node36_16).
edge(node36_1, node36_17).
edge(node36_17, node36_18).
edge(node36_1, node36_19).
edge(node36_19, node36_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny tri osoby, z toho jedna tezce. 
tree_root(node37_0).
%%%%%%%% node37_0 %%%%%%%%%%%%%%%%%%%
node(node37_0).
id(node37_0, t_plzensky60412_txt_001_p4s2).         const(t_plzensky60412_txt_001_p4s2).
%%%%%%%% node37_1 %%%%%%%%%%%%%%%%%%%
node(node37_1).
functor(node37_1, conj).         const(conj).
id(node37_1, t_plzensky60412_txt_001_p4s2a1).         const(t_plzensky60412_txt_001_p4s2a1).
t_lemma(node37_1, x_comma).         const(x_comma).
%%%%%%%% node37_2 %%%%%%%%%%%%%%%%%%%
node(node37_2).
functor(node37_2, pred).         const(pred).
gram_sempos(node37_2, v).         const(v).
id(node37_2, t_plzensky60412_txt_001_p4s2a2).         const(t_plzensky60412_txt_001_p4s2a2).
t_lemma(node37_2, zranit).         const(zranit).
%%%%%%%% node37_3 %%%%%%%%%%%%%%%%%%%
node(node37_3).
functor(node37_3, act).         const(act).
id(node37_3, t_plzensky60412_txt_001_p4s2a12).         const(t_plzensky60412_txt_001_p4s2a12).
t_lemma(node37_3, x_gen).         const(x_gen).
%%%%%%%% node37_4 %%%%%%%%%%%%%%%%%%%
node(node37_4).
functor(node37_4, twhen).         const(twhen).
gram_sempos(node37_4, n_denot).         const(n_denot).
id(node37_4, t_plzensky60412_txt_001_p4s2a4).         const(t_plzensky60412_txt_001_p4s2a4).
t_lemma(node37_4, nehoda).         const(nehoda).
%%%%%%%% node37_5 %%%%%%%%%%%%%%%%%%%
node(node37_5).
a_afun(node37_5, auxp).         const(auxp).
m_form(node37_5, pri).         const(pri).
m_lemma(node37_5, pri_1).         const(pri_1).
m_tag(node37_5, rr__6__________).         const(rr__6__________).
m_tag0(node37_5,'r'). const('r'). m_tag1(node37_5,'r'). const('r'). m_tag4(node37_5,'6'). const('6'). 
%%%%%%%% node37_6 %%%%%%%%%%%%%%%%%%%
node(node37_6).
a_afun(node37_6, adv).         const(adv).
m_form(node37_6, nehode).         const(nehode).
m_lemma(node37_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node37_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node37_6,'n'). const('n'). m_tag1(node37_6,'n'). const('n'). m_tag2(node37_6,'f'). const('f'). m_tag3(node37_6,'s'). const('s'). m_tag4(node37_6,'6'). const('6'). m_tag10(node37_6,'a'). const('a'). 
%%%%%%%% node37_7 %%%%%%%%%%%%%%%%%%%
node(node37_7).
a_afun(node37_7, auxv).         const(auxv).
m_form(node37_7, byly).         const(byly).
m_lemma(node37_7, byt).         const(byt).
m_tag(node37_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node37_7,'v'). const('v'). m_tag1(node37_7,'p'). const('p'). m_tag2(node37_7,'t'). const('t'). m_tag3(node37_7,'p'). const('p'). m_tag7(node37_7,'x'). const('x'). m_tag8(node37_7,'r'). const('r'). m_tag10(node37_7,'a'). const('a'). m_tag11(node37_7,'a'). const('a'). 
%%%%%%%% node37_8 %%%%%%%%%%%%%%%%%%%
node(node37_8).
a_afun(node37_8, pred).         const(pred).
m_form(node37_8, zraneny).         const(zraneny).
m_lemma(node37_8, zranit__w).         const(zranit__w).
m_tag(node37_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node37_8,'v'). const('v'). m_tag1(node37_8,'s'). const('s'). m_tag2(node37_8,'t'). const('t'). m_tag3(node37_8,'p'). const('p'). m_tag7(node37_8,'x'). const('x'). m_tag8(node37_8,'x'). const('x'). m_tag10(node37_8,'a'). const('a'). m_tag11(node37_8,'p'). const('p'). 
%%%%%%%% node37_9 %%%%%%%%%%%%%%%%%%%
node(node37_9).
functor(node37_9, pat).         const(pat).
gram_sempos(node37_9, n_denot).         const(n_denot).
id(node37_9, t_plzensky60412_txt_001_p4s2a6).         const(t_plzensky60412_txt_001_p4s2a6).
t_lemma(node37_9, osoba).         const(osoba).
%%%%%%%% node37_10 %%%%%%%%%%%%%%%%%%%
node(node37_10).
functor(node37_10, rstr).         const(rstr).
gram_sempos(node37_10, adj_quant_def).         const(adj_quant_def).
id(node37_10, t_plzensky60412_txt_001_p4s2a7).         const(t_plzensky60412_txt_001_p4s2a7).
t_lemma(node37_10, tri).         const(tri).
%%%%%%%% node37_11 %%%%%%%%%%%%%%%%%%%
node(node37_11).
a_afun(node37_11, atr).         const(atr).
m_form(node37_11, tri).         const(tri).
m_lemma(node37_11, tri_3).         const(tri_3).
m_tag(node37_11, clxp1__________).         const(clxp1__________).
m_tag0(node37_11,'c'). const('c'). m_tag1(node37_11,'l'). const('l'). m_tag2(node37_11,'x'). const('x'). m_tag3(node37_11,'p'). const('p'). m_tag4(node37_11,'1'). const('1'). 
%%%%%%%% node37_12 %%%%%%%%%%%%%%%%%%%
node(node37_12).
a_afun(node37_12, sb).         const(sb).
m_form(node37_12, osoby).         const(osoby).
m_lemma(node37_12, osoba).         const(osoba).
m_tag(node37_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node37_12,'n'). const('n'). m_tag1(node37_12,'n'). const('n'). m_tag2(node37_12,'f'). const('f'). m_tag3(node37_12,'p'). const('p'). m_tag4(node37_12,'1'). const('1'). m_tag10(node37_12,'a'). const('a'). 
%%%%%%%% node37_13 %%%%%%%%%%%%%%%%%%%
node(node37_13).
a_afun(node37_13, coord).         const(coord).
m_form(node37_13, x_).         const(x_).
m_lemma(node37_13, x_).         const(x_).
m_tag(node37_13, z______________).         const(z______________).
m_tag0(node37_13,'z'). const('z'). m_tag1(node37_13,':'). const(':'). 
%%%%%%%% node37_14 %%%%%%%%%%%%%%%%%%%
node(node37_14).
functor(node37_14, dir1).         const(dir1).
gram_sempos(node37_14, n_pron_def_demon).         const(n_pron_def_demon).
id(node37_14, t_plzensky60412_txt_001_p4s2a9).         const(t_plzensky60412_txt_001_p4s2a9).
t_lemma(node37_14, ten).         const(ten).
%%%%%%%% node37_15 %%%%%%%%%%%%%%%%%%%
node(node37_15).
a_afun(node37_15, auxp).         const(auxp).
m_form(node37_15, z).         const(z).
m_lemma(node37_15, z_1).         const(z_1).
m_tag(node37_15, rr__2__________).         const(rr__2__________).
m_tag0(node37_15,'r'). const('r'). m_tag1(node37_15,'r'). const('r'). m_tag4(node37_15,'2'). const('2'). 
%%%%%%%% node37_16 %%%%%%%%%%%%%%%%%%%
node(node37_16).
a_afun(node37_16, exd).         const(exd).
m_form(node37_16, toho).         const(toho).
m_lemma(node37_16, ten).         const(ten).
m_tag(node37_16, pdzs2__________).         const(pdzs2__________).
m_tag0(node37_16,'p'). const('p'). m_tag1(node37_16,'d'). const('d'). m_tag2(node37_16,'z'). const('z'). m_tag3(node37_16,'s'). const('s'). m_tag4(node37_16,'2'). const('2'). 
%%%%%%%% node37_17 %%%%%%%%%%%%%%%%%%%
node(node37_17).
functor(node37_17, rstr).         const(rstr).
gram_sempos(node37_17, n_quant_def).         const(n_quant_def).
id(node37_17, t_plzensky60412_txt_001_p4s2a10).         const(t_plzensky60412_txt_001_p4s2a10).
t_lemma(node37_17, jeden).         const(jeden).
%%%%%%%% node37_18 %%%%%%%%%%%%%%%%%%%
node(node37_18).
a_afun(node37_18, exd).         const(exd).
m_form(node37_18, jedna).         const(jedna).
m_lemma(node37_18, jeden_1).         const(jeden_1).
m_tag(node37_18, clfs1__________).         const(clfs1__________).
m_tag0(node37_18,'c'). const('c'). m_tag1(node37_18,'l'). const('l'). m_tag2(node37_18,'f'). const('f'). m_tag3(node37_18,'s'). const('s'). m_tag4(node37_18,'1'). const('1'). 
%%%%%%%% node37_19 %%%%%%%%%%%%%%%%%%%
node(node37_19).
functor(node37_19, twhen).         const(twhen).
gram_sempos(node37_19, adj_denot).         const(adj_denot).
id(node37_19, t_plzensky60412_txt_001_p4s2a11).         const(t_plzensky60412_txt_001_p4s2a11).
t_lemma(node37_19, tezky).         const(tezky).
%%%%%%%% node37_20 %%%%%%%%%%%%%%%%%%%
node(node37_20).
a_afun(node37_20, exd).         const(exd).
m_form(node37_20, tezce).         const(tezce).
m_lemma(node37_20, tezce).         const(tezce).
m_tag(node37_20, dg_______1a____).         const(dg_______1a____).
m_tag0(node37_20,'d'). const('d'). m_tag1(node37_20,'g'). const('g'). m_tag9(node37_20,'1'). const('1'). m_tag10(node37_20,'a'). const('a'). 
edge(node37_0, node37_1).
edge(node37_1, node37_2).
edge(node37_2, node37_3).
edge(node37_2, node37_4).
edge(node37_4, node37_5).
edge(node37_4, node37_6).
edge(node37_2, node37_7).
edge(node37_2, node37_8).
edge(node37_2, node37_9).
edge(node37_9, node37_10).
edge(node37_10, node37_11).
edge(node37_9, node37_12).
edge(node37_1, node37_13).
edge(node37_1, node37_14).
edge(node37_14, node37_15).
edge(node37_14, node37_16).
edge(node37_1, node37_17).
edge(node37_17, node37_18).
edge(node37_1, node37_19).
edge(node37_19, node37_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node38_0).
%%%%%%%% node38_0 %%%%%%%%%%%%%%%%%%%
node(node38_0).
id(node38_0, t_plzensky54670_txt_001_p1s3).         const(t_plzensky54670_txt_001_p1s3).
%%%%%%%% node38_1 %%%%%%%%%%%%%%%%%%%
node(node38_1).
functor(node38_1, pred).         const(pred).
gram_sempos(node38_1, v).         const(v).
id(node38_1, t_plzensky54670_txt_001_p1s3a1).         const(t_plzensky54670_txt_001_p1s3a1).
t_lemma(node38_1, zranit).         const(zranit).
%%%%%%%% node38_2 %%%%%%%%%%%%%%%%%%%
node(node38_2).
functor(node38_2, act).         const(act).
id(node38_2, t_plzensky54670_txt_001_p1s3a3).         const(t_plzensky54670_txt_001_p1s3a3).
t_lemma(node38_2, x_gen).         const(x_gen).
%%%%%%%% node38_3 %%%%%%%%%%%%%%%%%%%
node(node38_3).
functor(node38_3, pat).         const(pat).
gram_sempos(node38_3, n_pron_indef).         const(n_pron_indef).
id(node38_3, t_plzensky54670_txt_001_p1s3a2).         const(t_plzensky54670_txt_001_p1s3a2).
t_lemma(node38_3, kdo).         const(kdo).
%%%%%%%% node38_4 %%%%%%%%%%%%%%%%%%%
node(node38_4).
a_afun(node38_4, sb).         const(sb).
m_form(node38_4, nikdo).         const(nikdo).
m_lemma(node38_4, nikdo).         const(nikdo).
m_tag(node38_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node38_4,'p'). const('p'). m_tag1(node38_4,'w'). const('w'). m_tag2(node38_4,'m'). const('m'). m_tag4(node38_4,'1'). const('1'). 
%%%%%%%% node38_5 %%%%%%%%%%%%%%%%%%%
node(node38_5).
a_afun(node38_5, auxv).         const(auxv).
m_form(node38_5, nebyl).         const(nebyl).
m_lemma(node38_5, byt).         const(byt).
m_tag(node38_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node38_5,'v'). const('v'). m_tag1(node38_5,'p'). const('p'). m_tag2(node38_5,'y'). const('y'). m_tag3(node38_5,'s'). const('s'). m_tag7(node38_5,'x'). const('x'). m_tag8(node38_5,'r'). const('r'). m_tag10(node38_5,'n'). const('n'). m_tag11(node38_5,'a'). const('a'). 
%%%%%%%% node38_6 %%%%%%%%%%%%%%%%%%%
node(node38_6).
a_afun(node38_6, pred).         const(pred).
m_form(node38_6, zranen).         const(zranen).
m_lemma(node38_6, zranit__w).         const(zranit__w).
m_tag(node38_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node38_6,'v'). const('v'). m_tag1(node38_6,'s'). const('s'). m_tag2(node38_6,'y'). const('y'). m_tag3(node38_6,'s'). const('s'). m_tag7(node38_6,'x'). const('x'). m_tag8(node38_6,'x'). const('x'). m_tag10(node38_6,'a'). const('a'). m_tag11(node38_6,'p'). const('p'). 
edge(node38_0, node38_1).
edge(node38_1, node38_2).
edge(node38_1, node38_3).
edge(node38_3, node38_4).
edge(node38_1, node38_5).
edge(node38_1, node38_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny dve osoby, jedna z nich byla zaklinena ve vozidle a stezovala si na bolest zeber a sok. 
tree_root(node39_0).
%%%%%%%% node39_0 %%%%%%%%%%%%%%%%%%%
node(node39_0).
id(node39_0, t_plzensky57770_txt_001_p5s2).         const(t_plzensky57770_txt_001_p5s2).
%%%%%%%% node39_1 %%%%%%%%%%%%%%%%%%%
node(node39_1).
functor(node39_1, conj).         const(conj).
id(node39_1, t_plzensky57770_txt_001_p5s2a1).         const(t_plzensky57770_txt_001_p5s2a1).
t_lemma(node39_1, a).         const(a).
%%%%%%%% node39_2 %%%%%%%%%%%%%%%%%%%
node(node39_2).
functor(node39_2, rstr).         const(rstr).
id(node39_2, t_plzensky57770_txt_001_p5s2a2).         const(t_plzensky57770_txt_001_p5s2a2).
t_lemma(node39_2, x_comma).         const(x_comma).
%%%%%%%% node39_3 %%%%%%%%%%%%%%%%%%%
node(node39_3).
functor(node39_3, rstr).         const(rstr).
gram_sempos(node39_3, v).         const(v).
id(node39_3, t_plzensky57770_txt_001_p5s2a3).         const(t_plzensky57770_txt_001_p5s2a3).
t_lemma(node39_3, zranit).         const(zranit).
%%%%%%%% node39_4 %%%%%%%%%%%%%%%%%%%
node(node39_4).
functor(node39_4, act).         const(act).
id(node39_4, t_plzensky57770_txt_001_p5s2a23).         const(t_plzensky57770_txt_001_p5s2a23).
t_lemma(node39_4, x_gen).         const(x_gen).
%%%%%%%% node39_5 %%%%%%%%%%%%%%%%%%%
node(node39_5).
functor(node39_5, twhen).         const(twhen).
gram_sempos(node39_5, n_denot).         const(n_denot).
id(node39_5, t_plzensky57770_txt_001_p5s2a5).         const(t_plzensky57770_txt_001_p5s2a5).
t_lemma(node39_5, nehoda).         const(nehoda).
%%%%%%%% node39_6 %%%%%%%%%%%%%%%%%%%
node(node39_6).
a_afun(node39_6, auxp).         const(auxp).
m_form(node39_6, pri).         const(pri).
m_lemma(node39_6, pri_1).         const(pri_1).
m_tag(node39_6, rr__6__________).         const(rr__6__________).
m_tag0(node39_6,'r'). const('r'). m_tag1(node39_6,'r'). const('r'). m_tag4(node39_6,'6'). const('6'). 
%%%%%%%% node39_7 %%%%%%%%%%%%%%%%%%%
node(node39_7).
a_afun(node39_7, adv).         const(adv).
m_form(node39_7, nehode).         const(nehode).
m_lemma(node39_7, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node39_7, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node39_7,'n'). const('n'). m_tag1(node39_7,'n'). const('n'). m_tag2(node39_7,'f'). const('f'). m_tag3(node39_7,'s'). const('s'). m_tag4(node39_7,'6'). const('6'). m_tag10(node39_7,'a'). const('a'). 
%%%%%%%% node39_8 %%%%%%%%%%%%%%%%%%%
node(node39_8).
a_afun(node39_8, auxv).         const(auxv).
m_form(node39_8, byly).         const(byly).
m_lemma(node39_8, byt).         const(byt).
m_tag(node39_8, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node39_8,'v'). const('v'). m_tag1(node39_8,'p'). const('p'). m_tag2(node39_8,'t'). const('t'). m_tag3(node39_8,'p'). const('p'). m_tag7(node39_8,'x'). const('x'). m_tag8(node39_8,'r'). const('r'). m_tag10(node39_8,'a'). const('a'). m_tag11(node39_8,'a'). const('a'). 
%%%%%%%% node39_9 %%%%%%%%%%%%%%%%%%%
node(node39_9).
a_afun(node39_9, pred).         const(pred).
m_form(node39_9, zraneny).         const(zraneny).
m_lemma(node39_9, zranit__w).         const(zranit__w).
m_tag(node39_9, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node39_9,'v'). const('v'). m_tag1(node39_9,'s'). const('s'). m_tag2(node39_9,'t'). const('t'). m_tag3(node39_9,'p'). const('p'). m_tag7(node39_9,'x'). const('x'). m_tag8(node39_9,'x'). const('x'). m_tag10(node39_9,'a'). const('a'). m_tag11(node39_9,'p'). const('p'). 
%%%%%%%% node39_10 %%%%%%%%%%%%%%%%%%%
node(node39_10).
functor(node39_10, pat).         const(pat).
gram_sempos(node39_10, n_denot).         const(n_denot).
id(node39_10, t_plzensky57770_txt_001_p5s2a7).         const(t_plzensky57770_txt_001_p5s2a7).
t_lemma(node39_10, osoba).         const(osoba).
%%%%%%%% node39_11 %%%%%%%%%%%%%%%%%%%
node(node39_11).
functor(node39_11, rstr).         const(rstr).
gram_sempos(node39_11, adj_quant_def).         const(adj_quant_def).
id(node39_11, t_plzensky57770_txt_001_p5s2a8).         const(t_plzensky57770_txt_001_p5s2a8).
t_lemma(node39_11, dva).         const(dva).
%%%%%%%% node39_12 %%%%%%%%%%%%%%%%%%%
node(node39_12).
a_afun(node39_12, atr).         const(atr).
m_form(node39_12, dve).         const(dve).
m_lemma(node39_12, dva_2).         const(dva_2).
m_tag(node39_12, clhp1__________).         const(clhp1__________).
m_tag0(node39_12,'c'). const('c'). m_tag1(node39_12,'l'). const('l'). m_tag2(node39_12,'h'). const('h'). m_tag3(node39_12,'p'). const('p'). m_tag4(node39_12,'1'). const('1'). 
%%%%%%%% node39_13 %%%%%%%%%%%%%%%%%%%
node(node39_13).
a_afun(node39_13, sb).         const(sb).
m_form(node39_13, osoby).         const(osoby).
m_lemma(node39_13, osoba).         const(osoba).
m_tag(node39_13, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node39_13,'n'). const('n'). m_tag1(node39_13,'n'). const('n'). m_tag2(node39_13,'f'). const('f'). m_tag3(node39_13,'p'). const('p'). m_tag4(node39_13,'1'). const('1'). m_tag10(node39_13,'a'). const('a'). 
%%%%%%%% node39_14 %%%%%%%%%%%%%%%%%%%
node(node39_14).
a_afun(node39_14, auxx).         const(auxx).
m_form(node39_14, x_).         const(x_).
m_lemma(node39_14, x_).         const(x_).
m_tag(node39_14, z______________).         const(z______________).
m_tag0(node39_14,'z'). const('z'). m_tag1(node39_14,':'). const(':'). 
%%%%%%%% node39_15 %%%%%%%%%%%%%%%%%%%
node(node39_15).
functor(node39_15, rstr).         const(rstr).
gram_sempos(node39_15, v).         const(v).
id(node39_15, t_plzensky57770_txt_001_p5s2a9).         const(t_plzensky57770_txt_001_p5s2a9).
t_lemma(node39_15, zaklinit).         const(zaklinit).
%%%%%%%% node39_16 %%%%%%%%%%%%%%%%%%%
node(node39_16).
functor(node39_16, act).         const(act).
id(node39_16, t_plzensky57770_txt_001_p5s2a24).         const(t_plzensky57770_txt_001_p5s2a24).
t_lemma(node39_16, x_gen).         const(x_gen).
%%%%%%%% node39_17 %%%%%%%%%%%%%%%%%%%
node(node39_17).
functor(node39_17, pat).         const(pat).
gram_sempos(node39_17, n_quant_def).         const(n_quant_def).
id(node39_17, t_plzensky57770_txt_001_p5s2a10).         const(t_plzensky57770_txt_001_p5s2a10).
t_lemma(node39_17, jeden).         const(jeden).
%%%%%%%% node39_18 %%%%%%%%%%%%%%%%%%%
node(node39_18).
a_afun(node39_18, sb).         const(sb).
m_form(node39_18, jedna).         const(jedna).
m_lemma(node39_18, jeden_1).         const(jeden_1).
m_tag(node39_18, clfs1__________).         const(clfs1__________).
m_tag0(node39_18,'c'). const('c'). m_tag1(node39_18,'l'). const('l'). m_tag2(node39_18,'f'). const('f'). m_tag3(node39_18,'s'). const('s'). m_tag4(node39_18,'1'). const('1'). 
%%%%%%%% node39_19 %%%%%%%%%%%%%%%%%%%
node(node39_19).
functor(node39_19, dir1).         const(dir1).
gram_sempos(node39_19, n_pron_def_pers).         const(n_pron_def_pers).
id(node39_19, t_plzensky57770_txt_001_p5s2a12).         const(t_plzensky57770_txt_001_p5s2a12).
t_lemma(node39_19, x_perspron).         const(x_perspron).
%%%%%%%% node39_20 %%%%%%%%%%%%%%%%%%%
node(node39_20).
a_afun(node39_20, auxp).         const(auxp).
m_form(node39_20, z).         const(z).
m_lemma(node39_20, z_1).         const(z_1).
m_tag(node39_20, rr__2__________).         const(rr__2__________).
m_tag0(node39_20,'r'). const('r'). m_tag1(node39_20,'r'). const('r'). m_tag4(node39_20,'2'). const('2'). 
%%%%%%%% node39_21 %%%%%%%%%%%%%%%%%%%
node(node39_21).
a_afun(node39_21, atr).         const(atr).
m_form(node39_21, nich).         const(nich).
m_lemma(node39_21, on_1).         const(on_1).
m_tag(node39_21, p5xp2__3_______).         const(p5xp2__3_______).
m_tag0(node39_21,'p'). const('p'). m_tag1(node39_21,'5'). const('5'). m_tag2(node39_21,'x'). const('x'). m_tag3(node39_21,'p'). const('p'). m_tag4(node39_21,'2'). const('2'). m_tag7(node39_21,'3'). const('3'). 
%%%%%%%% node39_22 %%%%%%%%%%%%%%%%%%%
node(node39_22).
a_afun(node39_22, auxv).         const(auxv).
m_form(node39_22, byla).         const(byla).
m_lemma(node39_22, byt).         const(byt).
m_tag(node39_22, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node39_22,'v'). const('v'). m_tag1(node39_22,'p'). const('p'). m_tag2(node39_22,'q'). const('q'). m_tag3(node39_22,'w'). const('w'). m_tag7(node39_22,'x'). const('x'). m_tag8(node39_22,'r'). const('r'). m_tag10(node39_22,'a'). const('a'). m_tag11(node39_22,'a'). const('a'). 
%%%%%%%% node39_23 %%%%%%%%%%%%%%%%%%%
node(node39_23).
a_afun(node39_23, pred).         const(pred).
m_form(node39_23, zaklinena).         const(zaklinena).
m_lemma(node39_23, zaklinit).         const(zaklinit).
m_tag(node39_23, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node39_23,'v'). const('v'). m_tag1(node39_23,'s'). const('s'). m_tag2(node39_23,'q'). const('q'). m_tag3(node39_23,'w'). const('w'). m_tag7(node39_23,'x'). const('x'). m_tag8(node39_23,'x'). const('x'). m_tag10(node39_23,'a'). const('a'). m_tag11(node39_23,'p'). const('p'). 
%%%%%%%% node39_24 %%%%%%%%%%%%%%%%%%%
node(node39_24).
functor(node39_24, loc).         const(loc).
gram_sempos(node39_24, n_denot).         const(n_denot).
id(node39_24, t_plzensky57770_txt_001_p5s2a15).         const(t_plzensky57770_txt_001_p5s2a15).
t_lemma(node39_24, vozidlo).         const(vozidlo).
%%%%%%%% node39_25 %%%%%%%%%%%%%%%%%%%
node(node39_25).
a_afun(node39_25, auxp).         const(auxp).
m_form(node39_25, ve).         const(ve).
m_lemma(node39_25, v_1).         const(v_1).
m_tag(node39_25, rv__6__________).         const(rv__6__________).
m_tag0(node39_25,'r'). const('r'). m_tag1(node39_25,'v'). const('v'). m_tag4(node39_25,'6'). const('6'). 
%%%%%%%% node39_26 %%%%%%%%%%%%%%%%%%%
node(node39_26).
a_afun(node39_26, adv).         const(adv).
m_form(node39_26, vozidle).         const(vozidle).
m_lemma(node39_26, vozidlo).         const(vozidlo).
m_tag(node39_26, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node39_26,'n'). const('n'). m_tag1(node39_26,'n'). const('n'). m_tag2(node39_26,'n'). const('n'). m_tag3(node39_26,'s'). const('s'). m_tag4(node39_26,'6'). const('6'). m_tag10(node39_26,'a'). const('a'). 
%%%%%%%% node39_27 %%%%%%%%%%%%%%%%%%%
node(node39_27).
a_afun(node39_27, coord).         const(coord).
m_form(node39_27, a).         const(a).
m_lemma(node39_27, a_1).         const(a_1).
m_tag(node39_27, j______________).         const(j______________).
m_tag0(node39_27,'j'). const('j'). m_tag1(node39_27,'^'). const('^'). 
%%%%%%%% node39_28 %%%%%%%%%%%%%%%%%%%
node(node39_28).
functor(node39_28, pred).         const(pred).
gram_sempos(node39_28, v).         const(v).
id(node39_28, t_plzensky57770_txt_001_p5s2a16).         const(t_plzensky57770_txt_001_p5s2a16).
t_lemma(node39_28, stezovat_si).         const(stezovat_si).
%%%%%%%% node39_29 %%%%%%%%%%%%%%%%%%%
node(node39_29).
functor(node39_29, act).         const(act).
gram_sempos(node39_29, n_pron_def_pers).         const(n_pron_def_pers).
id(node39_29, t_plzensky57770_txt_001_p5s2a25).         const(t_plzensky57770_txt_001_p5s2a25).
t_lemma(node39_29, x_perspron).         const(x_perspron).
%%%%%%%% node39_30 %%%%%%%%%%%%%%%%%%%
node(node39_30).
a_afun(node39_30, pred).         const(pred).
m_form(node39_30, stezovala).         const(stezovala).
m_lemma(node39_30, stezovat__t).         const(stezovat__t).
m_tag(node39_30, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node39_30,'v'). const('v'). m_tag1(node39_30,'p'). const('p'). m_tag2(node39_30,'q'). const('q'). m_tag3(node39_30,'w'). const('w'). m_tag7(node39_30,'x'). const('x'). m_tag8(node39_30,'r'). const('r'). m_tag10(node39_30,'a'). const('a'). m_tag11(node39_30,'a'). const('a'). 
%%%%%%%% node39_31 %%%%%%%%%%%%%%%%%%%
node(node39_31).
a_afun(node39_31, auxt).         const(auxt).
m_form(node39_31, si).         const(si).
m_lemma(node39_31, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node39_31, p7_x3__________).         const(p7_x3__________).
m_tag0(node39_31,'p'). const('p'). m_tag1(node39_31,'7'). const('7'). m_tag3(node39_31,'x'). const('x'). m_tag4(node39_31,'3'). const('3'). 
%%%%%%%% node39_32 %%%%%%%%%%%%%%%%%%%
node(node39_32).
functor(node39_32, conj).         const(conj).
id(node39_32, t_plzensky57770_txt_001_p5s2a19).         const(t_plzensky57770_txt_001_p5s2a19).
t_lemma(node39_32, a).         const(a).
%%%%%%%% node39_33 %%%%%%%%%%%%%%%%%%%
node(node39_33).
functor(node39_33, rstr).         const(rstr).
gram_sempos(node39_33, n_denot).         const(n_denot).
id(node39_33, t_plzensky57770_txt_001_p5s2a20).         const(t_plzensky57770_txt_001_p5s2a20).
t_lemma(node39_33, bolest).         const(bolest).
%%%%%%%% node39_34 %%%%%%%%%%%%%%%%%%%
node(node39_34).
a_afun(node39_34, obj).         const(obj).
m_form(node39_34, bolest).         const(bolest).
m_lemma(node39_34, bolest).         const(bolest).
m_tag(node39_34, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node39_34,'n'). const('n'). m_tag1(node39_34,'n'). const('n'). m_tag2(node39_34,'f'). const('f'). m_tag3(node39_34,'s'). const('s'). m_tag4(node39_34,'4'). const('4'). m_tag10(node39_34,'a'). const('a'). 
%%%%%%%% node39_35 %%%%%%%%%%%%%%%%%%%
node(node39_35).
functor(node39_35, app).         const(app).
gram_sempos(node39_35, n_denot).         const(n_denot).
id(node39_35, t_plzensky57770_txt_001_p5s2a21).         const(t_plzensky57770_txt_001_p5s2a21).
t_lemma(node39_35, zebro).         const(zebro).
%%%%%%%% node39_36 %%%%%%%%%%%%%%%%%%%
node(node39_36).
a_afun(node39_36, atr).         const(atr).
m_form(node39_36, zeber).         const(zeber).
m_lemma(node39_36, zebro).         const(zebro).
m_tag(node39_36, nnnp2_____a____).         const(nnnp2_____a____).
m_tag0(node39_36,'n'). const('n'). m_tag1(node39_36,'n'). const('n'). m_tag2(node39_36,'n'). const('n'). m_tag3(node39_36,'p'). const('p'). m_tag4(node39_36,'2'). const('2'). m_tag10(node39_36,'a'). const('a'). 
%%%%%%%% node39_37 %%%%%%%%%%%%%%%%%%%
node(node39_37).
a_afun(node39_37, coord).         const(coord).
m_form(node39_37, a).         const(a).
m_lemma(node39_37, a_1).         const(a_1).
m_tag(node39_37, j______________).         const(j______________).
m_tag0(node39_37,'j'). const('j'). m_tag1(node39_37,'^'). const('^'). 
%%%%%%%% node39_38 %%%%%%%%%%%%%%%%%%%
node(node39_38).
functor(node39_38, rstr).         const(rstr).
gram_sempos(node39_38, n_denot).         const(n_denot).
id(node39_38, t_plzensky57770_txt_001_p5s2a22).         const(t_plzensky57770_txt_001_p5s2a22).
t_lemma(node39_38, sok).         const(sok).
%%%%%%%% node39_39 %%%%%%%%%%%%%%%%%%%
node(node39_39).
a_afun(node39_39, obj).         const(obj).
m_form(node39_39, sok).         const(sok).
m_lemma(node39_39, sok).         const(sok).
m_tag(node39_39, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node39_39,'n'). const('n'). m_tag1(node39_39,'n'). const('n'). m_tag2(node39_39,'i'). const('i'). m_tag3(node39_39,'s'). const('s'). m_tag4(node39_39,'4'). const('4'). m_tag10(node39_39,'a'). const('a'). 
edge(node39_0, node39_1).
edge(node39_1, node39_2).
edge(node39_2, node39_3).
edge(node39_3, node39_4).
edge(node39_3, node39_5).
edge(node39_5, node39_6).
edge(node39_5, node39_7).
edge(node39_3, node39_8).
edge(node39_3, node39_9).
edge(node39_3, node39_10).
edge(node39_10, node39_11).
edge(node39_11, node39_12).
edge(node39_10, node39_13).
edge(node39_2, node39_14).
edge(node39_2, node39_15).
edge(node39_15, node39_16).
edge(node39_15, node39_17).
edge(node39_17, node39_18).
edge(node39_17, node39_19).
edge(node39_19, node39_20).
edge(node39_19, node39_21).
edge(node39_15, node39_22).
edge(node39_15, node39_23).
edge(node39_15, node39_24).
edge(node39_24, node39_25).
edge(node39_24, node39_26).
edge(node39_1, node39_27).
edge(node39_1, node39_28).
edge(node39_28, node39_29).
edge(node39_28, node39_30).
edge(node39_28, node39_31).
edge(node39_28, node39_32).
edge(node39_32, node39_33).
edge(node39_33, node39_34).
edge(node39_33, node39_35).
edge(node39_35, node39_36).
edge(node39_32, node39_37).
edge(node39_32, node39_38).
edge(node39_38, node39_39).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node40_0).
%%%%%%%% node40_0 %%%%%%%%%%%%%%%%%%%
node(node40_0).
id(node40_0, t_plzensky69460_txt_001_p1s7).         const(t_plzensky69460_txt_001_p1s7).
%%%%%%%% node40_1 %%%%%%%%%%%%%%%%%%%
node(node40_1).
functor(node40_1, pred).         const(pred).
gram_sempos(node40_1, v).         const(v).
id(node40_1, t_plzensky69460_txt_001_p1s7a1).         const(t_plzensky69460_txt_001_p1s7a1).
t_lemma(node40_1, zranit).         const(zranit).
%%%%%%%% node40_2 %%%%%%%%%%%%%%%%%%%
node(node40_2).
functor(node40_2, act).         const(act).
id(node40_2, t_plzensky69460_txt_001_p1s7a3).         const(t_plzensky69460_txt_001_p1s7a3).
t_lemma(node40_2, x_gen).         const(x_gen).
%%%%%%%% node40_3 %%%%%%%%%%%%%%%%%%%
node(node40_3).
functor(node40_3, pat).         const(pat).
gram_sempos(node40_3, n_pron_indef).         const(n_pron_indef).
id(node40_3, t_plzensky69460_txt_001_p1s7a2).         const(t_plzensky69460_txt_001_p1s7a2).
t_lemma(node40_3, kdo).         const(kdo).
%%%%%%%% node40_4 %%%%%%%%%%%%%%%%%%%
node(node40_4).
a_afun(node40_4, sb).         const(sb).
m_form(node40_4, nikdo).         const(nikdo).
m_lemma(node40_4, nikdo).         const(nikdo).
m_tag(node40_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node40_4,'p'). const('p'). m_tag1(node40_4,'w'). const('w'). m_tag2(node40_4,'m'). const('m'). m_tag4(node40_4,'1'). const('1'). 
%%%%%%%% node40_5 %%%%%%%%%%%%%%%%%%%
node(node40_5).
a_afun(node40_5, auxv).         const(auxv).
m_form(node40_5, nebyl).         const(nebyl).
m_lemma(node40_5, byt).         const(byt).
m_tag(node40_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node40_5,'v'). const('v'). m_tag1(node40_5,'p'). const('p'). m_tag2(node40_5,'y'). const('y'). m_tag3(node40_5,'s'). const('s'). m_tag7(node40_5,'x'). const('x'). m_tag8(node40_5,'r'). const('r'). m_tag10(node40_5,'n'). const('n'). m_tag11(node40_5,'a'). const('a'). 
%%%%%%%% node40_6 %%%%%%%%%%%%%%%%%%%
node(node40_6).
a_afun(node40_6, pred).         const(pred).
m_form(node40_6, zranen).         const(zranen).
m_lemma(node40_6, zranit__w).         const(zranit__w).
m_tag(node40_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node40_6,'v'). const('v'). m_tag1(node40_6,'s'). const('s'). m_tag2(node40_6,'y'). const('y'). m_tag3(node40_6,'s'). const('s'). m_tag7(node40_6,'x'). const('x'). m_tag8(node40_6,'x'). const('x'). m_tag10(node40_6,'a'). const('a'). m_tag11(node40_6,'p'). const('p'). 
edge(node40_0, node40_1).
edge(node40_1, node40_2).
edge(node40_1, node40_3).
edge(node40_3, node40_4).
edge(node40_1, node40_5).
edge(node40_1, node40_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly lehce zraneny tri osoby. 
tree_root(node41_0).
%%%%%%%% node41_0 %%%%%%%%%%%%%%%%%%%
node(node41_0).
id(node41_0, t_plzensky72675_txt_001_p7s2).         const(t_plzensky72675_txt_001_p7s2).
%%%%%%%% node41_1 %%%%%%%%%%%%%%%%%%%
node(node41_1).
functor(node41_1, pred).         const(pred).
gram_sempos(node41_1, v).         const(v).
id(node41_1, t_plzensky72675_txt_001_p7s2a1).         const(t_plzensky72675_txt_001_p7s2a1).
t_lemma(node41_1, zranit).         const(zranit).
%%%%%%%% node41_2 %%%%%%%%%%%%%%%%%%%
node(node41_2).
functor(node41_2, act).         const(act).
id(node41_2, t_plzensky72675_txt_001_p7s2a8).         const(t_plzensky72675_txt_001_p7s2a8).
t_lemma(node41_2, x_gen).         const(x_gen).
%%%%%%%% node41_3 %%%%%%%%%%%%%%%%%%%
node(node41_3).
functor(node41_3, twhen).         const(twhen).
gram_sempos(node41_3, n_denot).         const(n_denot).
id(node41_3, t_plzensky72675_txt_001_p7s2a3).         const(t_plzensky72675_txt_001_p7s2a3).
t_lemma(node41_3, nehoda).         const(nehoda).
%%%%%%%% node41_4 %%%%%%%%%%%%%%%%%%%
node(node41_4).
a_afun(node41_4, auxp).         const(auxp).
m_form(node41_4, pri).         const(pri).
m_lemma(node41_4, pri_1).         const(pri_1).
m_tag(node41_4, rr__6__________).         const(rr__6__________).
m_tag0(node41_4,'r'). const('r'). m_tag1(node41_4,'r'). const('r'). m_tag4(node41_4,'6'). const('6'). 
%%%%%%%% node41_5 %%%%%%%%%%%%%%%%%%%
node(node41_5).
a_afun(node41_5, adv).         const(adv).
m_form(node41_5, nehode).         const(nehode).
m_lemma(node41_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node41_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node41_5,'n'). const('n'). m_tag1(node41_5,'n'). const('n'). m_tag2(node41_5,'f'). const('f'). m_tag3(node41_5,'s'). const('s'). m_tag4(node41_5,'6'). const('6'). m_tag10(node41_5,'a'). const('a'). 
%%%%%%%% node41_6 %%%%%%%%%%%%%%%%%%%
node(node41_6).
functor(node41_6, mann).         const(mann).
gram_sempos(node41_6, adj_denot).         const(adj_denot).
id(node41_6, t_plzensky72675_txt_001_p7s2a5).         const(t_plzensky72675_txt_001_p7s2a5).
t_lemma(node41_6, lehky).         const(lehky).
%%%%%%%% node41_7 %%%%%%%%%%%%%%%%%%%
node(node41_7).
a_afun(node41_7, adv).         const(adv).
m_form(node41_7, lehce).         const(lehce).
m_lemma(node41_7, lehce).         const(lehce).
m_tag(node41_7, dg_______1a____).         const(dg_______1a____).
m_tag0(node41_7,'d'). const('d'). m_tag1(node41_7,'g'). const('g'). m_tag9(node41_7,'1'). const('1'). m_tag10(node41_7,'a'). const('a'). 
%%%%%%%% node41_8 %%%%%%%%%%%%%%%%%%%
node(node41_8).
a_afun(node41_8, auxv).         const(auxv).
m_form(node41_8, byly).         const(byly).
m_lemma(node41_8, byt).         const(byt).
m_tag(node41_8, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node41_8,'v'). const('v'). m_tag1(node41_8,'p'). const('p'). m_tag2(node41_8,'t'). const('t'). m_tag3(node41_8,'p'). const('p'). m_tag7(node41_8,'x'). const('x'). m_tag8(node41_8,'r'). const('r'). m_tag10(node41_8,'a'). const('a'). m_tag11(node41_8,'a'). const('a'). 
%%%%%%%% node41_9 %%%%%%%%%%%%%%%%%%%
node(node41_9).
a_afun(node41_9, pred).         const(pred).
m_form(node41_9, zraneny).         const(zraneny).
m_lemma(node41_9, zranit__w).         const(zranit__w).
m_tag(node41_9, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node41_9,'v'). const('v'). m_tag1(node41_9,'s'). const('s'). m_tag2(node41_9,'t'). const('t'). m_tag3(node41_9,'p'). const('p'). m_tag7(node41_9,'x'). const('x'). m_tag8(node41_9,'x'). const('x'). m_tag10(node41_9,'a'). const('a'). m_tag11(node41_9,'p'). const('p'). 
%%%%%%%% node41_10 %%%%%%%%%%%%%%%%%%%
node(node41_10).
functor(node41_10, pat).         const(pat).
gram_sempos(node41_10, n_denot).         const(n_denot).
id(node41_10, t_plzensky72675_txt_001_p7s2a6).         const(t_plzensky72675_txt_001_p7s2a6).
t_lemma(node41_10, osoba).         const(osoba).
%%%%%%%% node41_11 %%%%%%%%%%%%%%%%%%%
node(node41_11).
functor(node41_11, rstr).         const(rstr).
gram_sempos(node41_11, adj_quant_def).         const(adj_quant_def).
id(node41_11, t_plzensky72675_txt_001_p7s2a7).         const(t_plzensky72675_txt_001_p7s2a7).
t_lemma(node41_11, tri).         const(tri).
%%%%%%%% node41_12 %%%%%%%%%%%%%%%%%%%
node(node41_12).
a_afun(node41_12, atr).         const(atr).
m_form(node41_12, tri).         const(tri).
m_lemma(node41_12, tri_3).         const(tri_3).
m_tag(node41_12, clxp1__________).         const(clxp1__________).
m_tag0(node41_12,'c'). const('c'). m_tag1(node41_12,'l'). const('l'). m_tag2(node41_12,'x'). const('x'). m_tag3(node41_12,'p'). const('p'). m_tag4(node41_12,'1'). const('1'). 
%%%%%%%% node41_13 %%%%%%%%%%%%%%%%%%%
node(node41_13).
a_afun(node41_13, sb).         const(sb).
m_form(node41_13, osoby).         const(osoby).
m_lemma(node41_13, osoba).         const(osoba).
m_tag(node41_13, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node41_13,'n'). const('n'). m_tag1(node41_13,'n'). const('n'). m_tag2(node41_13,'f'). const('f'). m_tag3(node41_13,'p'). const('p'). m_tag4(node41_13,'1'). const('1'). m_tag10(node41_13,'a'). const('a'). 
edge(node41_0, node41_1).
edge(node41_1, node41_2).
edge(node41_1, node41_3).
edge(node41_3, node41_4).
edge(node41_3, node41_5).
edge(node41_1, node41_6).
edge(node41_6, node41_7).
edge(node41_1, node41_8).
edge(node41_1, node41_9).
edge(node41_1, node41_10).
edge(node41_10, node41_11).
edge(node41_11, node41_12).
edge(node41_10, node41_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nejsmutnejsi udalosti se stal ve stredu 8. srpna pozar rodinneho domu v obci ostrov u bezdruzic, pri nemz zahynula mlada zena. 
tree_root(node42_0).
%%%%%%%% node42_0 %%%%%%%%%%%%%%%%%%%
node(node42_0).
id(node42_0, t_plzensky60661_txt_001_p1s2).         const(t_plzensky60661_txt_001_p1s2).
%%%%%%%% node42_1 %%%%%%%%%%%%%%%%%%%
node(node42_1).
functor(node42_1, pred).         const(pred).
gram_sempos(node42_1, v).         const(v).
id(node42_1, t_plzensky60661_txt_001_p1s2a1).         const(t_plzensky60661_txt_001_p1s2a1).
t_lemma(node42_1, stat_se).         const(stat_se).
%%%%%%%% node42_2 %%%%%%%%%%%%%%%%%%%
node(node42_2).
functor(node42_2, means).         const(means).
gram_sempos(node42_2, n_denot_neg).         const(n_denot_neg).
id(node42_2, t_plzensky60661_txt_001_p1s2a2).         const(t_plzensky60661_txt_001_p1s2a2).
t_lemma(node42_2, udalost).         const(udalost).
%%%%%%%% node42_3 %%%%%%%%%%%%%%%%%%%
node(node42_3).
functor(node42_3, rstr).         const(rstr).
gram_sempos(node42_3, adj_denot).         const(adj_denot).
id(node42_3, t_plzensky60661_txt_001_p1s2a3).         const(t_plzensky60661_txt_001_p1s2a3).
t_lemma(node42_3, smutny).         const(smutny).
%%%%%%%% node42_4 %%%%%%%%%%%%%%%%%%%
node(node42_4).
a_afun(node42_4, atr).         const(atr).
m_form(node42_4, nejsmutnejsi).         const(nejsmutnejsi).
m_lemma(node42_4, smutny).         const(smutny).
m_tag(node42_4, aafs7____3a____).         const(aafs7____3a____).
m_tag0(node42_4,'a'). const('a'). m_tag1(node42_4,'a'). const('a'). m_tag2(node42_4,'f'). const('f'). m_tag3(node42_4,'s'). const('s'). m_tag4(node42_4,'7'). const('7'). m_tag9(node42_4,'3'). const('3'). m_tag10(node42_4,'a'). const('a'). 
%%%%%%%% node42_5 %%%%%%%%%%%%%%%%%%%
node(node42_5).
a_afun(node42_5, adv).         const(adv).
m_form(node42_5, udalosti).         const(udalosti).
m_lemma(node42_5, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node42_5, nnfs7_____a____).         const(nnfs7_____a____).
m_tag0(node42_5,'n'). const('n'). m_tag1(node42_5,'n'). const('n'). m_tag2(node42_5,'f'). const('f'). m_tag3(node42_5,'s'). const('s'). m_tag4(node42_5,'7'). const('7'). m_tag10(node42_5,'a'). const('a'). 
%%%%%%%% node42_6 %%%%%%%%%%%%%%%%%%%
node(node42_6).
a_afun(node42_6, auxt).         const(auxt).
m_form(node42_6, se).         const(se).
m_lemma(node42_6, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node42_6, p7_x4__________).         const(p7_x4__________).
m_tag0(node42_6,'p'). const('p'). m_tag1(node42_6,'7'). const('7'). m_tag3(node42_6,'x'). const('x'). m_tag4(node42_6,'4'). const('4'). 
%%%%%%%% node42_7 %%%%%%%%%%%%%%%%%%%
node(node42_7).
a_afun(node42_7, pred).         const(pred).
m_form(node42_7, stal).         const(stal).
m_lemma(node42_7, stat_2___neco_se_prihodilo_).         const(stat_2___neco_se_prihodilo_).
m_tag(node42_7, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node42_7,'v'). const('v'). m_tag1(node42_7,'p'). const('p'). m_tag2(node42_7,'y'). const('y'). m_tag3(node42_7,'s'). const('s'). m_tag7(node42_7,'x'). const('x'). m_tag8(node42_7,'r'). const('r'). m_tag10(node42_7,'a'). const('a'). m_tag11(node42_7,'a'). const('a'). 
%%%%%%%% node42_8 %%%%%%%%%%%%%%%%%%%
node(node42_8).
functor(node42_8, twhen).         const(twhen).
gram_sempos(node42_8, n_denot).         const(n_denot).
id(node42_8, t_plzensky60661_txt_001_p1s2a6).         const(t_plzensky60661_txt_001_p1s2a6).
t_lemma(node42_8, streda).         const(streda).
%%%%%%%% node42_9 %%%%%%%%%%%%%%%%%%%
node(node42_9).
a_afun(node42_9, auxp).         const(auxp).
m_form(node42_9, ve).         const(ve).
m_lemma(node42_9, v_1).         const(v_1).
m_tag(node42_9, rv__4__________).         const(rv__4__________).
m_tag0(node42_9,'r'). const('r'). m_tag1(node42_9,'v'). const('v'). m_tag4(node42_9,'4'). const('4'). 
%%%%%%%% node42_10 %%%%%%%%%%%%%%%%%%%
node(node42_10).
a_afun(node42_10, adv).         const(adv).
m_form(node42_10, stredu).         const(stredu).
m_lemma(node42_10, streda).         const(streda).
m_tag(node42_10, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node42_10,'n'). const('n'). m_tag1(node42_10,'n'). const('n'). m_tag2(node42_10,'f'). const('f'). m_tag3(node42_10,'s'). const('s'). m_tag4(node42_10,'4'). const('4'). m_tag10(node42_10,'a'). const('a'). 
%%%%%%%% node42_11 %%%%%%%%%%%%%%%%%%%
node(node42_11).
functor(node42_11, app).         const(app).
gram_sempos(node42_11, n_denot).         const(n_denot).
id(node42_11, t_plzensky60661_txt_001_p1s2a7).         const(t_plzensky60661_txt_001_p1s2a7).
t_lemma(node42_11, srpen).         const(srpen).
%%%%%%%% node42_12 %%%%%%%%%%%%%%%%%%%
node(node42_12).
functor(node42_12, rstr).         const(rstr).
gram_sempos(node42_12, adj_quant_def).         const(adj_quant_def).
id(node42_12, t_plzensky60661_txt_001_p1s2a8).         const(t_plzensky60661_txt_001_p1s2a8).
t_lemma(node42_12, 8).         const(8).
%%%%%%%% node42_13 %%%%%%%%%%%%%%%%%%%
node(node42_13).
a_afun(node42_13, atr).         const(atr).
m_form(node42_13, 8).         const(8).
m_lemma(node42_13, 8).         const(8).
m_tag(node42_13, c=_____________).         const(c=_____________).
m_tag0(node42_13,'c'). const('c'). m_tag1(node42_13,'='). const('='). 
%%%%%%%% node42_14 %%%%%%%%%%%%%%%%%%%
node(node42_14).
a_afun(node42_14, atr).         const(atr).
m_form(node42_14, srpna).         const(srpna).
m_lemma(node42_14, srpen).         const(srpen).
m_tag(node42_14, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node42_14,'n'). const('n'). m_tag1(node42_14,'n'). const('n'). m_tag2(node42_14,'i'). const('i'). m_tag3(node42_14,'s'). const('s'). m_tag4(node42_14,'2'). const('2'). m_tag10(node42_14,'a'). const('a'). 
%%%%%%%% node42_15 %%%%%%%%%%%%%%%%%%%
node(node42_15).
functor(node42_15, act).         const(act).
gram_sempos(node42_15, n_denot).         const(n_denot).
id(node42_15, t_plzensky60661_txt_001_p1s2a10).         const(t_plzensky60661_txt_001_p1s2a10).
t_lemma(node42_15, pozar).         const(pozar).
%%%%%%%% node42_16 %%%%%%%%%%%%%%%%%%%
node(node42_16).
a_afun(node42_16, sb).         const(sb).
m_form(node42_16, pozar).         const(pozar).
m_lemma(node42_16, pozar).         const(pozar).
m_tag(node42_16, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node42_16,'n'). const('n'). m_tag1(node42_16,'n'). const('n'). m_tag2(node42_16,'i'). const('i'). m_tag3(node42_16,'s'). const('s'). m_tag4(node42_16,'1'). const('1'). m_tag10(node42_16,'a'). const('a'). 
%%%%%%%% node42_17 %%%%%%%%%%%%%%%%%%%
node(node42_17).
functor(node42_17, app).         const(app).
gram_sempos(node42_17, n_denot).         const(n_denot).
id(node42_17, t_plzensky60661_txt_001_p1s2a11).         const(t_plzensky60661_txt_001_p1s2a11).
t_lemma(node42_17, dum).         const(dum).
%%%%%%%% node42_18 %%%%%%%%%%%%%%%%%%%
node(node42_18).
functor(node42_18, rstr).         const(rstr).
gram_sempos(node42_18, adj_denot).         const(adj_denot).
id(node42_18, t_plzensky60661_txt_001_p1s2a12).         const(t_plzensky60661_txt_001_p1s2a12).
t_lemma(node42_18, rodinny).         const(rodinny).
%%%%%%%% node42_19 %%%%%%%%%%%%%%%%%%%
node(node42_19).
a_afun(node42_19, atr).         const(atr).
m_form(node42_19, rodinneho).         const(rodinneho).
m_lemma(node42_19, rodinny).         const(rodinny).
m_tag(node42_19, aais2____1a____).         const(aais2____1a____).
m_tag0(node42_19,'a'). const('a'). m_tag1(node42_19,'a'). const('a'). m_tag2(node42_19,'i'). const('i'). m_tag3(node42_19,'s'). const('s'). m_tag4(node42_19,'2'). const('2'). m_tag9(node42_19,'1'). const('1'). m_tag10(node42_19,'a'). const('a'). 
%%%%%%%% node42_20 %%%%%%%%%%%%%%%%%%%
node(node42_20).
a_afun(node42_20, atr).         const(atr).
m_form(node42_20, domu).         const(domu).
m_lemma(node42_20, dum).         const(dum).
m_tag(node42_20, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node42_20,'n'). const('n'). m_tag1(node42_20,'n'). const('n'). m_tag2(node42_20,'i'). const('i'). m_tag3(node42_20,'s'). const('s'). m_tag4(node42_20,'2'). const('2'). m_tag10(node42_20,'a'). const('a'). 
%%%%%%%% node42_21 %%%%%%%%%%%%%%%%%%%
node(node42_21).
functor(node42_21, loc).         const(loc).
gram_sempos(node42_21, n_denot).         const(n_denot).
id(node42_21, t_plzensky60661_txt_001_p1s2a14).         const(t_plzensky60661_txt_001_p1s2a14).
t_lemma(node42_21, obec).         const(obec).
%%%%%%%% node42_22 %%%%%%%%%%%%%%%%%%%
node(node42_22).
a_afun(node42_22, auxp).         const(auxp).
m_form(node42_22, v).         const(v).
m_lemma(node42_22, v_1).         const(v_1).
m_tag(node42_22, rr__6__________).         const(rr__6__________).
m_tag0(node42_22,'r'). const('r'). m_tag1(node42_22,'r'). const('r'). m_tag4(node42_22,'6'). const('6'). 
%%%%%%%% node42_23 %%%%%%%%%%%%%%%%%%%
node(node42_23).
a_afun(node42_23, atr).         const(atr).
m_form(node42_23, obci).         const(obci).
m_lemma(node42_23, obec).         const(obec).
m_tag(node42_23, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node42_23,'n'). const('n'). m_tag1(node42_23,'n'). const('n'). m_tag2(node42_23,'f'). const('f'). m_tag3(node42_23,'s'). const('s'). m_tag4(node42_23,'6'). const('6'). m_tag10(node42_23,'a'). const('a'). 
%%%%%%%% node42_24 %%%%%%%%%%%%%%%%%%%
node(node42_24).
functor(node42_24, id).         const(id).
gram_sempos(node42_24, n_denot).         const(n_denot).
id(node42_24, t_plzensky60661_txt_001_p1s2a15).         const(t_plzensky60661_txt_001_p1s2a15).
t_lemma(node42_24, ostrov).         const(ostrov).
%%%%%%%% node42_25 %%%%%%%%%%%%%%%%%%%
node(node42_25).
a_afun(node42_25, atr).         const(atr).
m_form(node42_25, ostrov).         const(ostrov).
m_lemma(node42_25, ostrov__g).         const(ostrov__g).
m_tag(node42_25, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node42_25,'n'). const('n'). m_tag1(node42_25,'n'). const('n'). m_tag2(node42_25,'i'). const('i'). m_tag3(node42_25,'s'). const('s'). m_tag4(node42_25,'1'). const('1'). m_tag10(node42_25,'a'). const('a'). 
%%%%%%%% node42_26 %%%%%%%%%%%%%%%%%%%
node(node42_26).
functor(node42_26, loc).         const(loc).
gram_sempos(node42_26, n_denot).         const(n_denot).
id(node42_26, t_plzensky60661_txt_001_p1s2a17).         const(t_plzensky60661_txt_001_p1s2a17).
t_lemma(node42_26, bezdruzice).         const(bezdruzice).
%%%%%%%% node42_27 %%%%%%%%%%%%%%%%%%%
node(node42_27).
a_afun(node42_27, auxp).         const(auxp).
m_form(node42_27, u).         const(u).
m_lemma(node42_27, u_1).         const(u_1).
m_tag(node42_27, rr__2__________).         const(rr__2__________).
m_tag0(node42_27,'r'). const('r'). m_tag1(node42_27,'r'). const('r'). m_tag4(node42_27,'2'). const('2'). 
%%%%%%%% node42_28 %%%%%%%%%%%%%%%%%%%
node(node42_28).
a_afun(node42_28, atr).         const(atr).
m_form(node42_28, bezdruzic).         const(bezdruzic).
m_lemma(node42_28, bezdruzice__g).         const(bezdruzice__g).
m_tag(node42_28, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node42_28,'n'). const('n'). m_tag1(node42_28,'n'). const('n'). m_tag2(node42_28,'f'). const('f'). m_tag3(node42_28,'p'). const('p'). m_tag4(node42_28,'2'). const('2'). m_tag10(node42_28,'a'). const('a'). 
%%%%%%%% node42_29 %%%%%%%%%%%%%%%%%%%
node(node42_29).
functor(node42_29, rstr).         const(rstr).
gram_sempos(node42_29, v).         const(v).
id(node42_29, t_plzensky60661_txt_001_p1s2a18).         const(t_plzensky60661_txt_001_p1s2a18).
t_lemma(node42_29, zahynout).         const(zahynout).
%%%%%%%% node42_30 %%%%%%%%%%%%%%%%%%%
node(node42_30).
functor(node42_30, twhen).         const(twhen).
gram_sempos(node42_30, n_pron_indef).         const(n_pron_indef).
id(node42_30, t_plzensky60661_txt_001_p1s2a21).         const(t_plzensky60661_txt_001_p1s2a21).
t_lemma(node42_30, ktery).         const(ktery).
%%%%%%%% node42_31 %%%%%%%%%%%%%%%%%%%
node(node42_31).
a_afun(node42_31, auxp).         const(auxp).
m_form(node42_31, pri).         const(pri).
m_lemma(node42_31, pri_1).         const(pri_1).
m_tag(node42_31, rr__6__________).         const(rr__6__________).
m_tag0(node42_31,'r'). const('r'). m_tag1(node42_31,'r'). const('r'). m_tag4(node42_31,'6'). const('6'). 
%%%%%%%% node42_32 %%%%%%%%%%%%%%%%%%%
node(node42_32).
a_afun(node42_32, adv).         const(adv).
m_form(node42_32, nemz).         const(nemz).
m_lemma(node42_32, jenz___ktery__ve_vedl_vete__).         const(jenz___ktery__ve_vedl_vete__).
m_tag(node42_32, p9zs6__________).         const(p9zs6__________).
m_tag0(node42_32,'p'). const('p'). m_tag1(node42_32,'9'). const('9'). m_tag2(node42_32,'z'). const('z'). m_tag3(node42_32,'s'). const('s'). m_tag4(node42_32,'6'). const('6'). 
%%%%%%%% node42_33 %%%%%%%%%%%%%%%%%%%
node(node42_33).
a_afun(node42_33, atr).         const(atr).
m_form(node42_33, zahynula).         const(zahynula).
m_lemma(node42_33, zahynout).         const(zahynout).
m_tag(node42_33, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node42_33,'v'). const('v'). m_tag1(node42_33,'p'). const('p'). m_tag2(node42_33,'q'). const('q'). m_tag3(node42_33,'w'). const('w'). m_tag7(node42_33,'x'). const('x'). m_tag8(node42_33,'r'). const('r'). m_tag10(node42_33,'a'). const('a'). m_tag11(node42_33,'a'). const('a'). 
%%%%%%%% node42_34 %%%%%%%%%%%%%%%%%%%
node(node42_34).
functor(node42_34, act).         const(act).
gram_sempos(node42_34, n_denot).         const(n_denot).
id(node42_34, t_plzensky60661_txt_001_p1s2a22).         const(t_plzensky60661_txt_001_p1s2a22).
t_lemma(node42_34, zena).         const(zena).
%%%%%%%% node42_35 %%%%%%%%%%%%%%%%%%%
node(node42_35).
functor(node42_35, rstr).         const(rstr).
gram_sempos(node42_35, adj_denot).         const(adj_denot).
id(node42_35, t_plzensky60661_txt_001_p1s2a23).         const(t_plzensky60661_txt_001_p1s2a23).
t_lemma(node42_35, mlady).         const(mlady).
%%%%%%%% node42_36 %%%%%%%%%%%%%%%%%%%
node(node42_36).
a_afun(node42_36, atr).         const(atr).
m_form(node42_36, mlada).         const(mlada).
m_lemma(node42_36, mlady).         const(mlady).
m_tag(node42_36, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node42_36,'a'). const('a'). m_tag1(node42_36,'a'). const('a'). m_tag2(node42_36,'f'). const('f'). m_tag3(node42_36,'s'). const('s'). m_tag4(node42_36,'1'). const('1'). m_tag9(node42_36,'1'). const('1'). m_tag10(node42_36,'a'). const('a'). 
%%%%%%%% node42_37 %%%%%%%%%%%%%%%%%%%
node(node42_37).
a_afun(node42_37, sb).         const(sb).
m_form(node42_37, zena).         const(zena).
m_lemma(node42_37, zena).         const(zena).
m_tag(node42_37, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node42_37,'n'). const('n'). m_tag1(node42_37,'n'). const('n'). m_tag2(node42_37,'f'). const('f'). m_tag3(node42_37,'s'). const('s'). m_tag4(node42_37,'1'). const('1'). m_tag10(node42_37,'a'). const('a'). 
edge(node42_0, node42_1).
edge(node42_1, node42_2).
edge(node42_2, node42_3).
edge(node42_3, node42_4).
edge(node42_2, node42_5).
edge(node42_1, node42_6).
edge(node42_1, node42_7).
edge(node42_1, node42_8).
edge(node42_8, node42_9).
edge(node42_8, node42_10).
edge(node42_8, node42_11).
edge(node42_11, node42_12).
edge(node42_12, node42_13).
edge(node42_11, node42_14).
edge(node42_1, node42_15).
edge(node42_15, node42_16).
edge(node42_15, node42_17).
edge(node42_17, node42_18).
edge(node42_18, node42_19).
edge(node42_17, node42_20).
edge(node42_17, node42_21).
edge(node42_21, node42_22).
edge(node42_21, node42_23).
edge(node42_21, node42_24).
edge(node42_24, node42_25).
edge(node42_21, node42_26).
edge(node42_26, node42_27).
edge(node42_26, node42_28).
edge(node42_15, node42_29).
edge(node42_29, node42_30).
edge(node42_30, node42_31).
edge(node42_30, node42_32).
edge(node42_29, node42_33).
edge(node42_29, node42_34).
edge(node42_34, node42_35).
edge(node42_35, node42_36).
edge(node42_34, node42_37).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node43_0).
%%%%%%%% node43_0 %%%%%%%%%%%%%%%%%%%
node(node43_0).
id(node43_0, t_plzensky58576_txt_001_p4s3).         const(t_plzensky58576_txt_001_p4s3).
%%%%%%%% node43_1 %%%%%%%%%%%%%%%%%%%
node(node43_1).
functor(node43_1, pred).         const(pred).
gram_sempos(node43_1, v).         const(v).
id(node43_1, t_plzensky58576_txt_001_p4s3a1).         const(t_plzensky58576_txt_001_p4s3a1).
t_lemma(node43_1, zranit).         const(zranit).
%%%%%%%% node43_2 %%%%%%%%%%%%%%%%%%%
node(node43_2).
functor(node43_2, act).         const(act).
id(node43_2, t_plzensky58576_txt_001_p4s3a3).         const(t_plzensky58576_txt_001_p4s3a3).
t_lemma(node43_2, x_gen).         const(x_gen).
%%%%%%%% node43_3 %%%%%%%%%%%%%%%%%%%
node(node43_3).
functor(node43_3, pat).         const(pat).
gram_sempos(node43_3, n_pron_indef).         const(n_pron_indef).
id(node43_3, t_plzensky58576_txt_001_p4s3a2).         const(t_plzensky58576_txt_001_p4s3a2).
t_lemma(node43_3, kdo).         const(kdo).
%%%%%%%% node43_4 %%%%%%%%%%%%%%%%%%%
node(node43_4).
a_afun(node43_4, sb).         const(sb).
m_form(node43_4, nikdo).         const(nikdo).
m_lemma(node43_4, nikdo).         const(nikdo).
m_tag(node43_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node43_4,'p'). const('p'). m_tag1(node43_4,'w'). const('w'). m_tag2(node43_4,'m'). const('m'). m_tag4(node43_4,'1'). const('1'). 
%%%%%%%% node43_5 %%%%%%%%%%%%%%%%%%%
node(node43_5).
a_afun(node43_5, auxv).         const(auxv).
m_form(node43_5, nebyl).         const(nebyl).
m_lemma(node43_5, byt).         const(byt).
m_tag(node43_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node43_5,'v'). const('v'). m_tag1(node43_5,'p'). const('p'). m_tag2(node43_5,'y'). const('y'). m_tag3(node43_5,'s'). const('s'). m_tag7(node43_5,'x'). const('x'). m_tag8(node43_5,'r'). const('r'). m_tag10(node43_5,'n'). const('n'). m_tag11(node43_5,'a'). const('a'). 
%%%%%%%% node43_6 %%%%%%%%%%%%%%%%%%%
node(node43_6).
a_afun(node43_6, pred).         const(pred).
m_form(node43_6, zranen).         const(zranen).
m_lemma(node43_6, zranit__w).         const(zranit__w).
m_tag(node43_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node43_6,'v'). const('v'). m_tag1(node43_6,'s'). const('s'). m_tag2(node43_6,'y'). const('y'). m_tag3(node43_6,'s'). const('s'). m_tag7(node43_6,'x'). const('x'). m_tag8(node43_6,'x'). const('x'). m_tag10(node43_6,'a'). const('a'). m_tag11(node43_6,'p'). const('p'). 
edge(node43_0, node43_1).
edge(node43_1, node43_2).
edge(node43_1, node43_3).
edge(node43_3, node43_4).
edge(node43_1, node43_5).
edge(node43_1, node43_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byly zraneny celkem tri osoby. 
tree_root(node44_0).
%%%%%%%% node44_0 %%%%%%%%%%%%%%%%%%%
node(node44_0).
id(node44_0, t_plzensky58576_txt_001_p5s2).         const(t_plzensky58576_txt_001_p5s2).
%%%%%%%% node44_1 %%%%%%%%%%%%%%%%%%%
node(node44_1).
functor(node44_1, pred).         const(pred).
gram_sempos(node44_1, v).         const(v).
id(node44_1, t_plzensky58576_txt_001_p5s2a1).         const(t_plzensky58576_txt_001_p5s2a1).
t_lemma(node44_1, zranit).         const(zranit).
%%%%%%%% node44_2 %%%%%%%%%%%%%%%%%%%
node(node44_2).
functor(node44_2, act).         const(act).
id(node44_2, t_plzensky58576_txt_001_p5s2a8).         const(t_plzensky58576_txt_001_p5s2a8).
t_lemma(node44_2, x_gen).         const(x_gen).
%%%%%%%% node44_3 %%%%%%%%%%%%%%%%%%%
node(node44_3).
functor(node44_3, twhen).         const(twhen).
gram_sempos(node44_3, n_denot).         const(n_denot).
id(node44_3, t_plzensky58576_txt_001_p5s2a3).         const(t_plzensky58576_txt_001_p5s2a3).
t_lemma(node44_3, nehoda).         const(nehoda).
%%%%%%%% node44_4 %%%%%%%%%%%%%%%%%%%
node(node44_4).
a_afun(node44_4, auxp).         const(auxp).
m_form(node44_4, pri).         const(pri).
m_lemma(node44_4, pri_1).         const(pri_1).
m_tag(node44_4, rr__6__________).         const(rr__6__________).
m_tag0(node44_4,'r'). const('r'). m_tag1(node44_4,'r'). const('r'). m_tag4(node44_4,'6'). const('6'). 
%%%%%%%% node44_5 %%%%%%%%%%%%%%%%%%%
node(node44_5).
a_afun(node44_5, adv).         const(adv).
m_form(node44_5, nehode).         const(nehode).
m_lemma(node44_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node44_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node44_5,'n'). const('n'). m_tag1(node44_5,'n'). const('n'). m_tag2(node44_5,'f'). const('f'). m_tag3(node44_5,'s'). const('s'). m_tag4(node44_5,'6'). const('6'). m_tag10(node44_5,'a'). const('a'). 
%%%%%%%% node44_6 %%%%%%%%%%%%%%%%%%%
node(node44_6).
a_afun(node44_6, auxv).         const(auxv).
m_form(node44_6, byly).         const(byly).
m_lemma(node44_6, byt).         const(byt).
m_tag(node44_6, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node44_6,'v'). const('v'). m_tag1(node44_6,'p'). const('p'). m_tag2(node44_6,'t'). const('t'). m_tag3(node44_6,'p'). const('p'). m_tag7(node44_6,'x'). const('x'). m_tag8(node44_6,'r'). const('r'). m_tag10(node44_6,'a'). const('a'). m_tag11(node44_6,'a'). const('a'). 
%%%%%%%% node44_7 %%%%%%%%%%%%%%%%%%%
node(node44_7).
a_afun(node44_7, pred).         const(pred).
m_form(node44_7, zraneny).         const(zraneny).
m_lemma(node44_7, zranit__w).         const(zranit__w).
m_tag(node44_7, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node44_7,'v'). const('v'). m_tag1(node44_7,'s'). const('s'). m_tag2(node44_7,'t'). const('t'). m_tag3(node44_7,'p'). const('p'). m_tag7(node44_7,'x'). const('x'). m_tag8(node44_7,'x'). const('x'). m_tag10(node44_7,'a'). const('a'). m_tag11(node44_7,'p'). const('p'). 
%%%%%%%% node44_8 %%%%%%%%%%%%%%%%%%%
node(node44_8).
functor(node44_8, pat).         const(pat).
gram_sempos(node44_8, n_denot).         const(n_denot).
id(node44_8, t_plzensky58576_txt_001_p5s2a5).         const(t_plzensky58576_txt_001_p5s2a5).
t_lemma(node44_8, osoba).         const(osoba).
%%%%%%%% node44_9 %%%%%%%%%%%%%%%%%%%
node(node44_9).
functor(node44_9, ext).         const(ext).
gram_sempos(node44_9, adv_denot_ngrad_nneg).         const(adv_denot_ngrad_nneg).
id(node44_9, t_plzensky58576_txt_001_p5s2a6).         const(t_plzensky58576_txt_001_p5s2a6).
t_lemma(node44_9, celkem).         const(celkem).
%%%%%%%% node44_10 %%%%%%%%%%%%%%%%%%%
node(node44_10).
a_afun(node44_10, auxz).         const(auxz).
m_form(node44_10, celkem).         const(celkem).
m_lemma(node44_10, celkem).         const(celkem).
m_tag(node44_10, db_____________).         const(db_____________).
m_tag0(node44_10,'d'). const('d'). m_tag1(node44_10,'b'). const('b'). 
%%%%%%%% node44_11 %%%%%%%%%%%%%%%%%%%
node(node44_11).
functor(node44_11, rstr).         const(rstr).
gram_sempos(node44_11, adj_quant_def).         const(adj_quant_def).
id(node44_11, t_plzensky58576_txt_001_p5s2a7).         const(t_plzensky58576_txt_001_p5s2a7).
t_lemma(node44_11, tri).         const(tri).
%%%%%%%% node44_12 %%%%%%%%%%%%%%%%%%%
node(node44_12).
a_afun(node44_12, atr).         const(atr).
m_form(node44_12, tri).         const(tri).
m_lemma(node44_12, tri_3).         const(tri_3).
m_tag(node44_12, clxp1__________).         const(clxp1__________).
m_tag0(node44_12,'c'). const('c'). m_tag1(node44_12,'l'). const('l'). m_tag2(node44_12,'x'). const('x'). m_tag3(node44_12,'p'). const('p'). m_tag4(node44_12,'1'). const('1'). 
%%%%%%%% node44_13 %%%%%%%%%%%%%%%%%%%
node(node44_13).
a_afun(node44_13, sb).         const(sb).
m_form(node44_13, osoby).         const(osoby).
m_lemma(node44_13, osoba).         const(osoba).
m_tag(node44_13, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node44_13,'n'). const('n'). m_tag1(node44_13,'n'). const('n'). m_tag2(node44_13,'f'). const('f'). m_tag3(node44_13,'p'). const('p'). m_tag4(node44_13,'1'). const('1'). m_tag10(node44_13,'a'). const('a'). 
edge(node44_0, node44_1).
edge(node44_1, node44_2).
edge(node44_1, node44_3).
edge(node44_3, node44_4).
edge(node44_3, node44_5).
edge(node44_1, node44_6).
edge(node44_1, node44_7).
edge(node44_1, node44_8).
edge(node44_8, node44_9).
edge(node44_9, node44_10).
edge(node44_8, node44_11).
edge(node44_11, node44_12).
edge(node44_8, node44_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byla lehce zranena jedna osoba. 
tree_root(node45_0).
%%%%%%%% node45_0 %%%%%%%%%%%%%%%%%%%
node(node45_0).
id(node45_0, t_plzensky64131_txt_001_p2s2).         const(t_plzensky64131_txt_001_p2s2).
%%%%%%%% node45_1 %%%%%%%%%%%%%%%%%%%
node(node45_1).
functor(node45_1, pred).         const(pred).
gram_sempos(node45_1, v).         const(v).
id(node45_1, t_plzensky64131_txt_001_p2s2a1).         const(t_plzensky64131_txt_001_p2s2a1).
t_lemma(node45_1, zranit).         const(zranit).
%%%%%%%% node45_2 %%%%%%%%%%%%%%%%%%%
node(node45_2).
functor(node45_2, act).         const(act).
id(node45_2, t_plzensky64131_txt_001_p2s2a8).         const(t_plzensky64131_txt_001_p2s2a8).
t_lemma(node45_2, x_gen).         const(x_gen).
%%%%%%%% node45_3 %%%%%%%%%%%%%%%%%%%
node(node45_3).
functor(node45_3, twhen).         const(twhen).
gram_sempos(node45_3, n_denot).         const(n_denot).
id(node45_3, t_plzensky64131_txt_001_p2s2a3).         const(t_plzensky64131_txt_001_p2s2a3).
t_lemma(node45_3, nehoda).         const(nehoda).
%%%%%%%% node45_4 %%%%%%%%%%%%%%%%%%%
node(node45_4).
a_afun(node45_4, auxp).         const(auxp).
m_form(node45_4, pri).         const(pri).
m_lemma(node45_4, pri_1).         const(pri_1).
m_tag(node45_4, rr__6__________).         const(rr__6__________).
m_tag0(node45_4,'r'). const('r'). m_tag1(node45_4,'r'). const('r'). m_tag4(node45_4,'6'). const('6'). 
%%%%%%%% node45_5 %%%%%%%%%%%%%%%%%%%
node(node45_5).
a_afun(node45_5, adv).         const(adv).
m_form(node45_5, nehode).         const(nehode).
m_lemma(node45_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node45_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node45_5,'n'). const('n'). m_tag1(node45_5,'n'). const('n'). m_tag2(node45_5,'f'). const('f'). m_tag3(node45_5,'s'). const('s'). m_tag4(node45_5,'6'). const('6'). m_tag10(node45_5,'a'). const('a'). 
%%%%%%%% node45_6 %%%%%%%%%%%%%%%%%%%
node(node45_6).
functor(node45_6, mann).         const(mann).
gram_sempos(node45_6, adj_denot).         const(adj_denot).
id(node45_6, t_plzensky64131_txt_001_p2s2a5).         const(t_plzensky64131_txt_001_p2s2a5).
t_lemma(node45_6, lehky).         const(lehky).
%%%%%%%% node45_7 %%%%%%%%%%%%%%%%%%%
node(node45_7).
a_afun(node45_7, adv).         const(adv).
m_form(node45_7, lehce).         const(lehce).
m_lemma(node45_7, lehce).         const(lehce).
m_tag(node45_7, dg_______1a____).         const(dg_______1a____).
m_tag0(node45_7,'d'). const('d'). m_tag1(node45_7,'g'). const('g'). m_tag9(node45_7,'1'). const('1'). m_tag10(node45_7,'a'). const('a'). 
%%%%%%%% node45_8 %%%%%%%%%%%%%%%%%%%
node(node45_8).
a_afun(node45_8, auxv).         const(auxv).
m_form(node45_8, byla).         const(byla).
m_lemma(node45_8, byt).         const(byt).
m_tag(node45_8, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node45_8,'v'). const('v'). m_tag1(node45_8,'p'). const('p'). m_tag2(node45_8,'q'). const('q'). m_tag3(node45_8,'w'). const('w'). m_tag7(node45_8,'x'). const('x'). m_tag8(node45_8,'r'). const('r'). m_tag10(node45_8,'a'). const('a'). m_tag11(node45_8,'a'). const('a'). 
%%%%%%%% node45_9 %%%%%%%%%%%%%%%%%%%
node(node45_9).
a_afun(node45_9, pred).         const(pred).
m_form(node45_9, zranena).         const(zranena).
m_lemma(node45_9, zranit__w).         const(zranit__w).
m_tag(node45_9, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node45_9,'v'). const('v'). m_tag1(node45_9,'s'). const('s'). m_tag2(node45_9,'q'). const('q'). m_tag3(node45_9,'w'). const('w'). m_tag7(node45_9,'x'). const('x'). m_tag8(node45_9,'x'). const('x'). m_tag10(node45_9,'a'). const('a'). m_tag11(node45_9,'p'). const('p'). 
%%%%%%%% node45_10 %%%%%%%%%%%%%%%%%%%
node(node45_10).
functor(node45_10, pat).         const(pat).
gram_sempos(node45_10, n_denot).         const(n_denot).
id(node45_10, t_plzensky64131_txt_001_p2s2a6).         const(t_plzensky64131_txt_001_p2s2a6).
t_lemma(node45_10, osoba).         const(osoba).
%%%%%%%% node45_11 %%%%%%%%%%%%%%%%%%%
node(node45_11).
functor(node45_11, rstr).         const(rstr).
gram_sempos(node45_11, adj_quant_def).         const(adj_quant_def).
id(node45_11, t_plzensky64131_txt_001_p2s2a7).         const(t_plzensky64131_txt_001_p2s2a7).
t_lemma(node45_11, jeden).         const(jeden).
%%%%%%%% node45_12 %%%%%%%%%%%%%%%%%%%
node(node45_12).
a_afun(node45_12, atr).         const(atr).
m_form(node45_12, jedna).         const(jedna).
m_lemma(node45_12, jeden_1).         const(jeden_1).
m_tag(node45_12, clfs1__________).         const(clfs1__________).
m_tag0(node45_12,'c'). const('c'). m_tag1(node45_12,'l'). const('l'). m_tag2(node45_12,'f'). const('f'). m_tag3(node45_12,'s'). const('s'). m_tag4(node45_12,'1'). const('1'). 
%%%%%%%% node45_13 %%%%%%%%%%%%%%%%%%%
node(node45_13).
a_afun(node45_13, sb).         const(sb).
m_form(node45_13, osoba).         const(osoba).
m_lemma(node45_13, osoba).         const(osoba).
m_tag(node45_13, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node45_13,'n'). const('n'). m_tag1(node45_13,'n'). const('n'). m_tag2(node45_13,'f'). const('f'). m_tag3(node45_13,'s'). const('s'). m_tag4(node45_13,'1'). const('1'). m_tag10(node45_13,'a'). const('a'). 
edge(node45_0, node45_1).
edge(node45_1, node45_2).
edge(node45_1, node45_3).
edge(node45_3, node45_4).
edge(node45_3, node45_5).
edge(node45_1, node45_6).
edge(node45_6, node45_7).
edge(node45_1, node45_8).
edge(node45_1, node45_9).
edge(node45_1, node45_10).
edge(node45_10, node45_11).
edge(node45_11, node45_12).
edge(node45_10, node45_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode bylo zraneno celkem pet osob, z toho dve tezce. 
tree_root(node46_0).
%%%%%%%% node46_0 %%%%%%%%%%%%%%%%%%%
node(node46_0).
id(node46_0, t_plzensky69695_txt_001_p1s1).         const(t_plzensky69695_txt_001_p1s1).
%%%%%%%% node46_1 %%%%%%%%%%%%%%%%%%%
node(node46_1).
functor(node46_1, pred).         const(pred).
gram_sempos(node46_1, v).         const(v).
id(node46_1, t_plzensky69695_txt_001_p1s1a1).         const(t_plzensky69695_txt_001_p1s1a1).
t_lemma(node46_1, zranit).         const(zranit).
%%%%%%%% node46_2 %%%%%%%%%%%%%%%%%%%
node(node46_2).
functor(node46_2, pat).         const(pat).
gram_sempos(node46_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node46_2, t_plzensky69695_txt_001_p1s1a14).         const(t_plzensky69695_txt_001_p1s1a14).
t_lemma(node46_2, x_perspron).         const(x_perspron).
%%%%%%%% node46_3 %%%%%%%%%%%%%%%%%%%
node(node46_3).
functor(node46_3, act).         const(act).
id(node46_3, t_plzensky69695_txt_001_p1s1a13).         const(t_plzensky69695_txt_001_p1s1a13).
t_lemma(node46_3, x_gen).         const(x_gen).
%%%%%%%% node46_4 %%%%%%%%%%%%%%%%%%%
node(node46_4).
functor(node46_4, twhen).         const(twhen).
gram_sempos(node46_4, n_denot).         const(n_denot).
id(node46_4, t_plzensky69695_txt_001_p1s1a3).         const(t_plzensky69695_txt_001_p1s1a3).
t_lemma(node46_4, nehoda).         const(nehoda).
%%%%%%%% node46_5 %%%%%%%%%%%%%%%%%%%
node(node46_5).
a_afun(node46_5, auxp).         const(auxp).
m_form(node46_5, pri).         const(pri).
m_lemma(node46_5, pri_1).         const(pri_1).
m_tag(node46_5, rr__6__________).         const(rr__6__________).
m_tag0(node46_5,'r'). const('r'). m_tag1(node46_5,'r'). const('r'). m_tag4(node46_5,'6'). const('6'). 
%%%%%%%% node46_6 %%%%%%%%%%%%%%%%%%%
node(node46_6).
a_afun(node46_6, adv).         const(adv).
m_form(node46_6, nehode).         const(nehode).
m_lemma(node46_6, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node46_6, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node46_6,'n'). const('n'). m_tag1(node46_6,'n'). const('n'). m_tag2(node46_6,'f'). const('f'). m_tag3(node46_6,'s'). const('s'). m_tag4(node46_6,'6'). const('6'). m_tag10(node46_6,'a'). const('a'). 
%%%%%%%% node46_7 %%%%%%%%%%%%%%%%%%%
node(node46_7).
a_afun(node46_7, auxv).         const(auxv).
m_form(node46_7, bylo).         const(bylo).
m_lemma(node46_7, byt).         const(byt).
m_tag(node46_7, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node46_7,'v'). const('v'). m_tag1(node46_7,'p'). const('p'). m_tag2(node46_7,'n'). const('n'). m_tag3(node46_7,'s'). const('s'). m_tag7(node46_7,'x'). const('x'). m_tag8(node46_7,'r'). const('r'). m_tag10(node46_7,'a'). const('a'). m_tag11(node46_7,'a'). const('a'). 
%%%%%%%% node46_8 %%%%%%%%%%%%%%%%%%%
node(node46_8).
a_afun(node46_8, pred).         const(pred).
m_form(node46_8, zraneno).         const(zraneno).
m_lemma(node46_8, zranit__w).         const(zranit__w).
m_tag(node46_8, vsns___xx_ap___).         const(vsns___xx_ap___).
m_tag0(node46_8,'v'). const('v'). m_tag1(node46_8,'s'). const('s'). m_tag2(node46_8,'n'). const('n'). m_tag3(node46_8,'s'). const('s'). m_tag7(node46_8,'x'). const('x'). m_tag8(node46_8,'x'). const('x'). m_tag10(node46_8,'a'). const('a'). m_tag11(node46_8,'p'). const('p'). 
%%%%%%%% node46_9 %%%%%%%%%%%%%%%%%%%
node(node46_9).
functor(node46_9, rstr).         const(rstr).
id(node46_9, t_plzensky69695_txt_001_p1s1a5).         const(t_plzensky69695_txt_001_p1s1a5).
t_lemma(node46_9, x_comma).         const(x_comma).
%%%%%%%% node46_10 %%%%%%%%%%%%%%%%%%%
node(node46_10).
functor(node46_10, act).         const(act).
gram_sempos(node46_10, n_denot).         const(n_denot).
id(node46_10, t_plzensky69695_txt_001_p1s1a8).         const(t_plzensky69695_txt_001_p1s1a8).
t_lemma(node46_10, osoba).         const(osoba).
%%%%%%%% node46_11 %%%%%%%%%%%%%%%%%%%
node(node46_11).
functor(node46_11, rstr).         const(rstr).
gram_sempos(node46_11, adj_quant_def).         const(adj_quant_def).
id(node46_11, t_plzensky69695_txt_001_p1s1a6).         const(t_plzensky69695_txt_001_p1s1a6).
t_lemma(node46_11, pet).         const(pet).
%%%%%%%% node46_12 %%%%%%%%%%%%%%%%%%%
node(node46_12).
functor(node46_12, ext).         const(ext).
gram_sempos(node46_12, adv_denot_ngrad_nneg).         const(adv_denot_ngrad_nneg).
id(node46_12, t_plzensky69695_txt_001_p1s1a7).         const(t_plzensky69695_txt_001_p1s1a7).
t_lemma(node46_12, celkem).         const(celkem).
%%%%%%%% node46_13 %%%%%%%%%%%%%%%%%%%
node(node46_13).
a_afun(node46_13, auxz).         const(auxz).
m_form(node46_13, celkem).         const(celkem).
m_lemma(node46_13, celkem).         const(celkem).
m_tag(node46_13, db_____________).         const(db_____________).
m_tag0(node46_13,'d'). const('d'). m_tag1(node46_13,'b'). const('b'). 
%%%%%%%% node46_14 %%%%%%%%%%%%%%%%%%%
node(node46_14).
a_afun(node46_14, sb).         const(sb).
m_form(node46_14, pet).         const(pet).
m_lemma(node46_14, pet_1_5).         const(pet_1_5).
m_tag(node46_14, cn_s4__________).         const(cn_s4__________).
m_tag0(node46_14,'c'). const('c'). m_tag1(node46_14,'n'). const('n'). m_tag3(node46_14,'s'). const('s'). m_tag4(node46_14,'4'). const('4'). 
%%%%%%%% node46_15 %%%%%%%%%%%%%%%%%%%
node(node46_15).
a_afun(node46_15, atr).         const(atr).
m_form(node46_15, osob).         const(osob).
m_lemma(node46_15, osoba).         const(osoba).
m_tag(node46_15, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node46_15,'n'). const('n'). m_tag1(node46_15,'n'). const('n'). m_tag2(node46_15,'f'). const('f'). m_tag3(node46_15,'p'). const('p'). m_tag4(node46_15,'2'). const('2'). m_tag10(node46_15,'a'). const('a'). 
%%%%%%%% node46_16 %%%%%%%%%%%%%%%%%%%
node(node46_16).
a_afun(node46_16, auxx).         const(auxx).
m_form(node46_16, x_).         const(x_).
m_lemma(node46_16, x_).         const(x_).
m_tag(node46_16, z______________).         const(z______________).
m_tag0(node46_16,'z'). const('z'). m_tag1(node46_16,':'). const(':'). 
%%%%%%%% node46_17 %%%%%%%%%%%%%%%%%%%
node(node46_17).
functor(node46_17, dir1).         const(dir1).
gram_sempos(node46_17, n_pron_def_demon).         const(n_pron_def_demon).
id(node46_17, t_plzensky69695_txt_001_p1s1a10).         const(t_plzensky69695_txt_001_p1s1a10).
t_lemma(node46_17, ten).         const(ten).
%%%%%%%% node46_18 %%%%%%%%%%%%%%%%%%%
node(node46_18).
a_afun(node46_18, auxp).         const(auxp).
m_form(node46_18, z).         const(z).
m_lemma(node46_18, z_1).         const(z_1).
m_tag(node46_18, rr__2__________).         const(rr__2__________).
m_tag0(node46_18,'r'). const('r'). m_tag1(node46_18,'r'). const('r'). m_tag4(node46_18,'2'). const('2'). 
%%%%%%%% node46_19 %%%%%%%%%%%%%%%%%%%
node(node46_19).
a_afun(node46_19, adv).         const(adv).
m_form(node46_19, toho).         const(toho).
m_lemma(node46_19, ten).         const(ten).
m_tag(node46_19, pdzs2__________).         const(pdzs2__________).
m_tag0(node46_19,'p'). const('p'). m_tag1(node46_19,'d'). const('d'). m_tag2(node46_19,'z'). const('z'). m_tag3(node46_19,'s'). const('s'). m_tag4(node46_19,'2'). const('2'). 
%%%%%%%% node46_20 %%%%%%%%%%%%%%%%%%%
node(node46_20).
functor(node46_20, act).         const(act).
gram_sempos(node46_20, n_quant_def).         const(n_quant_def).
id(node46_20, t_plzensky69695_txt_001_p1s1a11).         const(t_plzensky69695_txt_001_p1s1a11).
t_lemma(node46_20, dva).         const(dva).
%%%%%%%% node46_21 %%%%%%%%%%%%%%%%%%%
node(node46_21).
a_afun(node46_21, sb).         const(sb).
m_form(node46_21, dve).         const(dve).
m_lemma(node46_21, dva_2).         const(dva_2).
m_tag(node46_21, clhp1__________).         const(clhp1__________).
m_tag0(node46_21,'c'). const('c'). m_tag1(node46_21,'l'). const('l'). m_tag2(node46_21,'h'). const('h'). m_tag3(node46_21,'p'). const('p'). m_tag4(node46_21,'1'). const('1'). 
%%%%%%%% node46_22 %%%%%%%%%%%%%%%%%%%
node(node46_22).
functor(node46_22, rstr).         const(rstr).
gram_sempos(node46_22, adj_denot).         const(adj_denot).
id(node46_22, t_plzensky69695_txt_001_p1s1a12).         const(t_plzensky69695_txt_001_p1s1a12).
t_lemma(node46_22, tezky).         const(tezky).
%%%%%%%% node46_23 %%%%%%%%%%%%%%%%%%%
node(node46_23).
a_afun(node46_23, adv).         const(adv).
m_form(node46_23, tezce).         const(tezce).
m_lemma(node46_23, tezce).         const(tezce).
m_tag(node46_23, dg_______1a____).         const(dg_______1a____).
m_tag0(node46_23,'d'). const('d'). m_tag1(node46_23,'g'). const('g'). m_tag9(node46_23,'1'). const('1'). m_tag10(node46_23,'a'). const('a'). 
edge(node46_0, node46_1).
edge(node46_1, node46_2).
edge(node46_1, node46_3).
edge(node46_1, node46_4).
edge(node46_4, node46_5).
edge(node46_4, node46_6).
edge(node46_1, node46_7).
edge(node46_1, node46_8).
edge(node46_1, node46_9).
edge(node46_9, node46_10).
edge(node46_10, node46_11).
edge(node46_11, node46_12).
edge(node46_12, node46_13).
edge(node46_11, node46_14).
edge(node46_10, node46_15).
edge(node46_9, node46_16).
edge(node46_9, node46_17).
edge(node46_17, node46_18).
edge(node46_17, node46_19).
edge(node46_9, node46_20).
edge(node46_20, node46_21).
edge(node46_9, node46_22).
edge(node46_22, node46_23).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl lehce zranen ridic kamionu. 
tree_root(node47_0).
%%%%%%%% node47_0 %%%%%%%%%%%%%%%%%%%
node(node47_0).
id(node47_0, t_plzensky55831_txt_001_p1s3).         const(t_plzensky55831_txt_001_p1s3).
%%%%%%%% node47_1 %%%%%%%%%%%%%%%%%%%
node(node47_1).
functor(node47_1, pred).         const(pred).
gram_sempos(node47_1, v).         const(v).
id(node47_1, t_plzensky55831_txt_001_p1s3a1).         const(t_plzensky55831_txt_001_p1s3a1).
t_lemma(node47_1, zranit).         const(zranit).
%%%%%%%% node47_2 %%%%%%%%%%%%%%%%%%%
node(node47_2).
functor(node47_2, act).         const(act).
id(node47_2, t_plzensky55831_txt_001_p1s3a8).         const(t_plzensky55831_txt_001_p1s3a8).
t_lemma(node47_2, x_gen).         const(x_gen).
%%%%%%%% node47_3 %%%%%%%%%%%%%%%%%%%
node(node47_3).
functor(node47_3, twhen).         const(twhen).
gram_sempos(node47_3, n_denot).         const(n_denot).
id(node47_3, t_plzensky55831_txt_001_p1s3a3).         const(t_plzensky55831_txt_001_p1s3a3).
t_lemma(node47_3, nehoda).         const(nehoda).
%%%%%%%% node47_4 %%%%%%%%%%%%%%%%%%%
node(node47_4).
a_afun(node47_4, auxp).         const(auxp).
m_form(node47_4, pri).         const(pri).
m_lemma(node47_4, pri_1).         const(pri_1).
m_tag(node47_4, rr__6__________).         const(rr__6__________).
m_tag0(node47_4,'r'). const('r'). m_tag1(node47_4,'r'). const('r'). m_tag4(node47_4,'6'). const('6'). 
%%%%%%%% node47_5 %%%%%%%%%%%%%%%%%%%
node(node47_5).
a_afun(node47_5, adv).         const(adv).
m_form(node47_5, nehode).         const(nehode).
m_lemma(node47_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node47_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node47_5,'n'). const('n'). m_tag1(node47_5,'n'). const('n'). m_tag2(node47_5,'f'). const('f'). m_tag3(node47_5,'s'). const('s'). m_tag4(node47_5,'6'). const('6'). m_tag10(node47_5,'a'). const('a'). 
%%%%%%%% node47_6 %%%%%%%%%%%%%%%%%%%
node(node47_6).
functor(node47_6, mann).         const(mann).
gram_sempos(node47_6, adj_denot).         const(adj_denot).
id(node47_6, t_plzensky55831_txt_001_p1s3a5).         const(t_plzensky55831_txt_001_p1s3a5).
t_lemma(node47_6, lehky).         const(lehky).
%%%%%%%% node47_7 %%%%%%%%%%%%%%%%%%%
node(node47_7).
a_afun(node47_7, adv).         const(adv).
m_form(node47_7, lehce).         const(lehce).
m_lemma(node47_7, lehce).         const(lehce).
m_tag(node47_7, dg_______1a____).         const(dg_______1a____).
m_tag0(node47_7,'d'). const('d'). m_tag1(node47_7,'g'). const('g'). m_tag9(node47_7,'1'). const('1'). m_tag10(node47_7,'a'). const('a'). 
%%%%%%%% node47_8 %%%%%%%%%%%%%%%%%%%
node(node47_8).
a_afun(node47_8, auxv).         const(auxv).
m_form(node47_8, byl).         const(byl).
m_lemma(node47_8, byt).         const(byt).
m_tag(node47_8, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node47_8,'v'). const('v'). m_tag1(node47_8,'p'). const('p'). m_tag2(node47_8,'y'). const('y'). m_tag3(node47_8,'s'). const('s'). m_tag7(node47_8,'x'). const('x'). m_tag8(node47_8,'r'). const('r'). m_tag10(node47_8,'a'). const('a'). m_tag11(node47_8,'a'). const('a'). 
%%%%%%%% node47_9 %%%%%%%%%%%%%%%%%%%
node(node47_9).
a_afun(node47_9, pred).         const(pred).
m_form(node47_9, zranen).         const(zranen).
m_lemma(node47_9, zranit__w).         const(zranit__w).
m_tag(node47_9, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node47_9,'v'). const('v'). m_tag1(node47_9,'s'). const('s'). m_tag2(node47_9,'y'). const('y'). m_tag3(node47_9,'s'). const('s'). m_tag7(node47_9,'x'). const('x'). m_tag8(node47_9,'x'). const('x'). m_tag10(node47_9,'a'). const('a'). m_tag11(node47_9,'p'). const('p'). 
%%%%%%%% node47_10 %%%%%%%%%%%%%%%%%%%
node(node47_10).
functor(node47_10, pat).         const(pat).
gram_sempos(node47_10, n_denot).         const(n_denot).
id(node47_10, t_plzensky55831_txt_001_p1s3a6).         const(t_plzensky55831_txt_001_p1s3a6).
t_lemma(node47_10, ridic).         const(ridic).
%%%%%%%% node47_11 %%%%%%%%%%%%%%%%%%%
node(node47_11).
a_afun(node47_11, sb).         const(sb).
m_form(node47_11, ridic).         const(ridic).
m_lemma(node47_11, ridic).         const(ridic).
m_tag(node47_11, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node47_11,'n'). const('n'). m_tag1(node47_11,'n'). const('n'). m_tag2(node47_11,'m'). const('m'). m_tag3(node47_11,'s'). const('s'). m_tag4(node47_11,'1'). const('1'). m_tag10(node47_11,'a'). const('a'). 
%%%%%%%% node47_12 %%%%%%%%%%%%%%%%%%%
node(node47_12).
functor(node47_12, app).         const(app).
gram_sempos(node47_12, n_denot).         const(n_denot).
id(node47_12, t_plzensky55831_txt_001_p1s3a7).         const(t_plzensky55831_txt_001_p1s3a7).
t_lemma(node47_12, kamion).         const(kamion).
%%%%%%%% node47_13 %%%%%%%%%%%%%%%%%%%
node(node47_13).
a_afun(node47_13, atr).         const(atr).
m_form(node47_13, kamionu).         const(kamionu).
m_lemma(node47_13, kamion).         const(kamion).
m_tag(node47_13, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node47_13,'n'). const('n'). m_tag1(node47_13,'n'). const('n'). m_tag2(node47_13,'i'). const('i'). m_tag3(node47_13,'s'). const('s'). m_tag4(node47_13,'2'). const('2'). m_tag10(node47_13,'a'). const('a'). 
edge(node47_0, node47_1).
edge(node47_1, node47_2).
edge(node47_1, node47_3).
edge(node47_3, node47_4).
edge(node47_3, node47_5).
edge(node47_1, node47_6).
edge(node47_6, node47_7).
edge(node47_1, node47_8).
edge(node47_1, node47_9).
edge(node47_1, node47_10).
edge(node47_10, node47_11).
edge(node47_10, node47_12).
edge(node47_12, node47_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ridicka nebyla nastesti zranena. 
tree_root(node48_0).
%%%%%%%% node48_0 %%%%%%%%%%%%%%%%%%%
node(node48_0).
id(node48_0, t_plzensky49288_txt_001_p6s6).         const(t_plzensky49288_txt_001_p6s6).
%%%%%%%% node48_1 %%%%%%%%%%%%%%%%%%%
node(node48_1).
functor(node48_1, pred).         const(pred).
gram_sempos(node48_1, v).         const(v).
id(node48_1, t_plzensky49288_txt_001_p6s6a1).         const(t_plzensky49288_txt_001_p6s6a1).
t_lemma(node48_1, zranit).         const(zranit).
%%%%%%%% node48_2 %%%%%%%%%%%%%%%%%%%
node(node48_2).
functor(node48_2, act).         const(act).
id(node48_2, t_plzensky49288_txt_001_p6s6a5).         const(t_plzensky49288_txt_001_p6s6a5).
t_lemma(node48_2, x_gen).         const(x_gen).
%%%%%%%% node48_3 %%%%%%%%%%%%%%%%%%%
node(node48_3).
functor(node48_3, pat).         const(pat).
gram_sempos(node48_3, n_denot).         const(n_denot).
id(node48_3, t_plzensky49288_txt_001_p6s6a2).         const(t_plzensky49288_txt_001_p6s6a2).
t_lemma(node48_3, ridicka).         const(ridicka).
%%%%%%%% node48_4 %%%%%%%%%%%%%%%%%%%
node(node48_4).
a_afun(node48_4, sb).         const(sb).
m_form(node48_4, ridicka).         const(ridicka).
m_lemma(node48_4, ridicka____2_).         const(ridicka____2_).
m_tag(node48_4, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node48_4,'n'). const('n'). m_tag1(node48_4,'n'). const('n'). m_tag2(node48_4,'f'). const('f'). m_tag3(node48_4,'s'). const('s'). m_tag4(node48_4,'1'). const('1'). m_tag10(node48_4,'a'). const('a'). 
%%%%%%%% node48_5 %%%%%%%%%%%%%%%%%%%
node(node48_5).
functor(node48_5, att).         const(att).
id(node48_5, t_plzensky49288_txt_001_p6s6a4).         const(t_plzensky49288_txt_001_p6s6a4).
t_lemma(node48_5, nastesti).         const(nastesti).
%%%%%%%% node48_6 %%%%%%%%%%%%%%%%%%%
node(node48_6).
a_afun(node48_6, adv).         const(adv).
m_form(node48_6, nastesti).         const(nastesti).
m_lemma(node48_6, nastesti).         const(nastesti).
m_tag(node48_6, db_____________).         const(db_____________).
m_tag0(node48_6,'d'). const('d'). m_tag1(node48_6,'b'). const('b'). 
%%%%%%%% node48_7 %%%%%%%%%%%%%%%%%%%
node(node48_7).
a_afun(node48_7, auxv).         const(auxv).
m_form(node48_7, nebyla).         const(nebyla).
m_lemma(node48_7, byt).         const(byt).
m_tag(node48_7, vpqw___xr_na___).         const(vpqw___xr_na___).
m_tag0(node48_7,'v'). const('v'). m_tag1(node48_7,'p'). const('p'). m_tag2(node48_7,'q'). const('q'). m_tag3(node48_7,'w'). const('w'). m_tag7(node48_7,'x'). const('x'). m_tag8(node48_7,'r'). const('r'). m_tag10(node48_7,'n'). const('n'). m_tag11(node48_7,'a'). const('a'). 
%%%%%%%% node48_8 %%%%%%%%%%%%%%%%%%%
node(node48_8).
a_afun(node48_8, pred).         const(pred).
m_form(node48_8, zranena).         const(zranena).
m_lemma(node48_8, zranit__w).         const(zranit__w).
m_tag(node48_8, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node48_8,'v'). const('v'). m_tag1(node48_8,'s'). const('s'). m_tag2(node48_8,'q'). const('q'). m_tag3(node48_8,'w'). const('w'). m_tag7(node48_8,'x'). const('x'). m_tag8(node48_8,'x'). const('x'). m_tag10(node48_8,'a'). const('a'). m_tag11(node48_8,'p'). const('p'). 
edge(node48_0, node48_1).
edge(node48_1, node48_2).
edge(node48_1, node48_3).
edge(node48_3, node48_4).
edge(node48_1, node48_5).
edge(node48_5, node48_6).
edge(node48_1, node48_7).
edge(node48_1, node48_8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pri nehode byl zranen ridic vozidla, ktereho museli hasici vyprostovat. 
tree_root(node49_0).
%%%%%%%% node49_0 %%%%%%%%%%%%%%%%%%%
node(node49_0).
id(node49_0, t_plzensky59722_txt_001_p2s3).         const(t_plzensky59722_txt_001_p2s3).
%%%%%%%% node49_1 %%%%%%%%%%%%%%%%%%%
node(node49_1).
functor(node49_1, pred).         const(pred).
gram_sempos(node49_1, v).         const(v).
id(node49_1, t_plzensky59722_txt_001_p2s3a1).         const(t_plzensky59722_txt_001_p2s3a1).
t_lemma(node49_1, zranit).         const(zranit).
%%%%%%%% node49_2 %%%%%%%%%%%%%%%%%%%
node(node49_2).
functor(node49_2, act).         const(act).
id(node49_2, t_plzensky59722_txt_001_p2s3a12).         const(t_plzensky59722_txt_001_p2s3a12).
t_lemma(node49_2, x_gen).         const(x_gen).
%%%%%%%% node49_3 %%%%%%%%%%%%%%%%%%%
node(node49_3).
functor(node49_3, twhen).         const(twhen).
gram_sempos(node49_3, n_denot).         const(n_denot).
id(node49_3, t_plzensky59722_txt_001_p2s3a3).         const(t_plzensky59722_txt_001_p2s3a3).
t_lemma(node49_3, nehoda).         const(nehoda).
%%%%%%%% node49_4 %%%%%%%%%%%%%%%%%%%
node(node49_4).
a_afun(node49_4, auxp).         const(auxp).
m_form(node49_4, pri).         const(pri).
m_lemma(node49_4, pri_1).         const(pri_1).
m_tag(node49_4, rr__6__________).         const(rr__6__________).
m_tag0(node49_4,'r'). const('r'). m_tag1(node49_4,'r'). const('r'). m_tag4(node49_4,'6'). const('6'). 
%%%%%%%% node49_5 %%%%%%%%%%%%%%%%%%%
node(node49_5).
a_afun(node49_5, adv).         const(adv).
m_form(node49_5, nehode).         const(nehode).
m_lemma(node49_5, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node49_5, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node49_5,'n'). const('n'). m_tag1(node49_5,'n'). const('n'). m_tag2(node49_5,'f'). const('f'). m_tag3(node49_5,'s'). const('s'). m_tag4(node49_5,'6'). const('6'). m_tag10(node49_5,'a'). const('a'). 
%%%%%%%% node49_6 %%%%%%%%%%%%%%%%%%%
node(node49_6).
a_afun(node49_6, auxv).         const(auxv).
m_form(node49_6, byl).         const(byl).
m_lemma(node49_6, byt).         const(byt).
m_tag(node49_6, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node49_6,'v'). const('v'). m_tag1(node49_6,'p'). const('p'). m_tag2(node49_6,'y'). const('y'). m_tag3(node49_6,'s'). const('s'). m_tag7(node49_6,'x'). const('x'). m_tag8(node49_6,'r'). const('r'). m_tag10(node49_6,'a'). const('a'). m_tag11(node49_6,'a'). const('a'). 
%%%%%%%% node49_7 %%%%%%%%%%%%%%%%%%%
node(node49_7).
a_afun(node49_7, pred).         const(pred).
m_form(node49_7, zranen).         const(zranen).
m_lemma(node49_7, zranit__w).         const(zranit__w).
m_tag(node49_7, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node49_7,'v'). const('v'). m_tag1(node49_7,'s'). const('s'). m_tag2(node49_7,'y'). const('y'). m_tag3(node49_7,'s'). const('s'). m_tag7(node49_7,'x'). const('x'). m_tag8(node49_7,'x'). const('x'). m_tag10(node49_7,'a'). const('a'). m_tag11(node49_7,'p'). const('p'). 
%%%%%%%% node49_8 %%%%%%%%%%%%%%%%%%%
node(node49_8).
functor(node49_8, pat).         const(pat).
gram_sempos(node49_8, n_denot).         const(n_denot).
id(node49_8, t_plzensky59722_txt_001_p2s3a5).         const(t_plzensky59722_txt_001_p2s3a5).
t_lemma(node49_8, ridic).         const(ridic).
%%%%%%%% node49_9 %%%%%%%%%%%%%%%%%%%
node(node49_9).
a_afun(node49_9, sb).         const(sb).
m_form(node49_9, ridic).         const(ridic).
m_lemma(node49_9, ridic).         const(ridic).
m_tag(node49_9, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node49_9,'n'). const('n'). m_tag1(node49_9,'n'). const('n'). m_tag2(node49_9,'m'). const('m'). m_tag3(node49_9,'s'). const('s'). m_tag4(node49_9,'1'). const('1'). m_tag10(node49_9,'a'). const('a'). 
%%%%%%%% node49_10 %%%%%%%%%%%%%%%%%%%
node(node49_10).
functor(node49_10, app).         const(app).
gram_sempos(node49_10, n_denot).         const(n_denot).
id(node49_10, t_plzensky59722_txt_001_p2s3a6).         const(t_plzensky59722_txt_001_p2s3a6).
t_lemma(node49_10, vozidlo).         const(vozidlo).
%%%%%%%% node49_11 %%%%%%%%%%%%%%%%%%%
node(node49_11).
a_afun(node49_11, atr).         const(atr).
m_form(node49_11, vozidla).         const(vozidla).
m_lemma(node49_11, vozidlo).         const(vozidlo).
m_tag(node49_11, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node49_11,'n'). const('n'). m_tag1(node49_11,'n'). const('n'). m_tag2(node49_11,'n'). const('n'). m_tag3(node49_11,'s'). const('s'). m_tag4(node49_11,'2'). const('2'). m_tag10(node49_11,'a'). const('a'). 
%%%%%%%% node49_12 %%%%%%%%%%%%%%%%%%%
node(node49_12).
functor(node49_12, rstr).         const(rstr).
gram_sempos(node49_12, v).         const(v).
id(node49_12, t_plzensky59722_txt_001_p2s3a11).         const(t_plzensky59722_txt_001_p2s3a11).
t_lemma(node49_12, vyprostovat).         const(vyprostovat).
%%%%%%%% node49_13 %%%%%%%%%%%%%%%%%%%
node(node49_13).
functor(node49_13, pat).         const(pat).
gram_sempos(node49_13, n_pron_indef).         const(n_pron_indef).
id(node49_13, t_plzensky59722_txt_001_p2s3a9).         const(t_plzensky59722_txt_001_p2s3a9).
t_lemma(node49_13, ktery).         const(ktery).
%%%%%%%% node49_14 %%%%%%%%%%%%%%%%%%%
node(node49_14).
a_afun(node49_14, obj).         const(obj).
m_form(node49_14, ktereho).         const(ktereho).
m_lemma(node49_14, ktery).         const(ktery).
m_tag(node49_14, p4ms4__________).         const(p4ms4__________).
m_tag0(node49_14,'p'). const('p'). m_tag1(node49_14,'4'). const('4'). m_tag2(node49_14,'m'). const('m'). m_tag3(node49_14,'s'). const('s'). m_tag4(node49_14,'4'). const('4'). 
%%%%%%%% node49_15 %%%%%%%%%%%%%%%%%%%
node(node49_15).
functor(node49_15, act).         const(act).
gram_sempos(node49_15, n_denot).         const(n_denot).
id(node49_15, t_plzensky59722_txt_001_p2s3a10).         const(t_plzensky59722_txt_001_p2s3a10).
t_lemma(node49_15, hasic).         const(hasic).
%%%%%%%% node49_16 %%%%%%%%%%%%%%%%%%%
node(node49_16).
a_afun(node49_16, sb).         const(sb).
m_form(node49_16, hasici).         const(hasici).
m_lemma(node49_16, hasic).         const(hasic).
m_tag(node49_16, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node49_16,'n'). const('n'). m_tag1(node49_16,'n'). const('n'). m_tag2(node49_16,'m'). const('m'). m_tag3(node49_16,'p'). const('p'). m_tag4(node49_16,'1'). const('1'). m_tag10(node49_16,'a'). const('a'). 
%%%%%%%% node49_17 %%%%%%%%%%%%%%%%%%%
node(node49_17).
a_afun(node49_17, atr).         const(atr).
m_form(node49_17, museli).         const(museli).
m_lemma(node49_17, muset).         const(muset).
m_tag(node49_17, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node49_17,'v'). const('v'). m_tag1(node49_17,'p'). const('p'). m_tag2(node49_17,'m'). const('m'). m_tag3(node49_17,'p'). const('p'). m_tag7(node49_17,'x'). const('x'). m_tag8(node49_17,'r'). const('r'). m_tag10(node49_17,'a'). const('a'). m_tag11(node49_17,'a'). const('a'). 
%%%%%%%% node49_18 %%%%%%%%%%%%%%%%%%%
node(node49_18).
a_afun(node49_18, obj).         const(obj).
m_form(node49_18, vyprostovat).         const(vyprostovat).
m_lemma(node49_18, vyprostovat__t).         const(vyprostovat__t).
m_tag(node49_18, vf________a____).         const(vf________a____).
m_tag0(node49_18,'v'). const('v'). m_tag1(node49_18,'f'). const('f'). m_tag10(node49_18,'a'). const('a'). 
edge(node49_0, node49_1).
edge(node49_1, node49_2).
edge(node49_1, node49_3).
edge(node49_3, node49_4).
edge(node49_3, node49_5).
edge(node49_1, node49_6).
edge(node49_1, node49_7).
edge(node49_1, node49_8).
edge(node49_8, node49_9).
edge(node49_8, node49_10).
edge(node49_10, node49_11).
edge(node49_8, node49_12).
edge(node49_12, node49_13).
edge(node49_13, node49_14).
edge(node49_12, node49_15).
edge(node49_15, node49_16).
edge(node49_12, node49_17).
edge(node49_12, node49_18).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nikdo nebyl zranen. 
tree_root(node50_0).
%%%%%%%% node50_0 %%%%%%%%%%%%%%%%%%%
node(node50_0).
id(node50_0, t_plzensky59722_txt_001_p2s7).         const(t_plzensky59722_txt_001_p2s7).
%%%%%%%% node50_1 %%%%%%%%%%%%%%%%%%%
node(node50_1).
functor(node50_1, pred).         const(pred).
gram_sempos(node50_1, v).         const(v).
id(node50_1, t_plzensky59722_txt_001_p2s7a1).         const(t_plzensky59722_txt_001_p2s7a1).
t_lemma(node50_1, zranit).         const(zranit).
%%%%%%%% node50_2 %%%%%%%%%%%%%%%%%%%
node(node50_2).
functor(node50_2, act).         const(act).
id(node50_2, t_plzensky59722_txt_001_p2s7a3).         const(t_plzensky59722_txt_001_p2s7a3).
t_lemma(node50_2, x_gen).         const(x_gen).
%%%%%%%% node50_3 %%%%%%%%%%%%%%%%%%%
node(node50_3).
functor(node50_3, pat).         const(pat).
gram_sempos(node50_3, n_pron_indef).         const(n_pron_indef).
id(node50_3, t_plzensky59722_txt_001_p2s7a2).         const(t_plzensky59722_txt_001_p2s7a2).
t_lemma(node50_3, kdo).         const(kdo).
%%%%%%%% node50_4 %%%%%%%%%%%%%%%%%%%
node(node50_4).
a_afun(node50_4, sb).         const(sb).
m_form(node50_4, nikdo).         const(nikdo).
m_lemma(node50_4, nikdo).         const(nikdo).
m_tag(node50_4, pwm_1__________).         const(pwm_1__________).
m_tag0(node50_4,'p'). const('p'). m_tag1(node50_4,'w'). const('w'). m_tag2(node50_4,'m'). const('m'). m_tag4(node50_4,'1'). const('1'). 
%%%%%%%% node50_5 %%%%%%%%%%%%%%%%%%%
node(node50_5).
a_afun(node50_5, auxv).         const(auxv).
m_form(node50_5, nebyl).         const(nebyl).
m_lemma(node50_5, byt).         const(byt).
m_tag(node50_5, vpys___xr_na___).         const(vpys___xr_na___).
m_tag0(node50_5,'v'). const('v'). m_tag1(node50_5,'p'). const('p'). m_tag2(node50_5,'y'). const('y'). m_tag3(node50_5,'s'). const('s'). m_tag7(node50_5,'x'). const('x'). m_tag8(node50_5,'r'). const('r'). m_tag10(node50_5,'n'). const('n'). m_tag11(node50_5,'a'). const('a'). 
%%%%%%%% node50_6 %%%%%%%%%%%%%%%%%%%
node(node50_6).
a_afun(node50_6, pred).         const(pred).
m_form(node50_6, zranen).         const(zranen).
m_lemma(node50_6, zranit__w).         const(zranit__w).
m_tag(node50_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node50_6,'v'). const('v'). m_tag1(node50_6,'s'). const('s'). m_tag2(node50_6,'y'). const('y'). m_tag3(node50_6,'s'). const('s'). m_tag7(node50_6,'x'). const('x'). m_tag8(node50_6,'x'). const('x'). m_tag10(node50_6,'a'). const('a'). m_tag11(node50_6,'p'). const('p'). 
edge(node50_0, node50_1).
edge(node50_1, node50_2).
edge(node50_1, node50_3).
edge(node50_3, node50_4).
edge(node50_1, node50_5).
edge(node50_1, node50_6).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N E G A T I V E      E X A M P L E S

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% osobni automobily skoda octavia a vw golf po celnim stretu zustaly na vozovce, treti vozidlo skoncilo na kolech v prikopu. 
tree_root(node51_0).
:- %%%%%%%% node51_0 %%%%%%%%%%%%%%%%%%%
node(node51_0).
id(node51_0, t_plzensky70827_txt_001_p1s1).         const(t_plzensky70827_txt_001_p1s1).
%%%%%%%% node51_1 %%%%%%%%%%%%%%%%%%%
node(node51_1).
functor(node51_1, conj).         const(conj).
id(node51_1, t_plzensky70827_txt_001_p1s1a1).         const(t_plzensky70827_txt_001_p1s1a1).
t_lemma(node51_1, x_comma).         const(x_comma).
%%%%%%%% node51_2 %%%%%%%%%%%%%%%%%%%
node(node51_2).
functor(node51_2, pred).         const(pred).
gram_sempos(node51_2, v).         const(v).
id(node51_2, t_plzensky70827_txt_001_p1s1a2).         const(t_plzensky70827_txt_001_p1s1a2).
t_lemma(node51_2, zustat).         const(zustat).
%%%%%%%% node51_3 %%%%%%%%%%%%%%%%%%%
node(node51_3).
functor(node51_3, conj).         const(conj).
id(node51_3, t_plzensky70827_txt_001_p1s1a3).         const(t_plzensky70827_txt_001_p1s1a3).
t_lemma(node51_3, a).         const(a).
%%%%%%%% node51_4 %%%%%%%%%%%%%%%%%%%
node(node51_4).
functor(node51_4, act).         const(act).
gram_sempos(node51_4, n_denot).         const(n_denot).
id(node51_4, t_plzensky70827_txt_001_p1s1a4).         const(t_plzensky70827_txt_001_p1s1a4).
t_lemma(node51_4, automobil).         const(automobil).
%%%%%%%% node51_5 %%%%%%%%%%%%%%%%%%%
node(node51_5).
functor(node51_5, rstr).         const(rstr).
gram_sempos(node51_5, adj_denot).         const(adj_denot).
id(node51_5, t_plzensky70827_txt_001_p1s1a5).         const(t_plzensky70827_txt_001_p1s1a5).
t_lemma(node51_5, osobni).         const(osobni).
%%%%%%%% node51_6 %%%%%%%%%%%%%%%%%%%
node(node51_6).
a_afun(node51_6, atr).         const(atr).
m_form(node51_6, osobni).         const(osobni).
m_lemma(node51_6, osobni).         const(osobni).
m_tag(node51_6, aaip1____1a____).         const(aaip1____1a____).
m_tag0(node51_6,'a'). const('a'). m_tag1(node51_6,'a'). const('a'). m_tag2(node51_6,'i'). const('i'). m_tag3(node51_6,'p'). const('p'). m_tag4(node51_6,'1'). const('1'). m_tag9(node51_6,'1'). const('1'). m_tag10(node51_6,'a'). const('a'). 
%%%%%%%% node51_7 %%%%%%%%%%%%%%%%%%%
node(node51_7).
a_afun(node51_7, sb).         const(sb).
m_form(node51_7, automobily).         const(automobily).
m_lemma(node51_7, automobil).         const(automobil).
m_tag(node51_7, nnip1_____a____).         const(nnip1_____a____).
m_tag0(node51_7,'n'). const('n'). m_tag1(node51_7,'n'). const('n'). m_tag2(node51_7,'i'). const('i'). m_tag3(node51_7,'p'). const('p'). m_tag4(node51_7,'1'). const('1'). m_tag10(node51_7,'a'). const('a'). 
%%%%%%%% node51_8 %%%%%%%%%%%%%%%%%%%
node(node51_8).
functor(node51_8, id).         const(id).
gram_sempos(node51_8, n_denot).         const(n_denot).
id(node51_8, t_plzensky70827_txt_001_p1s1a6).         const(t_plzensky70827_txt_001_p1s1a6).
t_lemma(node51_8, skoda).         const(skoda).
%%%%%%%% node51_9 %%%%%%%%%%%%%%%%%%%
node(node51_9).
a_afun(node51_9, atr).         const(atr).
m_form(node51_9, skoda).         const(skoda).
m_lemma(node51_9, skoda_1__k).         const(skoda_1__k).
m_tag(node51_9, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node51_9,'n'). const('n'). m_tag1(node51_9,'n'). const('n'). m_tag2(node51_9,'f'). const('f'). m_tag3(node51_9,'s'). const('s'). m_tag4(node51_9,'1'). const('1'). m_tag10(node51_9,'a'). const('a'). 
%%%%%%%% node51_10 %%%%%%%%%%%%%%%%%%%
node(node51_10).
functor(node51_10, pat).         const(pat).
gram_sempos(node51_10, n_denot).         const(n_denot).
id(node51_10, t_plzensky70827_txt_001_p1s1a7).         const(t_plzensky70827_txt_001_p1s1a7).
t_lemma(node51_10, octavius).         const(octavius).
%%%%%%%% node51_11 %%%%%%%%%%%%%%%%%%%
node(node51_11).
a_afun(node51_11, adv).         const(adv).
m_form(node51_11, octavia).         const(octavia).
m_lemma(node51_11, octavius__s).         const(octavius__s).
m_tag(node51_11, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node51_11,'n'). const('n'). m_tag1(node51_11,'n'). const('n'). m_tag2(node51_11,'m'). const('m'). m_tag3(node51_11,'s'). const('s'). m_tag4(node51_11,'2'). const('2'). m_tag10(node51_11,'a'). const('a'). 
%%%%%%%% node51_12 %%%%%%%%%%%%%%%%%%%
node(node51_12).
a_afun(node51_12, coord).         const(coord).
m_form(node51_12, a).         const(a).
m_lemma(node51_12, a_1).         const(a_1).
m_tag(node51_12, j______________).         const(j______________).
m_tag0(node51_12,'j'). const('j'). m_tag1(node51_12,'^'). const('^'). 
%%%%%%%% node51_13 %%%%%%%%%%%%%%%%%%%
node(node51_13).
functor(node51_13, act).         const(act).
gram_sempos(node51_13, n_denot).         const(n_denot).
id(node51_13, t_plzensky70827_txt_001_p1s1a8).         const(t_plzensky70827_txt_001_p1s1a8).
t_lemma(node51_13, golf).         const(golf).
%%%%%%%% node51_14 %%%%%%%%%%%%%%%%%%%
node(node51_14).
functor(node51_14, id).         const(id).
gram_sempos(node51_14, n_denot).         const(n_denot).
id(node51_14, t_plzensky70827_txt_001_p1s1a9).         const(t_plzensky70827_txt_001_p1s1a9).
t_lemma(node51_14, vw).         const(vw).
%%%%%%%% node51_15 %%%%%%%%%%%%%%%%%%%
node(node51_15).
a_afun(node51_15, atr).         const(atr).
m_form(node51_15, vw).         const(vw).
m_lemma(node51_15, vw_1__b__r__t___automobil_znacky_volkswagen_).         const(vw_1__b__r__t___automobil_znacky_volkswagen_).
m_tag(node51_15, nnixx_____a____).         const(nnixx_____a____).
m_tag0(node51_15,'n'). const('n'). m_tag1(node51_15,'n'). const('n'). m_tag2(node51_15,'i'). const('i'). m_tag3(node51_15,'x'). const('x'). m_tag4(node51_15,'x'). const('x'). m_tag10(node51_15,'a'). const('a'). 
%%%%%%%% node51_16 %%%%%%%%%%%%%%%%%%%
node(node51_16).
a_afun(node51_16, sb).         const(sb).
m_form(node51_16, golf).         const(golf).
m_lemma(node51_16, golf_2__r___vozidlo_).         const(golf_2__r___vozidlo_).
m_tag(node51_16, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node51_16,'n'). const('n'). m_tag1(node51_16,'n'). const('n'). m_tag2(node51_16,'i'). const('i'). m_tag3(node51_16,'s'). const('s'). m_tag4(node51_16,'1'). const('1'). m_tag10(node51_16,'a'). const('a'). 
%%%%%%%% node51_17 %%%%%%%%%%%%%%%%%%%
node(node51_17).
functor(node51_17, twhen).         const(twhen).
gram_sempos(node51_17, n_denot).         const(n_denot).
id(node51_17, t_plzensky70827_txt_001_p1s1a11).         const(t_plzensky70827_txt_001_p1s1a11).
t_lemma(node51_17, stret).         const(stret).
%%%%%%%% node51_18 %%%%%%%%%%%%%%%%%%%
node(node51_18).
functor(node51_18, rstr).         const(rstr).
gram_sempos(node51_18, adj_denot).         const(adj_denot).
id(node51_18, t_plzensky70827_txt_001_p1s1a12).         const(t_plzensky70827_txt_001_p1s1a12).
t_lemma(node51_18, celni).         const(celni).
%%%%%%%% node51_19 %%%%%%%%%%%%%%%%%%%
node(node51_19).
a_afun(node51_19, atr).         const(atr).
m_form(node51_19, celnim).         const(celnim).
m_lemma(node51_19, celni).         const(celni).
m_tag(node51_19, aais6____1a____).         const(aais6____1a____).
m_tag0(node51_19,'a'). const('a'). m_tag1(node51_19,'a'). const('a'). m_tag2(node51_19,'i'). const('i'). m_tag3(node51_19,'s'). const('s'). m_tag4(node51_19,'6'). const('6'). m_tag9(node51_19,'1'). const('1'). m_tag10(node51_19,'a'). const('a'). 
%%%%%%%% node51_20 %%%%%%%%%%%%%%%%%%%
node(node51_20).
a_afun(node51_20, auxp).         const(auxp).
m_form(node51_20, po).         const(po).
m_lemma(node51_20, po_1).         const(po_1).
m_tag(node51_20, rr__6__________).         const(rr__6__________).
m_tag0(node51_20,'r'). const('r'). m_tag1(node51_20,'r'). const('r'). m_tag4(node51_20,'6'). const('6'). 
%%%%%%%% node51_21 %%%%%%%%%%%%%%%%%%%
node(node51_21).
a_afun(node51_21, atr).         const(atr).
m_form(node51_21, stretu).         const(stretu).
m_lemma(node51_21, stret).         const(stret).
m_tag(node51_21, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node51_21,'n'). const('n'). m_tag1(node51_21,'n'). const('n'). m_tag2(node51_21,'i'). const('i'). m_tag3(node51_21,'s'). const('s'). m_tag4(node51_21,'6'). const('6'). m_tag10(node51_21,'a'). const('a'). 
%%%%%%%% node51_22 %%%%%%%%%%%%%%%%%%%
node(node51_22).
a_afun(node51_22, pred).         const(pred).
m_form(node51_22, zustaly).         const(zustaly).
m_lemma(node51_22, zustat).         const(zustat).
m_tag(node51_22, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node51_22,'v'). const('v'). m_tag1(node51_22,'p'). const('p'). m_tag2(node51_22,'t'). const('t'). m_tag3(node51_22,'p'). const('p'). m_tag7(node51_22,'x'). const('x'). m_tag8(node51_22,'r'). const('r'). m_tag10(node51_22,'a'). const('a'). m_tag11(node51_22,'a'). const('a'). 
%%%%%%%% node51_23 %%%%%%%%%%%%%%%%%%%
node(node51_23).
functor(node51_23, loc).         const(loc).
gram_sempos(node51_23, n_denot).         const(n_denot).
id(node51_23, t_plzensky70827_txt_001_p1s1a14).         const(t_plzensky70827_txt_001_p1s1a14).
t_lemma(node51_23, vozovka).         const(vozovka).
%%%%%%%% node51_24 %%%%%%%%%%%%%%%%%%%
node(node51_24).
a_afun(node51_24, auxp).         const(auxp).
m_form(node51_24, na).         const(na).
m_lemma(node51_24, na_1).         const(na_1).
m_tag(node51_24, rr__6__________).         const(rr__6__________).
m_tag0(node51_24,'r'). const('r'). m_tag1(node51_24,'r'). const('r'). m_tag4(node51_24,'6'). const('6'). 
%%%%%%%% node51_25 %%%%%%%%%%%%%%%%%%%
node(node51_25).
a_afun(node51_25, adv).         const(adv).
m_form(node51_25, vozovce).         const(vozovce).
m_lemma(node51_25, vozovka).         const(vozovka).
m_tag(node51_25, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node51_25,'n'). const('n'). m_tag1(node51_25,'n'). const('n'). m_tag2(node51_25,'f'). const('f'). m_tag3(node51_25,'s'). const('s'). m_tag4(node51_25,'6'). const('6'). m_tag10(node51_25,'a'). const('a'). 
%%%%%%%% node51_26 %%%%%%%%%%%%%%%%%%%
node(node51_26).
a_afun(node51_26, coord).         const(coord).
m_form(node51_26, x_).         const(x_).
m_lemma(node51_26, x_).         const(x_).
m_tag(node51_26, z______________).         const(z______________).
m_tag0(node51_26,'z'). const('z'). m_tag1(node51_26,':'). const(':'). 
%%%%%%%% node51_27 %%%%%%%%%%%%%%%%%%%
node(node51_27).
functor(node51_27, pred).         const(pred).
gram_sempos(node51_27, v).         const(v).
id(node51_27, t_plzensky70827_txt_001_p1s1a15).         const(t_plzensky70827_txt_001_p1s1a15).
t_lemma(node51_27, skoncit).         const(skoncit).
%%%%%%%% node51_28 %%%%%%%%%%%%%%%%%%%
node(node51_28).
functor(node51_28, act).         const(act).
gram_sempos(node51_28, n_denot).         const(n_denot).
id(node51_28, t_plzensky70827_txt_001_p1s1a16).         const(t_plzensky70827_txt_001_p1s1a16).
t_lemma(node51_28, vozidlo).         const(vozidlo).
%%%%%%%% node51_29 %%%%%%%%%%%%%%%%%%%
node(node51_29).
functor(node51_29, rstr).         const(rstr).
gram_sempos(node51_29, adj_quant_def).         const(adj_quant_def).
id(node51_29, t_plzensky70827_txt_001_p1s1a17).         const(t_plzensky70827_txt_001_p1s1a17).
t_lemma(node51_29, tri).         const(tri).
%%%%%%%% node51_30 %%%%%%%%%%%%%%%%%%%
node(node51_30).
a_afun(node51_30, atr).         const(atr).
m_form(node51_30, treti).         const(treti).
m_lemma(node51_30, treti).         const(treti).
m_tag(node51_30, crns1__________).         const(crns1__________).
m_tag0(node51_30,'c'). const('c'). m_tag1(node51_30,'r'). const('r'). m_tag2(node51_30,'n'). const('n'). m_tag3(node51_30,'s'). const('s'). m_tag4(node51_30,'1'). const('1'). 
%%%%%%%% node51_31 %%%%%%%%%%%%%%%%%%%
node(node51_31).
a_afun(node51_31, sb).         const(sb).
m_form(node51_31, vozidlo).         const(vozidlo).
m_lemma(node51_31, vozidlo).         const(vozidlo).
m_tag(node51_31, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node51_31,'n'). const('n'). m_tag1(node51_31,'n'). const('n'). m_tag2(node51_31,'n'). const('n'). m_tag3(node51_31,'s'). const('s'). m_tag4(node51_31,'1'). const('1'). m_tag10(node51_31,'a'). const('a'). 
%%%%%%%% node51_32 %%%%%%%%%%%%%%%%%%%
node(node51_32).
a_afun(node51_32, pred).         const(pred).
m_form(node51_32, skoncilo).         const(skoncilo).
m_lemma(node51_32, skoncit__w).         const(skoncit__w).
m_tag(node51_32, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node51_32,'v'). const('v'). m_tag1(node51_32,'p'). const('p'). m_tag2(node51_32,'n'). const('n'). m_tag3(node51_32,'s'). const('s'). m_tag7(node51_32,'x'). const('x'). m_tag8(node51_32,'r'). const('r'). m_tag10(node51_32,'a'). const('a'). m_tag11(node51_32,'a'). const('a'). 
%%%%%%%% node51_33 %%%%%%%%%%%%%%%%%%%
node(node51_33).
functor(node51_33, loc).         const(loc).
gram_sempos(node51_33, n_denot).         const(n_denot).
id(node51_33, t_plzensky70827_txt_001_p1s1a19).         const(t_plzensky70827_txt_001_p1s1a19).
t_lemma(node51_33, kolo).         const(kolo).
%%%%%%%% node51_34 %%%%%%%%%%%%%%%%%%%
node(node51_34).
a_afun(node51_34, auxp).         const(auxp).
m_form(node51_34, na).         const(na).
m_lemma(node51_34, na_1).         const(na_1).
m_tag(node51_34, rr__6__________).         const(rr__6__________).
m_tag0(node51_34,'r'). const('r'). m_tag1(node51_34,'r'). const('r'). m_tag4(node51_34,'6'). const('6'). 
%%%%%%%% node51_35 %%%%%%%%%%%%%%%%%%%
node(node51_35).
a_afun(node51_35, adv).         const(adv).
m_form(node51_35, kolech).         const(kolech).
m_lemma(node51_35, kolo).         const(kolo).
m_tag(node51_35, nnnp6_____a____).         const(nnnp6_____a____).
m_tag0(node51_35,'n'). const('n'). m_tag1(node51_35,'n'). const('n'). m_tag2(node51_35,'n'). const('n'). m_tag3(node51_35,'p'). const('p'). m_tag4(node51_35,'6'). const('6'). m_tag10(node51_35,'a'). const('a'). 
%%%%%%%% node51_36 %%%%%%%%%%%%%%%%%%%
node(node51_36).
functor(node51_36, loc).         const(loc).
gram_sempos(node51_36, n_denot).         const(n_denot).
id(node51_36, t_plzensky70827_txt_001_p1s1a21).         const(t_plzensky70827_txt_001_p1s1a21).
t_lemma(node51_36, prikop).         const(prikop).
%%%%%%%% node51_37 %%%%%%%%%%%%%%%%%%%
node(node51_37).
a_afun(node51_37, auxp).         const(auxp).
m_form(node51_37, v).         const(v).
m_lemma(node51_37, v_1).         const(v_1).
m_tag(node51_37, rr__6__________).         const(rr__6__________).
m_tag0(node51_37,'r'). const('r'). m_tag1(node51_37,'r'). const('r'). m_tag4(node51_37,'6'). const('6'). 
%%%%%%%% node51_38 %%%%%%%%%%%%%%%%%%%
node(node51_38).
a_afun(node51_38, adv).         const(adv).
m_form(node51_38, prikopu).         const(prikopu).
m_lemma(node51_38, prikop).         const(prikop).
m_tag(node51_38, nnis6_____a___1).         const(nnis6_____a___1).
m_tag0(node51_38,'n'). const('n'). m_tag1(node51_38,'n'). const('n'). m_tag2(node51_38,'i'). const('i'). m_tag3(node51_38,'s'). const('s'). m_tag4(node51_38,'6'). const('6'). m_tag10(node51_38,'a'). const('a'). m_tag14(node51_38,'1'). const('1'). 
edge(node51_0, node51_1).
edge(node51_1, node51_2).
edge(node51_2, node51_3).
edge(node51_3, node51_4).
edge(node51_4, node51_5).
edge(node51_5, node51_6).
edge(node51_4, node51_7).
edge(node51_4, node51_8).
edge(node51_8, node51_9).
edge(node51_3, node51_10).
edge(node51_10, node51_11).
edge(node51_3, node51_12).
edge(node51_3, node51_13).
edge(node51_13, node51_14).
edge(node51_14, node51_15).
edge(node51_13, node51_16).
edge(node51_13, node51_17).
edge(node51_17, node51_18).
edge(node51_18, node51_19).
edge(node51_17, node51_20).
edge(node51_17, node51_21).
edge(node51_2, node51_22).
edge(node51_2, node51_23).
edge(node51_23, node51_24).
edge(node51_23, node51_25).
edge(node51_1, node51_26).
edge(node51_1, node51_27).
edge(node51_27, node51_28).
edge(node51_28, node51_29).
edge(node51_29, node51_30).
edge(node51_28, node51_31).
edge(node51_27, node51_32).
edge(node51_27, node51_33).
edge(node51_33, node51_34).
edge(node51_33, node51_35).
edge(node51_27, node51_36).
edge(node51_36, node51_37).
edge(node51_36, node51_38).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z osobnich automobilu na vozovce po narazu unikly provozni kapaliny, ktere hasici zlikvidovali pomoci sorbentu. 
tree_root(node52_0).
:- %%%%%%%% node52_0 %%%%%%%%%%%%%%%%%%%
node(node52_0).
id(node52_0, t_plzensky70827_txt_001_p1s2).         const(t_plzensky70827_txt_001_p1s2).
%%%%%%%% node52_1 %%%%%%%%%%%%%%%%%%%
node(node52_1).
functor(node52_1, pred).         const(pred).
gram_sempos(node52_1, v).         const(v).
id(node52_1, t_plzensky70827_txt_001_p1s2a1).         const(t_plzensky70827_txt_001_p1s2a1).
t_lemma(node52_1, uniknout).         const(uniknout).
%%%%%%%% node52_2 %%%%%%%%%%%%%%%%%%%
node(node52_2).
functor(node52_2, dir1).         const(dir1).
gram_sempos(node52_2, n_denot).         const(n_denot).
id(node52_2, t_plzensky70827_txt_001_p1s2a3).         const(t_plzensky70827_txt_001_p1s2a3).
t_lemma(node52_2, automobil).         const(automobil).
%%%%%%%% node52_3 %%%%%%%%%%%%%%%%%%%
node(node52_3).
functor(node52_3, rstr).         const(rstr).
gram_sempos(node52_3, adj_denot).         const(adj_denot).
id(node52_3, t_plzensky70827_txt_001_p1s2a4).         const(t_plzensky70827_txt_001_p1s2a4).
t_lemma(node52_3, osobni).         const(osobni).
%%%%%%%% node52_4 %%%%%%%%%%%%%%%%%%%
node(node52_4).
a_afun(node52_4, atr).         const(atr).
m_form(node52_4, osobnich).         const(osobnich).
m_lemma(node52_4, osobni).         const(osobni).
m_tag(node52_4, aaip2____1a____).         const(aaip2____1a____).
m_tag0(node52_4,'a'). const('a'). m_tag1(node52_4,'a'). const('a'). m_tag2(node52_4,'i'). const('i'). m_tag3(node52_4,'p'). const('p'). m_tag4(node52_4,'2'). const('2'). m_tag9(node52_4,'1'). const('1'). m_tag10(node52_4,'a'). const('a'). 
%%%%%%%% node52_5 %%%%%%%%%%%%%%%%%%%
node(node52_5).
a_afun(node52_5, auxp).         const(auxp).
m_form(node52_5, z).         const(z).
m_lemma(node52_5, z_1).         const(z_1).
m_tag(node52_5, rr__2__________).         const(rr__2__________).
m_tag0(node52_5,'r'). const('r'). m_tag1(node52_5,'r'). const('r'). m_tag4(node52_5,'2'). const('2'). 
%%%%%%%% node52_6 %%%%%%%%%%%%%%%%%%%
node(node52_6).
a_afun(node52_6, adv).         const(adv).
m_form(node52_6, automobilu).         const(automobilu).
m_lemma(node52_6, automobil).         const(automobil).
m_tag(node52_6, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node52_6,'n'). const('n'). m_tag1(node52_6,'n'). const('n'). m_tag2(node52_6,'i'). const('i'). m_tag3(node52_6,'p'). const('p'). m_tag4(node52_6,'2'). const('2'). m_tag10(node52_6,'a'). const('a'). 
%%%%%%%% node52_7 %%%%%%%%%%%%%%%%%%%
node(node52_7).
functor(node52_7, loc).         const(loc).
gram_sempos(node52_7, n_denot).         const(n_denot).
id(node52_7, t_plzensky70827_txt_001_p1s2a6).         const(t_plzensky70827_txt_001_p1s2a6).
t_lemma(node52_7, vozovka).         const(vozovka).
%%%%%%%% node52_8 %%%%%%%%%%%%%%%%%%%
node(node52_8).
a_afun(node52_8, auxp).         const(auxp).
m_form(node52_8, na).         const(na).
m_lemma(node52_8, na_1).         const(na_1).
m_tag(node52_8, rr__6__________).         const(rr__6__________).
m_tag0(node52_8,'r'). const('r'). m_tag1(node52_8,'r'). const('r'). m_tag4(node52_8,'6'). const('6'). 
%%%%%%%% node52_9 %%%%%%%%%%%%%%%%%%%
node(node52_9).
a_afun(node52_9, atr).         const(atr).
m_form(node52_9, vozovce).         const(vozovce).
m_lemma(node52_9, vozovka).         const(vozovka).
m_tag(node52_9, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node52_9,'n'). const('n'). m_tag1(node52_9,'n'). const('n'). m_tag2(node52_9,'f'). const('f'). m_tag3(node52_9,'s'). const('s'). m_tag4(node52_9,'6'). const('6'). m_tag10(node52_9,'a'). const('a'). 
%%%%%%%% node52_10 %%%%%%%%%%%%%%%%%%%
node(node52_10).
functor(node52_10, twhen).         const(twhen).
gram_sempos(node52_10, n_denot).         const(n_denot).
id(node52_10, t_plzensky70827_txt_001_p1s2a8).         const(t_plzensky70827_txt_001_p1s2a8).
t_lemma(node52_10, naraz).         const(naraz).
%%%%%%%% node52_11 %%%%%%%%%%%%%%%%%%%
node(node52_11).
a_afun(node52_11, auxp).         const(auxp).
m_form(node52_11, po).         const(po).
m_lemma(node52_11, po_1).         const(po_1).
m_tag(node52_11, rr__6__________).         const(rr__6__________).
m_tag0(node52_11,'r'). const('r'). m_tag1(node52_11,'r'). const('r'). m_tag4(node52_11,'6'). const('6'). 
%%%%%%%% node52_12 %%%%%%%%%%%%%%%%%%%
node(node52_12).
a_afun(node52_12, adv).         const(adv).
m_form(node52_12, narazu).         const(narazu).
m_lemma(node52_12, naraz).         const(naraz).
m_tag(node52_12, nnis6_____a___1).         const(nnis6_____a___1).
m_tag0(node52_12,'n'). const('n'). m_tag1(node52_12,'n'). const('n'). m_tag2(node52_12,'i'). const('i'). m_tag3(node52_12,'s'). const('s'). m_tag4(node52_12,'6'). const('6'). m_tag10(node52_12,'a'). const('a'). m_tag14(node52_12,'1'). const('1'). 
%%%%%%%% node52_13 %%%%%%%%%%%%%%%%%%%
node(node52_13).
a_afun(node52_13, pred).         const(pred).
m_form(node52_13, unikly).         const(unikly).
m_lemma(node52_13, uniknout__w).         const(uniknout__w).
m_tag(node52_13, vptp___xr_aa__1).         const(vptp___xr_aa__1).
m_tag0(node52_13,'v'). const('v'). m_tag1(node52_13,'p'). const('p'). m_tag2(node52_13,'t'). const('t'). m_tag3(node52_13,'p'). const('p'). m_tag7(node52_13,'x'). const('x'). m_tag8(node52_13,'r'). const('r'). m_tag10(node52_13,'a'). const('a'). m_tag11(node52_13,'a'). const('a'). m_tag14(node52_13,'1'). const('1'). 
%%%%%%%% node52_14 %%%%%%%%%%%%%%%%%%%
node(node52_14).
functor(node52_14, act).         const(act).
gram_sempos(node52_14, n_denot).         const(n_denot).
id(node52_14, t_plzensky70827_txt_001_p1s2a9).         const(t_plzensky70827_txt_001_p1s2a9).
t_lemma(node52_14, kapalina).         const(kapalina).
%%%%%%%% node52_15 %%%%%%%%%%%%%%%%%%%
node(node52_15).
functor(node52_15, rstr).         const(rstr).
gram_sempos(node52_15, adj_denot).         const(adj_denot).
id(node52_15, t_plzensky70827_txt_001_p1s2a10).         const(t_plzensky70827_txt_001_p1s2a10).
t_lemma(node52_15, provozni).         const(provozni).
%%%%%%%% node52_16 %%%%%%%%%%%%%%%%%%%
node(node52_16).
a_afun(node52_16, atr).         const(atr).
m_form(node52_16, provozni).         const(provozni).
m_lemma(node52_16, provozni).         const(provozni).
m_tag(node52_16, aafp1____1a____).         const(aafp1____1a____).
m_tag0(node52_16,'a'). const('a'). m_tag1(node52_16,'a'). const('a'). m_tag2(node52_16,'f'). const('f'). m_tag3(node52_16,'p'). const('p'). m_tag4(node52_16,'1'). const('1'). m_tag9(node52_16,'1'). const('1'). m_tag10(node52_16,'a'). const('a'). 
%%%%%%%% node52_17 %%%%%%%%%%%%%%%%%%%
node(node52_17).
a_afun(node52_17, sb).         const(sb).
m_form(node52_17, kapaliny).         const(kapaliny).
m_lemma(node52_17, kapalina).         const(kapalina).
m_tag(node52_17, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node52_17,'n'). const('n'). m_tag1(node52_17,'n'). const('n'). m_tag2(node52_17,'f'). const('f'). m_tag3(node52_17,'p'). const('p'). m_tag4(node52_17,'1'). const('1'). m_tag10(node52_17,'a'). const('a'). 
%%%%%%%% node52_18 %%%%%%%%%%%%%%%%%%%
node(node52_18).
functor(node52_18, rstr).         const(rstr).
gram_sempos(node52_18, v).         const(v).
id(node52_18, t_plzensky70827_txt_001_p1s2a11).         const(t_plzensky70827_txt_001_p1s2a11).
t_lemma(node52_18, zlikvidovat).         const(zlikvidovat).
%%%%%%%% node52_19 %%%%%%%%%%%%%%%%%%%
node(node52_19).
functor(node52_19, pat).         const(pat).
gram_sempos(node52_19, n_pron_indef).         const(n_pron_indef).
id(node52_19, t_plzensky70827_txt_001_p1s2a13).         const(t_plzensky70827_txt_001_p1s2a13).
t_lemma(node52_19, ktery).         const(ktery).
%%%%%%%% node52_20 %%%%%%%%%%%%%%%%%%%
node(node52_20).
a_afun(node52_20, obj).         const(obj).
m_form(node52_20, ktere).         const(ktere).
m_lemma(node52_20, ktery).         const(ktery).
m_tag(node52_20, p4fp4__________).         const(p4fp4__________).
m_tag0(node52_20,'p'). const('p'). m_tag1(node52_20,'4'). const('4'). m_tag2(node52_20,'f'). const('f'). m_tag3(node52_20,'p'). const('p'). m_tag4(node52_20,'4'). const('4'). 
%%%%%%%% node52_21 %%%%%%%%%%%%%%%%%%%
node(node52_21).
functor(node52_21, act).         const(act).
gram_sempos(node52_21, n_denot).         const(n_denot).
id(node52_21, t_plzensky70827_txt_001_p1s2a14).         const(t_plzensky70827_txt_001_p1s2a14).
t_lemma(node52_21, hasic).         const(hasic).
%%%%%%%% node52_22 %%%%%%%%%%%%%%%%%%%
node(node52_22).
a_afun(node52_22, sb).         const(sb).
m_form(node52_22, hasici).         const(hasici).
m_lemma(node52_22, hasic).         const(hasic).
m_tag(node52_22, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node52_22,'n'). const('n'). m_tag1(node52_22,'n'). const('n'). m_tag2(node52_22,'m'). const('m'). m_tag3(node52_22,'p'). const('p'). m_tag4(node52_22,'1'). const('1'). m_tag10(node52_22,'a'). const('a'). 
%%%%%%%% node52_23 %%%%%%%%%%%%%%%%%%%
node(node52_23).
a_afun(node52_23, atr).         const(atr).
m_form(node52_23, zlikvidovali).         const(zlikvidovali).
m_lemma(node52_23, zlikvidovat__w).         const(zlikvidovat__w).
m_tag(node52_23, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node52_23,'v'). const('v'). m_tag1(node52_23,'p'). const('p'). m_tag2(node52_23,'m'). const('m'). m_tag3(node52_23,'p'). const('p'). m_tag7(node52_23,'x'). const('x'). m_tag8(node52_23,'r'). const('r'). m_tag10(node52_23,'a'). const('a'). m_tag11(node52_23,'a'). const('a'). 
%%%%%%%% node52_24 %%%%%%%%%%%%%%%%%%%
node(node52_24).
functor(node52_24, means).         const(means).
gram_sempos(node52_24, n_denot).         const(n_denot).
id(node52_24, t_plzensky70827_txt_001_p1s2a16).         const(t_plzensky70827_txt_001_p1s2a16).
t_lemma(node52_24, sorbent).         const(sorbent).
%%%%%%%% node52_25 %%%%%%%%%%%%%%%%%%%
node(node52_25).
a_afun(node52_25, auxp).         const(auxp).
m_form(node52_25, pomoci).         const(pomoci).
m_lemma(node52_25, pomoci).         const(pomoci).
m_tag(node52_25, rr__2__________).         const(rr__2__________).
m_tag0(node52_25,'r'). const('r'). m_tag1(node52_25,'r'). const('r'). m_tag4(node52_25,'2'). const('2'). 
%%%%%%%% node52_26 %%%%%%%%%%%%%%%%%%%
node(node52_26).
a_afun(node52_26, adv).         const(adv).
m_form(node52_26, sorbentu).         const(sorbentu).
m_lemma(node52_26, sorbent).         const(sorbent).
m_tag(node52_26, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node52_26,'n'). const('n'). m_tag1(node52_26,'n'). const('n'). m_tag2(node52_26,'i'). const('i'). m_tag3(node52_26,'s'). const('s'). m_tag4(node52_26,'2'). const('2'). m_tag10(node52_26,'a'). const('a'). 
edge(node52_0, node52_1).
edge(node52_1, node52_2).
edge(node52_2, node52_3).
edge(node52_3, node52_4).
edge(node52_2, node52_5).
edge(node52_2, node52_6).
edge(node52_2, node52_7).
edge(node52_7, node52_8).
edge(node52_7, node52_9).
edge(node52_1, node52_10).
edge(node52_10, node52_11).
edge(node52_10, node52_12).
edge(node52_1, node52_13).
edge(node52_1, node52_14).
edge(node52_14, node52_15).
edge(node52_15, node52_16).
edge(node52_14, node52_17).
edge(node52_14, node52_18).
edge(node52_18, node52_19).
edge(node52_19, node52_20).
edge(node52_18, node52_21).
edge(node52_21, node52_22).
edge(node52_18, node52_23).
edge(node52_18, node52_24).
edge(node52_24, node52_25).
edge(node52_24, node52_26).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v dobe prijezdu hasicu byla zranena zena ze skodovky v peci zzs. 
tree_root(node53_0).
:- %%%%%%%% node53_0 %%%%%%%%%%%%%%%%%%%
node(node53_0).
id(node53_0, t_plzensky70827_txt_001_p1s4).         const(t_plzensky70827_txt_001_p1s4).
%%%%%%%% node53_1 %%%%%%%%%%%%%%%%%%%
node(node53_1).
functor(node53_1, pred).         const(pred).
gram_sempos(node53_1, v).         const(v).
id(node53_1, t_plzensky70827_txt_001_p1s4a1).         const(t_plzensky70827_txt_001_p1s4a1).
t_lemma(node53_1, byt).         const(byt).
%%%%%%%% node53_2 %%%%%%%%%%%%%%%%%%%
node(node53_2).
functor(node53_2, twhen).         const(twhen).
gram_sempos(node53_2, n_denot).         const(n_denot).
id(node53_2, t_plzensky70827_txt_001_p1s4a4).         const(t_plzensky70827_txt_001_p1s4a4).
t_lemma(node53_2, prijezd).         const(prijezd).
%%%%%%%% node53_3 %%%%%%%%%%%%%%%%%%%
node(node53_3).
a_afun(node53_3, auxp).         const(auxp).
m_form(node53_3, v).         const(v).
m_lemma(node53_3, v_1).         const(v_1).
m_tag(node53_3, rr__6__________).         const(rr__6__________).
m_tag0(node53_3,'r'). const('r'). m_tag1(node53_3,'r'). const('r'). m_tag4(node53_3,'6'). const('6'). 
%%%%%%%% node53_4 %%%%%%%%%%%%%%%%%%%
node(node53_4).
a_afun(node53_4, adv).         const(adv).
m_form(node53_4, dobe).         const(dobe).
m_lemma(node53_4, doba).         const(doba).
m_tag(node53_4, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node53_4,'n'). const('n'). m_tag1(node53_4,'n'). const('n'). m_tag2(node53_4,'f'). const('f'). m_tag3(node53_4,'s'). const('s'). m_tag4(node53_4,'6'). const('6'). m_tag10(node53_4,'a'). const('a'). 
%%%%%%%% node53_5 %%%%%%%%%%%%%%%%%%%
node(node53_5).
a_afun(node53_5, atr).         const(atr).
m_form(node53_5, prijezdu).         const(prijezdu).
m_lemma(node53_5, prijezd).         const(prijezd).
m_tag(node53_5, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node53_5,'n'). const('n'). m_tag1(node53_5,'n'). const('n'). m_tag2(node53_5,'i'). const('i'). m_tag3(node53_5,'s'). const('s'). m_tag4(node53_5,'2'). const('2'). m_tag10(node53_5,'a'). const('a'). 
%%%%%%%% node53_6 %%%%%%%%%%%%%%%%%%%
node(node53_6).
functor(node53_6, act).         const(act).
gram_sempos(node53_6, n_denot).         const(n_denot).
id(node53_6, t_plzensky70827_txt_001_p1s4a5).         const(t_plzensky70827_txt_001_p1s4a5).
t_lemma(node53_6, hasic).         const(hasic).
%%%%%%%% node53_7 %%%%%%%%%%%%%%%%%%%
node(node53_7).
a_afun(node53_7, atr).         const(atr).
m_form(node53_7, hasicu).         const(hasicu).
m_lemma(node53_7, hasic).         const(hasic).
m_tag(node53_7, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node53_7,'n'). const('n'). m_tag1(node53_7,'n'). const('n'). m_tag2(node53_7,'m'). const('m'). m_tag3(node53_7,'p'). const('p'). m_tag4(node53_7,'2'). const('2'). m_tag10(node53_7,'a'). const('a'). 
%%%%%%%% node53_8 %%%%%%%%%%%%%%%%%%%
node(node53_8).
a_afun(node53_8, pred).         const(pred).
m_form(node53_8, byla).         const(byla).
m_lemma(node53_8, byt).         const(byt).
m_tag(node53_8, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node53_8,'v'). const('v'). m_tag1(node53_8,'p'). const('p'). m_tag2(node53_8,'q'). const('q'). m_tag3(node53_8,'w'). const('w'). m_tag7(node53_8,'x'). const('x'). m_tag8(node53_8,'r'). const('r'). m_tag10(node53_8,'a'). const('a'). m_tag11(node53_8,'a'). const('a'). 
%%%%%%%% node53_9 %%%%%%%%%%%%%%%%%%%
node(node53_9).
functor(node53_9, act).         const(act).
gram_sempos(node53_9, n_denot).         const(n_denot).
id(node53_9, t_plzensky70827_txt_001_p1s4a6).         const(t_plzensky70827_txt_001_p1s4a6).
t_lemma(node53_9, zena).         const(zena).
%%%%%%%% node53_10 %%%%%%%%%%%%%%%%%%%
node(node53_10).
functor(node53_10, rstr).         const(rstr).
gram_sempos(node53_10, adj_denot).         const(adj_denot).
id(node53_10, t_plzensky70827_txt_001_p1s4a7).         const(t_plzensky70827_txt_001_p1s4a7).
t_lemma(node53_10, zraneny).         const(zraneny).
%%%%%%%% node53_11 %%%%%%%%%%%%%%%%%%%
node(node53_11).
a_afun(node53_11, atr).         const(atr).
m_form(node53_11, zranena).         const(zranena).
m_lemma(node53_11, zraneny____3it_).         const(zraneny____3it_).
m_tag(node53_11, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node53_11,'a'). const('a'). m_tag1(node53_11,'a'). const('a'). m_tag2(node53_11,'f'). const('f'). m_tag3(node53_11,'s'). const('s'). m_tag4(node53_11,'1'). const('1'). m_tag9(node53_11,'1'). const('1'). m_tag10(node53_11,'a'). const('a'). 
%%%%%%%% node53_12 %%%%%%%%%%%%%%%%%%%
node(node53_12).
a_afun(node53_12, sb).         const(sb).
m_form(node53_12, zena).         const(zena).
m_lemma(node53_12, zena).         const(zena).
m_tag(node53_12, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node53_12,'n'). const('n'). m_tag1(node53_12,'n'). const('n'). m_tag2(node53_12,'f'). const('f'). m_tag3(node53_12,'s'). const('s'). m_tag4(node53_12,'1'). const('1'). m_tag10(node53_12,'a'). const('a'). 
%%%%%%%% node53_13 %%%%%%%%%%%%%%%%%%%
node(node53_13).
functor(node53_13, dir1).         const(dir1).
gram_sempos(node53_13, n_denot).         const(n_denot).
id(node53_13, t_plzensky70827_txt_001_p1s4a9).         const(t_plzensky70827_txt_001_p1s4a9).
t_lemma(node53_13, skodovka).         const(skodovka).
%%%%%%%% node53_14 %%%%%%%%%%%%%%%%%%%
node(node53_14).
a_afun(node53_14, auxp).         const(auxp).
m_form(node53_14, ze).         const(ze).
m_lemma(node53_14, z_1).         const(z_1).
m_tag(node53_14, rv__2__________).         const(rv__2__________).
m_tag0(node53_14,'r'). const('r'). m_tag1(node53_14,'v'). const('v'). m_tag4(node53_14,'2'). const('2'). 
%%%%%%%% node53_15 %%%%%%%%%%%%%%%%%%%
node(node53_15).
a_afun(node53_15, atr).         const(atr).
m_form(node53_15, skodovky).         const(skodovky).
m_lemma(node53_15, skodovka).         const(skodovka).
m_tag(node53_15, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node53_15,'n'). const('n'). m_tag1(node53_15,'n'). const('n'). m_tag2(node53_15,'f'). const('f'). m_tag3(node53_15,'s'). const('s'). m_tag4(node53_15,'2'). const('2'). m_tag10(node53_15,'a'). const('a'). 
%%%%%%%% node53_16 %%%%%%%%%%%%%%%%%%%
node(node53_16).
functor(node53_16, loc).         const(loc).
gram_sempos(node53_16, n_denot).         const(n_denot).
id(node53_16, t_plzensky70827_txt_001_p1s4a11).         const(t_plzensky70827_txt_001_p1s4a11).
t_lemma(node53_16, pece).         const(pece).
%%%%%%%% node53_17 %%%%%%%%%%%%%%%%%%%
node(node53_17).
a_afun(node53_17, auxp).         const(auxp).
m_form(node53_17, v).         const(v).
m_lemma(node53_17, v_1).         const(v_1).
m_tag(node53_17, rr__6__________).         const(rr__6__________).
m_tag0(node53_17,'r'). const('r'). m_tag1(node53_17,'r'). const('r'). m_tag4(node53_17,'6'). const('6'). 
%%%%%%%% node53_18 %%%%%%%%%%%%%%%%%%%
node(node53_18).
a_afun(node53_18, adv).         const(adv).
m_form(node53_18, peci).         const(peci).
m_lemma(node53_18, pece).         const(pece).
m_tag(node53_18, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node53_18,'n'). const('n'). m_tag1(node53_18,'n'). const('n'). m_tag2(node53_18,'f'). const('f'). m_tag3(node53_18,'s'). const('s'). m_tag4(node53_18,'6'). const('6'). m_tag10(node53_18,'a'). const('a'). 
%%%%%%%% node53_19 %%%%%%%%%%%%%%%%%%%
node(node53_19).
functor(node53_19, act).         const(act).
gram_sempos(node53_19, n_denot).         const(n_denot).
id(node53_19, t_plzensky70827_txt_001_p1s4a12).         const(t_plzensky70827_txt_001_p1s4a12).
t_lemma(node53_19, zzs).         const(zzs).
%%%%%%%% node53_20 %%%%%%%%%%%%%%%%%%%
node(node53_20).
a_afun(node53_20, atr).         const(atr).
m_form(node53_20, zzs).         const(zzs).
m_lemma(node53_20, zzs).         const(zzs).
m_tag(node53_20, nnfsx_____a____).         const(nnfsx_____a____).
m_tag0(node53_20,'n'). const('n'). m_tag1(node53_20,'n'). const('n'). m_tag2(node53_20,'f'). const('f'). m_tag3(node53_20,'s'). const('s'). m_tag4(node53_20,'x'). const('x'). m_tag10(node53_20,'a'). const('a'). 
edge(node53_0, node53_1).
edge(node53_1, node53_2).
edge(node53_2, node53_3).
edge(node53_2, node53_4).
edge(node53_2, node53_5).
edge(node53_2, node53_6).
edge(node53_6, node53_7).
edge(node53_1, node53_8).
edge(node53_1, node53_9).
edge(node53_9, node53_10).
edge(node53_10, node53_11).
edge(node53_9, node53_12).
edge(node53_9, node53_13).
edge(node53_13, node53_14).
edge(node53_13, node53_15).
edge(node53_1, node53_16).
edge(node53_16, node53_17).
edge(node53_16, node53_18).
edge(node53_16, node53_19).
edge(node53_19, node53_20).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zraneneho muze z vozidla vw golf museli hasici vyprostovat, jelikoz nesly otevrit dvere. 
tree_root(node54_0).
:- %%%%%%%% node54_0 %%%%%%%%%%%%%%%%%%%
node(node54_0).
id(node54_0, t_plzensky70827_txt_001_p1s5).         const(t_plzensky70827_txt_001_p1s5).
%%%%%%%% node54_1 %%%%%%%%%%%%%%%%%%%
node(node54_1).
functor(node54_1, pred).         const(pred).
gram_sempos(node54_1, v).         const(v).
id(node54_1, t_plzensky70827_txt_001_p1s5a9).         const(t_plzensky70827_txt_001_p1s5a9).
t_lemma(node54_1, vyprostovat).         const(vyprostovat).
%%%%%%%% node54_2 %%%%%%%%%%%%%%%%%%%
node(node54_2).
functor(node54_2, twhen).         const(twhen).
gram_sempos(node54_2, n_denot).         const(n_denot).
id(node54_2, t_plzensky70827_txt_001_p1s5a2).         const(t_plzensky70827_txt_001_p1s5a2).
t_lemma(node54_2, muz).         const(muz).
%%%%%%%% node54_3 %%%%%%%%%%%%%%%%%%%
node(node54_3).
functor(node54_3, rstr).         const(rstr).
gram_sempos(node54_3, adj_denot).         const(adj_denot).
id(node54_3, t_plzensky70827_txt_001_p1s5a3).         const(t_plzensky70827_txt_001_p1s5a3).
t_lemma(node54_3, zraneny).         const(zraneny).
%%%%%%%% node54_4 %%%%%%%%%%%%%%%%%%%
node(node54_4).
a_afun(node54_4, atr).         const(atr).
m_form(node54_4, zraneneho).         const(zraneneho).
m_lemma(node54_4, zraneny____3it_).         const(zraneny____3it_).
m_tag(node54_4, aams2____1a____).         const(aams2____1a____).
m_tag0(node54_4,'a'). const('a'). m_tag1(node54_4,'a'). const('a'). m_tag2(node54_4,'m'). const('m'). m_tag3(node54_4,'s'). const('s'). m_tag4(node54_4,'2'). const('2'). m_tag9(node54_4,'1'). const('1'). m_tag10(node54_4,'a'). const('a'). 
%%%%%%%% node54_5 %%%%%%%%%%%%%%%%%%%
node(node54_5).
a_afun(node54_5, adv).         const(adv).
m_form(node54_5, muze).         const(muze).
m_lemma(node54_5, muz).         const(muz).
m_tag(node54_5, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node54_5,'n'). const('n'). m_tag1(node54_5,'n'). const('n'). m_tag2(node54_5,'m'). const('m'). m_tag3(node54_5,'s'). const('s'). m_tag4(node54_5,'2'). const('2'). m_tag10(node54_5,'a'). const('a'). 
%%%%%%%% node54_6 %%%%%%%%%%%%%%%%%%%
node(node54_6).
functor(node54_6, dir1).         const(dir1).
gram_sempos(node54_6, n_denot).         const(n_denot).
id(node54_6, t_plzensky70827_txt_001_p1s5a5).         const(t_plzensky70827_txt_001_p1s5a5).
t_lemma(node54_6, vozidlo).         const(vozidlo).
%%%%%%%% node54_7 %%%%%%%%%%%%%%%%%%%
node(node54_7).
a_afun(node54_7, auxp).         const(auxp).
m_form(node54_7, z).         const(z).
m_lemma(node54_7, z_1).         const(z_1).
m_tag(node54_7, rr__2__________).         const(rr__2__________).
m_tag0(node54_7,'r'). const('r'). m_tag1(node54_7,'r'). const('r'). m_tag4(node54_7,'2'). const('2'). 
%%%%%%%% node54_8 %%%%%%%%%%%%%%%%%%%
node(node54_8).
a_afun(node54_8, atr).         const(atr).
m_form(node54_8, vozidla).         const(vozidla).
m_lemma(node54_8, vozidlo).         const(vozidlo).
m_tag(node54_8, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node54_8,'n'). const('n'). m_tag1(node54_8,'n'). const('n'). m_tag2(node54_8,'n'). const('n'). m_tag3(node54_8,'s'). const('s'). m_tag4(node54_8,'2'). const('2'). m_tag10(node54_8,'a'). const('a'). 
%%%%%%%% node54_9 %%%%%%%%%%%%%%%%%%%
node(node54_9).
functor(node54_9, rstr).         const(rstr).
gram_sempos(node54_9, n_denot).         const(n_denot).
id(node54_9, t_plzensky70827_txt_001_p1s5a6).         const(t_plzensky70827_txt_001_p1s5a6).
t_lemma(node54_9, vw).         const(vw).
%%%%%%%% node54_10 %%%%%%%%%%%%%%%%%%%
node(node54_10).
a_afun(node54_10, atr).         const(atr).
m_form(node54_10, vw).         const(vw).
m_lemma(node54_10, vw_1__b__r__t___automobil_znacky_volkswagen_).         const(vw_1__b__r__t___automobil_znacky_volkswagen_).
m_tag(node54_10, nnixx_____a____).         const(nnixx_____a____).
m_tag0(node54_10,'n'). const('n'). m_tag1(node54_10,'n'). const('n'). m_tag2(node54_10,'i'). const('i'). m_tag3(node54_10,'x'). const('x'). m_tag4(node54_10,'x'). const('x'). m_tag10(node54_10,'a'). const('a'). 
%%%%%%%% node54_11 %%%%%%%%%%%%%%%%%%%
node(node54_11).
functor(node54_11, rstr).         const(rstr).
gram_sempos(node54_11, n_denot).         const(n_denot).
id(node54_11, t_plzensky70827_txt_001_p1s5a7).         const(t_plzensky70827_txt_001_p1s5a7).
t_lemma(node54_11, golf).         const(golf).
%%%%%%%% node54_12 %%%%%%%%%%%%%%%%%%%
node(node54_12).
a_afun(node54_12, atr).         const(atr).
m_form(node54_12, golf).         const(golf).
m_lemma(node54_12, golf_2__r___vozidlo_).         const(golf_2__r___vozidlo_).
m_tag(node54_12, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node54_12,'n'). const('n'). m_tag1(node54_12,'n'). const('n'). m_tag2(node54_12,'i'). const('i'). m_tag3(node54_12,'s'). const('s'). m_tag4(node54_12,'4'). const('4'). m_tag10(node54_12,'a'). const('a'). 
%%%%%%%% node54_13 %%%%%%%%%%%%%%%%%%%
node(node54_13).
functor(node54_13, act).         const(act).
gram_sempos(node54_13, n_denot).         const(n_denot).
id(node54_13, t_plzensky70827_txt_001_p1s5a8).         const(t_plzensky70827_txt_001_p1s5a8).
t_lemma(node54_13, hasic).         const(hasic).
%%%%%%%% node54_14 %%%%%%%%%%%%%%%%%%%
node(node54_14).
a_afun(node54_14, sb).         const(sb).
m_form(node54_14, hasici).         const(hasici).
m_lemma(node54_14, hasic).         const(hasic).
m_tag(node54_14, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node54_14,'n'). const('n'). m_tag1(node54_14,'n'). const('n'). m_tag2(node54_14,'m'). const('m'). m_tag3(node54_14,'p'). const('p'). m_tag4(node54_14,'1'). const('1'). m_tag10(node54_14,'a'). const('a'). 
%%%%%%%% node54_15 %%%%%%%%%%%%%%%%%%%
node(node54_15).
a_afun(node54_15, pred).         const(pred).
m_form(node54_15, museli).         const(museli).
m_lemma(node54_15, muset).         const(muset).
m_tag(node54_15, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node54_15,'v'). const('v'). m_tag1(node54_15,'p'). const('p'). m_tag2(node54_15,'m'). const('m'). m_tag3(node54_15,'p'). const('p'). m_tag7(node54_15,'x'). const('x'). m_tag8(node54_15,'r'). const('r'). m_tag10(node54_15,'a'). const('a'). m_tag11(node54_15,'a'). const('a'). 
%%%%%%%% node54_16 %%%%%%%%%%%%%%%%%%%
node(node54_16).
a_afun(node54_16, obj).         const(obj).
m_form(node54_16, vyprostovat).         const(vyprostovat).
m_lemma(node54_16, vyprostovat__t).         const(vyprostovat__t).
m_tag(node54_16, vf________a____).         const(vf________a____).
m_tag0(node54_16,'v'). const('v'). m_tag1(node54_16,'f'). const('f'). m_tag10(node54_16,'a'). const('a'). 
%%%%%%%% node54_17 %%%%%%%%%%%%%%%%%%%
node(node54_17).
functor(node54_17, caus).         const(caus).
gram_sempos(node54_17, v).         const(v).
id(node54_17, t_plzensky70827_txt_001_p1s5a12).         const(t_plzensky70827_txt_001_p1s5a12).
t_lemma(node54_17, jit).         const(jit).
%%%%%%%% node54_18 %%%%%%%%%%%%%%%%%%%
node(node54_18).
functor(node54_18, rhem).         const(rhem).
id(node54_18, t_plzensky70827_txt_001_p1s5a16).         const(t_plzensky70827_txt_001_p1s5a16).
t_lemma(node54_18, x_neg).         const(x_neg).
%%%%%%%% node54_19 %%%%%%%%%%%%%%%%%%%
node(node54_19).
functor(node54_19, act).         const(act).
gram_sempos(node54_19, n_pron_def_pers).         const(n_pron_def_pers).
id(node54_19, t_plzensky70827_txt_001_p1s5a15).         const(t_plzensky70827_txt_001_p1s5a15).
t_lemma(node54_19, x_perspron).         const(x_perspron).
%%%%%%%% node54_20 %%%%%%%%%%%%%%%%%%%
node(node54_20).
a_afun(node54_20, auxc).         const(auxc).
m_form(node54_20, jelikoz).         const(jelikoz).
m_lemma(node54_20, jelikoz).         const(jelikoz).
m_tag(node54_20, j______________).         const(j______________).
m_tag0(node54_20,'j'). const('j'). m_tag1(node54_20,','). const(','). 
%%%%%%%% node54_21 %%%%%%%%%%%%%%%%%%%
node(node54_21).
a_afun(node54_21, adv).         const(adv).
m_form(node54_21, nesly).         const(nesly).
m_lemma(node54_21, jit).         const(jit).
m_tag(node54_21, vptp___xr_na___).         const(vptp___xr_na___).
m_tag0(node54_21,'v'). const('v'). m_tag1(node54_21,'p'). const('p'). m_tag2(node54_21,'t'). const('t'). m_tag3(node54_21,'p'). const('p'). m_tag7(node54_21,'x'). const('x'). m_tag8(node54_21,'r'). const('r'). m_tag10(node54_21,'n'). const('n'). m_tag11(node54_21,'a'). const('a'). 
%%%%%%%% node54_22 %%%%%%%%%%%%%%%%%%%
node(node54_22).
functor(node54_22, intt).         const(intt).
gram_sempos(node54_22, v).         const(v).
id(node54_22, t_plzensky70827_txt_001_p1s5a13).         const(t_plzensky70827_txt_001_p1s5a13).
t_lemma(node54_22, otevrit).         const(otevrit).
%%%%%%%% node54_23 %%%%%%%%%%%%%%%%%%%
node(node54_23).
functor(node54_23, act).         const(act).
id(node54_23, t_plzensky70827_txt_001_p1s5a17).         const(t_plzensky70827_txt_001_p1s5a17).
t_lemma(node54_23, x_cor).         const(x_cor).
%%%%%%%% node54_24 %%%%%%%%%%%%%%%%%%%
node(node54_24).
a_afun(node54_24, adv).         const(adv).
m_form(node54_24, otevrit).         const(otevrit).
m_lemma(node54_24, otevrit).         const(otevrit).
m_tag(node54_24, vf________a____).         const(vf________a____).
m_tag0(node54_24,'v'). const('v'). m_tag1(node54_24,'f'). const('f'). m_tag10(node54_24,'a'). const('a'). 
%%%%%%%% node54_25 %%%%%%%%%%%%%%%%%%%
node(node54_25).
functor(node54_25, pat).         const(pat).
gram_sempos(node54_25, n_denot).         const(n_denot).
id(node54_25, t_plzensky70827_txt_001_p1s5a14).         const(t_plzensky70827_txt_001_p1s5a14).
t_lemma(node54_25, dvere).         const(dvere).
%%%%%%%% node54_26 %%%%%%%%%%%%%%%%%%%
node(node54_26).
a_afun(node54_26, obj).         const(obj).
m_form(node54_26, dvere).         const(dvere).
m_lemma(node54_26, dvere).         const(dvere).
m_tag(node54_26, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node54_26,'n'). const('n'). m_tag1(node54_26,'n'). const('n'). m_tag2(node54_26,'f'). const('f'). m_tag3(node54_26,'p'). const('p'). m_tag4(node54_26,'4'). const('4'). m_tag10(node54_26,'a'). const('a'). 
edge(node54_0, node54_1).
edge(node54_1, node54_2).
edge(node54_2, node54_3).
edge(node54_3, node54_4).
edge(node54_2, node54_5).
edge(node54_2, node54_6).
edge(node54_6, node54_7).
edge(node54_6, node54_8).
edge(node54_6, node54_9).
edge(node54_9, node54_10).
edge(node54_9, node54_11).
edge(node54_11, node54_12).
edge(node54_1, node54_13).
edge(node54_13, node54_14).
edge(node54_1, node54_15).
edge(node54_1, node54_16).
edge(node54_1, node54_17).
edge(node54_17, node54_18).
edge(node54_17, node54_19).
edge(node54_17, node54_20).
edge(node54_17, node54_21).
edge(node54_17, node54_22).
edge(node54_22, node54_23).
edge(node54_22, node54_24).
edge(node54_22, node54_25).
edge(node54_25, node54_26).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% muz utrpel otevrenou zlomeninu nohy a trzne rany. 
tree_root(node55_0).
:- %%%%%%%% node55_0 %%%%%%%%%%%%%%%%%%%
node(node55_0).
id(node55_0, t_plzensky70827_txt_001_p1s6).         const(t_plzensky70827_txt_001_p1s6).
%%%%%%%% node55_1 %%%%%%%%%%%%%%%%%%%
node(node55_1).
functor(node55_1, pred).         const(pred).
gram_sempos(node55_1, v).         const(v).
id(node55_1, t_plzensky70827_txt_001_p1s6a1).         const(t_plzensky70827_txt_001_p1s6a1).
t_lemma(node55_1, utrpet).         const(utrpet).
%%%%%%%% node55_2 %%%%%%%%%%%%%%%%%%%
node(node55_2).
functor(node55_2, pat).         const(pat).
id(node55_2, t_plzensky70827_txt_001_p1s6a9).         const(t_plzensky70827_txt_001_p1s6a9).
t_lemma(node55_2, x_gen).         const(x_gen).
%%%%%%%% node55_3 %%%%%%%%%%%%%%%%%%%
node(node55_3).
functor(node55_3, act).         const(act).
gram_sempos(node55_3, n_denot).         const(n_denot).
id(node55_3, t_plzensky70827_txt_001_p1s6a2).         const(t_plzensky70827_txt_001_p1s6a2).
t_lemma(node55_3, muz).         const(muz).
%%%%%%%% node55_4 %%%%%%%%%%%%%%%%%%%
node(node55_4).
a_afun(node55_4, sb).         const(sb).
m_form(node55_4, muz).         const(muz).
m_lemma(node55_4, muz).         const(muz).
m_tag(node55_4, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node55_4,'n'). const('n'). m_tag1(node55_4,'n'). const('n'). m_tag2(node55_4,'m'). const('m'). m_tag3(node55_4,'s'). const('s'). m_tag4(node55_4,'1'). const('1'). m_tag10(node55_4,'a'). const('a'). 
%%%%%%%% node55_5 %%%%%%%%%%%%%%%%%%%
node(node55_5).
a_afun(node55_5, pred).         const(pred).
m_form(node55_5, utrpel).         const(utrpel).
m_lemma(node55_5, utrpet).         const(utrpet).
m_tag(node55_5, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node55_5,'v'). const('v'). m_tag1(node55_5,'p'). const('p'). m_tag2(node55_5,'y'). const('y'). m_tag3(node55_5,'s'). const('s'). m_tag7(node55_5,'x'). const('x'). m_tag8(node55_5,'r'). const('r'). m_tag10(node55_5,'a'). const('a'). m_tag11(node55_5,'a'). const('a'). 
%%%%%%%% node55_6 %%%%%%%%%%%%%%%%%%%
node(node55_6).
functor(node55_6, conj).         const(conj).
id(node55_6, t_plzensky70827_txt_001_p1s6a3).         const(t_plzensky70827_txt_001_p1s6a3).
t_lemma(node55_6, a).         const(a).
%%%%%%%% node55_7 %%%%%%%%%%%%%%%%%%%
node(node55_7).
functor(node55_7, rstr).         const(rstr).
gram_sempos(node55_7, n_denot).         const(n_denot).
id(node55_7, t_plzensky70827_txt_001_p1s6a4).         const(t_plzensky70827_txt_001_p1s6a4).
t_lemma(node55_7, zlomenina).         const(zlomenina).
%%%%%%%% node55_8 %%%%%%%%%%%%%%%%%%%
node(node55_8).
functor(node55_8, rstr).         const(rstr).
gram_sempos(node55_8, adj_denot).         const(adj_denot).
id(node55_8, t_plzensky70827_txt_001_p1s6a5).         const(t_plzensky70827_txt_001_p1s6a5).
t_lemma(node55_8, otevreny).         const(otevreny).
%%%%%%%% node55_9 %%%%%%%%%%%%%%%%%%%
node(node55_9).
a_afun(node55_9, atr).         const(atr).
m_form(node55_9, otevrenou).         const(otevrenou).
m_lemma(node55_9, otevreny____3it_).         const(otevreny____3it_).
m_tag(node55_9, aafs4____1a____).         const(aafs4____1a____).
m_tag0(node55_9,'a'). const('a'). m_tag1(node55_9,'a'). const('a'). m_tag2(node55_9,'f'). const('f'). m_tag3(node55_9,'s'). const('s'). m_tag4(node55_9,'4'). const('4'). m_tag9(node55_9,'1'). const('1'). m_tag10(node55_9,'a'). const('a'). 
%%%%%%%% node55_10 %%%%%%%%%%%%%%%%%%%
node(node55_10).
a_afun(node55_10, obj).         const(obj).
m_form(node55_10, zlomeninu).         const(zlomeninu).
m_lemma(node55_10, zlomenina).         const(zlomenina).
m_tag(node55_10, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node55_10,'n'). const('n'). m_tag1(node55_10,'n'). const('n'). m_tag2(node55_10,'f'). const('f'). m_tag3(node55_10,'s'). const('s'). m_tag4(node55_10,'4'). const('4'). m_tag10(node55_10,'a'). const('a'). 
%%%%%%%% node55_11 %%%%%%%%%%%%%%%%%%%
node(node55_11).
functor(node55_11, app).         const(app).
gram_sempos(node55_11, n_denot).         const(n_denot).
id(node55_11, t_plzensky70827_txt_001_p1s6a6).         const(t_plzensky70827_txt_001_p1s6a6).
t_lemma(node55_11, noha).         const(noha).
%%%%%%%% node55_12 %%%%%%%%%%%%%%%%%%%
node(node55_12).
a_afun(node55_12, atr).         const(atr).
m_form(node55_12, nohy).         const(nohy).
m_lemma(node55_12, noha).         const(noha).
m_tag(node55_12, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node55_12,'n'). const('n'). m_tag1(node55_12,'n'). const('n'). m_tag2(node55_12,'f'). const('f'). m_tag3(node55_12,'s'). const('s'). m_tag4(node55_12,'2'). const('2'). m_tag10(node55_12,'a'). const('a'). 
%%%%%%%% node55_13 %%%%%%%%%%%%%%%%%%%
node(node55_13).
a_afun(node55_13, coord).         const(coord).
m_form(node55_13, a).         const(a).
m_lemma(node55_13, a_1).         const(a_1).
m_tag(node55_13, j______________).         const(j______________).
m_tag0(node55_13,'j'). const('j'). m_tag1(node55_13,'^'). const('^'). 
%%%%%%%% node55_14 %%%%%%%%%%%%%%%%%%%
node(node55_14).
functor(node55_14, rstr).         const(rstr).
gram_sempos(node55_14, n_denot).         const(n_denot).
id(node55_14, t_plzensky70827_txt_001_p1s6a7).         const(t_plzensky70827_txt_001_p1s6a7).
t_lemma(node55_14, rana).         const(rana).
%%%%%%%% node55_15 %%%%%%%%%%%%%%%%%%%
node(node55_15).
functor(node55_15, rstr).         const(rstr).
gram_sempos(node55_15, adj_denot).         const(adj_denot).
id(node55_15, t_plzensky70827_txt_001_p1s6a8).         const(t_plzensky70827_txt_001_p1s6a8).
t_lemma(node55_15, trzny).         const(trzny).
%%%%%%%% node55_16 %%%%%%%%%%%%%%%%%%%
node(node55_16).
a_afun(node55_16, atr).         const(atr).
m_form(node55_16, trzne).         const(trzne).
m_lemma(node55_16, trzny).         const(trzny).
m_tag(node55_16, aafp4____1a____).         const(aafp4____1a____).
m_tag0(node55_16,'a'). const('a'). m_tag1(node55_16,'a'). const('a'). m_tag2(node55_16,'f'). const('f'). m_tag3(node55_16,'p'). const('p'). m_tag4(node55_16,'4'). const('4'). m_tag9(node55_16,'1'). const('1'). m_tag10(node55_16,'a'). const('a'). 
%%%%%%%% node55_17 %%%%%%%%%%%%%%%%%%%
node(node55_17).
a_afun(node55_17, obj).         const(obj).
m_form(node55_17, rany).         const(rany).
m_lemma(node55_17, rana).         const(rana).
m_tag(node55_17, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node55_17,'n'). const('n'). m_tag1(node55_17,'n'). const('n'). m_tag2(node55_17,'f'). const('f'). m_tag3(node55_17,'p'). const('p'). m_tag4(node55_17,'4'). const('4'). m_tag10(node55_17,'a'). const('a'). 
edge(node55_0, node55_1).
edge(node55_1, node55_2).
edge(node55_1, node55_3).
edge(node55_3, node55_4).
edge(node55_1, node55_5).
edge(node55_1, node55_6).
edge(node55_6, node55_7).
edge(node55_7, node55_8).
edge(node55_8, node55_9).
edge(node55_7, node55_10).
edge(node55_7, node55_11).
edge(node55_11, node55_12).
edge(node55_6, node55_13).
edge(node55_6, node55_14).
edge(node55_14, node55_15).
edge(node55_15, node55_16).
edge(node55_14, node55_17).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% krome sanitek zzs priletel na misto i vrtulnik lzs. 
tree_root(node56_0).
:- %%%%%%%% node56_0 %%%%%%%%%%%%%%%%%%%
node(node56_0).
id(node56_0, t_plzensky70827_txt_001_p1s7).         const(t_plzensky70827_txt_001_p1s7).
%%%%%%%% node56_1 %%%%%%%%%%%%%%%%%%%
node(node56_1).
functor(node56_1, pred).         const(pred).
gram_sempos(node56_1, v).         const(v).
id(node56_1, t_plzensky70827_txt_001_p1s7a1).         const(t_plzensky70827_txt_001_p1s7a1).
t_lemma(node56_1, priletet).         const(priletet).
%%%%%%%% node56_2 %%%%%%%%%%%%%%%%%%%
node(node56_2).
functor(node56_2, dir3).         const(dir3).
id(node56_2, t_plzensky70827_txt_001_p1s7a10).         const(t_plzensky70827_txt_001_p1s7a10).
t_lemma(node56_2, x_oblfm).         const(x_oblfm).
%%%%%%%% node56_3 %%%%%%%%%%%%%%%%%%%
node(node56_3).
functor(node56_3, restr).         const(restr).
gram_sempos(node56_3, n_denot).         const(n_denot).
id(node56_3, t_plzensky70827_txt_001_p1s7a3).         const(t_plzensky70827_txt_001_p1s7a3).
t_lemma(node56_3, sanitka).         const(sanitka).
%%%%%%%% node56_4 %%%%%%%%%%%%%%%%%%%
node(node56_4).
a_afun(node56_4, auxp).         const(auxp).
m_form(node56_4, krome).         const(krome).
m_lemma(node56_4, krome).         const(krome).
m_tag(node56_4, rr__2__________).         const(rr__2__________).
m_tag0(node56_4,'r'). const('r'). m_tag1(node56_4,'r'). const('r'). m_tag4(node56_4,'2'). const('2'). 
%%%%%%%% node56_5 %%%%%%%%%%%%%%%%%%%
node(node56_5).
a_afun(node56_5, adv).         const(adv).
m_form(node56_5, sanitek).         const(sanitek).
m_lemma(node56_5, sanitka).         const(sanitka).
m_tag(node56_5, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node56_5,'n'). const('n'). m_tag1(node56_5,'n'). const('n'). m_tag2(node56_5,'f'). const('f'). m_tag3(node56_5,'p'). const('p'). m_tag4(node56_5,'2'). const('2'). m_tag10(node56_5,'a'). const('a'). 
%%%%%%%% node56_6 %%%%%%%%%%%%%%%%%%%
node(node56_6).
functor(node56_6, app).         const(app).
gram_sempos(node56_6, n_denot).         const(n_denot).
id(node56_6, t_plzensky70827_txt_001_p1s7a4).         const(t_plzensky70827_txt_001_p1s7a4).
t_lemma(node56_6, zzs).         const(zzs).
%%%%%%%% node56_7 %%%%%%%%%%%%%%%%%%%
node(node56_7).
a_afun(node56_7, atr).         const(atr).
m_form(node56_7, zzs).         const(zzs).
m_lemma(node56_7, zzs).         const(zzs).
m_tag(node56_7, nnnxx_____a____).         const(nnnxx_____a____).
m_tag0(node56_7,'n'). const('n'). m_tag1(node56_7,'n'). const('n'). m_tag2(node56_7,'n'). const('n'). m_tag3(node56_7,'x'). const('x'). m_tag4(node56_7,'x'). const('x'). m_tag10(node56_7,'a'). const('a'). 
%%%%%%%% node56_8 %%%%%%%%%%%%%%%%%%%
node(node56_8).
a_afun(node56_8, pred).         const(pred).
m_form(node56_8, priletel).         const(priletel).
m_lemma(node56_8, priletet).         const(priletet).
m_tag(node56_8, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node56_8,'v'). const('v'). m_tag1(node56_8,'p'). const('p'). m_tag2(node56_8,'y'). const('y'). m_tag3(node56_8,'s'). const('s'). m_tag7(node56_8,'x'). const('x'). m_tag8(node56_8,'r'). const('r'). m_tag10(node56_8,'a'). const('a'). m_tag11(node56_8,'a'). const('a'). 
%%%%%%%% node56_9 %%%%%%%%%%%%%%%%%%%
node(node56_9).
functor(node56_9, conj).         const(conj).
id(node56_9, t_plzensky70827_txt_001_p1s7a6).         const(t_plzensky70827_txt_001_p1s7a6).
t_lemma(node56_9, i).         const(i).
%%%%%%%% node56_10 %%%%%%%%%%%%%%%%%%%
node(node56_10).
functor(node56_10, rstr).         const(rstr).
gram_sempos(node56_10, n_denot).         const(n_denot).
id(node56_10, t_plzensky70827_txt_001_p1s7a7).         const(t_plzensky70827_txt_001_p1s7a7).
t_lemma(node56_10, misto).         const(misto).
%%%%%%%% node56_11 %%%%%%%%%%%%%%%%%%%
node(node56_11).
a_afun(node56_11, obj).         const(obj).
m_form(node56_11, misto).         const(misto).
m_lemma(node56_11, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node56_11, nnns4_____a____).         const(nnns4_____a____).
m_tag0(node56_11,'n'). const('n'). m_tag1(node56_11,'n'). const('n'). m_tag2(node56_11,'n'). const('n'). m_tag3(node56_11,'s'). const('s'). m_tag4(node56_11,'4'). const('4'). m_tag10(node56_11,'a'). const('a'). 
%%%%%%%% node56_12 %%%%%%%%%%%%%%%%%%%
node(node56_12).
a_afun(node56_12, coord).         const(coord).
m_form(node56_12, i).         const(i).
m_lemma(node56_12, i_1).         const(i_1).
m_tag(node56_12, j______________).         const(j______________).
m_tag0(node56_12,'j'). const('j'). m_tag1(node56_12,'^'). const('^'). 
%%%%%%%% node56_13 %%%%%%%%%%%%%%%%%%%
node(node56_13).
functor(node56_13, rstr).         const(rstr).
gram_sempos(node56_13, n_denot).         const(n_denot).
id(node56_13, t_plzensky70827_txt_001_p1s7a8).         const(t_plzensky70827_txt_001_p1s7a8).
t_lemma(node56_13, vrtulnik).         const(vrtulnik).
%%%%%%%% node56_14 %%%%%%%%%%%%%%%%%%%
node(node56_14).
a_afun(node56_14, obj).         const(obj).
m_form(node56_14, vrtulnik).         const(vrtulnik).
m_lemma(node56_14, vrtulnik).         const(vrtulnik).
m_tag(node56_14, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node56_14,'n'). const('n'). m_tag1(node56_14,'n'). const('n'). m_tag2(node56_14,'i'). const('i'). m_tag3(node56_14,'s'). const('s'). m_tag4(node56_14,'4'). const('4'). m_tag10(node56_14,'a'). const('a'). 
%%%%%%%% node56_15 %%%%%%%%%%%%%%%%%%%
node(node56_15).
functor(node56_15, act).         const(act).
gram_sempos(node56_15, n_denot).         const(n_denot).
id(node56_15, t_plzensky70827_txt_001_p1s7a9).         const(t_plzensky70827_txt_001_p1s7a9).
t_lemma(node56_15, lzs).         const(lzs).
%%%%%%%% node56_16 %%%%%%%%%%%%%%%%%%%
node(node56_16).
a_afun(node56_16, sb).         const(sb).
m_form(node56_16, lzs).         const(lzs).
m_lemma(node56_16, lzs).         const(lzs).
m_tag(node56_16, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node56_16,'n'). const('n'). m_tag1(node56_16,'n'). const('n'). m_tag2(node56_16,'m'). const('m'). m_tag3(node56_16,'s'). const('s'). m_tag4(node56_16,'1'). const('1'). m_tag10(node56_16,'a'). const('a'). 
edge(node56_0, node56_1).
edge(node56_1, node56_2).
edge(node56_1, node56_3).
edge(node56_3, node56_4).
edge(node56_3, node56_5).
edge(node56_3, node56_6).
edge(node56_6, node56_7).
edge(node56_1, node56_8).
edge(node56_1, node56_9).
edge(node56_9, node56_10).
edge(node56_10, node56_11).
edge(node56_9, node56_12).
edge(node56_9, node56_13).
edge(node56_13, node56_14).
edge(node56_1, node56_15).
edge(node56_15, node56_16).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hasici dale zajistili misto nehody, odpojili u vozidel akumulatory, pripravili pristavaci plochu pro vrtulnik lzs a pomohli s nalozenim zraneneho. 
tree_root(node57_0).
:- %%%%%%%% node57_0 %%%%%%%%%%%%%%%%%%%
node(node57_0).
id(node57_0, t_plzensky70827_txt_001_p1s8).         const(t_plzensky70827_txt_001_p1s8).
%%%%%%%% node57_1 %%%%%%%%%%%%%%%%%%%
node(node57_1).
functor(node57_1, conj).         const(conj).
id(node57_1, t_plzensky70827_txt_001_p1s8a1).         const(t_plzensky70827_txt_001_p1s8a1).
t_lemma(node57_1, x_comma).         const(x_comma).
%%%%%%%% node57_2 %%%%%%%%%%%%%%%%%%%
node(node57_2).
functor(node57_2, pred).         const(pred).
gram_sempos(node57_2, v).         const(v).
id(node57_2, t_plzensky70827_txt_001_p1s8a2).         const(t_plzensky70827_txt_001_p1s8a2).
t_lemma(node57_2, zajistit).         const(zajistit).
%%%%%%%% node57_3 %%%%%%%%%%%%%%%%%%%
node(node57_3).
functor(node57_3, act).         const(act).
gram_sempos(node57_3, n_denot).         const(n_denot).
id(node57_3, t_plzensky70827_txt_001_p1s8a3).         const(t_plzensky70827_txt_001_p1s8a3).
t_lemma(node57_3, hasic).         const(hasic).
%%%%%%%% node57_4 %%%%%%%%%%%%%%%%%%%
node(node57_4).
a_afun(node57_4, sb).         const(sb).
m_form(node57_4, hasici).         const(hasici).
m_lemma(node57_4, hasic).         const(hasic).
m_tag(node57_4, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node57_4,'n'). const('n'). m_tag1(node57_4,'n'). const('n'). m_tag2(node57_4,'m'). const('m'). m_tag3(node57_4,'p'). const('p'). m_tag4(node57_4,'1'). const('1'). m_tag10(node57_4,'a'). const('a'). 
%%%%%%%% node57_5 %%%%%%%%%%%%%%%%%%%
node(node57_5).
functor(node57_5, thl).         const(thl).
gram_sempos(node57_5, adv_denot_grad_neg).         const(adv_denot_grad_neg).
id(node57_5, t_plzensky70827_txt_001_p1s8a4).         const(t_plzensky70827_txt_001_p1s8a4).
t_lemma(node57_5, dale).         const(dale).
%%%%%%%% node57_6 %%%%%%%%%%%%%%%%%%%
node(node57_6).
a_afun(node57_6, adv).         const(adv).
m_form(node57_6, dale).         const(dale).
m_lemma(node57_6, dale_3___take__za_dalsi__poporade__cas__i_mist___nestupnuje_se_).         const(dale_3___take__za_dalsi__poporade__cas__i_mist___nestupnuje_se_).
m_tag(node57_6, db____________1).         const(db____________1).
m_tag0(node57_6,'d'). const('d'). m_tag1(node57_6,'b'). const('b'). m_tag14(node57_6,'1'). const('1'). 
%%%%%%%% node57_7 %%%%%%%%%%%%%%%%%%%
node(node57_7).
a_afun(node57_7, pred).         const(pred).
m_form(node57_7, zajistili).         const(zajistili).
m_lemma(node57_7, zajistit__w).         const(zajistit__w).
m_tag(node57_7, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node57_7,'v'). const('v'). m_tag1(node57_7,'p'). const('p'). m_tag2(node57_7,'m'). const('m'). m_tag3(node57_7,'p'). const('p'). m_tag7(node57_7,'x'). const('x'). m_tag8(node57_7,'r'). const('r'). m_tag10(node57_7,'a'). const('a'). m_tag11(node57_7,'a'). const('a'). 
%%%%%%%% node57_8 %%%%%%%%%%%%%%%%%%%
node(node57_8).
functor(node57_8, pat).         const(pat).
gram_sempos(node57_8, n_denot).         const(n_denot).
id(node57_8, t_plzensky70827_txt_001_p1s8a5).         const(t_plzensky70827_txt_001_p1s8a5).
t_lemma(node57_8, misto).         const(misto).
%%%%%%%% node57_9 %%%%%%%%%%%%%%%%%%%
node(node57_9).
a_afun(node57_9, obj).         const(obj).
m_form(node57_9, misto).         const(misto).
m_lemma(node57_9, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node57_9, nnns4_____a____).         const(nnns4_____a____).
m_tag0(node57_9,'n'). const('n'). m_tag1(node57_9,'n'). const('n'). m_tag2(node57_9,'n'). const('n'). m_tag3(node57_9,'s'). const('s'). m_tag4(node57_9,'4'). const('4'). m_tag10(node57_9,'a'). const('a'). 
%%%%%%%% node57_10 %%%%%%%%%%%%%%%%%%%
node(node57_10).
functor(node57_10, app).         const(app).
gram_sempos(node57_10, n_denot).         const(n_denot).
id(node57_10, t_plzensky70827_txt_001_p1s8a6).         const(t_plzensky70827_txt_001_p1s8a6).
t_lemma(node57_10, nehoda).         const(nehoda).
%%%%%%%% node57_11 %%%%%%%%%%%%%%%%%%%
node(node57_11).
a_afun(node57_11, atr).         const(atr).
m_form(node57_11, nehody).         const(nehody).
m_lemma(node57_11, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node57_11, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node57_11,'n'). const('n'). m_tag1(node57_11,'n'). const('n'). m_tag2(node57_11,'f'). const('f'). m_tag3(node57_11,'s'). const('s'). m_tag4(node57_11,'2'). const('2'). m_tag10(node57_11,'a'). const('a'). 
%%%%%%%% node57_12 %%%%%%%%%%%%%%%%%%%
node(node57_12).
a_afun(node57_12, coord).         const(coord).
m_form(node57_12, x_).         const(x_).
m_lemma(node57_12, x_).         const(x_).
m_tag(node57_12, z______________).         const(z______________).
m_tag0(node57_12,'z'). const('z'). m_tag1(node57_12,':'). const(':'). 
%%%%%%%% node57_13 %%%%%%%%%%%%%%%%%%%
node(node57_13).
functor(node57_13, pred).         const(pred).
gram_sempos(node57_13, v).         const(v).
id(node57_13, t_plzensky70827_txt_001_p1s8a7).         const(t_plzensky70827_txt_001_p1s8a7).
t_lemma(node57_13, odpojit).         const(odpojit).
%%%%%%%% node57_14 %%%%%%%%%%%%%%%%%%%
node(node57_14).
functor(node57_14, act).         const(act).
gram_sempos(node57_14, n_pron_def_pers).         const(n_pron_def_pers).
id(node57_14, t_plzensky70827_txt_001_p1s8a23).         const(t_plzensky70827_txt_001_p1s8a23).
t_lemma(node57_14, x_perspron).         const(x_perspron).
%%%%%%%% node57_15 %%%%%%%%%%%%%%%%%%%
node(node57_15).
a_afun(node57_15, pred).         const(pred).
m_form(node57_15, odpojili).         const(odpojili).
m_lemma(node57_15, odpojit__w).         const(odpojit__w).
m_tag(node57_15, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node57_15,'v'). const('v'). m_tag1(node57_15,'p'). const('p'). m_tag2(node57_15,'m'). const('m'). m_tag3(node57_15,'p'). const('p'). m_tag7(node57_15,'x'). const('x'). m_tag8(node57_15,'r'). const('r'). m_tag10(node57_15,'a'). const('a'). m_tag11(node57_15,'a'). const('a'). 
%%%%%%%% node57_16 %%%%%%%%%%%%%%%%%%%
node(node57_16).
functor(node57_16, loc).         const(loc).
gram_sempos(node57_16, n_denot).         const(n_denot).
id(node57_16, t_plzensky70827_txt_001_p1s8a9).         const(t_plzensky70827_txt_001_p1s8a9).
t_lemma(node57_16, vozidlo).         const(vozidlo).
%%%%%%%% node57_17 %%%%%%%%%%%%%%%%%%%
node(node57_17).
a_afun(node57_17, auxp).         const(auxp).
m_form(node57_17, u).         const(u).
m_lemma(node57_17, u_1).         const(u_1).
m_tag(node57_17, rr__2__________).         const(rr__2__________).
m_tag0(node57_17,'r'). const('r'). m_tag1(node57_17,'r'). const('r'). m_tag4(node57_17,'2'). const('2'). 
%%%%%%%% node57_18 %%%%%%%%%%%%%%%%%%%
node(node57_18).
a_afun(node57_18, adv).         const(adv).
m_form(node57_18, vozidel).         const(vozidel).
m_lemma(node57_18, vozidlo).         const(vozidlo).
m_tag(node57_18, nnnp2_____a____).         const(nnnp2_____a____).
m_tag0(node57_18,'n'). const('n'). m_tag1(node57_18,'n'). const('n'). m_tag2(node57_18,'n'). const('n'). m_tag3(node57_18,'p'). const('p'). m_tag4(node57_18,'2'). const('2'). m_tag10(node57_18,'a'). const('a'). 
%%%%%%%% node57_19 %%%%%%%%%%%%%%%%%%%
node(node57_19).
functor(node57_19, pat).         const(pat).
gram_sempos(node57_19, n_denot).         const(n_denot).
id(node57_19, t_plzensky70827_txt_001_p1s8a10).         const(t_plzensky70827_txt_001_p1s8a10).
t_lemma(node57_19, akumulator).         const(akumulator).
%%%%%%%% node57_20 %%%%%%%%%%%%%%%%%%%
node(node57_20).
a_afun(node57_20, obj).         const(obj).
m_form(node57_20, akumulatory).         const(akumulatory).
m_lemma(node57_20, akumulator).         const(akumulator).
m_tag(node57_20, nnip4_____a____).         const(nnip4_____a____).
m_tag0(node57_20,'n'). const('n'). m_tag1(node57_20,'n'). const('n'). m_tag2(node57_20,'i'). const('i'). m_tag3(node57_20,'p'). const('p'). m_tag4(node57_20,'4'). const('4'). m_tag10(node57_20,'a'). const('a'). 
%%%%%%%% node57_21 %%%%%%%%%%%%%%%%%%%
node(node57_21).
functor(node57_21, conj).         const(conj).
id(node57_21, t_plzensky70827_txt_001_p1s8a11).         const(t_plzensky70827_txt_001_p1s8a11).
t_lemma(node57_21, a).         const(a).
%%%%%%%% node57_22 %%%%%%%%%%%%%%%%%%%
node(node57_22).
functor(node57_22, act).         const(act).
gram_sempos(node57_22, n_pron_def_pers).         const(n_pron_def_pers).
id(node57_22, t_plzensky70827_txt_001_p1s8a27).         const(t_plzensky70827_txt_001_p1s8a27).
t_lemma(node57_22, x_perspron).         const(x_perspron).
%%%%%%%% node57_23 %%%%%%%%%%%%%%%%%%%
node(node57_23).
functor(node57_23, rstr).         const(rstr).
gram_sempos(node57_23, v).         const(v).
id(node57_23, t_plzensky70827_txt_001_p1s8a13).         const(t_plzensky70827_txt_001_p1s8a13).
t_lemma(node57_23, pripravit).         const(pripravit).
%%%%%%%% node57_24 %%%%%%%%%%%%%%%%%%%
node(node57_24).
a_afun(node57_24, atr).         const(atr).
m_form(node57_24, pripravili).         const(pripravili).
m_lemma(node57_24, pripravit__w).         const(pripravit__w).
m_tag(node57_24, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node57_24,'v'). const('v'). m_tag1(node57_24,'p'). const('p'). m_tag2(node57_24,'m'). const('m'). m_tag3(node57_24,'p'). const('p'). m_tag7(node57_24,'x'). const('x'). m_tag8(node57_24,'r'). const('r'). m_tag10(node57_24,'a'). const('a'). m_tag11(node57_24,'a'). const('a'). 
%%%%%%%% node57_25 %%%%%%%%%%%%%%%%%%%
node(node57_25).
functor(node57_25, pat).         const(pat).
gram_sempos(node57_25, adj_denot).         const(adj_denot).
id(node57_25, t_plzensky70827_txt_001_p1s8a14).         const(t_plzensky70827_txt_001_p1s8a14).
t_lemma(node57_25, pristavaci).         const(pristavaci).
%%%%%%%% node57_26 %%%%%%%%%%%%%%%%%%%
node(node57_26).
a_afun(node57_26, obj).         const(obj).
m_form(node57_26, pristavaci).         const(pristavaci).
m_lemma(node57_26, pristavaci____ic__pristat_).         const(pristavaci____ic__pristat_).
m_tag(node57_26, aafs4____1a____).         const(aafs4____1a____).
m_tag0(node57_26,'a'). const('a'). m_tag1(node57_26,'a'). const('a'). m_tag2(node57_26,'f'). const('f'). m_tag3(node57_26,'s'). const('s'). m_tag4(node57_26,'4'). const('4'). m_tag9(node57_26,'1'). const('1'). m_tag10(node57_26,'a'). const('a'). 
%%%%%%%% node57_27 %%%%%%%%%%%%%%%%%%%
node(node57_27).
functor(node57_27, pat).         const(pat).
gram_sempos(node57_27, n_denot).         const(n_denot).
id(node57_27, t_plzensky70827_txt_001_p1s8a15).         const(t_plzensky70827_txt_001_p1s8a15).
t_lemma(node57_27, plocha).         const(plocha).
%%%%%%%% node57_28 %%%%%%%%%%%%%%%%%%%
node(node57_28).
a_afun(node57_28, obj).         const(obj).
m_form(node57_28, plochu).         const(plochu).
m_lemma(node57_28, plocha).         const(plocha).
m_tag(node57_28, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node57_28,'n'). const('n'). m_tag1(node57_28,'n'). const('n'). m_tag2(node57_28,'f'). const('f'). m_tag3(node57_28,'s'). const('s'). m_tag4(node57_28,'4'). const('4'). m_tag10(node57_28,'a'). const('a'). 
%%%%%%%% node57_29 %%%%%%%%%%%%%%%%%%%
node(node57_29).
functor(node57_29, ben).         const(ben).
gram_sempos(node57_29, n_denot).         const(n_denot).
id(node57_29, t_plzensky70827_txt_001_p1s8a17).         const(t_plzensky70827_txt_001_p1s8a17).
t_lemma(node57_29, vrtulnik).         const(vrtulnik).
%%%%%%%% node57_30 %%%%%%%%%%%%%%%%%%%
node(node57_30).
a_afun(node57_30, auxp).         const(auxp).
m_form(node57_30, pro).         const(pro).
m_lemma(node57_30, pro_1).         const(pro_1).
m_tag(node57_30, rr__4__________).         const(rr__4__________).
m_tag0(node57_30,'r'). const('r'). m_tag1(node57_30,'r'). const('r'). m_tag4(node57_30,'4'). const('4'). 
%%%%%%%% node57_31 %%%%%%%%%%%%%%%%%%%
node(node57_31).
a_afun(node57_31, atr).         const(atr).
m_form(node57_31, vrtulnik).         const(vrtulnik).
m_lemma(node57_31, vrtulnik).         const(vrtulnik).
m_tag(node57_31, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node57_31,'n'). const('n'). m_tag1(node57_31,'n'). const('n'). m_tag2(node57_31,'i'). const('i'). m_tag3(node57_31,'s'). const('s'). m_tag4(node57_31,'4'). const('4'). m_tag10(node57_31,'a'). const('a'). 
%%%%%%%% node57_32 %%%%%%%%%%%%%%%%%%%
node(node57_32).
functor(node57_32, rstr).         const(rstr).
gram_sempos(node57_32, n_denot).         const(n_denot).
id(node57_32, t_plzensky70827_txt_001_p1s8a18).         const(t_plzensky70827_txt_001_p1s8a18).
t_lemma(node57_32, lzs).         const(lzs).
%%%%%%%% node57_33 %%%%%%%%%%%%%%%%%%%
node(node57_33).
a_afun(node57_33, atr).         const(atr).
m_form(node57_33, lzs).         const(lzs).
m_lemma(node57_33, lzs).         const(lzs).
m_tag(node57_33, nnxxx_____a____).         const(nnxxx_____a____).
m_tag0(node57_33,'n'). const('n'). m_tag1(node57_33,'n'). const('n'). m_tag2(node57_33,'x'). const('x'). m_tag3(node57_33,'x'). const('x'). m_tag4(node57_33,'x'). const('x'). m_tag10(node57_33,'a'). const('a'). 
%%%%%%%% node57_34 %%%%%%%%%%%%%%%%%%%
node(node57_34).
a_afun(node57_34, coord).         const(coord).
m_form(node57_34, a).         const(a).
m_lemma(node57_34, a_1).         const(a_1).
m_tag(node57_34, j______________).         const(j______________).
m_tag0(node57_34,'j'). const('j'). m_tag1(node57_34,'^'). const('^'). 
%%%%%%%% node57_35 %%%%%%%%%%%%%%%%%%%
node(node57_35).
functor(node57_35, rstr).         const(rstr).
gram_sempos(node57_35, v).         const(v).
id(node57_35, t_plzensky70827_txt_001_p1s8a19).         const(t_plzensky70827_txt_001_p1s8a19).
t_lemma(node57_35, pomoci).         const(pomoci).
%%%%%%%% node57_36 %%%%%%%%%%%%%%%%%%%
node(node57_36).
a_afun(node57_36, atr).         const(atr).
m_form(node57_36, pomohli).         const(pomohli).
m_lemma(node57_36, pomoci).         const(pomoci).
m_tag(node57_36, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node57_36,'v'). const('v'). m_tag1(node57_36,'p'). const('p'). m_tag2(node57_36,'m'). const('m'). m_tag3(node57_36,'p'). const('p'). m_tag7(node57_36,'x'). const('x'). m_tag8(node57_36,'r'). const('r'). m_tag10(node57_36,'a'). const('a'). m_tag11(node57_36,'a'). const('a'). 
%%%%%%%% node57_37 %%%%%%%%%%%%%%%%%%%
node(node57_37).
functor(node57_37, addr).         const(addr).
id(node57_37, t_plzensky70827_txt_001_p1s8a26).         const(t_plzensky70827_txt_001_p1s8a26).
t_lemma(node57_37, x_gen).         const(x_gen).
%%%%%%%% node57_38 %%%%%%%%%%%%%%%%%%%
node(node57_38).
functor(node57_38, acmp).         const(acmp).
gram_sempos(node57_38, n_denot).         const(n_denot).
id(node57_38, t_plzensky70827_txt_001_p1s8a21).         const(t_plzensky70827_txt_001_p1s8a21).
t_lemma(node57_38, nalozeni).         const(nalozeni).
%%%%%%%% node57_39 %%%%%%%%%%%%%%%%%%%
node(node57_39).
a_afun(node57_39, auxp).         const(auxp).
m_form(node57_39, s).         const(s).
m_lemma(node57_39, s_1).         const(s_1).
m_tag(node57_39, rr__7__________).         const(rr__7__________).
m_tag0(node57_39,'r'). const('r'). m_tag1(node57_39,'r'). const('r'). m_tag4(node57_39,'7'). const('7'). 
%%%%%%%% node57_40 %%%%%%%%%%%%%%%%%%%
node(node57_40).
a_afun(node57_40, adv).         const(adv).
m_form(node57_40, nalozenim).         const(nalozenim).
m_lemma(node57_40, nalozeni____3it_).         const(nalozeni____3it_).
m_tag(node57_40, nnns7_____a____).         const(nnns7_____a____).
m_tag0(node57_40,'n'). const('n'). m_tag1(node57_40,'n'). const('n'). m_tag2(node57_40,'n'). const('n'). m_tag3(node57_40,'s'). const('s'). m_tag4(node57_40,'7'). const('7'). m_tag10(node57_40,'a'). const('a'). 
%%%%%%%% node57_41 %%%%%%%%%%%%%%%%%%%
node(node57_41).
functor(node57_41, rstr).         const(rstr).
gram_sempos(node57_41, adj_denot).         const(adj_denot).
id(node57_41, t_plzensky70827_txt_001_p1s8a22).         const(t_plzensky70827_txt_001_p1s8a22).
t_lemma(node57_41, zraneny).         const(zraneny).
%%%%%%%% node57_42 %%%%%%%%%%%%%%%%%%%
node(node57_42).
a_afun(node57_42, exd).         const(exd).
m_form(node57_42, zraneneho).         const(zraneneho).
m_lemma(node57_42, zraneny____3it_).         const(zraneny____3it_).
m_tag(node57_42, aais2____1a____).         const(aais2____1a____).
m_tag0(node57_42,'a'). const('a'). m_tag1(node57_42,'a'). const('a'). m_tag2(node57_42,'i'). const('i'). m_tag3(node57_42,'s'). const('s'). m_tag4(node57_42,'2'). const('2'). m_tag9(node57_42,'1'). const('1'). m_tag10(node57_42,'a'). const('a'). 
edge(node57_0, node57_1).
edge(node57_1, node57_2).
edge(node57_2, node57_3).
edge(node57_3, node57_4).
edge(node57_2, node57_5).
edge(node57_5, node57_6).
edge(node57_2, node57_7).
edge(node57_2, node57_8).
edge(node57_8, node57_9).
edge(node57_8, node57_10).
edge(node57_10, node57_11).
edge(node57_1, node57_12).
edge(node57_1, node57_13).
edge(node57_13, node57_14).
edge(node57_13, node57_15).
edge(node57_13, node57_16).
edge(node57_16, node57_17).
edge(node57_16, node57_18).
edge(node57_13, node57_19).
edge(node57_19, node57_20).
edge(node57_19, node57_21).
edge(node57_21, node57_22).
edge(node57_21, node57_23).
edge(node57_23, node57_24).
edge(node57_23, node57_25).
edge(node57_25, node57_26).
edge(node57_23, node57_27).
edge(node57_27, node57_28).
edge(node57_27, node57_29).
edge(node57_29, node57_30).
edge(node57_29, node57_31).
edge(node57_29, node57_32).
edge(node57_32, node57_33).
edge(node57_21, node57_34).
edge(node57_21, node57_35).
edge(node57_35, node57_36).
edge(node57_35, node57_37).
edge(node57_35, node57_38).
edge(node57_38, node57_39).
edge(node57_38, node57_40).
edge(node57_38, node57_41).
edge(node57_41, node57_42).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% silnice v miste je uzavrena. 
tree_root(node58_0).
:- %%%%%%%% node58_0 %%%%%%%%%%%%%%%%%%%
node(node58_0).
id(node58_0, t_plzensky70827_txt_001_p1s9).         const(t_plzensky70827_txt_001_p1s9).
%%%%%%%% node58_1 %%%%%%%%%%%%%%%%%%%
node(node58_1).
functor(node58_1, pred).         const(pred).
gram_sempos(node58_1, v).         const(v).
id(node58_1, t_plzensky70827_txt_001_p1s9a5).         const(t_plzensky70827_txt_001_p1s9a5).
t_lemma(node58_1, uzavrit).         const(uzavrit).
%%%%%%%% node58_2 %%%%%%%%%%%%%%%%%%%
node(node58_2).
functor(node58_2, act).         const(act).
id(node58_2, t_plzensky70827_txt_001_p1s9a6).         const(t_plzensky70827_txt_001_p1s9a6).
t_lemma(node58_2, x_gen).         const(x_gen).
%%%%%%%% node58_3 %%%%%%%%%%%%%%%%%%%
node(node58_3).
functor(node58_3, pat).         const(pat).
gram_sempos(node58_3, n_denot).         const(n_denot).
id(node58_3, t_plzensky70827_txt_001_p1s9a2).         const(t_plzensky70827_txt_001_p1s9a2).
t_lemma(node58_3, silnice).         const(silnice).
%%%%%%%% node58_4 %%%%%%%%%%%%%%%%%%%
node(node58_4).
a_afun(node58_4, sb).         const(sb).
m_form(node58_4, silnice).         const(silnice).
m_lemma(node58_4, silnice).         const(silnice).
m_tag(node58_4, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node58_4,'n'). const('n'). m_tag1(node58_4,'n'). const('n'). m_tag2(node58_4,'f'). const('f'). m_tag3(node58_4,'s'). const('s'). m_tag4(node58_4,'1'). const('1'). m_tag10(node58_4,'a'). const('a'). 
%%%%%%%% node58_5 %%%%%%%%%%%%%%%%%%%
node(node58_5).
functor(node58_5, loc).         const(loc).
gram_sempos(node58_5, n_denot).         const(n_denot).
id(node58_5, t_plzensky70827_txt_001_p1s9a4).         const(t_plzensky70827_txt_001_p1s9a4).
t_lemma(node58_5, misto).         const(misto).
%%%%%%%% node58_6 %%%%%%%%%%%%%%%%%%%
node(node58_6).
a_afun(node58_6, auxp).         const(auxp).
m_form(node58_6, v).         const(v).
m_lemma(node58_6, v_1).         const(v_1).
m_tag(node58_6, rr__6__________).         const(rr__6__________).
m_tag0(node58_6,'r'). const('r'). m_tag1(node58_6,'r'). const('r'). m_tag4(node58_6,'6'). const('6'). 
%%%%%%%% node58_7 %%%%%%%%%%%%%%%%%%%
node(node58_7).
a_afun(node58_7, atr).         const(atr).
m_form(node58_7, miste).         const(miste).
m_lemma(node58_7, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node58_7, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node58_7,'n'). const('n'). m_tag1(node58_7,'n'). const('n'). m_tag2(node58_7,'n'). const('n'). m_tag3(node58_7,'s'). const('s'). m_tag4(node58_7,'6'). const('6'). m_tag10(node58_7,'a'). const('a'). 
%%%%%%%% node58_8 %%%%%%%%%%%%%%%%%%%
node(node58_8).
a_afun(node58_8, pred).         const(pred).
m_form(node58_8, je).         const(je).
m_lemma(node58_8, byt).         const(byt).
m_tag(node58_8, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node58_8,'v'). const('v'). m_tag1(node58_8,'b'). const('b'). m_tag3(node58_8,'s'). const('s'). m_tag7(node58_8,'3'). const('3'). m_tag8(node58_8,'p'). const('p'). m_tag10(node58_8,'a'). const('a'). m_tag11(node58_8,'a'). const('a'). 
%%%%%%%% node58_9 %%%%%%%%%%%%%%%%%%%
node(node58_9).
a_afun(node58_9, pnom).         const(pnom).
m_form(node58_9, uzavrena).         const(uzavrena).
m_lemma(node58_9, uzavrit).         const(uzavrit).
m_tag(node58_9, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node58_9,'v'). const('v'). m_tag1(node58_9,'s'). const('s'). m_tag2(node58_9,'q'). const('q'). m_tag3(node58_9,'w'). const('w'). m_tag7(node58_9,'x'). const('x'). m_tag8(node58_9,'x'). const('x'). m_tag10(node58_9,'a'). const('a'). m_tag11(node58_9,'p'). const('p'). 
edge(node58_0, node58_1).
edge(node58_1, node58_2).
edge(node58_1, node58_3).
edge(node58_3, node58_4).
edge(node58_3, node58_5).
edge(node58_5, node58_6).
edge(node58_5, node58_7).
edge(node58_1, node58_8).
edge(node58_1, node58_9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dle policie cr, ktera se pred jedenactou hodinou rozhodla na misto povolat soudniho znalce, by silnice mohla byt uzavrena jeste ctyri hodiny. 
tree_root(node59_0).
:- %%%%%%%% node59_0 %%%%%%%%%%%%%%%%%%%
node(node59_0).
id(node59_0, t_plzensky70827_txt_001_p1s10).         const(t_plzensky70827_txt_001_p1s10).
%%%%%%%% node59_1 %%%%%%%%%%%%%%%%%%%
node(node59_1).
functor(node59_1, pred).         const(pred).
gram_sempos(node59_1, v).         const(v).
id(node59_1, t_plzensky70827_txt_001_p1s10a20).         const(t_plzensky70827_txt_001_p1s10a20).
t_lemma(node59_1, uzavrit).         const(uzavrit).
%%%%%%%% node59_2 %%%%%%%%%%%%%%%%%%%
node(node59_2).
functor(node59_2, act).         const(act).
id(node59_2, t_plzensky70827_txt_001_p1s10a25).         const(t_plzensky70827_txt_001_p1s10a25).
t_lemma(node59_2, x_gen).         const(x_gen).
%%%%%%%% node59_3 %%%%%%%%%%%%%%%%%%%
node(node59_3).
functor(node59_3, crit).         const(crit).
gram_sempos(node59_3, n_denot).         const(n_denot).
id(node59_3, t_plzensky70827_txt_001_p1s10a3).         const(t_plzensky70827_txt_001_p1s10a3).
t_lemma(node59_3, policie).         const(policie).
%%%%%%%% node59_4 %%%%%%%%%%%%%%%%%%%
node(node59_4).
a_afun(node59_4, auxp).         const(auxp).
m_form(node59_4, dle).         const(dle).
m_lemma(node59_4, dle).         const(dle).
m_tag(node59_4, rr__2__________).         const(rr__2__________).
m_tag0(node59_4,'r'). const('r'). m_tag1(node59_4,'r'). const('r'). m_tag4(node59_4,'2'). const('2'). 
%%%%%%%% node59_5 %%%%%%%%%%%%%%%%%%%
node(node59_5).
a_afun(node59_5, adv).         const(adv).
m_form(node59_5, policie).         const(policie).
m_lemma(node59_5, policie).         const(policie).
m_tag(node59_5, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node59_5,'n'). const('n'). m_tag1(node59_5,'n'). const('n'). m_tag2(node59_5,'f'). const('f'). m_tag3(node59_5,'s'). const('s'). m_tag4(node59_5,'2'). const('2'). m_tag10(node59_5,'a'). const('a'). 
%%%%%%%% node59_6 %%%%%%%%%%%%%%%%%%%
node(node59_6).
functor(node59_6, app).         const(app).
gram_sempos(node59_6, n_denot).         const(n_denot).
id(node59_6, t_plzensky70827_txt_001_p1s10a4).         const(t_plzensky70827_txt_001_p1s10a4).
t_lemma(node59_6, cr).         const(cr).
%%%%%%%% node59_7 %%%%%%%%%%%%%%%%%%%
node(node59_7).
a_afun(node59_7, atr).         const(atr).
m_form(node59_7, cr).         const(cr).
m_lemma(node59_7, cr_1__b__g___ceska_republika_).         const(cr_1__b__g___ceska_republika_).
m_tag(node59_7, nnfxx_____a___8).         const(nnfxx_____a___8).
m_tag0(node59_7,'n'). const('n'). m_tag1(node59_7,'n'). const('n'). m_tag2(node59_7,'f'). const('f'). m_tag3(node59_7,'x'). const('x'). m_tag4(node59_7,'x'). const('x'). m_tag10(node59_7,'a'). const('a'). m_tag14(node59_7,'8'). const('8'). 
%%%%%%%% node59_8 %%%%%%%%%%%%%%%%%%%
node(node59_8).
functor(node59_8, rstr).         const(rstr).
gram_sempos(node59_8, v).         const(v).
id(node59_8, t_plzensky70827_txt_001_p1s10a5).         const(t_plzensky70827_txt_001_p1s10a5).
t_lemma(node59_8, rozhodnout_se).         const(rozhodnout_se).
%%%%%%%% node59_9 %%%%%%%%%%%%%%%%%%%
node(node59_9).
functor(node59_9, act).         const(act).
gram_sempos(node59_9, n_pron_indef).         const(n_pron_indef).
id(node59_9, t_plzensky70827_txt_001_p1s10a7).         const(t_plzensky70827_txt_001_p1s10a7).
t_lemma(node59_9, ktery).         const(ktery).
%%%%%%%% node59_10 %%%%%%%%%%%%%%%%%%%
node(node59_10).
a_afun(node59_10, sb).         const(sb).
m_form(node59_10, ktera).         const(ktera).
m_lemma(node59_10, ktery).         const(ktery).
m_tag(node59_10, p4fs1__________).         const(p4fs1__________).
m_tag0(node59_10,'p'). const('p'). m_tag1(node59_10,'4'). const('4'). m_tag2(node59_10,'f'). const('f'). m_tag3(node59_10,'s'). const('s'). m_tag4(node59_10,'1'). const('1'). 
%%%%%%%% node59_11 %%%%%%%%%%%%%%%%%%%
node(node59_11).
functor(node59_11, twhen).         const(twhen).
gram_sempos(node59_11, n_denot).         const(n_denot).
id(node59_11, t_plzensky70827_txt_001_p1s10a10).         const(t_plzensky70827_txt_001_p1s10a10).
t_lemma(node59_11, hodina).         const(hodina).
%%%%%%%% node59_12 %%%%%%%%%%%%%%%%%%%
node(node59_12).
functor(node59_12, rstr).         const(rstr).
gram_sempos(node59_12, adj_quant_def).         const(adj_quant_def).
id(node59_12, t_plzensky70827_txt_001_p1s10a11).         const(t_plzensky70827_txt_001_p1s10a11).
t_lemma(node59_12, jedenact).         const(jedenact).
%%%%%%%% node59_13 %%%%%%%%%%%%%%%%%%%
node(node59_13).
a_afun(node59_13, atr).         const(atr).
m_form(node59_13, jedenactou).         const(jedenactou).
m_lemma(node59_13, jedenacty).         const(jedenacty).
m_tag(node59_13, crfs7__________).         const(crfs7__________).
m_tag0(node59_13,'c'). const('c'). m_tag1(node59_13,'r'). const('r'). m_tag2(node59_13,'f'). const('f'). m_tag3(node59_13,'s'). const('s'). m_tag4(node59_13,'7'). const('7'). 
%%%%%%%% node59_14 %%%%%%%%%%%%%%%%%%%
node(node59_14).
a_afun(node59_14, auxp).         const(auxp).
m_form(node59_14, pred).         const(pred).
m_lemma(node59_14, pred_1).         const(pred_1).
m_tag(node59_14, rr__7__________).         const(rr__7__________).
m_tag0(node59_14,'r'). const('r'). m_tag1(node59_14,'r'). const('r'). m_tag4(node59_14,'7'). const('7'). 
%%%%%%%% node59_15 %%%%%%%%%%%%%%%%%%%
node(node59_15).
a_afun(node59_15, adv).         const(adv).
m_form(node59_15, hodinou).         const(hodinou).
m_lemma(node59_15, hodina___jednotka_casu_).         const(hodina___jednotka_casu_).
m_tag(node59_15, nnfs7_____a____).         const(nnfs7_____a____).
m_tag0(node59_15,'n'). const('n'). m_tag1(node59_15,'n'). const('n'). m_tag2(node59_15,'f'). const('f'). m_tag3(node59_15,'s'). const('s'). m_tag4(node59_15,'7'). const('7'). m_tag10(node59_15,'a'). const('a'). 
%%%%%%%% node59_16 %%%%%%%%%%%%%%%%%%%
node(node59_16).
a_afun(node59_16, auxt).         const(auxt).
m_form(node59_16, se).         const(se).
m_lemma(node59_16, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node59_16, p7_x4__________).         const(p7_x4__________).
m_tag0(node59_16,'p'). const('p'). m_tag1(node59_16,'7'). const('7'). m_tag3(node59_16,'x'). const('x'). m_tag4(node59_16,'4'). const('4'). 
%%%%%%%% node59_17 %%%%%%%%%%%%%%%%%%%
node(node59_17).
a_afun(node59_17, atr).         const(atr).
m_form(node59_17, rozhodla).         const(rozhodla).
m_lemma(node59_17, rozhodnout__w).         const(rozhodnout__w).
m_tag(node59_17, vpqw___xr_aa__1).         const(vpqw___xr_aa__1).
m_tag0(node59_17,'v'). const('v'). m_tag1(node59_17,'p'). const('p'). m_tag2(node59_17,'q'). const('q'). m_tag3(node59_17,'w'). const('w'). m_tag7(node59_17,'x'). const('x'). m_tag8(node59_17,'r'). const('r'). m_tag10(node59_17,'a'). const('a'). m_tag11(node59_17,'a'). const('a'). m_tag14(node59_17,'1'). const('1'). 
%%%%%%%% node59_18 %%%%%%%%%%%%%%%%%%%
node(node59_18).
functor(node59_18, pat).         const(pat).
gram_sempos(node59_18, v).         const(v).
id(node59_18, t_plzensky70827_txt_001_p1s10a12).         const(t_plzensky70827_txt_001_p1s10a12).
t_lemma(node59_18, povolat).         const(povolat).
%%%%%%%% node59_19 %%%%%%%%%%%%%%%%%%%
node(node59_19).
functor(node59_19, act).         const(act).
id(node59_19, t_plzensky70827_txt_001_p1s10a26).         const(t_plzensky70827_txt_001_p1s10a26).
t_lemma(node59_19, x_cor).         const(x_cor).
%%%%%%%% node59_20 %%%%%%%%%%%%%%%%%%%
node(node59_20).
functor(node59_20, dir3).         const(dir3).
gram_sempos(node59_20, n_denot).         const(n_denot).
id(node59_20, t_plzensky70827_txt_001_p1s10a14).         const(t_plzensky70827_txt_001_p1s10a14).
t_lemma(node59_20, misto).         const(misto).
%%%%%%%% node59_21 %%%%%%%%%%%%%%%%%%%
node(node59_21).
a_afun(node59_21, auxp).         const(auxp).
m_form(node59_21, na).         const(na).
m_lemma(node59_21, na_1).         const(na_1).
m_tag(node59_21, rr__4__________).         const(rr__4__________).
m_tag0(node59_21,'r'). const('r'). m_tag1(node59_21,'r'). const('r'). m_tag4(node59_21,'4'). const('4'). 
%%%%%%%% node59_22 %%%%%%%%%%%%%%%%%%%
node(node59_22).
a_afun(node59_22, adv).         const(adv).
m_form(node59_22, misto).         const(misto).
m_lemma(node59_22, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node59_22, nnns4_____a____).         const(nnns4_____a____).
m_tag0(node59_22,'n'). const('n'). m_tag1(node59_22,'n'). const('n'). m_tag2(node59_22,'n'). const('n'). m_tag3(node59_22,'s'). const('s'). m_tag4(node59_22,'4'). const('4'). m_tag10(node59_22,'a'). const('a'). 
%%%%%%%% node59_23 %%%%%%%%%%%%%%%%%%%
node(node59_23).
a_afun(node59_23, obj).         const(obj).
m_form(node59_23, povolat).         const(povolat).
m_lemma(node59_23, povolat__w).         const(povolat__w).
m_tag(node59_23, vf________a____).         const(vf________a____).
m_tag0(node59_23,'v'). const('v'). m_tag1(node59_23,'f'). const('f'). m_tag10(node59_23,'a'). const('a'). 
%%%%%%%% node59_24 %%%%%%%%%%%%%%%%%%%
node(node59_24).
functor(node59_24, pat).         const(pat).
gram_sempos(node59_24, n_denot).         const(n_denot).
id(node59_24, t_plzensky70827_txt_001_p1s10a15).         const(t_plzensky70827_txt_001_p1s10a15).
t_lemma(node59_24, znalec).         const(znalec).
%%%%%%%% node59_25 %%%%%%%%%%%%%%%%%%%
node(node59_25).
functor(node59_25, rstr).         const(rstr).
gram_sempos(node59_25, adj_denot).         const(adj_denot).
id(node59_25, t_plzensky70827_txt_001_p1s10a16).         const(t_plzensky70827_txt_001_p1s10a16).
t_lemma(node59_25, soudni).         const(soudni).
%%%%%%%% node59_26 %%%%%%%%%%%%%%%%%%%
node(node59_26).
a_afun(node59_26, atr).         const(atr).
m_form(node59_26, soudniho).         const(soudniho).
m_lemma(node59_26, soudni).         const(soudni).
m_tag(node59_26, aams4____1a____).         const(aams4____1a____).
m_tag0(node59_26,'a'). const('a'). m_tag1(node59_26,'a'). const('a'). m_tag2(node59_26,'m'). const('m'). m_tag3(node59_26,'s'). const('s'). m_tag4(node59_26,'4'). const('4'). m_tag9(node59_26,'1'). const('1'). m_tag10(node59_26,'a'). const('a'). 
%%%%%%%% node59_27 %%%%%%%%%%%%%%%%%%%
node(node59_27).
a_afun(node59_27, obj).         const(obj).
m_form(node59_27, znalce).         const(znalce).
m_lemma(node59_27, znalec).         const(znalec).
m_tag(node59_27, nnms4_____a____).         const(nnms4_____a____).
m_tag0(node59_27,'n'). const('n'). m_tag1(node59_27,'n'). const('n'). m_tag2(node59_27,'m'). const('m'). m_tag3(node59_27,'s'). const('s'). m_tag4(node59_27,'4'). const('4'). m_tag10(node59_27,'a'). const('a'). 
%%%%%%%% node59_28 %%%%%%%%%%%%%%%%%%%
node(node59_28).
functor(node59_28, pat).         const(pat).
gram_sempos(node59_28, n_denot).         const(n_denot).
id(node59_28, t_plzensky70827_txt_001_p1s10a19).         const(t_plzensky70827_txt_001_p1s10a19).
t_lemma(node59_28, silnice).         const(silnice).
%%%%%%%% node59_29 %%%%%%%%%%%%%%%%%%%
node(node59_29).
a_afun(node59_29, obj).         const(obj).
m_form(node59_29, silnice).         const(silnice).
m_lemma(node59_29, silnice).         const(silnice).
m_tag(node59_29, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node59_29,'n'). const('n'). m_tag1(node59_29,'n'). const('n'). m_tag2(node59_29,'f'). const('f'). m_tag3(node59_29,'p'). const('p'). m_tag4(node59_29,'4'). const('4'). m_tag10(node59_29,'a'). const('a'). 
%%%%%%%% node59_30 %%%%%%%%%%%%%%%%%%%
node(node59_30).
a_afun(node59_30, auxv).         const(auxv).
m_form(node59_30, by).         const(by).
m_lemma(node59_30, byt).         const(byt).
m_tag(node59_30, vc_____________).         const(vc_____________).
m_tag0(node59_30,'v'). const('v'). m_tag1(node59_30,'c'). const('c'). 
%%%%%%%% node59_31 %%%%%%%%%%%%%%%%%%%
node(node59_31).
a_afun(node59_31, pred).         const(pred).
m_form(node59_31, mohla).         const(mohla).
m_lemma(node59_31, moci___mit_moznost__neco_delat__).         const(moci___mit_moznost__neco_delat__).
m_tag(node59_31, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node59_31,'v'). const('v'). m_tag1(node59_31,'p'). const('p'). m_tag2(node59_31,'q'). const('q'). m_tag3(node59_31,'w'). const('w'). m_tag7(node59_31,'x'). const('x'). m_tag8(node59_31,'r'). const('r'). m_tag10(node59_31,'a'). const('a'). m_tag11(node59_31,'a'). const('a'). 
%%%%%%%% node59_32 %%%%%%%%%%%%%%%%%%%
node(node59_32).
a_afun(node59_32, auxv).         const(auxv).
m_form(node59_32, byt).         const(byt).
m_lemma(node59_32, byt).         const(byt).
m_tag(node59_32, vf________a____).         const(vf________a____).
m_tag0(node59_32,'v'). const('v'). m_tag1(node59_32,'f'). const('f'). m_tag10(node59_32,'a'). const('a'). 
%%%%%%%% node59_33 %%%%%%%%%%%%%%%%%%%
node(node59_33).
a_afun(node59_33, obj).         const(obj).
m_form(node59_33, uzavrena).         const(uzavrena).
m_lemma(node59_33, uzavrit).         const(uzavrit).
m_tag(node59_33, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node59_33,'v'). const('v'). m_tag1(node59_33,'s'). const('s'). m_tag2(node59_33,'q'). const('q'). m_tag3(node59_33,'w'). const('w'). m_tag7(node59_33,'x'). const('x'). m_tag8(node59_33,'x'). const('x'). m_tag10(node59_33,'a'). const('a'). m_tag11(node59_33,'p'). const('p'). 
%%%%%%%% node59_34 %%%%%%%%%%%%%%%%%%%
node(node59_34).
functor(node59_34, pat).         const(pat).
gram_sempos(node59_34, n_denot).         const(n_denot).
id(node59_34, t_plzensky70827_txt_001_p1s10a22).         const(t_plzensky70827_txt_001_p1s10a22).
t_lemma(node59_34, hodina).         const(hodina).
%%%%%%%% node59_35 %%%%%%%%%%%%%%%%%%%
node(node59_35).
functor(node59_35, rhem).         const(rhem).
id(node59_35, t_plzensky70827_txt_001_p1s10a23).         const(t_plzensky70827_txt_001_p1s10a23).
t_lemma(node59_35, jeste).         const(jeste).
%%%%%%%% node59_36 %%%%%%%%%%%%%%%%%%%
node(node59_36).
a_afun(node59_36, auxz).         const(auxz).
m_form(node59_36, jeste).         const(jeste).
m_lemma(node59_36, jeste).         const(jeste).
m_tag(node59_36, db_____________).         const(db_____________).
m_tag0(node59_36,'d'). const('d'). m_tag1(node59_36,'b'). const('b'). 
%%%%%%%% node59_37 %%%%%%%%%%%%%%%%%%%
node(node59_37).
functor(node59_37, rstr).         const(rstr).
gram_sempos(node59_37, adj_quant_def).         const(adj_quant_def).
id(node59_37, t_plzensky70827_txt_001_p1s10a24).         const(t_plzensky70827_txt_001_p1s10a24).
t_lemma(node59_37, ctyri).         const(ctyri).
%%%%%%%% node59_38 %%%%%%%%%%%%%%%%%%%
node(node59_38).
a_afun(node59_38, atr).         const(atr).
m_form(node59_38, ctyri).         const(ctyri).
m_lemma(node59_38, ctyri_4).         const(ctyri_4).
m_tag(node59_38, clxp1__________).         const(clxp1__________).
m_tag0(node59_38,'c'). const('c'). m_tag1(node59_38,'l'). const('l'). m_tag2(node59_38,'x'). const('x'). m_tag3(node59_38,'p'). const('p'). m_tag4(node59_38,'1'). const('1'). 
%%%%%%%% node59_39 %%%%%%%%%%%%%%%%%%%
node(node59_39).
a_afun(node59_39, sb).         const(sb).
m_form(node59_39, hodiny).         const(hodiny).
m_lemma(node59_39, hodina___jednotka_casu_).         const(hodina___jednotka_casu_).
m_tag(node59_39, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node59_39,'n'). const('n'). m_tag1(node59_39,'n'). const('n'). m_tag2(node59_39,'f'). const('f'). m_tag3(node59_39,'p'). const('p'). m_tag4(node59_39,'1'). const('1'). m_tag10(node59_39,'a'). const('a'). 
edge(node59_0, node59_1).
edge(node59_1, node59_2).
edge(node59_1, node59_3).
edge(node59_3, node59_4).
edge(node59_3, node59_5).
edge(node59_3, node59_6).
edge(node59_6, node59_7).
edge(node59_3, node59_8).
edge(node59_8, node59_9).
edge(node59_9, node59_10).
edge(node59_8, node59_11).
edge(node59_11, node59_12).
edge(node59_12, node59_13).
edge(node59_11, node59_14).
edge(node59_11, node59_15).
edge(node59_8, node59_16).
edge(node59_8, node59_17).
edge(node59_8, node59_18).
edge(node59_18, node59_19).
edge(node59_18, node59_20).
edge(node59_20, node59_21).
edge(node59_20, node59_22).
edge(node59_18, node59_23).
edge(node59_18, node59_24).
edge(node59_24, node59_25).
edge(node59_25, node59_26).
edge(node59_24, node59_27).
edge(node59_1, node59_28).
edge(node59_28, node59_29).
edge(node59_1, node59_30).
edge(node59_1, node59_31).
edge(node59_1, node59_32).
edge(node59_1, node59_33).
edge(node59_1, node59_34).
edge(node59_34, node59_35).
edge(node59_35, node59_36).
edge(node59_34, node59_37).
edge(node59_37, node59_38).
edge(node59_34, node59_39).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hasici se po domluve s pcr vratili na zakladnu a k udalosti se vrati po ukonceni prace policie cr. 
tree_root(node60_0).
:- %%%%%%%% node60_0 %%%%%%%%%%%%%%%%%%%
node(node60_0).
id(node60_0, t_plzensky70827_txt_001_p1s11).         const(t_plzensky70827_txt_001_p1s11).
%%%%%%%% node60_1 %%%%%%%%%%%%%%%%%%%
node(node60_1).
functor(node60_1, conj).         const(conj).
id(node60_1, t_plzensky70827_txt_001_p1s11a1).         const(t_plzensky70827_txt_001_p1s11a1).
t_lemma(node60_1, a).         const(a).
%%%%%%%% node60_2 %%%%%%%%%%%%%%%%%%%
node(node60_2).
functor(node60_2, act).         const(act).
gram_sempos(node60_2, n_denot).         const(n_denot).
id(node60_2, t_plzensky70827_txt_001_p1s11a2).         const(t_plzensky70827_txt_001_p1s11a2).
t_lemma(node60_2, hasic).         const(hasic).
%%%%%%%% node60_3 %%%%%%%%%%%%%%%%%%%
node(node60_3).
a_afun(node60_3, sb).         const(sb).
m_form(node60_3, hasici).         const(hasici).
m_lemma(node60_3, hasic).         const(hasic).
m_tag(node60_3, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node60_3,'n'). const('n'). m_tag1(node60_3,'n'). const('n'). m_tag2(node60_3,'m'). const('m'). m_tag3(node60_3,'p'). const('p'). m_tag4(node60_3,'1'). const('1'). m_tag10(node60_3,'a'). const('a'). 
%%%%%%%% node60_4 %%%%%%%%%%%%%%%%%%%
node(node60_4).
functor(node60_4, pred).         const(pred).
gram_sempos(node60_4, v).         const(v).
id(node60_4, t_plzensky70827_txt_001_p1s11a3).         const(t_plzensky70827_txt_001_p1s11a3).
t_lemma(node60_4, vratit_se).         const(vratit_se).
%%%%%%%% node60_5 %%%%%%%%%%%%%%%%%%%
node(node60_5).
functor(node60_5, twhen).         const(twhen).
gram_sempos(node60_5, n_denot).         const(n_denot).
id(node60_5, t_plzensky70827_txt_001_p1s11a6).         const(t_plzensky70827_txt_001_p1s11a6).
t_lemma(node60_5, domluva).         const(domluva).
%%%%%%%% node60_6 %%%%%%%%%%%%%%%%%%%
node(node60_6).
a_afun(node60_6, auxp).         const(auxp).
m_form(node60_6, po).         const(po).
m_lemma(node60_6, po_1).         const(po_1).
m_tag(node60_6, rr__6__________).         const(rr__6__________).
m_tag0(node60_6,'r'). const('r'). m_tag1(node60_6,'r'). const('r'). m_tag4(node60_6,'6'). const('6'). 
%%%%%%%% node60_7 %%%%%%%%%%%%%%%%%%%
node(node60_7).
a_afun(node60_7, adv).         const(adv).
m_form(node60_7, domluve).         const(domluve).
m_lemma(node60_7, domluva).         const(domluva).
m_tag(node60_7, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node60_7,'n'). const('n'). m_tag1(node60_7,'n'). const('n'). m_tag2(node60_7,'f'). const('f'). m_tag3(node60_7,'s'). const('s'). m_tag4(node60_7,'6'). const('6'). m_tag10(node60_7,'a'). const('a'). 
%%%%%%%% node60_8 %%%%%%%%%%%%%%%%%%%
node(node60_8).
functor(node60_8, pat).         const(pat).
id(node60_8, t_plzensky70827_txt_001_p1s11a8).         const(t_plzensky70827_txt_001_p1s11a8).
t_lemma(node60_8, pcr).         const(pcr).
%%%%%%%% node60_9 %%%%%%%%%%%%%%%%%%%
node(node60_9).
a_afun(node60_9, auxp).         const(auxp).
m_form(node60_9, s).         const(s).
m_lemma(node60_9, s_1).         const(s_1).
m_tag(node60_9, rr__7__________).         const(rr__7__________).
m_tag0(node60_9,'r'). const('r'). m_tag1(node60_9,'r'). const('r'). m_tag4(node60_9,'7'). const('7'). 
%%%%%%%% node60_10 %%%%%%%%%%%%%%%%%%%
node(node60_10).
a_afun(node60_10, atr).         const(atr).
m_form(node60_10, pcr).         const(pcr).
m_lemma(node60_10, pcr__b__k___parlament_ceske_republiky_).         const(pcr__b__k___parlament_ceske_republiky_).
m_tag(node60_10, xx_____________).         const(xx_____________).
m_tag0(node60_10,'x'). const('x'). m_tag1(node60_10,'x'). const('x'). 
%%%%%%%% node60_11 %%%%%%%%%%%%%%%%%%%
node(node60_11).
a_afun(node60_11, auxt).         const(auxt).
m_form(node60_11, se).         const(se).
m_lemma(node60_11, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node60_11, p7_x4__________).         const(p7_x4__________).
m_tag0(node60_11,'p'). const('p'). m_tag1(node60_11,'7'). const('7'). m_tag3(node60_11,'x'). const('x'). m_tag4(node60_11,'4'). const('4'). 
%%%%%%%% node60_12 %%%%%%%%%%%%%%%%%%%
node(node60_12).
a_afun(node60_12, pred).         const(pred).
m_form(node60_12, vratili).         const(vratili).
m_lemma(node60_12, vratit__w).         const(vratit__w).
m_tag(node60_12, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node60_12,'v'). const('v'). m_tag1(node60_12,'p'). const('p'). m_tag2(node60_12,'m'). const('m'). m_tag3(node60_12,'p'). const('p'). m_tag7(node60_12,'x'). const('x'). m_tag8(node60_12,'r'). const('r'). m_tag10(node60_12,'a'). const('a'). m_tag11(node60_12,'a'). const('a'). 
%%%%%%%% node60_13 %%%%%%%%%%%%%%%%%%%
node(node60_13).
functor(node60_13, dir3).         const(dir3).
gram_sempos(node60_13, n_denot).         const(n_denot).
id(node60_13, t_plzensky70827_txt_001_p1s11a10).         const(t_plzensky70827_txt_001_p1s11a10).
t_lemma(node60_13, zakladna).         const(zakladna).
%%%%%%%% node60_14 %%%%%%%%%%%%%%%%%%%
node(node60_14).
a_afun(node60_14, auxp).         const(auxp).
m_form(node60_14, na).         const(na).
m_lemma(node60_14, na_1).         const(na_1).
m_tag(node60_14, rr__4__________).         const(rr__4__________).
m_tag0(node60_14,'r'). const('r'). m_tag1(node60_14,'r'). const('r'). m_tag4(node60_14,'4'). const('4'). 
%%%%%%%% node60_15 %%%%%%%%%%%%%%%%%%%
node(node60_15).
a_afun(node60_15, adv).         const(adv).
m_form(node60_15, zakladnu).         const(zakladnu).
m_lemma(node60_15, zakladna).         const(zakladna).
m_tag(node60_15, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node60_15,'n'). const('n'). m_tag1(node60_15,'n'). const('n'). m_tag2(node60_15,'f'). const('f'). m_tag3(node60_15,'s'). const('s'). m_tag4(node60_15,'4'). const('4'). m_tag10(node60_15,'a'). const('a'). 
%%%%%%%% node60_16 %%%%%%%%%%%%%%%%%%%
node(node60_16).
a_afun(node60_16, coord).         const(coord).
m_form(node60_16, a).         const(a).
m_lemma(node60_16, a_1).         const(a_1).
m_tag(node60_16, j______________).         const(j______________).
m_tag0(node60_16,'j'). const('j'). m_tag1(node60_16,'^'). const('^'). 
%%%%%%%% node60_17 %%%%%%%%%%%%%%%%%%%
node(node60_17).
functor(node60_17, pred).         const(pred).
gram_sempos(node60_17, v).         const(v).
id(node60_17, t_plzensky70827_txt_001_p1s11a11).         const(t_plzensky70827_txt_001_p1s11a11).
t_lemma(node60_17, vratit_se).         const(vratit_se).
%%%%%%%% node60_18 %%%%%%%%%%%%%%%%%%%
node(node60_18).
functor(node60_18, reg).         const(reg).
gram_sempos(node60_18, n_denot_neg).         const(n_denot_neg).
id(node60_18, t_plzensky70827_txt_001_p1s11a13).         const(t_plzensky70827_txt_001_p1s11a13).
t_lemma(node60_18, udalost).         const(udalost).
%%%%%%%% node60_19 %%%%%%%%%%%%%%%%%%%
node(node60_19).
a_afun(node60_19, auxp).         const(auxp).
m_form(node60_19, k).         const(k).
m_lemma(node60_19, k_1).         const(k_1).
m_tag(node60_19, rr__3__________).         const(rr__3__________).
m_tag0(node60_19,'r'). const('r'). m_tag1(node60_19,'r'). const('r'). m_tag4(node60_19,'3'). const('3'). 
%%%%%%%% node60_20 %%%%%%%%%%%%%%%%%%%
node(node60_20).
a_afun(node60_20, adv).         const(adv).
m_form(node60_20, udalosti).         const(udalosti).
m_lemma(node60_20, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node60_20, nnfs3_____a____).         const(nnfs3_____a____).
m_tag0(node60_20,'n'). const('n'). m_tag1(node60_20,'n'). const('n'). m_tag2(node60_20,'f'). const('f'). m_tag3(node60_20,'s'). const('s'). m_tag4(node60_20,'3'). const('3'). m_tag10(node60_20,'a'). const('a'). 
%%%%%%%% node60_21 %%%%%%%%%%%%%%%%%%%
node(node60_21).
a_afun(node60_21, auxt).         const(auxt).
m_form(node60_21, se).         const(se).
m_lemma(node60_21, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node60_21, p7_x4__________).         const(p7_x4__________).
m_tag0(node60_21,'p'). const('p'). m_tag1(node60_21,'7'). const('7'). m_tag3(node60_21,'x'). const('x'). m_tag4(node60_21,'4'). const('4'). 
%%%%%%%% node60_22 %%%%%%%%%%%%%%%%%%%
node(node60_22).
a_afun(node60_22, pred).         const(pred).
m_form(node60_22, vrati).         const(vrati).
m_lemma(node60_22, vratit__w).         const(vratit__w).
m_tag(node60_22, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node60_22,'v'). const('v'). m_tag1(node60_22,'b'). const('b'). m_tag3(node60_22,'s'). const('s'). m_tag7(node60_22,'3'). const('3'). m_tag8(node60_22,'p'). const('p'). m_tag10(node60_22,'a'). const('a'). m_tag11(node60_22,'a'). const('a'). 
%%%%%%%% node60_23 %%%%%%%%%%%%%%%%%%%
node(node60_23).
functor(node60_23, twhen).         const(twhen).
gram_sempos(node60_23, n_denot_neg).         const(n_denot_neg).
id(node60_23, t_plzensky70827_txt_001_p1s11a16).         const(t_plzensky70827_txt_001_p1s11a16).
t_lemma(node60_23, ukonceni).         const(ukonceni).
%%%%%%%% node60_24 %%%%%%%%%%%%%%%%%%%
node(node60_24).
functor(node60_24, act).         const(act).
id(node60_24, t_plzensky70827_txt_001_p1s11a20).         const(t_plzensky70827_txt_001_p1s11a20).
t_lemma(node60_24, x_gen).         const(x_gen).
%%%%%%%% node60_25 %%%%%%%%%%%%%%%%%%%
node(node60_25).
a_afun(node60_25, auxp).         const(auxp).
m_form(node60_25, po).         const(po).
m_lemma(node60_25, po_1).         const(po_1).
m_tag(node60_25, rr__6__________).         const(rr__6__________).
m_tag0(node60_25,'r'). const('r'). m_tag1(node60_25,'r'). const('r'). m_tag4(node60_25,'6'). const('6'). 
%%%%%%%% node60_26 %%%%%%%%%%%%%%%%%%%
node(node60_26).
a_afun(node60_26, adv).         const(adv).
m_form(node60_26, ukonceni).         const(ukonceni).
m_lemma(node60_26, ukonceni____3it_).         const(ukonceni____3it_).
m_tag(node60_26, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node60_26,'n'). const('n'). m_tag1(node60_26,'n'). const('n'). m_tag2(node60_26,'n'). const('n'). m_tag3(node60_26,'s'). const('s'). m_tag4(node60_26,'6'). const('6'). m_tag10(node60_26,'a'). const('a'). 
%%%%%%%% node60_27 %%%%%%%%%%%%%%%%%%%
node(node60_27).
functor(node60_27, pat).         const(pat).
gram_sempos(node60_27, n_denot).         const(n_denot).
id(node60_27, t_plzensky70827_txt_001_p1s11a17).         const(t_plzensky70827_txt_001_p1s11a17).
t_lemma(node60_27, prace).         const(prace).
%%%%%%%% node60_28 %%%%%%%%%%%%%%%%%%%
node(node60_28).
a_afun(node60_28, atr).         const(atr).
m_form(node60_28, prace).         const(prace).
m_lemma(node60_28, prace___jako_cinnost_i_misto_).         const(prace___jako_cinnost_i_misto_).
m_tag(node60_28, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node60_28,'n'). const('n'). m_tag1(node60_28,'n'). const('n'). m_tag2(node60_28,'f'). const('f'). m_tag3(node60_28,'s'). const('s'). m_tag4(node60_28,'2'). const('2'). m_tag10(node60_28,'a'). const('a'). 
%%%%%%%% node60_29 %%%%%%%%%%%%%%%%%%%
node(node60_29).
functor(node60_29, act).         const(act).
gram_sempos(node60_29, n_denot).         const(n_denot).
id(node60_29, t_plzensky70827_txt_001_p1s11a18).         const(t_plzensky70827_txt_001_p1s11a18).
t_lemma(node60_29, policie).         const(policie).
%%%%%%%% node60_30 %%%%%%%%%%%%%%%%%%%
node(node60_30).
a_afun(node60_30, atr).         const(atr).
m_form(node60_30, policie).         const(policie).
m_lemma(node60_30, policie).         const(policie).
m_tag(node60_30, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node60_30,'n'). const('n'). m_tag1(node60_30,'n'). const('n'). m_tag2(node60_30,'f'). const('f'). m_tag3(node60_30,'s'). const('s'). m_tag4(node60_30,'2'). const('2'). m_tag10(node60_30,'a'). const('a'). 
%%%%%%%% node60_31 %%%%%%%%%%%%%%%%%%%
node(node60_31).
functor(node60_31, app).         const(app).
gram_sempos(node60_31, n_denot).         const(n_denot).
id(node60_31, t_plzensky70827_txt_001_p1s11a19).         const(t_plzensky70827_txt_001_p1s11a19).
t_lemma(node60_31, cr).         const(cr).
%%%%%%%% node60_32 %%%%%%%%%%%%%%%%%%%
node(node60_32).
a_afun(node60_32, atr).         const(atr).
m_form(node60_32, cr).         const(cr).
m_lemma(node60_32, cr_1__b__g___ceska_republika_).         const(cr_1__b__g___ceska_republika_).
m_tag(node60_32, nnfxx_____a___8).         const(nnfxx_____a___8).
m_tag0(node60_32,'n'). const('n'). m_tag1(node60_32,'n'). const('n'). m_tag2(node60_32,'f'). const('f'). m_tag3(node60_32,'x'). const('x'). m_tag4(node60_32,'x'). const('x'). m_tag10(node60_32,'a'). const('a'). m_tag14(node60_32,'8'). const('8'). 
edge(node60_0, node60_1).
edge(node60_1, node60_2).
edge(node60_2, node60_3).
edge(node60_1, node60_4).
edge(node60_4, node60_5).
edge(node60_5, node60_6).
edge(node60_5, node60_7).
edge(node60_5, node60_8).
edge(node60_8, node60_9).
edge(node60_8, node60_10).
edge(node60_4, node60_11).
edge(node60_4, node60_12).
edge(node60_4, node60_13).
edge(node60_13, node60_14).
edge(node60_13, node60_15).
edge(node60_1, node60_16).
edge(node60_1, node60_17).
edge(node60_17, node60_18).
edge(node60_18, node60_19).
edge(node60_18, node60_20).
edge(node60_17, node60_21).
edge(node60_17, node60_22).
edge(node60_17, node60_23).
edge(node60_23, node60_24).
edge(node60_23, node60_25).
edge(node60_23, node60_26).
edge(node60_23, node60_27).
edge(node60_27, node60_28).
edge(node60_27, node60_29).
edge(node60_29, node60_30).
edge(node60_29, node60_31).
edge(node60_31, node60_32).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ceka je asistence odtahove sluzbe a odstraneni nasledku nehody. 
tree_root(node61_0).
:- %%%%%%%% node61_0 %%%%%%%%%%%%%%%%%%%
node(node61_0).
id(node61_0, t_plzensky70827_txt_001_p1s12).         const(t_plzensky70827_txt_001_p1s12).
%%%%%%%% node61_1 %%%%%%%%%%%%%%%%%%%
node(node61_1).
functor(node61_1, pred).         const(pred).
gram_sempos(node61_1, v).         const(v).
id(node61_1, t_plzensky70827_txt_001_p1s12a1).         const(t_plzensky70827_txt_001_p1s12a1).
t_lemma(node61_1, cekat).         const(cekat).
%%%%%%%% node61_2 %%%%%%%%%%%%%%%%%%%
node(node61_2).
functor(node61_2, act).         const(act).
gram_sempos(node61_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node61_2, t_plzensky70827_txt_001_p1s12a10).         const(t_plzensky70827_txt_001_p1s12a10).
t_lemma(node61_2, x_perspron).         const(x_perspron).
%%%%%%%% node61_3 %%%%%%%%%%%%%%%%%%%
node(node61_3).
a_afun(node61_3, pred).         const(pred).
m_form(node61_3, ceka).         const(ceka).
m_lemma(node61_3, cekat__t).         const(cekat__t).
m_tag(node61_3, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node61_3,'v'). const('v'). m_tag1(node61_3,'b'). const('b'). m_tag3(node61_3,'s'). const('s'). m_tag7(node61_3,'3'). const('3'). m_tag8(node61_3,'p'). const('p'). m_tag10(node61_3,'a'). const('a'). m_tag11(node61_3,'a'). const('a'). 
%%%%%%%% node61_4 %%%%%%%%%%%%%%%%%%%
node(node61_4).
functor(node61_4, pat).         const(pat).
gram_sempos(node61_4, n_pron_def_pers).         const(n_pron_def_pers).
id(node61_4, t_plzensky70827_txt_001_p1s12a2).         const(t_plzensky70827_txt_001_p1s12a2).
t_lemma(node61_4, x_perspron).         const(x_perspron).
%%%%%%%% node61_5 %%%%%%%%%%%%%%%%%%%
node(node61_5).
a_afun(node61_5, obj).         const(obj).
m_form(node61_5, je).         const(je).
m_lemma(node61_5, on_1___oni_ono_).         const(on_1___oni_ono_).
m_tag(node61_5, ppxp4__3_______).         const(ppxp4__3_______).
m_tag0(node61_5,'p'). const('p'). m_tag1(node61_5,'p'). const('p'). m_tag2(node61_5,'x'). const('x'). m_tag3(node61_5,'p'). const('p'). m_tag4(node61_5,'4'). const('4'). m_tag7(node61_5,'3'). const('3'). 
%%%%%%%% node61_6 %%%%%%%%%%%%%%%%%%%
node(node61_6).
functor(node61_6, conj).         const(conj).
id(node61_6, t_plzensky70827_txt_001_p1s12a3).         const(t_plzensky70827_txt_001_p1s12a3).
t_lemma(node61_6, a).         const(a).
%%%%%%%% node61_7 %%%%%%%%%%%%%%%%%%%
node(node61_7).
functor(node61_7, rstr).         const(rstr).
gram_sempos(node61_7, n_denot).         const(n_denot).
id(node61_7, t_plzensky70827_txt_001_p1s12a4).         const(t_plzensky70827_txt_001_p1s12a4).
t_lemma(node61_7, asistence).         const(asistence).
%%%%%%%% node61_8 %%%%%%%%%%%%%%%%%%%
node(node61_8).
a_afun(node61_8, obj).         const(obj).
m_form(node61_8, asistence).         const(asistence).
m_lemma(node61_8, asistence).         const(asistence).
m_tag(node61_8, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node61_8,'n'). const('n'). m_tag1(node61_8,'n'). const('n'). m_tag2(node61_8,'f'). const('f'). m_tag3(node61_8,'p'). const('p'). m_tag4(node61_8,'4'). const('4'). m_tag10(node61_8,'a'). const('a'). 
%%%%%%%% node61_9 %%%%%%%%%%%%%%%%%%%
node(node61_9).
functor(node61_9, loc).         const(loc).
gram_sempos(node61_9, adj_denot).         const(adj_denot).
id(node61_9, t_plzensky70827_txt_001_p1s12a6).         const(t_plzensky70827_txt_001_p1s12a6).
t_lemma(node61_9, odtahovy).         const(odtahovy).
%%%%%%%% node61_10 %%%%%%%%%%%%%%%%%%%
node(node61_10).
a_afun(node61_10, atr).         const(atr).
m_form(node61_10, odtahove).         const(odtahove).
m_lemma(node61_10, odtahovy).         const(odtahovy).
m_tag(node61_10, aafs6____1a____).         const(aafs6____1a____).
m_tag0(node61_10,'a'). const('a'). m_tag1(node61_10,'a'). const('a'). m_tag2(node61_10,'f'). const('f'). m_tag3(node61_10,'s'). const('s'). m_tag4(node61_10,'6'). const('6'). m_tag9(node61_10,'1'). const('1'). m_tag10(node61_10,'a'). const('a'). 
%%%%%%%% node61_11 %%%%%%%%%%%%%%%%%%%
node(node61_11).
a_afun(node61_11, auxp).         const(auxp).
m_form(node61_11, sluzbe).         const(sluzbe).
m_lemma(node61_11, sluzba).         const(sluzba).
m_tag(node61_11, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node61_11,'n'). const('n'). m_tag1(node61_11,'n'). const('n'). m_tag2(node61_11,'f'). const('f'). m_tag3(node61_11,'s'). const('s'). m_tag4(node61_11,'6'). const('6'). m_tag10(node61_11,'a'). const('a'). 
%%%%%%%% node61_12 %%%%%%%%%%%%%%%%%%%
node(node61_12).
a_afun(node61_12, coord).         const(coord).
m_form(node61_12, a).         const(a).
m_lemma(node61_12, a_1).         const(a_1).
m_tag(node61_12, j______________).         const(j______________).
m_tag0(node61_12,'j'). const('j'). m_tag1(node61_12,'^'). const('^'). 
%%%%%%%% node61_13 %%%%%%%%%%%%%%%%%%%
node(node61_13).
functor(node61_13, act).         const(act).
gram_sempos(node61_13, n_denot_neg).         const(n_denot_neg).
id(node61_13, t_plzensky70827_txt_001_p1s12a7).         const(t_plzensky70827_txt_001_p1s12a7).
t_lemma(node61_13, odstraneni).         const(odstraneni).
%%%%%%%% node61_14 %%%%%%%%%%%%%%%%%%%
node(node61_14).
functor(node61_14, act).         const(act).
id(node61_14, t_plzensky70827_txt_001_p1s12a11).         const(t_plzensky70827_txt_001_p1s12a11).
t_lemma(node61_14, x_gen).         const(x_gen).
%%%%%%%% node61_15 %%%%%%%%%%%%%%%%%%%
node(node61_15).
a_afun(node61_15, sb).         const(sb).
m_form(node61_15, odstraneni).         const(odstraneni).
m_lemma(node61_15, odstraneni____3it_).         const(odstraneni____3it_).
m_tag(node61_15, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node61_15,'n'). const('n'). m_tag1(node61_15,'n'). const('n'). m_tag2(node61_15,'n'). const('n'). m_tag3(node61_15,'s'). const('s'). m_tag4(node61_15,'1'). const('1'). m_tag10(node61_15,'a'). const('a'). 
%%%%%%%% node61_16 %%%%%%%%%%%%%%%%%%%
node(node61_16).
functor(node61_16, pat).         const(pat).
gram_sempos(node61_16, n_denot).         const(n_denot).
id(node61_16, t_plzensky70827_txt_001_p1s12a8).         const(t_plzensky70827_txt_001_p1s12a8).
t_lemma(node61_16, nasledek).         const(nasledek).
%%%%%%%% node61_17 %%%%%%%%%%%%%%%%%%%
node(node61_17).
a_afun(node61_17, atr).         const(atr).
m_form(node61_17, nasledku).         const(nasledku).
m_lemma(node61_17, nasledek).         const(nasledek).
m_tag(node61_17, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node61_17,'n'). const('n'). m_tag1(node61_17,'n'). const('n'). m_tag2(node61_17,'i'). const('i'). m_tag3(node61_17,'p'). const('p'). m_tag4(node61_17,'2'). const('2'). m_tag10(node61_17,'a'). const('a'). 
%%%%%%%% node61_18 %%%%%%%%%%%%%%%%%%%
node(node61_18).
functor(node61_18, app).         const(app).
gram_sempos(node61_18, n_denot).         const(n_denot).
id(node61_18, t_plzensky70827_txt_001_p1s12a9).         const(t_plzensky70827_txt_001_p1s12a9).
t_lemma(node61_18, nehoda).         const(nehoda).
%%%%%%%% node61_19 %%%%%%%%%%%%%%%%%%%
node(node61_19).
a_afun(node61_19, atr).         const(atr).
m_form(node61_19, nehody).         const(nehody).
m_lemma(node61_19, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node61_19, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node61_19,'n'). const('n'). m_tag1(node61_19,'n'). const('n'). m_tag2(node61_19,'f'). const('f'). m_tag3(node61_19,'s'). const('s'). m_tag4(node61_19,'2'). const('2'). m_tag10(node61_19,'a'). const('a'). 
edge(node61_0, node61_1).
edge(node61_1, node61_2).
edge(node61_1, node61_3).
edge(node61_1, node61_4).
edge(node61_4, node61_5).
edge(node61_1, node61_6).
edge(node61_6, node61_7).
edge(node61_7, node61_8).
edge(node61_7, node61_9).
edge(node61_9, node61_10).
edge(node61_9, node61_11).
edge(node61_6, node61_12).
edge(node61_6, node61_13).
edge(node61_13, node61_14).
edge(node61_13, node61_15).
edge(node61_13, node61_16).
edge(node61_16, node61_17).
edge(node61_16, node61_18).
edge(node61_18, node61_19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% jednalo se o v. rocnik souteze na tema "ochrana cloveka za mimoradnych udalosti" - "maly zachranar 2007". 
tree_root(node62_0).
:- %%%%%%%% node62_0 %%%%%%%%%%%%%%%%%%%
node(node62_0).
id(node62_0, t_plzensky51278_txt_001_p1s1).         const(t_plzensky51278_txt_001_p1s1).
%%%%%%%% node62_1 %%%%%%%%%%%%%%%%%%%
node(node62_1).
functor(node62_1, pred).         const(pred).
gram_sempos(node62_1, v).         const(v).
id(node62_1, t_plzensky51278_txt_001_p1s1a1).         const(t_plzensky51278_txt_001_p1s1a1).
t_lemma(node62_1, jednat_se).         const(jednat_se).
%%%%%%%% node62_2 %%%%%%%%%%%%%%%%%%%
node(node62_2).
functor(node62_2, pat).         const(pat).
id(node62_2, t_plzensky51278_txt_001_p1s1a23).         const(t_plzensky51278_txt_001_p1s1a23).
t_lemma(node62_2, x_gen).         const(x_gen).
%%%%%%%% node62_3 %%%%%%%%%%%%%%%%%%%
node(node62_3).
functor(node62_3, act).         const(act).
gram_sempos(node62_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node62_3, t_plzensky51278_txt_001_p1s1a22).         const(t_plzensky51278_txt_001_p1s1a22).
t_lemma(node62_3, x_perspron).         const(x_perspron).
%%%%%%%% node62_4 %%%%%%%%%%%%%%%%%%%
node(node62_4).
a_afun(node62_4, pred).         const(pred).
m_form(node62_4, jednalo).         const(jednalo).
m_lemma(node62_4, jednat__t).         const(jednat__t).
m_tag(node62_4, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node62_4,'v'). const('v'). m_tag1(node62_4,'p'). const('p'). m_tag2(node62_4,'n'). const('n'). m_tag3(node62_4,'s'). const('s'). m_tag7(node62_4,'x'). const('x'). m_tag8(node62_4,'r'). const('r'). m_tag10(node62_4,'a'). const('a'). m_tag11(node62_4,'a'). const('a'). 
%%%%%%%% node62_5 %%%%%%%%%%%%%%%%%%%
node(node62_5).
a_afun(node62_5, auxt).         const(auxt).
m_form(node62_5, se).         const(se).
m_lemma(node62_5, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node62_5, p7_x4__________).         const(p7_x4__________).
m_tag0(node62_5,'p'). const('p'). m_tag1(node62_5,'7'). const('7'). m_tag3(node62_5,'x'). const('x'). m_tag4(node62_5,'4'). const('4'). 
%%%%%%%% node62_6 %%%%%%%%%%%%%%%%%%%
node(node62_6).
functor(node62_6, par).         const(par).
gram_sempos(node62_6, n_denot).         const(n_denot).
id(node62_6, t_plzensky51278_txt_001_p1s1a4).         const(t_plzensky51278_txt_001_p1s1a4).
t_lemma(node62_6, rocnik).         const(rocnik).
%%%%%%%% node62_7 %%%%%%%%%%%%%%%%%%%
node(node62_7).
functor(node62_7, rstr).         const(rstr).
gram_sempos(node62_7, n_denot).         const(n_denot).
id(node62_7, t_plzensky51278_txt_001_p1s1a5).         const(t_plzensky51278_txt_001_p1s1a5).
t_lemma(node62_7, v).         const(v).
%%%%%%%% node62_8 %%%%%%%%%%%%%%%%%%%
node(node62_8).
a_afun(node62_8, atr).         const(atr).
m_form(node62_8, v).         const(v).
m_lemma(node62_8, v_0__b__y).         const(v_0__b__y).
m_tag(node62_8, nnmxx_____a___8).         const(nnmxx_____a___8).
m_tag0(node62_8,'n'). const('n'). m_tag1(node62_8,'n'). const('n'). m_tag2(node62_8,'m'). const('m'). m_tag3(node62_8,'x'). const('x'). m_tag4(node62_8,'x'). const('x'). m_tag10(node62_8,'a'). const('a'). m_tag14(node62_8,'8'). const('8'). 
%%%%%%%% node62_9 %%%%%%%%%%%%%%%%%%%
node(node62_9).
a_afun(node62_9, auxp).         const(auxp).
m_form(node62_9, o).         const(o).
m_lemma(node62_9, o_1).         const(o_1).
m_tag(node62_9, rr__4__________).         const(rr__4__________).
m_tag0(node62_9,'r'). const('r'). m_tag1(node62_9,'r'). const('r'). m_tag4(node62_9,'4'). const('4'). 
%%%%%%%% node62_10 %%%%%%%%%%%%%%%%%%%
node(node62_10).
a_afun(node62_10, adv).         const(adv).
m_form(node62_10, rocnik).         const(rocnik).
m_lemma(node62_10, rocnik).         const(rocnik).
m_tag(node62_10, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node62_10,'n'). const('n'). m_tag1(node62_10,'n'). const('n'). m_tag2(node62_10,'i'). const('i'). m_tag3(node62_10,'s'). const('s'). m_tag4(node62_10,'1'). const('1'). m_tag10(node62_10,'a'). const('a'). 
%%%%%%%% node62_11 %%%%%%%%%%%%%%%%%%%
node(node62_11).
functor(node62_11, app).         const(app).
gram_sempos(node62_11, n_denot).         const(n_denot).
id(node62_11, t_plzensky51278_txt_001_p1s1a7).         const(t_plzensky51278_txt_001_p1s1a7).
t_lemma(node62_11, soutez).         const(soutez).
%%%%%%%% node62_12 %%%%%%%%%%%%%%%%%%%
node(node62_12).
functor(node62_12, rstr).         const(rstr).
id(node62_12, t_plzensky51278_txt_001_p1s1a24).         const(t_plzensky51278_txt_001_p1s1a24).
t_lemma(node62_12, x_forn).         const(x_forn).
%%%%%%%% node62_13 %%%%%%%%%%%%%%%%%%%
node(node62_13).
a_afun(node62_13, atr).         const(atr).
m_form(node62_13, souteze).         const(souteze).
m_lemma(node62_13, soutez).         const(soutez).
m_tag(node62_13, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node62_13,'n'). const('n'). m_tag1(node62_13,'n'). const('n'). m_tag2(node62_13,'f'). const('f'). m_tag3(node62_13,'s'). const('s'). m_tag4(node62_13,'2'). const('2'). m_tag10(node62_13,'a'). const('a'). 
%%%%%%%% node62_14 %%%%%%%%%%%%%%%%%%%
node(node62_14).
functor(node62_14, conj).         const(conj).
id(node62_14, t_plzensky51278_txt_001_p1s1a10).         const(t_plzensky51278_txt_001_p1s1a10).
t_lemma(node62_14, x_dash).         const(x_dash).
%%%%%%%% node62_15 %%%%%%%%%%%%%%%%%%%
node(node62_15).
functor(node62_15, id).         const(id).
gram_sempos(node62_15, n_denot).         const(n_denot).
id(node62_15, t_plzensky51278_txt_001_p1s1a11).         const(t_plzensky51278_txt_001_p1s1a11).
t_lemma(node62_15, ochrana).         const(ochrana).
%%%%%%%% node62_16 %%%%%%%%%%%%%%%%%%%
node(node62_16).
a_afun(node62_16, atr).         const(atr).
m_form(node62_16, ochrana).         const(ochrana).
m_lemma(node62_16, ochrana).         const(ochrana).
m_tag(node62_16, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node62_16,'n'). const('n'). m_tag1(node62_16,'n'). const('n'). m_tag2(node62_16,'f'). const('f'). m_tag3(node62_16,'s'). const('s'). m_tag4(node62_16,'1'). const('1'). m_tag10(node62_16,'a'). const('a'). 
%%%%%%%% node62_17 %%%%%%%%%%%%%%%%%%%
node(node62_17).
functor(node62_17, pat).         const(pat).
gram_sempos(node62_17, n_denot).         const(n_denot).
id(node62_17, t_plzensky51278_txt_001_p1s1a13).         const(t_plzensky51278_txt_001_p1s1a13).
t_lemma(node62_17, clovek).         const(clovek).
%%%%%%%% node62_18 %%%%%%%%%%%%%%%%%%%
node(node62_18).
a_afun(node62_18, atr).         const(atr).
m_form(node62_18, cloveka).         const(cloveka).
m_lemma(node62_18, clovek).         const(clovek).
m_tag(node62_18, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node62_18,'n'). const('n'). m_tag1(node62_18,'n'). const('n'). m_tag2(node62_18,'m'). const('m'). m_tag3(node62_18,'s'). const('s'). m_tag4(node62_18,'2'). const('2'). m_tag10(node62_18,'a'). const('a'). 
%%%%%%%% node62_19 %%%%%%%%%%%%%%%%%%%
node(node62_19).
functor(node62_19, pat).         const(pat).
gram_sempos(node62_19, n_denot_neg).         const(n_denot_neg).
id(node62_19, t_plzensky51278_txt_001_p1s1a15).         const(t_plzensky51278_txt_001_p1s1a15).
t_lemma(node62_19, udalost).         const(udalost).
%%%%%%%% node62_20 %%%%%%%%%%%%%%%%%%%
node(node62_20).
functor(node62_20, rstr).         const(rstr).
gram_sempos(node62_20, adj_denot).         const(adj_denot).
id(node62_20, t_plzensky51278_txt_001_p1s1a16).         const(t_plzensky51278_txt_001_p1s1a16).
t_lemma(node62_20, mimoradny).         const(mimoradny).
%%%%%%%% node62_21 %%%%%%%%%%%%%%%%%%%
node(node62_21).
a_afun(node62_21, atr).         const(atr).
m_form(node62_21, mimoradnych).         const(mimoradnych).
m_lemma(node62_21, mimoradny).         const(mimoradny).
m_tag(node62_21, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node62_21,'a'). const('a'). m_tag1(node62_21,'a'). const('a'). m_tag2(node62_21,'f'). const('f'). m_tag3(node62_21,'p'). const('p'). m_tag4(node62_21,'2'). const('2'). m_tag9(node62_21,'1'). const('1'). m_tag10(node62_21,'a'). const('a'). 
%%%%%%%% node62_22 %%%%%%%%%%%%%%%%%%%
node(node62_22).
a_afun(node62_22, auxp).         const(auxp).
m_form(node62_22, za).         const(za).
m_lemma(node62_22, za_1).         const(za_1).
m_tag(node62_22, rr__4__________).         const(rr__4__________).
m_tag0(node62_22,'r'). const('r'). m_tag1(node62_22,'r'). const('r'). m_tag4(node62_22,'4'). const('4'). 
%%%%%%%% node62_23 %%%%%%%%%%%%%%%%%%%
node(node62_23).
a_afun(node62_23, atr).         const(atr).
m_form(node62_23, udalosti).         const(udalosti).
m_lemma(node62_23, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node62_23, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node62_23,'n'). const('n'). m_tag1(node62_23,'n'). const('n'). m_tag2(node62_23,'f'). const('f'). m_tag3(node62_23,'p'). const('p'). m_tag4(node62_23,'2'). const('2'). m_tag10(node62_23,'a'). const('a'). 
%%%%%%%% node62_24 %%%%%%%%%%%%%%%%%%%
node(node62_24).
a_afun(node62_24, coord).         const(coord).
m_form(node62_24, x_).         const(x_).
m_lemma(node62_24, x_).         const(x_).
m_tag(node62_24, z______________).         const(z______________).
m_tag0(node62_24,'z'). const('z'). m_tag1(node62_24,':'). const(':'). 
%%%%%%%% node62_25 %%%%%%%%%%%%%%%%%%%
node(node62_25).
functor(node62_25, id).         const(id).
gram_sempos(node62_25, n_denot).         const(n_denot).
id(node62_25, t_plzensky51278_txt_001_p1s1a18).         const(t_plzensky51278_txt_001_p1s1a18).
t_lemma(node62_25, zachranar).         const(zachranar).
%%%%%%%% node62_26 %%%%%%%%%%%%%%%%%%%
node(node62_26).
functor(node62_26, rstr).         const(rstr).
gram_sempos(node62_26, adj_denot).         const(adj_denot).
id(node62_26, t_plzensky51278_txt_001_p1s1a20).         const(t_plzensky51278_txt_001_p1s1a20).
t_lemma(node62_26, maly).         const(maly).
%%%%%%%% node62_27 %%%%%%%%%%%%%%%%%%%
node(node62_27).
a_afun(node62_27, atr).         const(atr).
m_form(node62_27, maly).         const(maly).
m_lemma(node62_27, maly).         const(maly).
m_tag(node62_27, aams1____1a____).         const(aams1____1a____).
m_tag0(node62_27,'a'). const('a'). m_tag1(node62_27,'a'). const('a'). m_tag2(node62_27,'m'). const('m'). m_tag3(node62_27,'s'). const('s'). m_tag4(node62_27,'1'). const('1'). m_tag9(node62_27,'1'). const('1'). m_tag10(node62_27,'a'). const('a'). 
%%%%%%%% node62_28 %%%%%%%%%%%%%%%%%%%
node(node62_28).
a_afun(node62_28, atr).         const(atr).
m_form(node62_28, zachranar).         const(zachranar).
m_lemma(node62_28, zachranar).         const(zachranar).
m_tag(node62_28, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node62_28,'n'). const('n'). m_tag1(node62_28,'n'). const('n'). m_tag2(node62_28,'m'). const('m'). m_tag3(node62_28,'s'). const('s'). m_tag4(node62_28,'1'). const('1'). m_tag10(node62_28,'a'). const('a'). 
%%%%%%%% node62_29 %%%%%%%%%%%%%%%%%%%
node(node62_29).
functor(node62_29, rstr).         const(rstr).
gram_sempos(node62_29, adj_quant_def).         const(adj_quant_def).
id(node62_29, t_plzensky51278_txt_001_p1s1a21).         const(t_plzensky51278_txt_001_p1s1a21).
t_lemma(node62_29, 2007).         const(2007).
%%%%%%%% node62_30 %%%%%%%%%%%%%%%%%%%
node(node62_30).
a_afun(node62_30, atr).         const(atr).
m_form(node62_30, 2007).         const(2007).
m_lemma(node62_30, 2007).         const(2007).
m_tag(node62_30, c=_____________).         const(c=_____________).
m_tag0(node62_30,'c'). const('c'). m_tag1(node62_30,'='). const('='). 
edge(node62_0, node62_1).
edge(node62_1, node62_2).
edge(node62_1, node62_3).
edge(node62_1, node62_4).
edge(node62_1, node62_5).
edge(node62_1, node62_6).
edge(node62_6, node62_7).
edge(node62_7, node62_8).
edge(node62_6, node62_9).
edge(node62_6, node62_10).
edge(node62_6, node62_11).
edge(node62_11, node62_12).
edge(node62_11, node62_13).
edge(node62_11, node62_14).
edge(node62_14, node62_15).
edge(node62_15, node62_16).
edge(node62_15, node62_17).
edge(node62_17, node62_18).
edge(node62_17, node62_19).
edge(node62_19, node62_20).
edge(node62_20, node62_21).
edge(node62_19, node62_22).
edge(node62_19, node62_23).
edge(node62_14, node62_24).
edge(node62_14, node62_25).
edge(node62_25, node62_26).
edge(node62_26, node62_27).
edge(node62_25, node62_28).
edge(node62_25, node62_29).
edge(node62_29, node62_30).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mistem konani byla centralni pozarni stanice plzen - kosutka. 
tree_root(node63_0).
:- %%%%%%%% node63_0 %%%%%%%%%%%%%%%%%%%
node(node63_0).
id(node63_0, t_plzensky51278_txt_001_p1s2).         const(t_plzensky51278_txt_001_p1s2).
%%%%%%%% node63_1 %%%%%%%%%%%%%%%%%%%
node(node63_1).
functor(node63_1, pred).         const(pred).
gram_sempos(node63_1, v).         const(v).
id(node63_1, t_plzensky51278_txt_001_p1s2a1).         const(t_plzensky51278_txt_001_p1s2a1).
t_lemma(node63_1, byt).         const(byt).
%%%%%%%% node63_2 %%%%%%%%%%%%%%%%%%%
node(node63_2).
functor(node63_2, pat).         const(pat).
gram_sempos(node63_2, n_denot).         const(n_denot).
id(node63_2, t_plzensky51278_txt_001_p1s2a2).         const(t_plzensky51278_txt_001_p1s2a2).
t_lemma(node63_2, misto).         const(misto).
%%%%%%%% node63_3 %%%%%%%%%%%%%%%%%%%
node(node63_3).
a_afun(node63_3, pnom).         const(pnom).
m_form(node63_3, mistem).         const(mistem).
m_lemma(node63_3, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node63_3, nnns7_____a____).         const(nnns7_____a____).
m_tag0(node63_3,'n'). const('n'). m_tag1(node63_3,'n'). const('n'). m_tag2(node63_3,'n'). const('n'). m_tag3(node63_3,'s'). const('s'). m_tag4(node63_3,'7'). const('7'). m_tag10(node63_3,'a'). const('a'). 
%%%%%%%% node63_4 %%%%%%%%%%%%%%%%%%%
node(node63_4).
functor(node63_4, app).         const(app).
gram_sempos(node63_4, n_denot_neg).         const(n_denot_neg).
id(node63_4, t_plzensky51278_txt_001_p1s2a3).         const(t_plzensky51278_txt_001_p1s2a3).
t_lemma(node63_4, konani).         const(konani).
%%%%%%%% node63_5 %%%%%%%%%%%%%%%%%%%
node(node63_5).
functor(node63_5, act).         const(act).
id(node63_5, t_plzensky51278_txt_001_p1s2a10).         const(t_plzensky51278_txt_001_p1s2a10).
t_lemma(node63_5, x_gen).         const(x_gen).
%%%%%%%% node63_6 %%%%%%%%%%%%%%%%%%%
node(node63_6).
a_afun(node63_6, atr).         const(atr).
m_form(node63_6, konani).         const(konani).
m_lemma(node63_6, konani____3at_).         const(konani____3at_).
m_tag(node63_6, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node63_6,'n'). const('n'). m_tag1(node63_6,'n'). const('n'). m_tag2(node63_6,'n'). const('n'). m_tag3(node63_6,'s'). const('s'). m_tag4(node63_6,'2'). const('2'). m_tag10(node63_6,'a'). const('a'). 
%%%%%%%% node63_7 %%%%%%%%%%%%%%%%%%%
node(node63_7).
a_afun(node63_7, pred).         const(pred).
m_form(node63_7, byla).         const(byla).
m_lemma(node63_7, byt).         const(byt).
m_tag(node63_7, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node63_7,'v'). const('v'). m_tag1(node63_7,'p'). const('p'). m_tag2(node63_7,'q'). const('q'). m_tag3(node63_7,'w'). const('w'). m_tag7(node63_7,'x'). const('x'). m_tag8(node63_7,'r'). const('r'). m_tag10(node63_7,'a'). const('a'). m_tag11(node63_7,'a'). const('a'). 
%%%%%%%% node63_8 %%%%%%%%%%%%%%%%%%%
node(node63_8).
functor(node63_8, act).         const(act).
gram_sempos(node63_8, n_denot).         const(n_denot).
id(node63_8, t_plzensky51278_txt_001_p1s2a4).         const(t_plzensky51278_txt_001_p1s2a4).
t_lemma(node63_8, stanice).         const(stanice).
%%%%%%%% node63_9 %%%%%%%%%%%%%%%%%%%
node(node63_9).
functor(node63_9, rstr).         const(rstr).
gram_sempos(node63_9, adj_denot).         const(adj_denot).
id(node63_9, t_plzensky51278_txt_001_p1s2a5).         const(t_plzensky51278_txt_001_p1s2a5).
t_lemma(node63_9, centralni).         const(centralni).
%%%%%%%% node63_10 %%%%%%%%%%%%%%%%%%%
node(node63_10).
a_afun(node63_10, atr).         const(atr).
m_form(node63_10, centralni).         const(centralni).
m_lemma(node63_10, centralni).         const(centralni).
m_tag(node63_10, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node63_10,'a'). const('a'). m_tag1(node63_10,'a'). const('a'). m_tag2(node63_10,'f'). const('f'). m_tag3(node63_10,'s'). const('s'). m_tag4(node63_10,'1'). const('1'). m_tag9(node63_10,'1'). const('1'). m_tag10(node63_10,'a'). const('a'). 
%%%%%%%% node63_11 %%%%%%%%%%%%%%%%%%%
node(node63_11).
functor(node63_11, rstr).         const(rstr).
gram_sempos(node63_11, adj_denot).         const(adj_denot).
id(node63_11, t_plzensky51278_txt_001_p1s2a6).         const(t_plzensky51278_txt_001_p1s2a6).
t_lemma(node63_11, pozarni).         const(pozarni).
%%%%%%%% node63_12 %%%%%%%%%%%%%%%%%%%
node(node63_12).
a_afun(node63_12, atr).         const(atr).
m_form(node63_12, pozarni).         const(pozarni).
m_lemma(node63_12, pozarni).         const(pozarni).
m_tag(node63_12, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node63_12,'a'). const('a'). m_tag1(node63_12,'a'). const('a'). m_tag2(node63_12,'f'). const('f'). m_tag3(node63_12,'s'). const('s'). m_tag4(node63_12,'1'). const('1'). m_tag9(node63_12,'1'). const('1'). m_tag10(node63_12,'a'). const('a'). 
%%%%%%%% node63_13 %%%%%%%%%%%%%%%%%%%
node(node63_13).
a_afun(node63_13, sb).         const(sb).
m_form(node63_13, stanice).         const(stanice).
m_lemma(node63_13, stanice).         const(stanice).
m_tag(node63_13, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node63_13,'n'). const('n'). m_tag1(node63_13,'n'). const('n'). m_tag2(node63_13,'f'). const('f'). m_tag3(node63_13,'s'). const('s'). m_tag4(node63_13,'1'). const('1'). m_tag10(node63_13,'a'). const('a'). 
%%%%%%%% node63_14 %%%%%%%%%%%%%%%%%%%
node(node63_14).
functor(node63_14, rstr).         const(rstr).
id(node63_14, t_plzensky51278_txt_001_p1s2a7).         const(t_plzensky51278_txt_001_p1s2a7).
t_lemma(node63_14, x_dash).         const(x_dash).
%%%%%%%% node63_15 %%%%%%%%%%%%%%%%%%%
node(node63_15).
functor(node63_15, rstr).         const(rstr).
gram_sempos(node63_15, n_denot).         const(n_denot).
id(node63_15, t_plzensky51278_txt_001_p1s2a8).         const(t_plzensky51278_txt_001_p1s2a8).
t_lemma(node63_15, plzen).         const(plzen).
%%%%%%%% node63_16 %%%%%%%%%%%%%%%%%%%
node(node63_16).
a_afun(node63_16, atr).         const(atr).
m_form(node63_16, plzen).         const(plzen).
m_lemma(node63_16, plzen__g).         const(plzen__g).
m_tag(node63_16, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node63_16,'n'). const('n'). m_tag1(node63_16,'n'). const('n'). m_tag2(node63_16,'f'). const('f'). m_tag3(node63_16,'s'). const('s'). m_tag4(node63_16,'1'). const('1'). m_tag10(node63_16,'a'). const('a'). 
%%%%%%%% node63_17 %%%%%%%%%%%%%%%%%%%
node(node63_17).
a_afun(node63_17, auxg).         const(auxg).
m_form(node63_17, x_).         const(x_).
m_lemma(node63_17, x_).         const(x_).
m_tag(node63_17, z______________).         const(z______________).
m_tag0(node63_17,'z'). const('z'). m_tag1(node63_17,':'). const(':'). 
%%%%%%%% node63_18 %%%%%%%%%%%%%%%%%%%
node(node63_18).
functor(node63_18, rstr).         const(rstr).
gram_sempos(node63_18, n_denot).         const(n_denot).
id(node63_18, t_plzensky51278_txt_001_p1s2a9).         const(t_plzensky51278_txt_001_p1s2a9).
t_lemma(node63_18, kosutka).         const(kosutka).
%%%%%%%% node63_19 %%%%%%%%%%%%%%%%%%%
node(node63_19).
a_afun(node63_19, atr).         const(atr).
m_form(node63_19, kosutka).         const(kosutka).
m_lemma(node63_19, kosutka).         const(kosutka).
m_tag(node63_19, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node63_19,'n'). const('n'). m_tag1(node63_19,'n'). const('n'). m_tag2(node63_19,'m'). const('m'). m_tag3(node63_19,'s'). const('s'). m_tag4(node63_19,'1'). const('1'). m_tag10(node63_19,'a'). const('a'). 
edge(node63_0, node63_1).
edge(node63_1, node63_2).
edge(node63_2, node63_3).
edge(node63_2, node63_4).
edge(node63_4, node63_5).
edge(node63_4, node63_6).
edge(node63_1, node63_7).
edge(node63_1, node63_8).
edge(node63_8, node63_9).
edge(node63_9, node63_10).
edge(node63_8, node63_11).
edge(node63_11, node63_12).
edge(node63_8, node63_13).
edge(node63_8, node63_14).
edge(node63_14, node63_15).
edge(node63_15, node63_16).
edge(node63_14, node63_17).
edge(node63_14, node63_18).
edge(node63_18, node63_19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% akce byla organizovana pro zakladni skoly a viceleta gymnazia z plzne a okoli. 
tree_root(node64_0).
:- %%%%%%%% node64_0 %%%%%%%%%%%%%%%%%%%
node(node64_0).
id(node64_0, t_plzensky51278_txt_001_p1s3).         const(t_plzensky51278_txt_001_p1s3).
%%%%%%%% node64_1 %%%%%%%%%%%%%%%%%%%
node(node64_1).
functor(node64_1, pred).         const(pred).
gram_sempos(node64_1, v).         const(v).
id(node64_1, t_plzensky51278_txt_001_p1s3a1).         const(t_plzensky51278_txt_001_p1s3a1).
t_lemma(node64_1, organizovat).         const(organizovat).
%%%%%%%% node64_2 %%%%%%%%%%%%%%%%%%%
node(node64_2).
functor(node64_2, act).         const(act).
id(node64_2, t_plzensky51278_txt_001_p1s3a14).         const(t_plzensky51278_txt_001_p1s3a14).
t_lemma(node64_2, x_gen).         const(x_gen).
%%%%%%%% node64_3 %%%%%%%%%%%%%%%%%%%
node(node64_3).
functor(node64_3, pat).         const(pat).
gram_sempos(node64_3, n_denot).         const(n_denot).
id(node64_3, t_plzensky51278_txt_001_p1s3a2).         const(t_plzensky51278_txt_001_p1s3a2).
t_lemma(node64_3, akce).         const(akce).
%%%%%%%% node64_4 %%%%%%%%%%%%%%%%%%%
node(node64_4).
a_afun(node64_4, sb).         const(sb).
m_form(node64_4, akce).         const(akce).
m_lemma(node64_4, akce).         const(akce).
m_tag(node64_4, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node64_4,'n'). const('n'). m_tag1(node64_4,'n'). const('n'). m_tag2(node64_4,'f'). const('f'). m_tag3(node64_4,'s'). const('s'). m_tag4(node64_4,'1'). const('1'). m_tag10(node64_4,'a'). const('a'). 
%%%%%%%% node64_5 %%%%%%%%%%%%%%%%%%%
node(node64_5).
a_afun(node64_5, auxv).         const(auxv).
m_form(node64_5, byla).         const(byla).
m_lemma(node64_5, byt).         const(byt).
m_tag(node64_5, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node64_5,'v'). const('v'). m_tag1(node64_5,'p'). const('p'). m_tag2(node64_5,'q'). const('q'). m_tag3(node64_5,'w'). const('w'). m_tag7(node64_5,'x'). const('x'). m_tag8(node64_5,'r'). const('r'). m_tag10(node64_5,'a'). const('a'). m_tag11(node64_5,'a'). const('a'). 
%%%%%%%% node64_6 %%%%%%%%%%%%%%%%%%%
node(node64_6).
a_afun(node64_6, pred).         const(pred).
m_form(node64_6, organizovana).         const(organizovana).
m_lemma(node64_6, organizovat__t__w).         const(organizovat__t__w).
m_tag(node64_6, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node64_6,'v'). const('v'). m_tag1(node64_6,'s'). const('s'). m_tag2(node64_6,'q'). const('q'). m_tag3(node64_6,'w'). const('w'). m_tag7(node64_6,'x'). const('x'). m_tag8(node64_6,'x'). const('x'). m_tag10(node64_6,'a'). const('a'). m_tag11(node64_6,'p'). const('p'). 
%%%%%%%% node64_7 %%%%%%%%%%%%%%%%%%%
node(node64_7).
functor(node64_7, conj).         const(conj).
id(node64_7, t_plzensky51278_txt_001_p1s3a5).         const(t_plzensky51278_txt_001_p1s3a5).
t_lemma(node64_7, a).         const(a).
%%%%%%%% node64_8 %%%%%%%%%%%%%%%%%%%
node(node64_8).
functor(node64_8, pat).         const(pat).
gram_sempos(node64_8, n_denot).         const(n_denot).
id(node64_8, t_plzensky51278_txt_001_p1s3a6).         const(t_plzensky51278_txt_001_p1s3a6).
t_lemma(node64_8, skola).         const(skola).
%%%%%%%% node64_9 %%%%%%%%%%%%%%%%%%%
node(node64_9).
functor(node64_9, rstr).         const(rstr).
gram_sempos(node64_9, adj_denot).         const(adj_denot).
id(node64_9, t_plzensky51278_txt_001_p1s3a7).         const(t_plzensky51278_txt_001_p1s3a7).
t_lemma(node64_9, zakladni).         const(zakladni).
%%%%%%%% node64_10 %%%%%%%%%%%%%%%%%%%
node(node64_10).
a_afun(node64_10, atr).         const(atr).
m_form(node64_10, zakladni).         const(zakladni).
m_lemma(node64_10, zakladni__s).         const(zakladni__s).
m_tag(node64_10, aafs4____1a____).         const(aafs4____1a____).
m_tag0(node64_10,'a'). const('a'). m_tag1(node64_10,'a'). const('a'). m_tag2(node64_10,'f'). const('f'). m_tag3(node64_10,'s'). const('s'). m_tag4(node64_10,'4'). const('4'). m_tag9(node64_10,'1'). const('1'). m_tag10(node64_10,'a'). const('a'). 
%%%%%%%% node64_11 %%%%%%%%%%%%%%%%%%%
node(node64_11).
a_afun(node64_11, adv).         const(adv).
m_form(node64_11, skoly).         const(skoly).
m_lemma(node64_11, skola).         const(skola).
m_tag(node64_11, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node64_11,'n'). const('n'). m_tag1(node64_11,'n'). const('n'). m_tag2(node64_11,'f'). const('f'). m_tag3(node64_11,'s'). const('s'). m_tag4(node64_11,'2'). const('2'). m_tag10(node64_11,'a'). const('a'). 
%%%%%%%% node64_12 %%%%%%%%%%%%%%%%%%%
node(node64_12).
a_afun(node64_12, coord).         const(coord).
m_form(node64_12, a).         const(a).
m_lemma(node64_12, a_1).         const(a_1).
m_tag(node64_12, j______________).         const(j______________).
m_tag0(node64_12,'j'). const('j'). m_tag1(node64_12,'^'). const('^'). 
%%%%%%%% node64_13 %%%%%%%%%%%%%%%%%%%
node(node64_13).
functor(node64_13, pat).         const(pat).
gram_sempos(node64_13, n_denot).         const(n_denot).
id(node64_13, t_plzensky51278_txt_001_p1s3a8).         const(t_plzensky51278_txt_001_p1s3a8).
t_lemma(node64_13, gymnazium).         const(gymnazium).
%%%%%%%% node64_14 %%%%%%%%%%%%%%%%%%%
node(node64_14).
functor(node64_14, rstr).         const(rstr).
gram_sempos(node64_14, adj_denot).         const(adj_denot).
id(node64_14, t_plzensky51278_txt_001_p1s3a9).         const(t_plzensky51278_txt_001_p1s3a9).
t_lemma(node64_14, vicelety).         const(vicelety).
%%%%%%%% node64_15 %%%%%%%%%%%%%%%%%%%
node(node64_15).
a_afun(node64_15, atr).         const(atr).
m_form(node64_15, viceleta).         const(viceleta).
m_lemma(node64_15, vicelety).         const(vicelety).
m_tag(node64_15, aanp1____1a____).         const(aanp1____1a____).
m_tag0(node64_15,'a'). const('a'). m_tag1(node64_15,'a'). const('a'). m_tag2(node64_15,'n'). const('n'). m_tag3(node64_15,'p'). const('p'). m_tag4(node64_15,'1'). const('1'). m_tag9(node64_15,'1'). const('1'). m_tag10(node64_15,'a'). const('a'). 
%%%%%%%% node64_16 %%%%%%%%%%%%%%%%%%%
node(node64_16).
a_afun(node64_16, sb).         const(sb).
m_form(node64_16, gymnazia).         const(gymnazia).
m_lemma(node64_16, gymnazium).         const(gymnazium).
m_tag(node64_16, nnnp1_____a____).         const(nnnp1_____a____).
m_tag0(node64_16,'n'). const('n'). m_tag1(node64_16,'n'). const('n'). m_tag2(node64_16,'n'). const('n'). m_tag3(node64_16,'p'). const('p'). m_tag4(node64_16,'1'). const('1'). m_tag10(node64_16,'a'). const('a'). 
%%%%%%%% node64_17 %%%%%%%%%%%%%%%%%%%
node(node64_17).
functor(node64_17, conj).         const(conj).
id(node64_17, t_plzensky51278_txt_001_p1s3a11).         const(t_plzensky51278_txt_001_p1s3a11).
t_lemma(node64_17, a).         const(a).
%%%%%%%% node64_18 %%%%%%%%%%%%%%%%%%%
node(node64_18).
functor(node64_18, pat).         const(pat).
gram_sempos(node64_18, n_denot).         const(n_denot).
id(node64_18, t_plzensky51278_txt_001_p1s3a12).         const(t_plzensky51278_txt_001_p1s3a12).
t_lemma(node64_18, plzen).         const(plzen).
%%%%%%%% node64_19 %%%%%%%%%%%%%%%%%%%
node(node64_19).
a_afun(node64_19, atr).         const(atr).
m_form(node64_19, plzne).         const(plzne).
m_lemma(node64_19, plzen__g).         const(plzen__g).
m_tag(node64_19, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node64_19,'n'). const('n'). m_tag1(node64_19,'n'). const('n'). m_tag2(node64_19,'f'). const('f'). m_tag3(node64_19,'s'). const('s'). m_tag4(node64_19,'2'). const('2'). m_tag10(node64_19,'a'). const('a'). 
%%%%%%%% node64_20 %%%%%%%%%%%%%%%%%%%
node(node64_20).
a_afun(node64_20, coord).         const(coord).
m_form(node64_20, a).         const(a).
m_lemma(node64_20, a_1).         const(a_1).
m_tag(node64_20, j______________).         const(j______________).
m_tag0(node64_20,'j'). const('j'). m_tag1(node64_20,'^'). const('^'). 
%%%%%%%% node64_21 %%%%%%%%%%%%%%%%%%%
node(node64_21).
functor(node64_21, pat).         const(pat).
gram_sempos(node64_21, n_denot).         const(n_denot).
id(node64_21, t_plzensky51278_txt_001_p1s3a13).         const(t_plzensky51278_txt_001_p1s3a13).
t_lemma(node64_21, okoli).         const(okoli).
%%%%%%%% node64_22 %%%%%%%%%%%%%%%%%%%
node(node64_22).
a_afun(node64_22, atr).         const(atr).
m_form(node64_22, okoli).         const(okoli).
m_lemma(node64_22, okoli).         const(okoli).
m_tag(node64_22, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node64_22,'n'). const('n'). m_tag1(node64_22,'n'). const('n'). m_tag2(node64_22,'n'). const('n'). m_tag3(node64_22,'s'). const('s'). m_tag4(node64_22,'2'). const('2'). m_tag10(node64_22,'a'). const('a'). 
edge(node64_0, node64_1).
edge(node64_1, node64_2).
edge(node64_1, node64_3).
edge(node64_3, node64_4).
edge(node64_1, node64_5).
edge(node64_1, node64_6).
edge(node64_1, node64_7).
edge(node64_7, node64_8).
edge(node64_8, node64_9).
edge(node64_9, node64_10).
edge(node64_8, node64_11).
edge(node64_7, node64_12).
edge(node64_7, node64_13).
edge(node64_13, node64_14).
edge(node64_14, node64_15).
edge(node64_13, node64_16).
edge(node64_13, node64_17).
edge(node64_17, node64_18).
edge(node64_18, node64_19).
edge(node64_17, node64_20).
edge(node64_17, node64_21).
edge(node64_21, node64_22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% soutezila ctyrclenna smisena druzstva, ktera budou u uplnych zakladnich skol tvorit dva zastupci ze 4. nebo 5. tridy a dva zastupci ze 6. nebo 7. tridy. 
tree_root(node65_0).
:- %%%%%%%% node65_0 %%%%%%%%%%%%%%%%%%%
node(node65_0).
id(node65_0, t_plzensky51278_txt_001_p1s4).         const(t_plzensky51278_txt_001_p1s4).
%%%%%%%% node65_1 %%%%%%%%%%%%%%%%%%%
node(node65_1).
functor(node65_1, pred).         const(pred).
gram_sempos(node65_1, v).         const(v).
id(node65_1, t_plzensky51278_txt_001_p1s4a1).         const(t_plzensky51278_txt_001_p1s4a1).
t_lemma(node65_1, soutezit).         const(soutezit).
%%%%%%%% node65_2 %%%%%%%%%%%%%%%%%%%
node(node65_2).
functor(node65_2, addr).         const(addr).
id(node65_2, t_plzensky51278_txt_001_p1s4a31).         const(t_plzensky51278_txt_001_p1s4a31).
t_lemma(node65_2, x_gen).         const(x_gen).
%%%%%%%% node65_3 %%%%%%%%%%%%%%%%%%%
node(node65_3).
a_afun(node65_3, pred).         const(pred).
m_form(node65_3, soutezila).         const(soutezila).
m_lemma(node65_3, soutezit__t).         const(soutezit__t).
m_tag(node65_3, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node65_3,'v'). const('v'). m_tag1(node65_3,'p'). const('p'). m_tag2(node65_3,'q'). const('q'). m_tag3(node65_3,'w'). const('w'). m_tag7(node65_3,'x'). const('x'). m_tag8(node65_3,'r'). const('r'). m_tag10(node65_3,'a'). const('a'). m_tag11(node65_3,'a'). const('a'). 
%%%%%%%% node65_4 %%%%%%%%%%%%%%%%%%%
node(node65_4).
functor(node65_4, act).         const(act).
gram_sempos(node65_4, n_denot).         const(n_denot).
id(node65_4, t_plzensky51278_txt_001_p1s4a2).         const(t_plzensky51278_txt_001_p1s4a2).
t_lemma(node65_4, druzstvo).         const(druzstvo).
%%%%%%%% node65_5 %%%%%%%%%%%%%%%%%%%
node(node65_5).
functor(node65_5, rstr).         const(rstr).
gram_sempos(node65_5, adj_denot).         const(adj_denot).
id(node65_5, t_plzensky51278_txt_001_p1s4a3).         const(t_plzensky51278_txt_001_p1s4a3).
t_lemma(node65_5, ctyrclenny).         const(ctyrclenny).
%%%%%%%% node65_6 %%%%%%%%%%%%%%%%%%%
node(node65_6).
a_afun(node65_6, atr).         const(atr).
m_form(node65_6, ctyrclenna).         const(ctyrclenna).
m_lemma(node65_6, ctyrclenny).         const(ctyrclenny).
m_tag(node65_6, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node65_6,'a'). const('a'). m_tag1(node65_6,'a'). const('a'). m_tag2(node65_6,'f'). const('f'). m_tag3(node65_6,'s'). const('s'). m_tag4(node65_6,'1'). const('1'). m_tag9(node65_6,'1'). const('1'). m_tag10(node65_6,'a'). const('a'). 
%%%%%%%% node65_7 %%%%%%%%%%%%%%%%%%%
node(node65_7).
functor(node65_7, rstr).         const(rstr).
gram_sempos(node65_7, adj_denot).         const(adj_denot).
id(node65_7, t_plzensky51278_txt_001_p1s4a4).         const(t_plzensky51278_txt_001_p1s4a4).
t_lemma(node65_7, smiseny).         const(smiseny).
%%%%%%%% node65_8 %%%%%%%%%%%%%%%%%%%
node(node65_8).
a_afun(node65_8, atr).         const(atr).
m_form(node65_8, smisena).         const(smisena).
m_lemma(node65_8, smiseny____4sit_).         const(smiseny____4sit_).
m_tag(node65_8, aanp1____1a____).         const(aanp1____1a____).
m_tag0(node65_8,'a'). const('a'). m_tag1(node65_8,'a'). const('a'). m_tag2(node65_8,'n'). const('n'). m_tag3(node65_8,'p'). const('p'). m_tag4(node65_8,'1'). const('1'). m_tag9(node65_8,'1'). const('1'). m_tag10(node65_8,'a'). const('a'). 
%%%%%%%% node65_9 %%%%%%%%%%%%%%%%%%%
node(node65_9).
a_afun(node65_9, sb).         const(sb).
m_form(node65_9, druzstva).         const(druzstva).
m_lemma(node65_9, druzstvo).         const(druzstvo).
m_tag(node65_9, nnnp1_____a____).         const(nnnp1_____a____).
m_tag0(node65_9,'n'). const('n'). m_tag1(node65_9,'n'). const('n'). m_tag2(node65_9,'n'). const('n'). m_tag3(node65_9,'p'). const('p'). m_tag4(node65_9,'1'). const('1'). m_tag10(node65_9,'a'). const('a'). 
%%%%%%%% node65_10 %%%%%%%%%%%%%%%%%%%
node(node65_10).
functor(node65_10, pat).         const(pat).
gram_sempos(node65_10, v).         const(v).
id(node65_10, t_plzensky51278_txt_001_p1s4a5).         const(t_plzensky51278_txt_001_p1s4a5).
t_lemma(node65_10, tvorit).         const(tvorit).
%%%%%%%% node65_11 %%%%%%%%%%%%%%%%%%%
node(node65_11).
functor(node65_11, act).         const(act).
gram_sempos(node65_11, n_pron_indef).         const(n_pron_indef).
id(node65_11, t_plzensky51278_txt_001_p1s4a7).         const(t_plzensky51278_txt_001_p1s4a7).
t_lemma(node65_11, ktery).         const(ktery).
%%%%%%%% node65_12 %%%%%%%%%%%%%%%%%%%
node(node65_12).
a_afun(node65_12, sb).         const(sb).
m_form(node65_12, ktera).         const(ktera).
m_lemma(node65_12, ktery).         const(ktery).
m_tag(node65_12, p4np1__________).         const(p4np1__________).
m_tag0(node65_12,'p'). const('p'). m_tag1(node65_12,'4'). const('4'). m_tag2(node65_12,'n'). const('n'). m_tag3(node65_12,'p'). const('p'). m_tag4(node65_12,'1'). const('1'). 
%%%%%%%% node65_13 %%%%%%%%%%%%%%%%%%%
node(node65_13).
functor(node65_13, loc).         const(loc).
gram_sempos(node65_13, n_denot).         const(n_denot).
id(node65_13, t_plzensky51278_txt_001_p1s4a10).         const(t_plzensky51278_txt_001_p1s4a10).
t_lemma(node65_13, skola).         const(skola).
%%%%%%%% node65_14 %%%%%%%%%%%%%%%%%%%
node(node65_14).
functor(node65_14, rstr).         const(rstr).
gram_sempos(node65_14, adj_denot).         const(adj_denot).
id(node65_14, t_plzensky51278_txt_001_p1s4a11).         const(t_plzensky51278_txt_001_p1s4a11).
t_lemma(node65_14, uplny).         const(uplny).
%%%%%%%% node65_15 %%%%%%%%%%%%%%%%%%%
node(node65_15).
a_afun(node65_15, atr).         const(atr).
m_form(node65_15, uplnych).         const(uplnych).
m_lemma(node65_15, uplny).         const(uplny).
m_tag(node65_15, aanp2____1a____).         const(aanp2____1a____).
m_tag0(node65_15,'a'). const('a'). m_tag1(node65_15,'a'). const('a'). m_tag2(node65_15,'n'). const('n'). m_tag3(node65_15,'p'). const('p'). m_tag4(node65_15,'2'). const('2'). m_tag9(node65_15,'1'). const('1'). m_tag10(node65_15,'a'). const('a'). 
%%%%%%%% node65_16 %%%%%%%%%%%%%%%%%%%
node(node65_16).
functor(node65_16, rstr).         const(rstr).
gram_sempos(node65_16, adj_denot).         const(adj_denot).
id(node65_16, t_plzensky51278_txt_001_p1s4a12).         const(t_plzensky51278_txt_001_p1s4a12).
t_lemma(node65_16, zakladni).         const(zakladni).
%%%%%%%% node65_17 %%%%%%%%%%%%%%%%%%%
node(node65_17).
a_afun(node65_17, atr).         const(atr).
m_form(node65_17, zakladnich).         const(zakladnich).
m_lemma(node65_17, zakladni).         const(zakladni).
m_tag(node65_17, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node65_17,'a'). const('a'). m_tag1(node65_17,'a'). const('a'). m_tag2(node65_17,'f'). const('f'). m_tag3(node65_17,'p'). const('p'). m_tag4(node65_17,'2'). const('2'). m_tag9(node65_17,'1'). const('1'). m_tag10(node65_17,'a'). const('a'). 
%%%%%%%% node65_18 %%%%%%%%%%%%%%%%%%%
node(node65_18).
a_afun(node65_18, auxp).         const(auxp).
m_form(node65_18, u).         const(u).
m_lemma(node65_18, u_1).         const(u_1).
m_tag(node65_18, rr__2__________).         const(rr__2__________).
m_tag0(node65_18,'r'). const('r'). m_tag1(node65_18,'r'). const('r'). m_tag4(node65_18,'2'). const('2'). 
%%%%%%%% node65_19 %%%%%%%%%%%%%%%%%%%
node(node65_19).
a_afun(node65_19, adv).         const(adv).
m_form(node65_19, skol).         const(skol).
m_lemma(node65_19, skola).         const(skola).
m_tag(node65_19, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node65_19,'n'). const('n'). m_tag1(node65_19,'n'). const('n'). m_tag2(node65_19,'f'). const('f'). m_tag3(node65_19,'p'). const('p'). m_tag4(node65_19,'2'). const('2'). m_tag10(node65_19,'a'). const('a'). 
%%%%%%%% node65_20 %%%%%%%%%%%%%%%%%%%
node(node65_20).
a_afun(node65_20, auxv).         const(auxv).
m_form(node65_20, budou).         const(budou).
m_lemma(node65_20, byt).         const(byt).
m_tag(node65_20, vb_p___3f_aa___).         const(vb_p___3f_aa___).
m_tag0(node65_20,'v'). const('v'). m_tag1(node65_20,'b'). const('b'). m_tag3(node65_20,'p'). const('p'). m_tag7(node65_20,'3'). const('3'). m_tag8(node65_20,'f'). const('f'). m_tag10(node65_20,'a'). const('a'). m_tag11(node65_20,'a'). const('a'). 
%%%%%%%% node65_21 %%%%%%%%%%%%%%%%%%%
node(node65_21).
a_afun(node65_21, atr).         const(atr).
m_form(node65_21, tvorit).         const(tvorit).
m_lemma(node65_21, tvorit__t).         const(tvorit__t).
m_tag(node65_21, vf________a____).         const(vf________a____).
m_tag0(node65_21,'v'). const('v'). m_tag1(node65_21,'f'). const('f'). m_tag10(node65_21,'a'). const('a'). 
%%%%%%%% node65_22 %%%%%%%%%%%%%%%%%%%
node(node65_22).
functor(node65_22, conj).         const(conj).
id(node65_22, t_plzensky51278_txt_001_p1s4a13).         const(t_plzensky51278_txt_001_p1s4a13).
t_lemma(node65_22, a).         const(a).
%%%%%%%% node65_23 %%%%%%%%%%%%%%%%%%%
node(node65_23).
functor(node65_23, act).         const(act).
gram_sempos(node65_23, n_denot).         const(n_denot).
id(node65_23, t_plzensky51278_txt_001_p1s4a14).         const(t_plzensky51278_txt_001_p1s4a14).
t_lemma(node65_23, zastupce).         const(zastupce).
%%%%%%%% node65_24 %%%%%%%%%%%%%%%%%%%
node(node65_24).
functor(node65_24, rstr).         const(rstr).
gram_sempos(node65_24, adj_quant_def).         const(adj_quant_def).
id(node65_24, t_plzensky51278_txt_001_p1s4a15).         const(t_plzensky51278_txt_001_p1s4a15).
t_lemma(node65_24, dva).         const(dva).
%%%%%%%% node65_25 %%%%%%%%%%%%%%%%%%%
node(node65_25).
a_afun(node65_25, atr).         const(atr).
m_form(node65_25, dva).         const(dva).
m_lemma(node65_25, dva_2).         const(dva_2).
m_tag(node65_25, clyp4__________).         const(clyp4__________).
m_tag0(node65_25,'c'). const('c'). m_tag1(node65_25,'l'). const('l'). m_tag2(node65_25,'y'). const('y'). m_tag3(node65_25,'p'). const('p'). m_tag4(node65_25,'4'). const('4'). 
%%%%%%%% node65_26 %%%%%%%%%%%%%%%%%%%
node(node65_26).
a_afun(node65_26, sb).         const(sb).
m_form(node65_26, zastupci).         const(zastupci).
m_lemma(node65_26, zastupce).         const(zastupce).
m_tag(node65_26, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node65_26,'n'). const('n'). m_tag1(node65_26,'n'). const('n'). m_tag2(node65_26,'m'). const('m'). m_tag3(node65_26,'p'). const('p'). m_tag4(node65_26,'1'). const('1'). m_tag10(node65_26,'a'). const('a'). 
%%%%%%%% node65_27 %%%%%%%%%%%%%%%%%%%
node(node65_27).
functor(node65_27, dir1).         const(dir1).
gram_sempos(node65_27, n_denot).         const(n_denot).
id(node65_27, t_plzensky51278_txt_001_p1s4a17).         const(t_plzensky51278_txt_001_p1s4a17).
t_lemma(node65_27, trida).         const(trida).
%%%%%%%% node65_28 %%%%%%%%%%%%%%%%%%%
node(node65_28).
functor(node65_28, disj).         const(disj).
id(node65_28, t_plzensky51278_txt_001_p1s4a18).         const(t_plzensky51278_txt_001_p1s4a18).
t_lemma(node65_28, nebo).         const(nebo).
%%%%%%%% node65_29 %%%%%%%%%%%%%%%%%%%
node(node65_29).
functor(node65_29, rstr).         const(rstr).
gram_sempos(node65_29, adj_quant_def).         const(adj_quant_def).
id(node65_29, t_plzensky51278_txt_001_p1s4a19).         const(t_plzensky51278_txt_001_p1s4a19).
t_lemma(node65_29, 4).         const(4).
%%%%%%%% node65_30 %%%%%%%%%%%%%%%%%%%
node(node65_30).
a_afun(node65_30, atr).         const(atr).
m_form(node65_30, 4).         const(4).
m_lemma(node65_30, 4).         const(4).
m_tag(node65_30, c=_____________).         const(c=_____________).
m_tag0(node65_30,'c'). const('c'). m_tag1(node65_30,'='). const('='). 
%%%%%%%% node65_31 %%%%%%%%%%%%%%%%%%%
node(node65_31).
a_afun(node65_31, coord).         const(coord).
m_form(node65_31, nebo).         const(nebo).
m_lemma(node65_31, nebo).         const(nebo).
m_tag(node65_31, j______________).         const(j______________).
m_tag0(node65_31,'j'). const('j'). m_tag1(node65_31,'^'). const('^'). 
%%%%%%%% node65_32 %%%%%%%%%%%%%%%%%%%
node(node65_32).
functor(node65_32, rstr).         const(rstr).
gram_sempos(node65_32, adj_quant_def).         const(adj_quant_def).
id(node65_32, t_plzensky51278_txt_001_p1s4a21).         const(t_plzensky51278_txt_001_p1s4a21).
t_lemma(node65_32, 5).         const(5).
%%%%%%%% node65_33 %%%%%%%%%%%%%%%%%%%
node(node65_33).
a_afun(node65_33, atr).         const(atr).
m_form(node65_33, 5).         const(5).
m_lemma(node65_33, 5).         const(5).
m_tag(node65_33, c=_____________).         const(c=_____________).
m_tag0(node65_33,'c'). const('c'). m_tag1(node65_33,'='). const('='). 
%%%%%%%% node65_34 %%%%%%%%%%%%%%%%%%%
node(node65_34).
a_afun(node65_34, auxp).         const(auxp).
m_form(node65_34, ze).         const(ze).
m_lemma(node65_34, z_1).         const(z_1).
m_tag(node65_34, rv__2__________).         const(rv__2__________).
m_tag0(node65_34,'r'). const('r'). m_tag1(node65_34,'v'). const('v'). m_tag4(node65_34,'2'). const('2'). 
%%%%%%%% node65_35 %%%%%%%%%%%%%%%%%%%
node(node65_35).
a_afun(node65_35, atr).         const(atr).
m_form(node65_35, tridy).         const(tridy).
m_lemma(node65_35, trida).         const(trida).
m_tag(node65_35, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node65_35,'n'). const('n'). m_tag1(node65_35,'n'). const('n'). m_tag2(node65_35,'f'). const('f'). m_tag3(node65_35,'s'). const('s'). m_tag4(node65_35,'2'). const('2'). m_tag10(node65_35,'a'). const('a'). 
%%%%%%%% node65_36 %%%%%%%%%%%%%%%%%%%
node(node65_36).
a_afun(node65_36, coord).         const(coord).
m_form(node65_36, a).         const(a).
m_lemma(node65_36, a_1).         const(a_1).
m_tag(node65_36, j______________).         const(j______________).
m_tag0(node65_36,'j'). const('j'). m_tag1(node65_36,'^'). const('^'). 
%%%%%%%% node65_37 %%%%%%%%%%%%%%%%%%%
node(node65_37).
functor(node65_37, act).         const(act).
gram_sempos(node65_37, n_denot).         const(n_denot).
id(node65_37, t_plzensky51278_txt_001_p1s4a23).         const(t_plzensky51278_txt_001_p1s4a23).
t_lemma(node65_37, zastupce).         const(zastupce).
%%%%%%%% node65_38 %%%%%%%%%%%%%%%%%%%
node(node65_38).
functor(node65_38, rstr).         const(rstr).
gram_sempos(node65_38, adj_quant_def).         const(adj_quant_def).
id(node65_38, t_plzensky51278_txt_001_p1s4a24).         const(t_plzensky51278_txt_001_p1s4a24).
t_lemma(node65_38, dva).         const(dva).
%%%%%%%% node65_39 %%%%%%%%%%%%%%%%%%%
node(node65_39).
a_afun(node65_39, atr).         const(atr).
m_form(node65_39, dva).         const(dva).
m_lemma(node65_39, dva_2).         const(dva_2).
m_tag(node65_39, clyp1__________).         const(clyp1__________).
m_tag0(node65_39,'c'). const('c'). m_tag1(node65_39,'l'). const('l'). m_tag2(node65_39,'y'). const('y'). m_tag3(node65_39,'p'). const('p'). m_tag4(node65_39,'1'). const('1'). 
%%%%%%%% node65_40 %%%%%%%%%%%%%%%%%%%
node(node65_40).
a_afun(node65_40, sb).         const(sb).
m_form(node65_40, zastupci).         const(zastupci).
m_lemma(node65_40, zastupce).         const(zastupce).
m_tag(node65_40, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node65_40,'n'). const('n'). m_tag1(node65_40,'n'). const('n'). m_tag2(node65_40,'m'). const('m'). m_tag3(node65_40,'p'). const('p'). m_tag4(node65_40,'1'). const('1'). m_tag10(node65_40,'a'). const('a'). 
%%%%%%%% node65_41 %%%%%%%%%%%%%%%%%%%
node(node65_41).
functor(node65_41, dir1).         const(dir1).
gram_sempos(node65_41, n_denot).         const(n_denot).
id(node65_41, t_plzensky51278_txt_001_p1s4a26).         const(t_plzensky51278_txt_001_p1s4a26).
t_lemma(node65_41, trida).         const(trida).
%%%%%%%% node65_42 %%%%%%%%%%%%%%%%%%%
node(node65_42).
functor(node65_42, disj).         const(disj).
id(node65_42, t_plzensky51278_txt_001_p1s4a27).         const(t_plzensky51278_txt_001_p1s4a27).
t_lemma(node65_42, nebo).         const(nebo).
%%%%%%%% node65_43 %%%%%%%%%%%%%%%%%%%
node(node65_43).
functor(node65_43, rstr).         const(rstr).
gram_sempos(node65_43, adj_quant_def).         const(adj_quant_def).
id(node65_43, t_plzensky51278_txt_001_p1s4a28).         const(t_plzensky51278_txt_001_p1s4a28).
t_lemma(node65_43, 6).         const(6).
%%%%%%%% node65_44 %%%%%%%%%%%%%%%%%%%
node(node65_44).
a_afun(node65_44, atr).         const(atr).
m_form(node65_44, 6).         const(6).
m_lemma(node65_44, 6).         const(6).
m_tag(node65_44, c=_____________).         const(c=_____________).
m_tag0(node65_44,'c'). const('c'). m_tag1(node65_44,'='). const('='). 
%%%%%%%% node65_45 %%%%%%%%%%%%%%%%%%%
node(node65_45).
a_afun(node65_45, coord).         const(coord).
m_form(node65_45, nebo).         const(nebo).
m_lemma(node65_45, nebo).         const(nebo).
m_tag(node65_45, j______________).         const(j______________).
m_tag0(node65_45,'j'). const('j'). m_tag1(node65_45,'^'). const('^'). 
%%%%%%%% node65_46 %%%%%%%%%%%%%%%%%%%
node(node65_46).
functor(node65_46, rstr).         const(rstr).
gram_sempos(node65_46, adj_quant_def).         const(adj_quant_def).
id(node65_46, t_plzensky51278_txt_001_p1s4a30).         const(t_plzensky51278_txt_001_p1s4a30).
t_lemma(node65_46, 7).         const(7).
%%%%%%%% node65_47 %%%%%%%%%%%%%%%%%%%
node(node65_47).
a_afun(node65_47, atr).         const(atr).
m_form(node65_47, 7).         const(7).
m_lemma(node65_47, 7).         const(7).
m_tag(node65_47, c=_____________).         const(c=_____________).
m_tag0(node65_47,'c'). const('c'). m_tag1(node65_47,'='). const('='). 
%%%%%%%% node65_48 %%%%%%%%%%%%%%%%%%%
node(node65_48).
a_afun(node65_48, auxp).         const(auxp).
m_form(node65_48, ze).         const(ze).
m_lemma(node65_48, z_1).         const(z_1).
m_tag(node65_48, rv__2__________).         const(rv__2__________).
m_tag0(node65_48,'r'). const('r'). m_tag1(node65_48,'v'). const('v'). m_tag4(node65_48,'2'). const('2'). 
%%%%%%%% node65_49 %%%%%%%%%%%%%%%%%%%
node(node65_49).
a_afun(node65_49, atr).         const(atr).
m_form(node65_49, tridy).         const(tridy).
m_lemma(node65_49, trida).         const(trida).
m_tag(node65_49, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node65_49,'n'). const('n'). m_tag1(node65_49,'n'). const('n'). m_tag2(node65_49,'f'). const('f'). m_tag3(node65_49,'s'). const('s'). m_tag4(node65_49,'2'). const('2'). m_tag10(node65_49,'a'). const('a'). 
edge(node65_0, node65_1).
edge(node65_1, node65_2).
edge(node65_1, node65_3).
edge(node65_1, node65_4).
edge(node65_4, node65_5).
edge(node65_5, node65_6).
edge(node65_4, node65_7).
edge(node65_7, node65_8).
edge(node65_4, node65_9).
edge(node65_4, node65_10).
edge(node65_10, node65_11).
edge(node65_11, node65_12).
edge(node65_10, node65_13).
edge(node65_13, node65_14).
edge(node65_14, node65_15).
edge(node65_13, node65_16).
edge(node65_16, node65_17).
edge(node65_13, node65_18).
edge(node65_13, node65_19).
edge(node65_10, node65_20).
edge(node65_10, node65_21).
edge(node65_10, node65_22).
edge(node65_22, node65_23).
edge(node65_23, node65_24).
edge(node65_24, node65_25).
edge(node65_23, node65_26).
edge(node65_23, node65_27).
edge(node65_27, node65_28).
edge(node65_28, node65_29).
edge(node65_29, node65_30).
edge(node65_28, node65_31).
edge(node65_28, node65_32).
edge(node65_32, node65_33).
edge(node65_27, node65_34).
edge(node65_27, node65_35).
edge(node65_22, node65_36).
edge(node65_22, node65_37).
edge(node65_37, node65_38).
edge(node65_38, node65_39).
edge(node65_37, node65_40).
edge(node65_37, node65_41).
edge(node65_41, node65_42).
edge(node65_42, node65_43).
edge(node65_43, node65_44).
edge(node65_42, node65_45).
edge(node65_42, node65_46).
edge(node65_46, node65_47).
edge(node65_41, node65_48).
edge(node65_41, node65_49).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zakladni skoly, ktere meli pouze prvni stupen, mohli vytvorit druzstvo ze zastupcu 4. a 5. trid a viceleta gymnazia ze zastupcu primy a sekundy. 
tree_root(node66_0).
:- %%%%%%%% node66_0 %%%%%%%%%%%%%%%%%%%
node(node66_0).
id(node66_0, t_plzensky51278_txt_001_p1s5).         const(t_plzensky51278_txt_001_p1s5).
%%%%%%%% node66_1 %%%%%%%%%%%%%%%%%%%
node(node66_1).
functor(node66_1, pred).         const(pred).
gram_sempos(node66_1, v).         const(v).
id(node66_1, t_plzensky51278_txt_001_p1s5a11).         const(t_plzensky51278_txt_001_p1s5a11).
t_lemma(node66_1, vytvorit).         const(vytvorit).
%%%%%%%% node66_2 %%%%%%%%%%%%%%%%%%%
node(node66_2).
functor(node66_2, pat).         const(pat).
id(node66_2, t_plzensky51278_txt_001_p1s5a30).         const(t_plzensky51278_txt_001_p1s5a30).
t_lemma(node66_2, x_gen).         const(x_gen).
%%%%%%%% node66_3 %%%%%%%%%%%%%%%%%%%
node(node66_3).
functor(node66_3, act).         const(act).
gram_sempos(node66_3, n_denot).         const(n_denot).
id(node66_3, t_plzensky51278_txt_001_p1s5a2).         const(t_plzensky51278_txt_001_p1s5a2).
t_lemma(node66_3, skola).         const(skola).
%%%%%%%% node66_4 %%%%%%%%%%%%%%%%%%%
node(node66_4).
functor(node66_4, rstr).         const(rstr).
gram_sempos(node66_4, adj_denot).         const(adj_denot).
id(node66_4, t_plzensky51278_txt_001_p1s5a3).         const(t_plzensky51278_txt_001_p1s5a3).
t_lemma(node66_4, zakladni).         const(zakladni).
%%%%%%%% node66_5 %%%%%%%%%%%%%%%%%%%
node(node66_5).
a_afun(node66_5, atr).         const(atr).
m_form(node66_5, zakladni).         const(zakladni).
m_lemma(node66_5, zakladni__s).         const(zakladni__s).
m_tag(node66_5, aafp1____1a____).         const(aafp1____1a____).
m_tag0(node66_5,'a'). const('a'). m_tag1(node66_5,'a'). const('a'). m_tag2(node66_5,'f'). const('f'). m_tag3(node66_5,'p'). const('p'). m_tag4(node66_5,'1'). const('1'). m_tag9(node66_5,'1'). const('1'). m_tag10(node66_5,'a'). const('a'). 
%%%%%%%% node66_6 %%%%%%%%%%%%%%%%%%%
node(node66_6).
a_afun(node66_6, sb).         const(sb).
m_form(node66_6, skoly).         const(skoly).
m_lemma(node66_6, skola).         const(skola).
m_tag(node66_6, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node66_6,'n'). const('n'). m_tag1(node66_6,'n'). const('n'). m_tag2(node66_6,'f'). const('f'). m_tag3(node66_6,'p'). const('p'). m_tag4(node66_6,'1'). const('1'). m_tag10(node66_6,'a'). const('a'). 
%%%%%%%% node66_7 %%%%%%%%%%%%%%%%%%%
node(node66_7).
functor(node66_7, rstr).         const(rstr).
gram_sempos(node66_7, v).         const(v).
id(node66_7, t_plzensky51278_txt_001_p1s5a4).         const(t_plzensky51278_txt_001_p1s5a4).
t_lemma(node66_7, mit).         const(mit).
%%%%%%%% node66_8 %%%%%%%%%%%%%%%%%%%
node(node66_8).
functor(node66_8, pat).         const(pat).
gram_sempos(node66_8, n_pron_indef).         const(n_pron_indef).
id(node66_8, t_plzensky51278_txt_001_p1s5a6).         const(t_plzensky51278_txt_001_p1s5a6).
t_lemma(node66_8, ktery).         const(ktery).
%%%%%%%% node66_9 %%%%%%%%%%%%%%%%%%%
node(node66_9).
a_afun(node66_9, obj).         const(obj).
m_form(node66_9, ktere).         const(ktere).
m_lemma(node66_9, ktery).         const(ktery).
m_tag(node66_9, p4fp4__________).         const(p4fp4__________).
m_tag0(node66_9,'p'). const('p'). m_tag1(node66_9,'4'). const('4'). m_tag2(node66_9,'f'). const('f'). m_tag3(node66_9,'p'). const('p'). m_tag4(node66_9,'4'). const('4'). 
%%%%%%%% node66_10 %%%%%%%%%%%%%%%%%%%
node(node66_10).
a_afun(node66_10, atr).         const(atr).
m_form(node66_10, meli).         const(meli).
m_lemma(node66_10, mit).         const(mit).
m_tag(node66_10, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node66_10,'v'). const('v'). m_tag1(node66_10,'p'). const('p'). m_tag2(node66_10,'m'). const('m'). m_tag3(node66_10,'p'). const('p'). m_tag7(node66_10,'x'). const('x'). m_tag8(node66_10,'r'). const('r'). m_tag10(node66_10,'a'). const('a'). m_tag11(node66_10,'a'). const('a'). 
%%%%%%%% node66_11 %%%%%%%%%%%%%%%%%%%
node(node66_11).
functor(node66_11, act).         const(act).
gram_sempos(node66_11, n_denot).         const(n_denot).
id(node66_11, t_plzensky51278_txt_001_p1s5a7).         const(t_plzensky51278_txt_001_p1s5a7).
t_lemma(node66_11, stupen).         const(stupen).
%%%%%%%% node66_12 %%%%%%%%%%%%%%%%%%%
node(node66_12).
functor(node66_12, rhem).         const(rhem).
id(node66_12, t_plzensky51278_txt_001_p1s5a8).         const(t_plzensky51278_txt_001_p1s5a8).
t_lemma(node66_12, pouze).         const(pouze).
%%%%%%%% node66_13 %%%%%%%%%%%%%%%%%%%
node(node66_13).
a_afun(node66_13, auxz).         const(auxz).
m_form(node66_13, pouze).         const(pouze).
m_lemma(node66_13, pouze).         const(pouze).
m_tag(node66_13, db_____________).         const(db_____________).
m_tag0(node66_13,'d'). const('d'). m_tag1(node66_13,'b'). const('b'). 
%%%%%%%% node66_14 %%%%%%%%%%%%%%%%%%%
node(node66_14).
functor(node66_14, rstr).         const(rstr).
gram_sempos(node66_14, adj_quant_def).         const(adj_quant_def).
id(node66_14, t_plzensky51278_txt_001_p1s5a9).         const(t_plzensky51278_txt_001_p1s5a9).
t_lemma(node66_14, jeden).         const(jeden).
%%%%%%%% node66_15 %%%%%%%%%%%%%%%%%%%
node(node66_15).
a_afun(node66_15, atr).         const(atr).
m_form(node66_15, prvni).         const(prvni).
m_lemma(node66_15, prvni).         const(prvni).
m_tag(node66_15, cris1__________).         const(cris1__________).
m_tag0(node66_15,'c'). const('c'). m_tag1(node66_15,'r'). const('r'). m_tag2(node66_15,'i'). const('i'). m_tag3(node66_15,'s'). const('s'). m_tag4(node66_15,'1'). const('1'). 
%%%%%%%% node66_16 %%%%%%%%%%%%%%%%%%%
node(node66_16).
a_afun(node66_16, sb).         const(sb).
m_form(node66_16, stupen).         const(stupen).
m_lemma(node66_16, stupen).         const(stupen).
m_tag(node66_16, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node66_16,'n'). const('n'). m_tag1(node66_16,'n'). const('n'). m_tag2(node66_16,'i'). const('i'). m_tag3(node66_16,'s'). const('s'). m_tag4(node66_16,'1'). const('1'). m_tag10(node66_16,'a'). const('a'). 
%%%%%%%% node66_17 %%%%%%%%%%%%%%%%%%%
node(node66_17).
a_afun(node66_17, pred).         const(pred).
m_form(node66_17, mohli).         const(mohli).
m_lemma(node66_17, moci___mit_moznost__neco_delat__).         const(moci___mit_moznost__neco_delat__).
m_tag(node66_17, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node66_17,'v'). const('v'). m_tag1(node66_17,'p'). const('p'). m_tag2(node66_17,'m'). const('m'). m_tag3(node66_17,'p'). const('p'). m_tag7(node66_17,'x'). const('x'). m_tag8(node66_17,'r'). const('r'). m_tag10(node66_17,'a'). const('a'). m_tag11(node66_17,'a'). const('a'). 
%%%%%%%% node66_18 %%%%%%%%%%%%%%%%%%%
node(node66_18).
a_afun(node66_18, obj).         const(obj).
m_form(node66_18, vytvorit).         const(vytvorit).
m_lemma(node66_18, vytvorit__w).         const(vytvorit__w).
m_tag(node66_18, vf________a____).         const(vf________a____).
m_tag0(node66_18,'v'). const('v'). m_tag1(node66_18,'f'). const('f'). m_tag10(node66_18,'a'). const('a'). 
%%%%%%%% node66_19 %%%%%%%%%%%%%%%%%%%
node(node66_19).
functor(node66_19, act).         const(act).
gram_sempos(node66_19, n_denot).         const(n_denot).
id(node66_19, t_plzensky51278_txt_001_p1s5a12).         const(t_plzensky51278_txt_001_p1s5a12).
t_lemma(node66_19, druzstvo).         const(druzstvo).
%%%%%%%% node66_20 %%%%%%%%%%%%%%%%%%%
node(node66_20).
a_afun(node66_20, sb).         const(sb).
m_form(node66_20, druzstvo).         const(druzstvo).
m_lemma(node66_20, druzstvo).         const(druzstvo).
m_tag(node66_20, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node66_20,'n'). const('n'). m_tag1(node66_20,'n'). const('n'). m_tag2(node66_20,'n'). const('n'). m_tag3(node66_20,'s'). const('s'). m_tag4(node66_20,'1'). const('1'). m_tag10(node66_20,'a'). const('a'). 
%%%%%%%% node66_21 %%%%%%%%%%%%%%%%%%%
node(node66_21).
functor(node66_21, dir1).         const(dir1).
gram_sempos(node66_21, n_denot).         const(n_denot).
id(node66_21, t_plzensky51278_txt_001_p1s5a14).         const(t_plzensky51278_txt_001_p1s5a14).
t_lemma(node66_21, zastupce).         const(zastupce).
%%%%%%%% node66_22 %%%%%%%%%%%%%%%%%%%
node(node66_22).
a_afun(node66_22, auxp).         const(auxp).
m_form(node66_22, ze).         const(ze).
m_lemma(node66_22, z_1).         const(z_1).
m_tag(node66_22, rv__2__________).         const(rv__2__________).
m_tag0(node66_22,'r'). const('r'). m_tag1(node66_22,'v'). const('v'). m_tag4(node66_22,'2'). const('2'). 
%%%%%%%% node66_23 %%%%%%%%%%%%%%%%%%%
node(node66_23).
a_afun(node66_23, atr).         const(atr).
m_form(node66_23, zastupcu).         const(zastupcu).
m_lemma(node66_23, zastupce).         const(zastupce).
m_tag(node66_23, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node66_23,'n'). const('n'). m_tag1(node66_23,'n'). const('n'). m_tag2(node66_23,'m'). const('m'). m_tag3(node66_23,'p'). const('p'). m_tag4(node66_23,'2'). const('2'). m_tag10(node66_23,'a'). const('a'). 
%%%%%%%% node66_24 %%%%%%%%%%%%%%%%%%%
node(node66_24).
functor(node66_24, conj).         const(conj).
id(node66_24, t_plzensky51278_txt_001_p1s5a15).         const(t_plzensky51278_txt_001_p1s5a15).
t_lemma(node66_24, a).         const(a).
%%%%%%%% node66_25 %%%%%%%%%%%%%%%%%%%
node(node66_25).
functor(node66_25, pat).         const(pat).
gram_sempos(node66_25, n_denot).         const(n_denot).
id(node66_25, t_plzensky51278_txt_001_p1s5a16).         const(t_plzensky51278_txt_001_p1s5a16).
t_lemma(node66_25, trida).         const(trida).
%%%%%%%% node66_26 %%%%%%%%%%%%%%%%%%%
node(node66_26).
functor(node66_26, conj).         const(conj).
id(node66_26, t_plzensky51278_txt_001_p1s5a17).         const(t_plzensky51278_txt_001_p1s5a17).
t_lemma(node66_26, a).         const(a).
%%%%%%%% node66_27 %%%%%%%%%%%%%%%%%%%
node(node66_27).
functor(node66_27, rstr).         const(rstr).
gram_sempos(node66_27, adj_quant_def).         const(adj_quant_def).
id(node66_27, t_plzensky51278_txt_001_p1s5a18).         const(t_plzensky51278_txt_001_p1s5a18).
t_lemma(node66_27, 4).         const(4).
%%%%%%%% node66_28 %%%%%%%%%%%%%%%%%%%
node(node66_28).
a_afun(node66_28, atr).         const(atr).
m_form(node66_28, 4).         const(4).
m_lemma(node66_28, 4).         const(4).
m_tag(node66_28, c=_____________).         const(c=_____________).
m_tag0(node66_28,'c'). const('c'). m_tag1(node66_28,'='). const('='). 
%%%%%%%% node66_29 %%%%%%%%%%%%%%%%%%%
node(node66_29).
a_afun(node66_29, coord).         const(coord).
m_form(node66_29, a).         const(a).
m_lemma(node66_29, a_1).         const(a_1).
m_tag(node66_29, j______________).         const(j______________).
m_tag0(node66_29,'j'). const('j'). m_tag1(node66_29,'^'). const('^'). 
%%%%%%%% node66_30 %%%%%%%%%%%%%%%%%%%
node(node66_30).
functor(node66_30, rstr).         const(rstr).
gram_sempos(node66_30, adj_quant_def).         const(adj_quant_def).
id(node66_30, t_plzensky51278_txt_001_p1s5a20).         const(t_plzensky51278_txt_001_p1s5a20).
t_lemma(node66_30, 5).         const(5).
%%%%%%%% node66_31 %%%%%%%%%%%%%%%%%%%
node(node66_31).
a_afun(node66_31, atr).         const(atr).
m_form(node66_31, 5).         const(5).
m_lemma(node66_31, 5).         const(5).
m_tag(node66_31, c=_____________).         const(c=_____________).
m_tag0(node66_31,'c'). const('c'). m_tag1(node66_31,'='). const('='). 
%%%%%%%% node66_32 %%%%%%%%%%%%%%%%%%%
node(node66_32).
a_afun(node66_32, atr).         const(atr).
m_form(node66_32, trid).         const(trid).
m_lemma(node66_32, trida).         const(trida).
m_tag(node66_32, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node66_32,'n'). const('n'). m_tag1(node66_32,'n'). const('n'). m_tag2(node66_32,'f'). const('f'). m_tag3(node66_32,'p'). const('p'). m_tag4(node66_32,'2'). const('2'). m_tag10(node66_32,'a'). const('a'). 
%%%%%%%% node66_33 %%%%%%%%%%%%%%%%%%%
node(node66_33).
a_afun(node66_33, coord).         const(coord).
m_form(node66_33, a).         const(a).
m_lemma(node66_33, a_1).         const(a_1).
m_tag(node66_33, j______________).         const(j______________).
m_tag0(node66_33,'j'). const('j'). m_tag1(node66_33,'^'). const('^'). 
%%%%%%%% node66_34 %%%%%%%%%%%%%%%%%%%
node(node66_34).
functor(node66_34, rstr).         const(rstr).
gram_sempos(node66_34, n_denot).         const(n_denot).
id(node66_34, t_plzensky51278_txt_001_p1s5a22).         const(t_plzensky51278_txt_001_p1s5a22).
t_lemma(node66_34, gymnazium).         const(gymnazium).
%%%%%%%% node66_35 %%%%%%%%%%%%%%%%%%%
node(node66_35).
functor(node66_35, rstr).         const(rstr).
gram_sempos(node66_35, adj_denot).         const(adj_denot).
id(node66_35, t_plzensky51278_txt_001_p1s5a23).         const(t_plzensky51278_txt_001_p1s5a23).
t_lemma(node66_35, vicelety).         const(vicelety).
%%%%%%%% node66_36 %%%%%%%%%%%%%%%%%%%
node(node66_36).
a_afun(node66_36, atr).         const(atr).
m_form(node66_36, viceleta).         const(viceleta).
m_lemma(node66_36, vicelety).         const(vicelety).
m_tag(node66_36, aanp1____1a____).         const(aanp1____1a____).
m_tag0(node66_36,'a'). const('a'). m_tag1(node66_36,'a'). const('a'). m_tag2(node66_36,'n'). const('n'). m_tag3(node66_36,'p'). const('p'). m_tag4(node66_36,'1'). const('1'). m_tag9(node66_36,'1'). const('1'). m_tag10(node66_36,'a'). const('a'). 
%%%%%%%% node66_37 %%%%%%%%%%%%%%%%%%%
node(node66_37).
a_afun(node66_37, atr).         const(atr).
m_form(node66_37, gymnazia).         const(gymnazia).
m_lemma(node66_37, gymnazium).         const(gymnazium).
m_tag(node66_37, nnnp1_____a____).         const(nnnp1_____a____).
m_tag0(node66_37,'n'). const('n'). m_tag1(node66_37,'n'). const('n'). m_tag2(node66_37,'n'). const('n'). m_tag3(node66_37,'p'). const('p'). m_tag4(node66_37,'1'). const('1'). m_tag10(node66_37,'a'). const('a'). 
%%%%%%%% node66_38 %%%%%%%%%%%%%%%%%%%
node(node66_38).
functor(node66_38, conj).         const(conj).
id(node66_38, t_plzensky51278_txt_001_p1s5a26).         const(t_plzensky51278_txt_001_p1s5a26).
t_lemma(node66_38, a).         const(a).
%%%%%%%% node66_39 %%%%%%%%%%%%%%%%%%%
node(node66_39).
functor(node66_39, dir1).         const(dir1).
gram_sempos(node66_39, n_denot).         const(n_denot).
id(node66_39, t_plzensky51278_txt_001_p1s5a25).         const(t_plzensky51278_txt_001_p1s5a25).
t_lemma(node66_39, zastupce).         const(zastupce).
%%%%%%%% node66_40 %%%%%%%%%%%%%%%%%%%
node(node66_40).
a_afun(node66_40, auxp).         const(auxp).
m_form(node66_40, ze).         const(ze).
m_lemma(node66_40, z_1).         const(z_1).
m_tag(node66_40, rv__2__________).         const(rv__2__________).
m_tag0(node66_40,'r'). const('r'). m_tag1(node66_40,'v'). const('v'). m_tag4(node66_40,'2'). const('2'). 
%%%%%%%% node66_41 %%%%%%%%%%%%%%%%%%%
node(node66_41).
a_afun(node66_41, atr).         const(atr).
m_form(node66_41, zastupcu).         const(zastupcu).
m_lemma(node66_41, zastupce).         const(zastupce).
m_tag(node66_41, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node66_41,'n'). const('n'). m_tag1(node66_41,'n'). const('n'). m_tag2(node66_41,'m'). const('m'). m_tag3(node66_41,'p'). const('p'). m_tag4(node66_41,'2'). const('2'). m_tag10(node66_41,'a'). const('a'). 
%%%%%%%% node66_42 %%%%%%%%%%%%%%%%%%%
node(node66_42).
functor(node66_42, rstr).         const(rstr).
gram_sempos(node66_42, n_denot).         const(n_denot).
id(node66_42, t_plzensky51278_txt_001_p1s5a28).         const(t_plzensky51278_txt_001_p1s5a28).
t_lemma(node66_42, sekunda).         const(sekunda).
%%%%%%%% node66_43 %%%%%%%%%%%%%%%%%%%
node(node66_43).
a_afun(node66_43, atr).         const(atr).
m_form(node66_43, sekundy).         const(sekundy).
m_lemma(node66_43, sekunda).         const(sekunda).
m_tag(node66_43, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node66_43,'n'). const('n'). m_tag1(node66_43,'n'). const('n'). m_tag2(node66_43,'f'). const('f'). m_tag3(node66_43,'p'). const('p'). m_tag4(node66_43,'4'). const('4'). m_tag10(node66_43,'a'). const('a'). 
%%%%%%%% node66_44 %%%%%%%%%%%%%%%%%%%
node(node66_44).
a_afun(node66_44, coord).         const(coord).
m_form(node66_44, a).         const(a).
m_lemma(node66_44, a_1).         const(a_1).
m_tag(node66_44, j______________).         const(j______________).
m_tag0(node66_44,'j'). const('j'). m_tag1(node66_44,'^'). const('^'). 
%%%%%%%% node66_45 %%%%%%%%%%%%%%%%%%%
node(node66_45).
functor(node66_45, dir1).         const(dir1).
gram_sempos(node66_45, n_denot).         const(n_denot).
id(node66_45, t_plzensky51278_txt_001_p1s5a29).         const(t_plzensky51278_txt_001_p1s5a29).
t_lemma(node66_45, zastupce).         const(zastupce).
%%%%%%%% node66_46 %%%%%%%%%%%%%%%%%%%
node(node66_46).
functor(node66_46, rstr).         const(rstr).
gram_sempos(node66_46, n_denot).         const(n_denot).
id(node66_46, t_plzensky51278_txt_001_p1s5a27).         const(t_plzensky51278_txt_001_p1s5a27).
t_lemma(node66_46, prim).         const(prim).
%%%%%%%% node66_47 %%%%%%%%%%%%%%%%%%%
node(node66_47).
a_afun(node66_47, atr).         const(atr).
m_form(node66_47, primy).         const(primy).
m_lemma(node66_47, prim).         const(prim).
m_tag(node66_47, nnip4_____a____).         const(nnip4_____a____).
m_tag0(node66_47,'n'). const('n'). m_tag1(node66_47,'n'). const('n'). m_tag2(node66_47,'i'). const('i'). m_tag3(node66_47,'p'). const('p'). m_tag4(node66_47,'4'). const('4'). m_tag10(node66_47,'a'). const('a'). 
%%%%%%%% node66_48 %%%%%%%%%%%%%%%%%%%
node(node66_48).
a_afun(node66_48, auxp).         const(auxp).
m_form(node66_48, ze).         const(ze).
m_lemma(node66_48, z_1).         const(z_1).
m_tag(node66_48, rv__2__________).         const(rv__2__________).
m_tag0(node66_48,'r'). const('r'). m_tag1(node66_48,'v'). const('v'). m_tag4(node66_48,'2'). const('2'). 
%%%%%%%% node66_49 %%%%%%%%%%%%%%%%%%%
node(node66_49).
a_afun(node66_49, atr).         const(atr).
m_form(node66_49, zastupcu).         const(zastupcu).
m_lemma(node66_49, zastupce).         const(zastupce).
m_tag(node66_49, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node66_49,'n'). const('n'). m_tag1(node66_49,'n'). const('n'). m_tag2(node66_49,'m'). const('m'). m_tag3(node66_49,'p'). const('p'). m_tag4(node66_49,'2'). const('2'). m_tag10(node66_49,'a'). const('a'). 
edge(node66_0, node66_1).
edge(node66_1, node66_2).
edge(node66_1, node66_3).
edge(node66_3, node66_4).
edge(node66_4, node66_5).
edge(node66_3, node66_6).
edge(node66_3, node66_7).
edge(node66_7, node66_8).
edge(node66_8, node66_9).
edge(node66_7, node66_10).
edge(node66_7, node66_11).
edge(node66_11, node66_12).
edge(node66_12, node66_13).
edge(node66_11, node66_14).
edge(node66_14, node66_15).
edge(node66_11, node66_16).
edge(node66_1, node66_17).
edge(node66_1, node66_18).
edge(node66_1, node66_19).
edge(node66_19, node66_20).
edge(node66_19, node66_21).
edge(node66_21, node66_22).
edge(node66_21, node66_23).
edge(node66_21, node66_24).
edge(node66_24, node66_25).
edge(node66_25, node66_26).
edge(node66_26, node66_27).
edge(node66_27, node66_28).
edge(node66_26, node66_29).
edge(node66_26, node66_30).
edge(node66_30, node66_31).
edge(node66_25, node66_32).
edge(node66_24, node66_33).
edge(node66_24, node66_34).
edge(node66_34, node66_35).
edge(node66_35, node66_36).
edge(node66_34, node66_37).
edge(node66_34, node66_38).
edge(node66_38, node66_39).
edge(node66_39, node66_40).
edge(node66_39, node66_41).
edge(node66_39, node66_42).
edge(node66_42, node66_43).
edge(node66_38, node66_44).
edge(node66_38, node66_45).
edge(node66_45, node66_46).
edge(node66_46, node66_47).
edge(node66_45, node66_48).
edge(node66_45, node66_49).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pro soutezni druzstva byly pripraveny prakticke i vedomostni ukoly souvisejici s vyukou predmetu "ochrana cloveka za mimoradnych udalosti". 
tree_root(node67_0).
:- %%%%%%%% node67_0 %%%%%%%%%%%%%%%%%%%
node(node67_0).
id(node67_0, t_plzensky51278_txt_001_p2s1).         const(t_plzensky51278_txt_001_p2s1).
%%%%%%%% node67_1 %%%%%%%%%%%%%%%%%%%
node(node67_1).
functor(node67_1, pred).         const(pred).
gram_sempos(node67_1, v).         const(v).
id(node67_1, t_plzensky51278_txt_001_p2s1a1).         const(t_plzensky51278_txt_001_p2s1a1).
t_lemma(node67_1, pripravit).         const(pripravit).
%%%%%%%% node67_2 %%%%%%%%%%%%%%%%%%%
node(node67_2).
functor(node67_2, ben).         const(ben).
gram_sempos(node67_2, n_denot).         const(n_denot).
id(node67_2, t_plzensky51278_txt_001_p2s1a3).         const(t_plzensky51278_txt_001_p2s1a3).
t_lemma(node67_2, druzstvo).         const(druzstvo).
%%%%%%%% node67_3 %%%%%%%%%%%%%%%%%%%
node(node67_3).
functor(node67_3, rstr).         const(rstr).
gram_sempos(node67_3, adj_denot).         const(adj_denot).
id(node67_3, t_plzensky51278_txt_001_p2s1a4).         const(t_plzensky51278_txt_001_p2s1a4).
t_lemma(node67_3, soutezni).         const(soutezni).
%%%%%%%% node67_4 %%%%%%%%%%%%%%%%%%%
node(node67_4).
a_afun(node67_4, atr).         const(atr).
m_form(node67_4, soutezni).         const(soutezni).
m_lemma(node67_4, soutezni).         const(soutezni).
m_tag(node67_4, aanp4____1a____).         const(aanp4____1a____).
m_tag0(node67_4,'a'). const('a'). m_tag1(node67_4,'a'). const('a'). m_tag2(node67_4,'n'). const('n'). m_tag3(node67_4,'p'). const('p'). m_tag4(node67_4,'4'). const('4'). m_tag9(node67_4,'1'). const('1'). m_tag10(node67_4,'a'). const('a'). 
%%%%%%%% node67_5 %%%%%%%%%%%%%%%%%%%
node(node67_5).
a_afun(node67_5, auxp).         const(auxp).
m_form(node67_5, pro).         const(pro).
m_lemma(node67_5, pro_1).         const(pro_1).
m_tag(node67_5, rr__4__________).         const(rr__4__________).
m_tag0(node67_5,'r'). const('r'). m_tag1(node67_5,'r'). const('r'). m_tag4(node67_5,'4'). const('4'). 
%%%%%%%% node67_6 %%%%%%%%%%%%%%%%%%%
node(node67_6).
a_afun(node67_6, adv).         const(adv).
m_form(node67_6, druzstva).         const(druzstva).
m_lemma(node67_6, druzstvo).         const(druzstvo).
m_tag(node67_6, nnnp4_____a____).         const(nnnp4_____a____).
m_tag0(node67_6,'n'). const('n'). m_tag1(node67_6,'n'). const('n'). m_tag2(node67_6,'n'). const('n'). m_tag3(node67_6,'p'). const('p'). m_tag4(node67_6,'4'). const('4'). m_tag10(node67_6,'a'). const('a'). 
%%%%%%%% node67_7 %%%%%%%%%%%%%%%%%%%
node(node67_7).
a_afun(node67_7, auxv).         const(auxv).
m_form(node67_7, byly).         const(byly).
m_lemma(node67_7, byt).         const(byt).
m_tag(node67_7, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node67_7,'v'). const('v'). m_tag1(node67_7,'p'). const('p'). m_tag2(node67_7,'t'). const('t'). m_tag3(node67_7,'p'). const('p'). m_tag7(node67_7,'x'). const('x'). m_tag8(node67_7,'r'). const('r'). m_tag10(node67_7,'a'). const('a'). m_tag11(node67_7,'a'). const('a'). 
%%%%%%%% node67_8 %%%%%%%%%%%%%%%%%%%
node(node67_8).
a_afun(node67_8, pred).         const(pred).
m_form(node67_8, pripraveny).         const(pripraveny).
m_lemma(node67_8, pripravit__w).         const(pripravit__w).
m_tag(node67_8, vstp___xx_ap___).         const(vstp___xx_ap___).
m_tag0(node67_8,'v'). const('v'). m_tag1(node67_8,'s'). const('s'). m_tag2(node67_8,'t'). const('t'). m_tag3(node67_8,'p'). const('p'). m_tag7(node67_8,'x'). const('x'). m_tag8(node67_8,'x'). const('x'). m_tag10(node67_8,'a'). const('a'). m_tag11(node67_8,'p'). const('p'). 
%%%%%%%% node67_9 %%%%%%%%%%%%%%%%%%%
node(node67_9).
functor(node67_9, pat).         const(pat).
gram_sempos(node67_9, n_denot).         const(n_denot).
id(node67_9, t_plzensky51278_txt_001_p2s1a6).         const(t_plzensky51278_txt_001_p2s1a6).
t_lemma(node67_9, ochrana).         const(ochrana).
%%%%%%%% node67_10 %%%%%%%%%%%%%%%%%%%
node(node67_10).
functor(node67_10, pat).         const(pat).
gram_sempos(node67_10, n_denot).         const(n_denot).
id(node67_10, t_plzensky51278_txt_001_p2s1a7).         const(t_plzensky51278_txt_001_p2s1a7).
t_lemma(node67_10, ukol).         const(ukol).
%%%%%%%% node67_11 %%%%%%%%%%%%%%%%%%%
node(node67_11).
functor(node67_11, conj).         const(conj).
id(node67_11, t_plzensky51278_txt_001_p2s1a8).         const(t_plzensky51278_txt_001_p2s1a8).
t_lemma(node67_11, i).         const(i).
%%%%%%%% node67_12 %%%%%%%%%%%%%%%%%%%
node(node67_12).
functor(node67_12, rstr).         const(rstr).
gram_sempos(node67_12, adj_denot).         const(adj_denot).
id(node67_12, t_plzensky51278_txt_001_p2s1a9).         const(t_plzensky51278_txt_001_p2s1a9).
t_lemma(node67_12, prakticky).         const(prakticky).
%%%%%%%% node67_13 %%%%%%%%%%%%%%%%%%%
node(node67_13).
a_afun(node67_13, atr).         const(atr).
m_form(node67_13, prakticke).         const(prakticke).
m_lemma(node67_13, prakticky).         const(prakticky).
m_tag(node67_13, aaip1____1a____).         const(aaip1____1a____).
m_tag0(node67_13,'a'). const('a'). m_tag1(node67_13,'a'). const('a'). m_tag2(node67_13,'i'). const('i'). m_tag3(node67_13,'p'). const('p'). m_tag4(node67_13,'1'). const('1'). m_tag9(node67_13,'1'). const('1'). m_tag10(node67_13,'a'). const('a'). 
%%%%%%%% node67_14 %%%%%%%%%%%%%%%%%%%
node(node67_14).
a_afun(node67_14, coord).         const(coord).
m_form(node67_14, i).         const(i).
m_lemma(node67_14, i_1).         const(i_1).
m_tag(node67_14, j______________).         const(j______________).
m_tag0(node67_14,'j'). const('j'). m_tag1(node67_14,'^'). const('^'). 
%%%%%%%% node67_15 %%%%%%%%%%%%%%%%%%%
node(node67_15).
functor(node67_15, rstr).         const(rstr).
gram_sempos(node67_15, adj_denot).         const(adj_denot).
id(node67_15, t_plzensky51278_txt_001_p2s1a10).         const(t_plzensky51278_txt_001_p2s1a10).
t_lemma(node67_15, vedomostni).         const(vedomostni).
%%%%%%%% node67_16 %%%%%%%%%%%%%%%%%%%
node(node67_16).
a_afun(node67_16, atr).         const(atr).
m_form(node67_16, vedomostni).         const(vedomostni).
m_lemma(node67_16, vedomostni).         const(vedomostni).
m_tag(node67_16, aaip4____1a____).         const(aaip4____1a____).
m_tag0(node67_16,'a'). const('a'). m_tag1(node67_16,'a'). const('a'). m_tag2(node67_16,'i'). const('i'). m_tag3(node67_16,'p'). const('p'). m_tag4(node67_16,'4'). const('4'). m_tag9(node67_16,'1'). const('1'). m_tag10(node67_16,'a'). const('a'). 
%%%%%%%% node67_17 %%%%%%%%%%%%%%%%%%%
node(node67_17).
a_afun(node67_17, atr).         const(atr).
m_form(node67_17, ukoly).         const(ukoly).
m_lemma(node67_17, ukol).         const(ukol).
m_tag(node67_17, nnip4_____a____).         const(nnip4_____a____).
m_tag0(node67_17,'n'). const('n'). m_tag1(node67_17,'n'). const('n'). m_tag2(node67_17,'i'). const('i'). m_tag3(node67_17,'p'). const('p'). m_tag4(node67_17,'4'). const('4'). m_tag10(node67_17,'a'). const('a'). 
%%%%%%%% node67_18 %%%%%%%%%%%%%%%%%%%
node(node67_18).
functor(node67_18, rstr).         const(rstr).
gram_sempos(node67_18, adj_denot).         const(adj_denot).
id(node67_18, t_plzensky51278_txt_001_p2s1a11).         const(t_plzensky51278_txt_001_p2s1a11).
t_lemma(node67_18, souvisejici).         const(souvisejici).
%%%%%%%% node67_19 %%%%%%%%%%%%%%%%%%%
node(node67_19).
a_afun(node67_19, atr).         const(atr).
m_form(node67_19, souvisejici).         const(souvisejici).
m_lemma(node67_19, souvisejici____4t_).         const(souvisejici____4t_).
m_tag(node67_19, agis4_____a____).         const(agis4_____a____).
m_tag0(node67_19,'a'). const('a'). m_tag1(node67_19,'g'). const('g'). m_tag2(node67_19,'i'). const('i'). m_tag3(node67_19,'s'). const('s'). m_tag4(node67_19,'4'). const('4'). m_tag10(node67_19,'a'). const('a'). 
%%%%%%%% node67_20 %%%%%%%%%%%%%%%%%%%
node(node67_20).
functor(node67_20, pat).         const(pat).
gram_sempos(node67_20, n_denot).         const(n_denot).
id(node67_20, t_plzensky51278_txt_001_p2s1a13).         const(t_plzensky51278_txt_001_p2s1a13).
t_lemma(node67_20, vyuka).         const(vyuka).
%%%%%%%% node67_21 %%%%%%%%%%%%%%%%%%%
node(node67_21).
a_afun(node67_21, auxp).         const(auxp).
m_form(node67_21, s).         const(s).
m_lemma(node67_21, s_1).         const(s_1).
m_tag(node67_21, rr__7__________).         const(rr__7__________).
m_tag0(node67_21,'r'). const('r'). m_tag1(node67_21,'r'). const('r'). m_tag4(node67_21,'7'). const('7'). 
%%%%%%%% node67_22 %%%%%%%%%%%%%%%%%%%
node(node67_22).
a_afun(node67_22, obj).         const(obj).
m_form(node67_22, vyukou).         const(vyukou).
m_lemma(node67_22, vyuka).         const(vyuka).
m_tag(node67_22, nnfs7_____a____).         const(nnfs7_____a____).
m_tag0(node67_22,'n'). const('n'). m_tag1(node67_22,'n'). const('n'). m_tag2(node67_22,'f'). const('f'). m_tag3(node67_22,'s'). const('s'). m_tag4(node67_22,'7'). const('7'). m_tag10(node67_22,'a'). const('a'). 
%%%%%%%% node67_23 %%%%%%%%%%%%%%%%%%%
node(node67_23).
functor(node67_23, pat).         const(pat).
gram_sempos(node67_23, n_denot).         const(n_denot).
id(node67_23, t_plzensky51278_txt_001_p2s1a14).         const(t_plzensky51278_txt_001_p2s1a14).
t_lemma(node67_23, predmet).         const(predmet).
%%%%%%%% node67_24 %%%%%%%%%%%%%%%%%%%
node(node67_24).
a_afun(node67_24, atr).         const(atr).
m_form(node67_24, predmetu).         const(predmetu).
m_lemma(node67_24, predmet).         const(predmet).
m_tag(node67_24, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node67_24,'n'). const('n'). m_tag1(node67_24,'n'). const('n'). m_tag2(node67_24,'i'). const('i'). m_tag3(node67_24,'s'). const('s'). m_tag4(node67_24,'2'). const('2'). m_tag10(node67_24,'a'). const('a'). 
%%%%%%%% node67_25 %%%%%%%%%%%%%%%%%%%
node(node67_25).
a_afun(node67_25, sb).         const(sb).
m_form(node67_25, ochrana).         const(ochrana).
m_lemma(node67_25, ochrana).         const(ochrana).
m_tag(node67_25, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node67_25,'n'). const('n'). m_tag1(node67_25,'n'). const('n'). m_tag2(node67_25,'f'). const('f'). m_tag3(node67_25,'s'). const('s'). m_tag4(node67_25,'1'). const('1'). m_tag10(node67_25,'a'). const('a'). 
%%%%%%%% node67_26 %%%%%%%%%%%%%%%%%%%
node(node67_26).
functor(node67_26, pat).         const(pat).
gram_sempos(node67_26, n_denot).         const(n_denot).
id(node67_26, t_plzensky51278_txt_001_p2s1a16).         const(t_plzensky51278_txt_001_p2s1a16).
t_lemma(node67_26, clovek).         const(clovek).
%%%%%%%% node67_27 %%%%%%%%%%%%%%%%%%%
node(node67_27).
a_afun(node67_27, atr).         const(atr).
m_form(node67_27, cloveka).         const(cloveka).
m_lemma(node67_27, clovek).         const(clovek).
m_tag(node67_27, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node67_27,'n'). const('n'). m_tag1(node67_27,'n'). const('n'). m_tag2(node67_27,'m'). const('m'). m_tag3(node67_27,'s'). const('s'). m_tag4(node67_27,'2'). const('2'). m_tag10(node67_27,'a'). const('a'). 
%%%%%%%% node67_28 %%%%%%%%%%%%%%%%%%%
node(node67_28).
functor(node67_28, loc).         const(loc).
gram_sempos(node67_28, adj_denot).         const(adj_denot).
id(node67_28, t_plzensky51278_txt_001_p2s1a19).         const(t_plzensky51278_txt_001_p2s1a19).
t_lemma(node67_28, mimoradny).         const(mimoradny).
%%%%%%%% node67_29 %%%%%%%%%%%%%%%%%%%
node(node67_29).
a_afun(node67_29, auxp).         const(auxp).
m_form(node67_29, za).         const(za).
m_lemma(node67_29, za_1).         const(za_1).
m_tag(node67_29, rr__4__________).         const(rr__4__________).
m_tag0(node67_29,'r'). const('r'). m_tag1(node67_29,'r'). const('r'). m_tag4(node67_29,'4'). const('4'). 
%%%%%%%% node67_30 %%%%%%%%%%%%%%%%%%%
node(node67_30).
a_afun(node67_30, atr).         const(atr).
m_form(node67_30, mimoradnych).         const(mimoradnych).
m_lemma(node67_30, mimoradny).         const(mimoradny).
m_tag(node67_30, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node67_30,'a'). const('a'). m_tag1(node67_30,'a'). const('a'). m_tag2(node67_30,'f'). const('f'). m_tag3(node67_30,'p'). const('p'). m_tag4(node67_30,'2'). const('2'). m_tag9(node67_30,'1'). const('1'). m_tag10(node67_30,'a'). const('a'). 
%%%%%%%% node67_31 %%%%%%%%%%%%%%%%%%%
node(node67_31).
a_afun(node67_31, auxp).         const(auxp).
m_form(node67_31, udalosti).         const(udalosti).
m_lemma(node67_31, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node67_31, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node67_31,'n'). const('n'). m_tag1(node67_31,'n'). const('n'). m_tag2(node67_31,'f'). const('f'). m_tag3(node67_31,'p'). const('p'). m_tag4(node67_31,'2'). const('2'). m_tag10(node67_31,'a'). const('a'). 
edge(node67_0, node67_1).
edge(node67_1, node67_2).
edge(node67_2, node67_3).
edge(node67_3, node67_4).
edge(node67_2, node67_5).
edge(node67_2, node67_6).
edge(node67_1, node67_7).
edge(node67_1, node67_8).
edge(node67_1, node67_9).
edge(node67_9, node67_10).
edge(node67_10, node67_11).
edge(node67_11, node67_12).
edge(node67_12, node67_13).
edge(node67_11, node67_14).
edge(node67_11, node67_15).
edge(node67_15, node67_16).
edge(node67_10, node67_17).
edge(node67_10, node67_18).
edge(node67_18, node67_19).
edge(node67_18, node67_20).
edge(node67_20, node67_21).
edge(node67_20, node67_22).
edge(node67_20, node67_23).
edge(node67_23, node67_24).
edge(node67_9, node67_25).
edge(node67_9, node67_26).
edge(node67_26, node67_27).
edge(node67_1, node67_28).
edge(node67_28, node67_29).
edge(node67_28, node67_30).
edge(node67_28, node67_31).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% deti cekalo napriklad nahlaseni dopravni nehody, pozaru aj., na nekterou z linek tisnoveho volani. 
tree_root(node68_0).
:- %%%%%%%% node68_0 %%%%%%%%%%%%%%%%%%%
node(node68_0).
id(node68_0, t_plzensky51278_txt_001_p2s2).         const(t_plzensky51278_txt_001_p2s2).
%%%%%%%% node68_1 %%%%%%%%%%%%%%%%%%%
node(node68_1).
functor(node68_1, pred).         const(pred).
gram_sempos(node68_1, v).         const(v).
id(node68_1, t_plzensky51278_txt_001_p2s2a1).         const(t_plzensky51278_txt_001_p2s2a1).
t_lemma(node68_1, cekat).         const(cekat).
%%%%%%%% node68_2 %%%%%%%%%%%%%%%%%%%
node(node68_2).
functor(node68_2, pat).         const(pat).
id(node68_2, t_plzensky51278_txt_001_p2s2a18).         const(t_plzensky51278_txt_001_p2s2a18).
t_lemma(node68_2, x_gen).         const(x_gen).
%%%%%%%% node68_3 %%%%%%%%%%%%%%%%%%%
node(node68_3).
functor(node68_3, act).         const(act).
gram_sempos(node68_3, n_denot).         const(n_denot).
id(node68_3, t_plzensky51278_txt_001_p2s2a2).         const(t_plzensky51278_txt_001_p2s2a2).
t_lemma(node68_3, dite).         const(dite).
%%%%%%%% node68_4 %%%%%%%%%%%%%%%%%%%
node(node68_4).
a_afun(node68_4, sb).         const(sb).
m_form(node68_4, deti).         const(deti).
m_lemma(node68_4, dite).         const(dite).
m_tag(node68_4, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node68_4,'n'). const('n'). m_tag1(node68_4,'n'). const('n'). m_tag2(node68_4,'f'). const('f'). m_tag3(node68_4,'p'). const('p'). m_tag4(node68_4,'1'). const('1'). m_tag10(node68_4,'a'). const('a'). 
%%%%%%%% node68_5 %%%%%%%%%%%%%%%%%%%
node(node68_5).
a_afun(node68_5, pred).         const(pred).
m_form(node68_5, cekalo).         const(cekalo).
m_lemma(node68_5, cekat__t).         const(cekat__t).
m_tag(node68_5, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node68_5,'v'). const('v'). m_tag1(node68_5,'p'). const('p'). m_tag2(node68_5,'n'). const('n'). m_tag3(node68_5,'s'). const('s'). m_tag7(node68_5,'x'). const('x'). m_tag8(node68_5,'r'). const('r'). m_tag10(node68_5,'a'). const('a'). m_tag11(node68_5,'a'). const('a'). 
%%%%%%%% node68_6 %%%%%%%%%%%%%%%%%%%
node(node68_6).
functor(node68_6, rhem).         const(rhem).
id(node68_6, t_plzensky51278_txt_001_p2s2a4).         const(t_plzensky51278_txt_001_p2s2a4).
t_lemma(node68_6, napriklad).         const(napriklad).
%%%%%%%% node68_7 %%%%%%%%%%%%%%%%%%%
node(node68_7).
a_afun(node68_7, auxz).         const(auxz).
m_form(node68_7, napriklad).         const(napriklad).
m_lemma(node68_7, napriklad).         const(napriklad).
m_tag(node68_7, db_____________).         const(db_____________).
m_tag0(node68_7,'d'). const('d'). m_tag1(node68_7,'b'). const('b'). 
%%%%%%%% node68_8 %%%%%%%%%%%%%%%%%%%
node(node68_8).
functor(node68_8, act).         const(act).
gram_sempos(node68_8, n_denot).         const(n_denot).
id(node68_8, t_plzensky51278_txt_001_p2s2a3).         const(t_plzensky51278_txt_001_p2s2a3).
t_lemma(node68_8, nahlaseni).         const(nahlaseni).
%%%%%%%% node68_9 %%%%%%%%%%%%%%%%%%%
node(node68_9).
a_afun(node68_9, sb).         const(sb).
m_form(node68_9, nahlaseni).         const(nahlaseni).
m_lemma(node68_9, nahlaseni____4sit_).         const(nahlaseni____4sit_).
m_tag(node68_9, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node68_9,'n'). const('n'). m_tag1(node68_9,'n'). const('n'). m_tag2(node68_9,'n'). const('n'). m_tag3(node68_9,'s'). const('s'). m_tag4(node68_9,'1'). const('1'). m_tag10(node68_9,'a'). const('a'). 
%%%%%%%% node68_10 %%%%%%%%%%%%%%%%%%%
node(node68_10).
functor(node68_10, rstr).         const(rstr).
id(node68_10, t_plzensky51278_txt_001_p2s2a5).         const(t_plzensky51278_txt_001_p2s2a5).
t_lemma(node68_10, x_comma).         const(x_comma).
%%%%%%%% node68_11 %%%%%%%%%%%%%%%%%%%
node(node68_11).
functor(node68_11, rstr).         const(rstr).
gram_sempos(node68_11, n_denot).         const(n_denot).
id(node68_11, t_plzensky51278_txt_001_p2s2a6).         const(t_plzensky51278_txt_001_p2s2a6).
t_lemma(node68_11, nehoda).         const(nehoda).
%%%%%%%% node68_12 %%%%%%%%%%%%%%%%%%%
node(node68_12).
functor(node68_12, rstr).         const(rstr).
gram_sempos(node68_12, adj_denot).         const(adj_denot).
id(node68_12, t_plzensky51278_txt_001_p2s2a7).         const(t_plzensky51278_txt_001_p2s2a7).
t_lemma(node68_12, dopravni).         const(dopravni).
%%%%%%%% node68_13 %%%%%%%%%%%%%%%%%%%
node(node68_13).
a_afun(node68_13, atr).         const(atr).
m_form(node68_13, dopravni).         const(dopravni).
m_lemma(node68_13, dopravni).         const(dopravni).
m_tag(node68_13, aafs2____1a____).         const(aafs2____1a____).
m_tag0(node68_13,'a'). const('a'). m_tag1(node68_13,'a'). const('a'). m_tag2(node68_13,'f'). const('f'). m_tag3(node68_13,'s'). const('s'). m_tag4(node68_13,'2'). const('2'). m_tag9(node68_13,'1'). const('1'). m_tag10(node68_13,'a'). const('a'). 
%%%%%%%% node68_14 %%%%%%%%%%%%%%%%%%%
node(node68_14).
a_afun(node68_14, atr).         const(atr).
m_form(node68_14, nehody).         const(nehody).
m_lemma(node68_14, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node68_14, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node68_14,'n'). const('n'). m_tag1(node68_14,'n'). const('n'). m_tag2(node68_14,'f'). const('f'). m_tag3(node68_14,'s'). const('s'). m_tag4(node68_14,'2'). const('2'). m_tag10(node68_14,'a'). const('a'). 
%%%%%%%% node68_15 %%%%%%%%%%%%%%%%%%%
node(node68_15).
a_afun(node68_15, auxx).         const(auxx).
m_form(node68_15, x_).         const(x_).
m_lemma(node68_15, x_).         const(x_).
m_tag(node68_15, z______________).         const(z______________).
m_tag0(node68_15,'z'). const('z'). m_tag1(node68_15,':'). const(':'). 
%%%%%%%% node68_16 %%%%%%%%%%%%%%%%%%%
node(node68_16).
functor(node68_16, rstr).         const(rstr).
gram_sempos(node68_16, n_denot).         const(n_denot).
id(node68_16, t_plzensky51278_txt_001_p2s2a8).         const(t_plzensky51278_txt_001_p2s2a8).
t_lemma(node68_16, pozar).         const(pozar).
%%%%%%%% node68_17 %%%%%%%%%%%%%%%%%%%
node(node68_17).
a_afun(node68_17, atr).         const(atr).
m_form(node68_17, pozaru).         const(pozaru).
m_lemma(node68_17, pozar).         const(pozar).
m_tag(node68_17, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node68_17,'n'). const('n'). m_tag1(node68_17,'n'). const('n'). m_tag2(node68_17,'i'). const('i'). m_tag3(node68_17,'s'). const('s'). m_tag4(node68_17,'2'). const('2'). m_tag10(node68_17,'a'). const('a'). 
%%%%%%%% node68_18 %%%%%%%%%%%%%%%%%%%
node(node68_18).
functor(node68_18, fphr).         const(fphr).
gram_sempos(node68_18, n_denot).         const(n_denot).
id(node68_18, t_plzensky51278_txt_001_p2s2a9).         const(t_plzensky51278_txt_001_p2s2a9).
t_lemma(node68_18, aj).         const(aj).
%%%%%%%% node68_19 %%%%%%%%%%%%%%%%%%%
node(node68_19).
a_afun(node68_19, atr).         const(atr).
m_form(node68_19, aj).         const(aj).
m_lemma(node68_19, aj_1__b___a_jiny_a_e_).         const(aj_1__b___a_jiny_a_e_).
m_tag(node68_19, aaxxx____1a___8).         const(aaxxx____1a___8).
m_tag0(node68_19,'a'). const('a'). m_tag1(node68_19,'a'). const('a'). m_tag2(node68_19,'x'). const('x'). m_tag3(node68_19,'x'). const('x'). m_tag4(node68_19,'x'). const('x'). m_tag9(node68_19,'1'). const('1'). m_tag10(node68_19,'a'). const('a'). m_tag14(node68_19,'8'). const('8'). 
%%%%%%%% node68_20 %%%%%%%%%%%%%%%%%%%
node(node68_20).
functor(node68_20, loc).         const(loc).
gram_sempos(node68_20, n_pron_indef).         const(n_pron_indef).
id(node68_20, t_plzensky51278_txt_001_p2s2a13).         const(t_plzensky51278_txt_001_p2s2a13).
t_lemma(node68_20, ktery).         const(ktery).
%%%%%%%% node68_21 %%%%%%%%%%%%%%%%%%%
node(node68_21).
a_afun(node68_21, auxp).         const(auxp).
m_form(node68_21, na).         const(na).
m_lemma(node68_21, na_1).         const(na_1).
m_tag(node68_21, rr__4__________).         const(rr__4__________).
m_tag0(node68_21,'r'). const('r'). m_tag1(node68_21,'r'). const('r'). m_tag4(node68_21,'4'). const('4'). 
%%%%%%%% node68_22 %%%%%%%%%%%%%%%%%%%
node(node68_22).
a_afun(node68_22, atr).         const(atr).
m_form(node68_22, nekterou).         const(nekterou).
m_lemma(node68_22, nektery).         const(nektery).
m_tag(node68_22, pzfs4__________).         const(pzfs4__________).
m_tag0(node68_22,'p'). const('p'). m_tag1(node68_22,'z'). const('z'). m_tag2(node68_22,'f'). const('f'). m_tag3(node68_22,'s'). const('s'). m_tag4(node68_22,'4'). const('4'). 
%%%%%%%% node68_23 %%%%%%%%%%%%%%%%%%%
node(node68_23).
functor(node68_23, dir1).         const(dir1).
gram_sempos(node68_23, n_denot).         const(n_denot).
id(node68_23, t_plzensky51278_txt_001_p2s2a15).         const(t_plzensky51278_txt_001_p2s2a15).
t_lemma(node68_23, linka).         const(linka).
%%%%%%%% node68_24 %%%%%%%%%%%%%%%%%%%
node(node68_24).
a_afun(node68_24, auxp).         const(auxp).
m_form(node68_24, z).         const(z).
m_lemma(node68_24, z_1).         const(z_1).
m_tag(node68_24, rr__2__________).         const(rr__2__________).
m_tag0(node68_24,'r'). const('r'). m_tag1(node68_24,'r'). const('r'). m_tag4(node68_24,'2'). const('2'). 
%%%%%%%% node68_25 %%%%%%%%%%%%%%%%%%%
node(node68_25).
a_afun(node68_25, atr).         const(atr).
m_form(node68_25, linek).         const(linek).
m_lemma(node68_25, linka).         const(linka).
m_tag(node68_25, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node68_25,'n'). const('n'). m_tag1(node68_25,'n'). const('n'). m_tag2(node68_25,'f'). const('f'). m_tag3(node68_25,'p'). const('p'). m_tag4(node68_25,'2'). const('2'). m_tag10(node68_25,'a'). const('a'). 
%%%%%%%% node68_26 %%%%%%%%%%%%%%%%%%%
node(node68_26).
functor(node68_26, rstr).         const(rstr).
gram_sempos(node68_26, n_denot_neg).         const(n_denot_neg).
id(node68_26, t_plzensky51278_txt_001_p2s2a16).         const(t_plzensky51278_txt_001_p2s2a16).
t_lemma(node68_26, volani).         const(volani).
%%%%%%%% node68_27 %%%%%%%%%%%%%%%%%%%
node(node68_27).
functor(node68_27, pat).         const(pat).
id(node68_27, t_plzensky51278_txt_001_p2s2a20).         const(t_plzensky51278_txt_001_p2s2a20).
t_lemma(node68_27, x_gen).         const(x_gen).
%%%%%%%% node68_28 %%%%%%%%%%%%%%%%%%%
node(node68_28).
functor(node68_28, act).         const(act).
id(node68_28, t_plzensky51278_txt_001_p2s2a19).         const(t_plzensky51278_txt_001_p2s2a19).
t_lemma(node68_28, x_gen).         const(x_gen).
%%%%%%%% node68_29 %%%%%%%%%%%%%%%%%%%
node(node68_29).
functor(node68_29, rstr).         const(rstr).
gram_sempos(node68_29, adj_denot).         const(adj_denot).
id(node68_29, t_plzensky51278_txt_001_p2s2a17).         const(t_plzensky51278_txt_001_p2s2a17).
t_lemma(node68_29, tisnovy).         const(tisnovy).
%%%%%%%% node68_30 %%%%%%%%%%%%%%%%%%%
node(node68_30).
a_afun(node68_30, atr).         const(atr).
m_form(node68_30, tisnoveho).         const(tisnoveho).
m_lemma(node68_30, tisnovy).         const(tisnovy).
m_tag(node68_30, aans2____1a____).         const(aans2____1a____).
m_tag0(node68_30,'a'). const('a'). m_tag1(node68_30,'a'). const('a'). m_tag2(node68_30,'n'). const('n'). m_tag3(node68_30,'s'). const('s'). m_tag4(node68_30,'2'). const('2'). m_tag9(node68_30,'1'). const('1'). m_tag10(node68_30,'a'). const('a'). 
%%%%%%%% node68_31 %%%%%%%%%%%%%%%%%%%
node(node68_31).
a_afun(node68_31, atr).         const(atr).
m_form(node68_31, volani).         const(volani).
m_lemma(node68_31, volani____3at_).         const(volani____3at_).
m_tag(node68_31, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node68_31,'n'). const('n'). m_tag1(node68_31,'n'). const('n'). m_tag2(node68_31,'n'). const('n'). m_tag3(node68_31,'s'). const('s'). m_tag4(node68_31,'2'). const('2'). m_tag10(node68_31,'a'). const('a'). 
edge(node68_0, node68_1).
edge(node68_1, node68_2).
edge(node68_1, node68_3).
edge(node68_3, node68_4).
edge(node68_1, node68_5).
edge(node68_1, node68_6).
edge(node68_6, node68_7).
edge(node68_1, node68_8).
edge(node68_8, node68_9).
edge(node68_8, node68_10).
edge(node68_10, node68_11).
edge(node68_11, node68_12).
edge(node68_12, node68_13).
edge(node68_11, node68_14).
edge(node68_10, node68_15).
edge(node68_10, node68_16).
edge(node68_16, node68_17).
edge(node68_10, node68_18).
edge(node68_18, node68_19).
edge(node68_8, node68_20).
edge(node68_20, node68_21).
edge(node68_20, node68_22).
edge(node68_20, node68_23).
edge(node68_23, node68_24).
edge(node68_23, node68_25).
edge(node68_23, node68_26).
edge(node68_26, node68_27).
edge(node68_26, node68_28).
edge(node68_26, node68_29).
edge(node68_29, node68_30).
edge(node68_26, node68_31).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% museli rozpoznat varovne signaly a poskytnout prvni pomoc na pracovisti cck. 
tree_root(node69_0).
:- %%%%%%%% node69_0 %%%%%%%%%%%%%%%%%%%
node(node69_0).
id(node69_0, t_plzensky51278_txt_001_p2s3).         const(t_plzensky51278_txt_001_p2s3).
%%%%%%%% node69_1 %%%%%%%%%%%%%%%%%%%
node(node69_1).
functor(node69_1, conj).         const(conj).
id(node69_1, t_plzensky51278_txt_001_p2s3a2).         const(t_plzensky51278_txt_001_p2s3a2).
t_lemma(node69_1, a).         const(a).
%%%%%%%% node69_2 %%%%%%%%%%%%%%%%%%%
node(node69_2).
functor(node69_2, act).         const(act).
id(node69_2, t_plzensky51278_txt_001_p2s3a15).         const(t_plzensky51278_txt_001_p2s3a15).
t_lemma(node69_2, x_cor).         const(x_cor).
%%%%%%%% node69_3 %%%%%%%%%%%%%%%%%%%
node(node69_3).
functor(node69_3, rstr).         const(rstr).
gram_sempos(node69_3, v).         const(v).
id(node69_3, t_plzensky51278_txt_001_p2s3a3).         const(t_plzensky51278_txt_001_p2s3a3).
t_lemma(node69_3, rozpoznat).         const(rozpoznat).
%%%%%%%% node69_4 %%%%%%%%%%%%%%%%%%%
node(node69_4).
a_afun(node69_4, obj).         const(obj).
m_form(node69_4, rozpoznat).         const(rozpoznat).
m_lemma(node69_4, rozpoznat__w).         const(rozpoznat__w).
m_tag(node69_4, vf________a____).         const(vf________a____).
m_tag0(node69_4,'v'). const('v'). m_tag1(node69_4,'f'). const('f'). m_tag10(node69_4,'a'). const('a'). 
%%%%%%%% node69_5 %%%%%%%%%%%%%%%%%%%
node(node69_5).
functor(node69_5, pat).         const(pat).
gram_sempos(node69_5, n_denot).         const(n_denot).
id(node69_5, t_plzensky51278_txt_001_p2s3a4).         const(t_plzensky51278_txt_001_p2s3a4).
t_lemma(node69_5, signal).         const(signal).
%%%%%%%% node69_6 %%%%%%%%%%%%%%%%%%%
node(node69_6).
functor(node69_6, rstr).         const(rstr).
gram_sempos(node69_6, adj_denot).         const(adj_denot).
id(node69_6, t_plzensky51278_txt_001_p2s3a5).         const(t_plzensky51278_txt_001_p2s3a5).
t_lemma(node69_6, varovny).         const(varovny).
%%%%%%%% node69_7 %%%%%%%%%%%%%%%%%%%
node(node69_7).
a_afun(node69_7, atr).         const(atr).
m_form(node69_7, varovne).         const(varovne).
m_lemma(node69_7, varovny).         const(varovny).
m_tag(node69_7, aaip4____1a____).         const(aaip4____1a____).
m_tag0(node69_7,'a'). const('a'). m_tag1(node69_7,'a'). const('a'). m_tag2(node69_7,'i'). const('i'). m_tag3(node69_7,'p'). const('p'). m_tag4(node69_7,'4'). const('4'). m_tag9(node69_7,'1'). const('1'). m_tag10(node69_7,'a'). const('a'). 
%%%%%%%% node69_8 %%%%%%%%%%%%%%%%%%%
node(node69_8).
a_afun(node69_8, obj).         const(obj).
m_form(node69_8, signaly).         const(signaly).
m_lemma(node69_8, signal).         const(signal).
m_tag(node69_8, nnip4_____a____).         const(nnip4_____a____).
m_tag0(node69_8,'n'). const('n'). m_tag1(node69_8,'n'). const('n'). m_tag2(node69_8,'i'). const('i'). m_tag3(node69_8,'p'). const('p'). m_tag4(node69_8,'4'). const('4'). m_tag10(node69_8,'a'). const('a'). 
%%%%%%%% node69_9 %%%%%%%%%%%%%%%%%%%
node(node69_9).
a_afun(node69_9, coord).         const(coord).
m_form(node69_9, a).         const(a).
m_lemma(node69_9, a_1).         const(a_1).
m_tag(node69_9, j______________).         const(j______________).
m_tag0(node69_9,'j'). const('j'). m_tag1(node69_9,'^'). const('^'). 
%%%%%%%% node69_10 %%%%%%%%%%%%%%%%%%%
node(node69_10).
functor(node69_10, rstr).         const(rstr).
gram_sempos(node69_10, v).         const(v).
id(node69_10, t_plzensky51278_txt_001_p2s3a6).         const(t_plzensky51278_txt_001_p2s3a6).
t_lemma(node69_10, poskytnout).         const(poskytnout).
%%%%%%%% node69_11 %%%%%%%%%%%%%%%%%%%
node(node69_11).
a_afun(node69_11, obj).         const(obj).
m_form(node69_11, poskytnout).         const(poskytnout).
m_lemma(node69_11, poskytnout__w).         const(poskytnout__w).
m_tag(node69_11, vf________a____).         const(vf________a____).
m_tag0(node69_11,'v'). const('v'). m_tag1(node69_11,'f'). const('f'). m_tag10(node69_11,'a'). const('a'). 
%%%%%%%% node69_12 %%%%%%%%%%%%%%%%%%%
node(node69_12).
functor(node69_12, addr).         const(addr).
id(node69_12, t_plzensky51278_txt_001_p2s3a14).         const(t_plzensky51278_txt_001_p2s3a14).
t_lemma(node69_12, x_gen).         const(x_gen).
%%%%%%%% node69_13 %%%%%%%%%%%%%%%%%%%
node(node69_13).
functor(node69_13, cphr).         const(cphr).
gram_sempos(node69_13, n_denot).         const(n_denot).
id(node69_13, t_plzensky51278_txt_001_p2s3a7).         const(t_plzensky51278_txt_001_p2s3a7).
t_lemma(node69_13, pomoc).         const(pomoc).
%%%%%%%% node69_14 %%%%%%%%%%%%%%%%%%%
node(node69_14).
functor(node69_14, rstr).         const(rstr).
gram_sempos(node69_14, adj_quant_def).         const(adj_quant_def).
id(node69_14, t_plzensky51278_txt_001_p2s3a8).         const(t_plzensky51278_txt_001_p2s3a8).
t_lemma(node69_14, jeden).         const(jeden).
%%%%%%%% node69_15 %%%%%%%%%%%%%%%%%%%
node(node69_15).
a_afun(node69_15, atr).         const(atr).
m_form(node69_15, prvni).         const(prvni).
m_lemma(node69_15, prvni).         const(prvni).
m_tag(node69_15, crfs4__________).         const(crfs4__________).
m_tag0(node69_15,'c'). const('c'). m_tag1(node69_15,'r'). const('r'). m_tag2(node69_15,'f'). const('f'). m_tag3(node69_15,'s'). const('s'). m_tag4(node69_15,'4'). const('4'). 
%%%%%%%% node69_16 %%%%%%%%%%%%%%%%%%%
node(node69_16).
a_afun(node69_16, obj).         const(obj).
m_form(node69_16, pomoc).         const(pomoc).
m_lemma(node69_16, pomoc).         const(pomoc).
m_tag(node69_16, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node69_16,'n'). const('n'). m_tag1(node69_16,'n'). const('n'). m_tag2(node69_16,'f'). const('f'). m_tag3(node69_16,'s'). const('s'). m_tag4(node69_16,'4'). const('4'). m_tag10(node69_16,'a'). const('a'). 
%%%%%%%% node69_17 %%%%%%%%%%%%%%%%%%%
node(node69_17).
functor(node69_17, loc).         const(loc).
gram_sempos(node69_17, n_denot).         const(n_denot).
id(node69_17, t_plzensky51278_txt_001_p2s3a10).         const(t_plzensky51278_txt_001_p2s3a10).
t_lemma(node69_17, pracoviste).         const(pracoviste).
%%%%%%%% node69_18 %%%%%%%%%%%%%%%%%%%
node(node69_18).
a_afun(node69_18, auxp).         const(auxp).
m_form(node69_18, na).         const(na).
m_lemma(node69_18, na_1).         const(na_1).
m_tag(node69_18, rr__6__________).         const(rr__6__________).
m_tag0(node69_18,'r'). const('r'). m_tag1(node69_18,'r'). const('r'). m_tag4(node69_18,'6'). const('6'). 
%%%%%%%% node69_19 %%%%%%%%%%%%%%%%%%%
node(node69_19).
a_afun(node69_19, atr).         const(atr).
m_form(node69_19, pracovisti).         const(pracovisti).
m_lemma(node69_19, pracoviste).         const(pracoviste).
m_tag(node69_19, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node69_19,'n'). const('n'). m_tag1(node69_19,'n'). const('n'). m_tag2(node69_19,'n'). const('n'). m_tag3(node69_19,'s'). const('s'). m_tag4(node69_19,'6'). const('6'). m_tag10(node69_19,'a'). const('a'). 
%%%%%%%% node69_20 %%%%%%%%%%%%%%%%%%%
node(node69_20).
functor(node69_20, rstr).         const(rstr).
id(node69_20, t_plzensky51278_txt_001_p2s3a11).         const(t_plzensky51278_txt_001_p2s3a11).
t_lemma(node69_20, cck).         const(cck).
%%%%%%%% node69_21 %%%%%%%%%%%%%%%%%%%
node(node69_21).
a_afun(node69_21, atr).         const(atr).
m_form(node69_21, cck).         const(cck).
m_lemma(node69_21, cck__b__k).         const(cck__b__k).
m_tag(node69_21, xx_____________).         const(xx_____________).
m_tag0(node69_21,'x'). const('x'). m_tag1(node69_21,'x'). const('x'). 
edge(node69_0, node69_1).
edge(node69_1, node69_2).
edge(node69_1, node69_3).
edge(node69_3, node69_4).
edge(node69_3, node69_5).
edge(node69_5, node69_6).
edge(node69_6, node69_7).
edge(node69_5, node69_8).
edge(node69_1, node69_9).
edge(node69_1, node69_10).
edge(node69_10, node69_11).
edge(node69_10, node69_12).
edge(node69_10, node69_13).
edge(node69_13, node69_14).
edge(node69_14, node69_15).
edge(node69_13, node69_16).
edge(node69_13, node69_17).
edge(node69_17, node69_18).
edge(node69_17, node69_19).
edge(node69_17, node69_20).
edge(node69_20, node69_21).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nechybela proverka znalosti zasad provadeni evakuace, vcetne sbaleni evakuacniho zavazadla, proverka znalosti z cinnosti pri povodnich aj. 
tree_root(node70_0).
:- %%%%%%%% node70_0 %%%%%%%%%%%%%%%%%%%
node(node70_0).
id(node70_0, t_plzensky51278_txt_001_p2s4).         const(t_plzensky51278_txt_001_p2s4).
%%%%%%%% node70_1 %%%%%%%%%%%%%%%%%%%
node(node70_1).
functor(node70_1, pred).         const(pred).
gram_sempos(node70_1, v).         const(v).
id(node70_1, t_plzensky51278_txt_001_p2s4a1).         const(t_plzensky51278_txt_001_p2s4a1).
t_lemma(node70_1, chybet).         const(chybet).
%%%%%%%% node70_2 %%%%%%%%%%%%%%%%%%%
node(node70_2).
functor(node70_2, rhem).         const(rhem).
id(node70_2, t_plzensky51278_txt_001_p2s4a21).         const(t_plzensky51278_txt_001_p2s4a21).
t_lemma(node70_2, x_neg).         const(x_neg).
%%%%%%%% node70_3 %%%%%%%%%%%%%%%%%%%
node(node70_3).
functor(node70_3, act).         const(act).
gram_sempos(node70_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node70_3, t_plzensky51278_txt_001_p2s4a20).         const(t_plzensky51278_txt_001_p2s4a20).
t_lemma(node70_3, x_perspron).         const(x_perspron).
%%%%%%%% node70_4 %%%%%%%%%%%%%%%%%%%
node(node70_4).
a_afun(node70_4, pred).         const(pred).
m_form(node70_4, nechybela).         const(nechybela).
m_lemma(node70_4, chybet__t___nekde_neco_chybi_).         const(chybet__t___nekde_neco_chybi_).
m_tag(node70_4, vpqw___xr_na___).         const(vpqw___xr_na___).
m_tag0(node70_4,'v'). const('v'). m_tag1(node70_4,'p'). const('p'). m_tag2(node70_4,'q'). const('q'). m_tag3(node70_4,'w'). const('w'). m_tag7(node70_4,'x'). const('x'). m_tag8(node70_4,'r'). const('r'). m_tag10(node70_4,'n'). const('n'). m_tag11(node70_4,'a'). const('a'). 
%%%%%%%% node70_5 %%%%%%%%%%%%%%%%%%%
node(node70_5).
functor(node70_5, rstr).         const(rstr).
id(node70_5, t_plzensky51278_txt_001_p2s4a2).         const(t_plzensky51278_txt_001_p2s4a2).
t_lemma(node70_5, x_comma).         const(x_comma).
%%%%%%%% node70_6 %%%%%%%%%%%%%%%%%%%
node(node70_6).
functor(node70_6, rstr).         const(rstr).
gram_sempos(node70_6, n_denot).         const(n_denot).
id(node70_6, t_plzensky51278_txt_001_p2s4a3).         const(t_plzensky51278_txt_001_p2s4a3).
t_lemma(node70_6, proverka).         const(proverka).
%%%%%%%% node70_7 %%%%%%%%%%%%%%%%%%%
node(node70_7).
a_afun(node70_7, sb).         const(sb).
m_form(node70_7, proverka).         const(proverka).
m_lemma(node70_7, proverka).         const(proverka).
m_tag(node70_7, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node70_7,'n'). const('n'). m_tag1(node70_7,'n'). const('n'). m_tag2(node70_7,'f'). const('f'). m_tag3(node70_7,'s'). const('s'). m_tag4(node70_7,'1'). const('1'). m_tag10(node70_7,'a'). const('a'). 
%%%%%%%% node70_8 %%%%%%%%%%%%%%%%%%%
node(node70_8).
functor(node70_8, pat).         const(pat).
gram_sempos(node70_8, n_denot_neg).         const(n_denot_neg).
id(node70_8, t_plzensky51278_txt_001_p2s4a4).         const(t_plzensky51278_txt_001_p2s4a4).
t_lemma(node70_8, znalost).         const(znalost).
%%%%%%%% node70_9 %%%%%%%%%%%%%%%%%%%
node(node70_9).
a_afun(node70_9, atr).         const(atr).
m_form(node70_9, znalosti).         const(znalosti).
m_lemma(node70_9, znalost____3y_).         const(znalost____3y_).
m_tag(node70_9, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node70_9,'n'). const('n'). m_tag1(node70_9,'n'). const('n'). m_tag2(node70_9,'f'). const('f'). m_tag3(node70_9,'p'). const('p'). m_tag4(node70_9,'2'). const('2'). m_tag10(node70_9,'a'). const('a'). 
%%%%%%%% node70_10 %%%%%%%%%%%%%%%%%%%
node(node70_10).
functor(node70_10, pat).         const(pat).
gram_sempos(node70_10, n_denot).         const(n_denot).
id(node70_10, t_plzensky51278_txt_001_p2s4a5).         const(t_plzensky51278_txt_001_p2s4a5).
t_lemma(node70_10, zasada).         const(zasada).
%%%%%%%% node70_11 %%%%%%%%%%%%%%%%%%%
node(node70_11).
a_afun(node70_11, atr).         const(atr).
m_form(node70_11, zasad).         const(zasad).
m_lemma(node70_11, zasada).         const(zasada).
m_tag(node70_11, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node70_11,'n'). const('n'). m_tag1(node70_11,'n'). const('n'). m_tag2(node70_11,'f'). const('f'). m_tag3(node70_11,'p'). const('p'). m_tag4(node70_11,'2'). const('2'). m_tag10(node70_11,'a'). const('a'). 
%%%%%%%% node70_12 %%%%%%%%%%%%%%%%%%%
node(node70_12).
functor(node70_12, app).         const(app).
gram_sempos(node70_12, n_denot_neg).         const(n_denot_neg).
id(node70_12, t_plzensky51278_txt_001_p2s4a6).         const(t_plzensky51278_txt_001_p2s4a6).
t_lemma(node70_12, provadeni).         const(provadeni).
%%%%%%%% node70_13 %%%%%%%%%%%%%%%%%%%
node(node70_13).
functor(node70_13, act).         const(act).
id(node70_13, t_plzensky51278_txt_001_p2s4a22).         const(t_plzensky51278_txt_001_p2s4a22).
t_lemma(node70_13, x_gen).         const(x_gen).
%%%%%%%% node70_14 %%%%%%%%%%%%%%%%%%%
node(node70_14).
a_afun(node70_14, atr).         const(atr).
m_form(node70_14, provadeni).         const(provadeni).
m_lemma(node70_14, provadeni____2t_).         const(provadeni____2t_).
m_tag(node70_14, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node70_14,'n'). const('n'). m_tag1(node70_14,'n'). const('n'). m_tag2(node70_14,'n'). const('n'). m_tag3(node70_14,'s'). const('s'). m_tag4(node70_14,'2'). const('2'). m_tag10(node70_14,'a'). const('a'). 
%%%%%%%% node70_15 %%%%%%%%%%%%%%%%%%%
node(node70_15).
functor(node70_15, pat).         const(pat).
gram_sempos(node70_15, n_denot).         const(n_denot).
id(node70_15, t_plzensky51278_txt_001_p2s4a7).         const(t_plzensky51278_txt_001_p2s4a7).
t_lemma(node70_15, evakuace).         const(evakuace).
%%%%%%%% node70_16 %%%%%%%%%%%%%%%%%%%
node(node70_16).
a_afun(node70_16, atr).         const(atr).
m_form(node70_16, evakuace).         const(evakuace).
m_lemma(node70_16, evakuace).         const(evakuace).
m_tag(node70_16, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node70_16,'n'). const('n'). m_tag1(node70_16,'n'). const('n'). m_tag2(node70_16,'f'). const('f'). m_tag3(node70_16,'s'). const('s'). m_tag4(node70_16,'2'). const('2'). m_tag10(node70_16,'a'). const('a'). 
%%%%%%%% node70_17 %%%%%%%%%%%%%%%%%%%
node(node70_17).
functor(node70_17, acmp).         const(acmp).
gram_sempos(node70_17, n_denot).         const(n_denot).
id(node70_17, t_plzensky51278_txt_001_p2s4a10).         const(t_plzensky51278_txt_001_p2s4a10).
t_lemma(node70_17, sbaleni).         const(sbaleni).
%%%%%%%% node70_18 %%%%%%%%%%%%%%%%%%%
node(node70_18).
a_afun(node70_18, auxp).         const(auxp).
m_form(node70_18, vcetne).         const(vcetne).
m_lemma(node70_18, vcetne_2).         const(vcetne_2).
m_tag(node70_18, rr__2__________).         const(rr__2__________).
m_tag0(node70_18,'r'). const('r'). m_tag1(node70_18,'r'). const('r'). m_tag4(node70_18,'2'). const('2'). 
%%%%%%%% node70_19 %%%%%%%%%%%%%%%%%%%
node(node70_19).
a_afun(node70_19, atr).         const(atr).
m_form(node70_19, sbaleni).         const(sbaleni).
m_lemma(node70_19, sbaleni____3it_).         const(sbaleni____3it_).
m_tag(node70_19, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node70_19,'n'). const('n'). m_tag1(node70_19,'n'). const('n'). m_tag2(node70_19,'n'). const('n'). m_tag3(node70_19,'s'). const('s'). m_tag4(node70_19,'2'). const('2'). m_tag10(node70_19,'a'). const('a'). 
%%%%%%%% node70_20 %%%%%%%%%%%%%%%%%%%
node(node70_20).
functor(node70_20, rstr).         const(rstr).
gram_sempos(node70_20, adj_denot).         const(adj_denot).
id(node70_20, t_plzensky51278_txt_001_p2s4a11).         const(t_plzensky51278_txt_001_p2s4a11).
t_lemma(node70_20, evakuacni).         const(evakuacni).
%%%%%%%% node70_21 %%%%%%%%%%%%%%%%%%%
node(node70_21).
a_afun(node70_21, atr).         const(atr).
m_form(node70_21, evakuacniho).         const(evakuacniho).
m_lemma(node70_21, evakuacni).         const(evakuacni).
m_tag(node70_21, aans2____1a____).         const(aans2____1a____).
m_tag0(node70_21,'a'). const('a'). m_tag1(node70_21,'a'). const('a'). m_tag2(node70_21,'n'). const('n'). m_tag3(node70_21,'s'). const('s'). m_tag4(node70_21,'2'). const('2'). m_tag9(node70_21,'1'). const('1'). m_tag10(node70_21,'a'). const('a'). 
%%%%%%%% node70_22 %%%%%%%%%%%%%%%%%%%
node(node70_22).
functor(node70_22, pat).         const(pat).
gram_sempos(node70_22, n_denot).         const(n_denot).
id(node70_22, t_plzensky51278_txt_001_p2s4a12).         const(t_plzensky51278_txt_001_p2s4a12).
t_lemma(node70_22, zavazadlo).         const(zavazadlo).
%%%%%%%% node70_23 %%%%%%%%%%%%%%%%%%%
node(node70_23).
a_afun(node70_23, atr).         const(atr).
m_form(node70_23, zavazadla).         const(zavazadla).
m_lemma(node70_23, zavazadlo).         const(zavazadlo).
m_tag(node70_23, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node70_23,'n'). const('n'). m_tag1(node70_23,'n'). const('n'). m_tag2(node70_23,'n'). const('n'). m_tag3(node70_23,'s'). const('s'). m_tag4(node70_23,'2'). const('2'). m_tag10(node70_23,'a'). const('a'). 
%%%%%%%% node70_24 %%%%%%%%%%%%%%%%%%%
node(node70_24).
a_afun(node70_24, auxx).         const(auxx).
m_form(node70_24, x_).         const(x_).
m_lemma(node70_24, x_).         const(x_).
m_tag(node70_24, z______________).         const(z______________).
m_tag0(node70_24,'z'). const('z'). m_tag1(node70_24,':'). const(':'). 
%%%%%%%% node70_25 %%%%%%%%%%%%%%%%%%%
node(node70_25).
functor(node70_25, rstr).         const(rstr).
gram_sempos(node70_25, n_denot).         const(n_denot).
id(node70_25, t_plzensky51278_txt_001_p2s4a13).         const(t_plzensky51278_txt_001_p2s4a13).
t_lemma(node70_25, proverka).         const(proverka).
%%%%%%%% node70_26 %%%%%%%%%%%%%%%%%%%
node(node70_26).
a_afun(node70_26, sb).         const(sb).
m_form(node70_26, proverka).         const(proverka).
m_lemma(node70_26, proverka).         const(proverka).
m_tag(node70_26, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node70_26,'n'). const('n'). m_tag1(node70_26,'n'). const('n'). m_tag2(node70_26,'f'). const('f'). m_tag3(node70_26,'s'). const('s'). m_tag4(node70_26,'1'). const('1'). m_tag10(node70_26,'a'). const('a'). 
%%%%%%%% node70_27 %%%%%%%%%%%%%%%%%%%
node(node70_27).
functor(node70_27, pat).         const(pat).
gram_sempos(node70_27, n_denot_neg).         const(n_denot_neg).
id(node70_27, t_plzensky51278_txt_001_p2s4a14).         const(t_plzensky51278_txt_001_p2s4a14).
t_lemma(node70_27, znalost).         const(znalost).
%%%%%%%% node70_28 %%%%%%%%%%%%%%%%%%%
node(node70_28).
a_afun(node70_28, atr).         const(atr).
m_form(node70_28, znalosti).         const(znalosti).
m_lemma(node70_28, znalost____3y_).         const(znalost____3y_).
m_tag(node70_28, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node70_28,'n'). const('n'). m_tag1(node70_28,'n'). const('n'). m_tag2(node70_28,'f'). const('f'). m_tag3(node70_28,'p'). const('p'). m_tag4(node70_28,'2'). const('2'). m_tag10(node70_28,'a'). const('a'). 
%%%%%%%% node70_29 %%%%%%%%%%%%%%%%%%%
node(node70_29).
functor(node70_29, dir1).         const(dir1).
gram_sempos(node70_29, n_denot_neg).         const(n_denot_neg).
id(node70_29, t_plzensky51278_txt_001_p2s4a16).         const(t_plzensky51278_txt_001_p2s4a16).
t_lemma(node70_29, cinnost).         const(cinnost).
%%%%%%%% node70_30 %%%%%%%%%%%%%%%%%%%
node(node70_30).
a_afun(node70_30, auxp).         const(auxp).
m_form(node70_30, z).         const(z).
m_lemma(node70_30, z_1).         const(z_1).
m_tag(node70_30, rr__2__________).         const(rr__2__________).
m_tag0(node70_30,'r'). const('r'). m_tag1(node70_30,'r'). const('r'). m_tag4(node70_30,'2'). const('2'). 
%%%%%%%% node70_31 %%%%%%%%%%%%%%%%%%%
node(node70_31).
a_afun(node70_31, atr).         const(atr).
m_form(node70_31, cinnosti).         const(cinnosti).
m_lemma(node70_31, cinnost____3y_).         const(cinnost____3y_).
m_tag(node70_31, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node70_31,'n'). const('n'). m_tag1(node70_31,'n'). const('n'). m_tag2(node70_31,'f'). const('f'). m_tag3(node70_31,'s'). const('s'). m_tag4(node70_31,'2'). const('2'). m_tag10(node70_31,'a'). const('a'). 
%%%%%%%% node70_32 %%%%%%%%%%%%%%%%%%%
node(node70_32).
functor(node70_32, twhen).         const(twhen).
gram_sempos(node70_32, n_denot).         const(n_denot).
id(node70_32, t_plzensky51278_txt_001_p2s4a18).         const(t_plzensky51278_txt_001_p2s4a18).
t_lemma(node70_32, povoden).         const(povoden).
%%%%%%%% node70_33 %%%%%%%%%%%%%%%%%%%
node(node70_33).
a_afun(node70_33, auxp).         const(auxp).
m_form(node70_33, pri).         const(pri).
m_lemma(node70_33, pri_1).         const(pri_1).
m_tag(node70_33, rr__6__________).         const(rr__6__________).
m_tag0(node70_33,'r'). const('r'). m_tag1(node70_33,'r'). const('r'). m_tag4(node70_33,'6'). const('6'). 
%%%%%%%% node70_34 %%%%%%%%%%%%%%%%%%%
node(node70_34).
a_afun(node70_34, atr).         const(atr).
m_form(node70_34, povodnich).         const(povodnich).
m_lemma(node70_34, povoden).         const(povoden).
m_tag(node70_34, nnfp6_____a____).         const(nnfp6_____a____).
m_tag0(node70_34,'n'). const('n'). m_tag1(node70_34,'n'). const('n'). m_tag2(node70_34,'f'). const('f'). m_tag3(node70_34,'p'). const('p'). m_tag4(node70_34,'6'). const('6'). m_tag10(node70_34,'a'). const('a'). 
%%%%%%%% node70_35 %%%%%%%%%%%%%%%%%%%
node(node70_35).
functor(node70_35, fphr).         const(fphr).
gram_sempos(node70_35, n_denot).         const(n_denot).
id(node70_35, t_plzensky51278_txt_001_p2s4a19).         const(t_plzensky51278_txt_001_p2s4a19).
t_lemma(node70_35, aj).         const(aj).
%%%%%%%% node70_36 %%%%%%%%%%%%%%%%%%%
node(node70_36).
a_afun(node70_36, sb).         const(sb).
m_form(node70_36, aj).         const(aj).
m_lemma(node70_36, aj_1__b___a_jiny_a_e_).         const(aj_1__b___a_jiny_a_e_).
m_tag(node70_36, aaxxx____1a___8).         const(aaxxx____1a___8).
m_tag0(node70_36,'a'). const('a'). m_tag1(node70_36,'a'). const('a'). m_tag2(node70_36,'x'). const('x'). m_tag3(node70_36,'x'). const('x'). m_tag4(node70_36,'x'). const('x'). m_tag9(node70_36,'1'). const('1'). m_tag10(node70_36,'a'). const('a'). m_tag14(node70_36,'8'). const('8'). 
edge(node70_0, node70_1).
edge(node70_1, node70_2).
edge(node70_1, node70_3).
edge(node70_1, node70_4).
edge(node70_1, node70_5).
edge(node70_5, node70_6).
edge(node70_6, node70_7).
edge(node70_6, node70_8).
edge(node70_8, node70_9).
edge(node70_8, node70_10).
edge(node70_10, node70_11).
edge(node70_10, node70_12).
edge(node70_12, node70_13).
edge(node70_12, node70_14).
edge(node70_12, node70_15).
edge(node70_15, node70_16).
edge(node70_15, node70_17).
edge(node70_17, node70_18).
edge(node70_17, node70_19).
edge(node70_17, node70_20).
edge(node70_20, node70_21).
edge(node70_20, node70_22).
edge(node70_22, node70_23).
edge(node70_5, node70_24).
edge(node70_5, node70_25).
edge(node70_25, node70_26).
edge(node70_25, node70_27).
edge(node70_27, node70_28).
edge(node70_27, node70_29).
edge(node70_29, node70_30).
edge(node70_29, node70_31).
edge(node70_25, node70_32).
edge(node70_32, node70_33).
edge(node70_32, node70_34).
edge(node70_5, node70_35).
edge(node70_35, node70_36).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% soucasti byl i znalostni test. 
tree_root(node71_0).
:- %%%%%%%% node71_0 %%%%%%%%%%%%%%%%%%%
node(node71_0).
id(node71_0, t_plzensky51278_txt_001_p2s5).         const(t_plzensky51278_txt_001_p2s5).
%%%%%%%% node71_1 %%%%%%%%%%%%%%%%%%%
node(node71_1).
functor(node71_1, pred).         const(pred).
gram_sempos(node71_1, v).         const(v).
id(node71_1, t_plzensky51278_txt_001_p2s5a1).         const(t_plzensky51278_txt_001_p2s5a1).
t_lemma(node71_1, byt).         const(byt).
%%%%%%%% node71_2 %%%%%%%%%%%%%%%%%%%
node(node71_2).
functor(node71_2, pat).         const(pat).
gram_sempos(node71_2, n_denot).         const(n_denot).
id(node71_2, t_plzensky51278_txt_001_p2s5a2).         const(t_plzensky51278_txt_001_p2s5a2).
t_lemma(node71_2, soucast).         const(soucast).
%%%%%%%% node71_3 %%%%%%%%%%%%%%%%%%%
node(node71_3).
a_afun(node71_3, pnom).         const(pnom).
m_form(node71_3, soucasti).         const(soucasti).
m_lemma(node71_3, soucast).         const(soucast).
m_tag(node71_3, nnfs7_____a____).         const(nnfs7_____a____).
m_tag0(node71_3,'n'). const('n'). m_tag1(node71_3,'n'). const('n'). m_tag2(node71_3,'f'). const('f'). m_tag3(node71_3,'s'). const('s'). m_tag4(node71_3,'7'). const('7'). m_tag10(node71_3,'a'). const('a'). 
%%%%%%%% node71_4 %%%%%%%%%%%%%%%%%%%
node(node71_4).
a_afun(node71_4, pred).         const(pred).
m_form(node71_4, byl).         const(byl).
m_lemma(node71_4, byt).         const(byt).
m_tag(node71_4, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node71_4,'v'). const('v'). m_tag1(node71_4,'p'). const('p'). m_tag2(node71_4,'y'). const('y'). m_tag3(node71_4,'s'). const('s'). m_tag7(node71_4,'x'). const('x'). m_tag8(node71_4,'r'). const('r'). m_tag10(node71_4,'a'). const('a'). m_tag11(node71_4,'a'). const('a'). 
%%%%%%%% node71_5 %%%%%%%%%%%%%%%%%%%
node(node71_5).
functor(node71_5, act).         const(act).
gram_sempos(node71_5, n_denot).         const(n_denot).
id(node71_5, t_plzensky51278_txt_001_p2s5a3).         const(t_plzensky51278_txt_001_p2s5a3).
t_lemma(node71_5, test).         const(test).
%%%%%%%% node71_6 %%%%%%%%%%%%%%%%%%%
node(node71_6).
functor(node71_6, conj).         const(conj).
id(node71_6, t_plzensky51278_txt_001_p2s5a4).         const(t_plzensky51278_txt_001_p2s5a4).
t_lemma(node71_6, i).         const(i).
%%%%%%%% node71_7 %%%%%%%%%%%%%%%%%%%
node(node71_7).
a_afun(node71_7, coord).         const(coord).
m_form(node71_7, i).         const(i).
m_lemma(node71_7, i_1).         const(i_1).
m_tag(node71_7, j______________).         const(j______________).
m_tag0(node71_7,'j'). const('j'). m_tag1(node71_7,'^'). const('^'). 
%%%%%%%% node71_8 %%%%%%%%%%%%%%%%%%%
node(node71_8).
functor(node71_8, rstr).         const(rstr).
gram_sempos(node71_8, adj_denot).         const(adj_denot).
id(node71_8, t_plzensky51278_txt_001_p2s5a5).         const(t_plzensky51278_txt_001_p2s5a5).
t_lemma(node71_8, znalostni).         const(znalostni).
%%%%%%%% node71_9 %%%%%%%%%%%%%%%%%%%
node(node71_9).
a_afun(node71_9, atr).         const(atr).
m_form(node71_9, znalostni).         const(znalostni).
m_lemma(node71_9, znalostni).         const(znalostni).
m_tag(node71_9, aais1____1a____).         const(aais1____1a____).
m_tag0(node71_9,'a'). const('a'). m_tag1(node71_9,'a'). const('a'). m_tag2(node71_9,'i'). const('i'). m_tag3(node71_9,'s'). const('s'). m_tag4(node71_9,'1'). const('1'). m_tag9(node71_9,'1'). const('1'). m_tag10(node71_9,'a'). const('a'). 
%%%%%%%% node71_10 %%%%%%%%%%%%%%%%%%%
node(node71_10).
a_afun(node71_10, sb).         const(sb).
m_form(node71_10, test).         const(test).
m_lemma(node71_10, test).         const(test).
m_tag(node71_10, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node71_10,'n'). const('n'). m_tag1(node71_10,'n'). const('n'). m_tag2(node71_10,'i'). const('i'). m_tag3(node71_10,'s'). const('s'). m_tag4(node71_10,'1'). const('1'). m_tag10(node71_10,'a'). const('a'). 
edge(node71_0, node71_1).
edge(node71_1, node71_2).
edge(node71_2, node71_3).
edge(node71_1, node71_4).
edge(node71_1, node71_5).
edge(node71_5, node71_6).
edge(node71_6, node71_7).
edge(node71_5, node71_8).
edge(node71_8, node71_9).
edge(node71_5, node71_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vse zpestri discipliny, ve kterych budou moci soutezici prokazat aktivitu, rychly usudek a rozhodnost. 
tree_root(node72_0).
:- %%%%%%%% node72_0 %%%%%%%%%%%%%%%%%%%
node(node72_0).
id(node72_0, t_plzensky51278_txt_001_p2s6).         const(t_plzensky51278_txt_001_p2s6).
%%%%%%%% node72_1 %%%%%%%%%%%%%%%%%%%
node(node72_1).
functor(node72_1, pred).         const(pred).
gram_sempos(node72_1, v).         const(v).
id(node72_1, t_plzensky51278_txt_001_p2s6a1).         const(t_plzensky51278_txt_001_p2s6a1).
t_lemma(node72_1, zpestret).         const(zpestret).
%%%%%%%% node72_2 %%%%%%%%%%%%%%%%%%%
node(node72_2).
functor(node72_2, compl).         const(compl).
gram_sempos(node72_2, adj_pron_indef).         const(adj_pron_indef).
id(node72_2, t_plzensky51278_txt_001_p2s6a2).         const(t_plzensky51278_txt_001_p2s6a2).
t_lemma(node72_2, ktery).         const(ktery).
%%%%%%%% node72_3 %%%%%%%%%%%%%%%%%%%
node(node72_3).
a_afun(node72_3, atvv).         const(atvv).
m_form(node72_3, vse).         const(vse).
m_lemma(node72_3, vsechen).         const(vsechen).
m_tag(node72_3, plns1_________1).         const(plns1_________1).
m_tag0(node72_3,'p'). const('p'). m_tag1(node72_3,'l'). const('l'). m_tag2(node72_3,'n'). const('n'). m_tag3(node72_3,'s'). const('s'). m_tag4(node72_3,'1'). const('1'). m_tag14(node72_3,'1'). const('1'). 
%%%%%%%% node72_4 %%%%%%%%%%%%%%%%%%%
node(node72_4).
a_afun(node72_4, pred).         const(pred).
m_form(node72_4, zpestri).         const(zpestri).
m_lemma(node72_4, zpestret__w__s).         const(zpestret__w__s).
m_tag(node72_4, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node72_4,'v'). const('v'). m_tag1(node72_4,'b'). const('b'). m_tag3(node72_4,'s'). const('s'). m_tag7(node72_4,'3'). const('3'). m_tag8(node72_4,'p'). const('p'). m_tag10(node72_4,'a'). const('a'). m_tag11(node72_4,'a'). const('a'). 
%%%%%%%% node72_5 %%%%%%%%%%%%%%%%%%%
node(node72_5).
functor(node72_5, conj).         const(conj).
id(node72_5, t_plzensky51278_txt_001_p2s6a3).         const(t_plzensky51278_txt_001_p2s6a3).
t_lemma(node72_5, a).         const(a).
%%%%%%%% node72_6 %%%%%%%%%%%%%%%%%%%
node(node72_6).
functor(node72_6, act).         const(act).
gram_sempos(node72_6, n_denot).         const(n_denot).
id(node72_6, t_plzensky51278_txt_001_p2s6a4).         const(t_plzensky51278_txt_001_p2s6a4).
t_lemma(node72_6, disciplina).         const(disciplina).
%%%%%%%% node72_7 %%%%%%%%%%%%%%%%%%%
node(node72_7).
a_afun(node72_7, sb).         const(sb).
m_form(node72_7, discipliny).         const(discipliny).
m_lemma(node72_7, disciplina).         const(disciplina).
m_tag(node72_7, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node72_7,'n'). const('n'). m_tag1(node72_7,'n'). const('n'). m_tag2(node72_7,'f'). const('f'). m_tag3(node72_7,'p'). const('p'). m_tag4(node72_7,'1'). const('1'). m_tag10(node72_7,'a'). const('a'). 
%%%%%%%% node72_8 %%%%%%%%%%%%%%%%%%%
node(node72_8).
functor(node72_8, rstr).         const(rstr).
gram_sempos(node72_8, v).         const(v).
id(node72_8, t_plzensky51278_txt_001_p2s6a11).         const(t_plzensky51278_txt_001_p2s6a11).
t_lemma(node72_8, prokazat).         const(prokazat).
%%%%%%%% node72_9 %%%%%%%%%%%%%%%%%%%
node(node72_9).
functor(node72_9, act).         const(act).
id(node72_9, t_plzensky51278_txt_001_p2s6a17).         const(t_plzensky51278_txt_001_p2s6a17).
t_lemma(node72_9, x_perspron).         const(x_perspron).
%%%%%%%% node72_10 %%%%%%%%%%%%%%%%%%%
node(node72_10).
functor(node72_10, loc).         const(loc).
gram_sempos(node72_10, n_pron_indef).         const(n_pron_indef).
id(node72_10, t_plzensky51278_txt_001_p2s6a8).         const(t_plzensky51278_txt_001_p2s6a8).
t_lemma(node72_10, ktery).         const(ktery).
%%%%%%%% node72_11 %%%%%%%%%%%%%%%%%%%
node(node72_11).
a_afun(node72_11, auxp).         const(auxp).
m_form(node72_11, ve).         const(ve).
m_lemma(node72_11, v_1).         const(v_1).
m_tag(node72_11, rv__6__________).         const(rv__6__________).
m_tag0(node72_11,'r'). const('r'). m_tag1(node72_11,'v'). const('v'). m_tag4(node72_11,'6'). const('6'). 
%%%%%%%% node72_12 %%%%%%%%%%%%%%%%%%%
node(node72_12).
a_afun(node72_12, adv).         const(adv).
m_form(node72_12, kterych).         const(kterych).
m_lemma(node72_12, ktery).         const(ktery).
m_tag(node72_12, p4xp6__________).         const(p4xp6__________).
m_tag0(node72_12,'p'). const('p'). m_tag1(node72_12,'4'). const('4'). m_tag2(node72_12,'x'). const('x'). m_tag3(node72_12,'p'). const('p'). m_tag4(node72_12,'6'). const('6'). 
%%%%%%%% node72_13 %%%%%%%%%%%%%%%%%%%
node(node72_13).
functor(node72_13, rstr).         const(rstr).
gram_sempos(node72_13, n_denot).         const(n_denot).
id(node72_13, t_plzensky51278_txt_001_p2s6a10).         const(t_plzensky51278_txt_001_p2s6a10).
t_lemma(node72_13, soutezici).         const(soutezici).
%%%%%%%% node72_14 %%%%%%%%%%%%%%%%%%%
node(node72_14).
a_afun(node72_14, obj).         const(obj).
m_form(node72_14, soutezici).         const(soutezici).
m_lemma(node72_14, soutezici____3it_).         const(soutezici____3it_).
m_tag(node72_14, agns1_____a____).         const(agns1_____a____).
m_tag0(node72_14,'a'). const('a'). m_tag1(node72_14,'g'). const('g'). m_tag2(node72_14,'n'). const('n'). m_tag3(node72_14,'s'). const('s'). m_tag4(node72_14,'1'). const('1'). m_tag10(node72_14,'a'). const('a'). 
%%%%%%%% node72_15 %%%%%%%%%%%%%%%%%%%
node(node72_15).
a_afun(node72_15, auxv).         const(auxv).
m_form(node72_15, budou).         const(budou).
m_lemma(node72_15, byt).         const(byt).
m_tag(node72_15, vb_p___3f_aa___).         const(vb_p___3f_aa___).
m_tag0(node72_15,'v'). const('v'). m_tag1(node72_15,'b'). const('b'). m_tag3(node72_15,'p'). const('p'). m_tag7(node72_15,'3'). const('3'). m_tag8(node72_15,'f'). const('f'). m_tag10(node72_15,'a'). const('a'). m_tag11(node72_15,'a'). const('a'). 
%%%%%%%% node72_16 %%%%%%%%%%%%%%%%%%%
node(node72_16).
a_afun(node72_16, atr).         const(atr).
m_form(node72_16, moci).         const(moci).
m_lemma(node72_16, moci___mit_moznost__neco_delat__).         const(moci___mit_moznost__neco_delat__).
m_tag(node72_16, vf________a____).         const(vf________a____).
m_tag0(node72_16,'v'). const('v'). m_tag1(node72_16,'f'). const('f'). m_tag10(node72_16,'a'). const('a'). 
%%%%%%%% node72_17 %%%%%%%%%%%%%%%%%%%
node(node72_17).
a_afun(node72_17, obj).         const(obj).
m_form(node72_17, prokazat).         const(prokazat).
m_lemma(node72_17, prokazat).         const(prokazat).
m_tag(node72_17, vf________a____).         const(vf________a____).
m_tag0(node72_17,'v'). const('v'). m_tag1(node72_17,'f'). const('f'). m_tag10(node72_17,'a'). const('a'). 
%%%%%%%% node72_18 %%%%%%%%%%%%%%%%%%%
node(node72_18).
functor(node72_18, pat).         const(pat).
gram_sempos(node72_18, n_denot).         const(n_denot).
id(node72_18, t_plzensky51278_txt_001_p2s6a12).         const(t_plzensky51278_txt_001_p2s6a12).
t_lemma(node72_18, aktivita).         const(aktivita).
%%%%%%%% node72_19 %%%%%%%%%%%%%%%%%%%
node(node72_19).
a_afun(node72_19, obj).         const(obj).
m_form(node72_19, aktivitu).         const(aktivitu).
m_lemma(node72_19, aktivita).         const(aktivita).
m_tag(node72_19, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node72_19,'n'). const('n'). m_tag1(node72_19,'n'). const('n'). m_tag2(node72_19,'f'). const('f'). m_tag3(node72_19,'s'). const('s'). m_tag4(node72_19,'4'). const('4'). m_tag10(node72_19,'a'). const('a'). 
%%%%%%%% node72_20 %%%%%%%%%%%%%%%%%%%
node(node72_20).
functor(node72_20, rstr).         const(rstr).
gram_sempos(node72_20, n_denot).         const(n_denot).
id(node72_20, t_plzensky51278_txt_001_p2s6a14).         const(t_plzensky51278_txt_001_p2s6a14).
t_lemma(node72_20, usudek).         const(usudek).
%%%%%%%% node72_21 %%%%%%%%%%%%%%%%%%%
node(node72_21).
functor(node72_21, rstr).         const(rstr).
gram_sempos(node72_21, adj_denot).         const(adj_denot).
id(node72_21, t_plzensky51278_txt_001_p2s6a15).         const(t_plzensky51278_txt_001_p2s6a15).
t_lemma(node72_21, rychly).         const(rychly).
%%%%%%%% node72_22 %%%%%%%%%%%%%%%%%%%
node(node72_22).
a_afun(node72_22, atr).         const(atr).
m_form(node72_22, rychly).         const(rychly).
m_lemma(node72_22, rychly).         const(rychly).
m_tag(node72_22, aais4____1a____).         const(aais4____1a____).
m_tag0(node72_22,'a'). const('a'). m_tag1(node72_22,'a'). const('a'). m_tag2(node72_22,'i'). const('i'). m_tag3(node72_22,'s'). const('s'). m_tag4(node72_22,'4'). const('4'). m_tag9(node72_22,'1'). const('1'). m_tag10(node72_22,'a'). const('a'). 
%%%%%%%% node72_23 %%%%%%%%%%%%%%%%%%%
node(node72_23).
a_afun(node72_23, obj).         const(obj).
m_form(node72_23, usudek).         const(usudek).
m_lemma(node72_23, usudek).         const(usudek).
m_tag(node72_23, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node72_23,'n'). const('n'). m_tag1(node72_23,'n'). const('n'). m_tag2(node72_23,'i'). const('i'). m_tag3(node72_23,'s'). const('s'). m_tag4(node72_23,'4'). const('4'). m_tag10(node72_23,'a'). const('a'). 
%%%%%%%% node72_24 %%%%%%%%%%%%%%%%%%%
node(node72_24).
a_afun(node72_24, coord).         const(coord).
m_form(node72_24, a).         const(a).
m_lemma(node72_24, a_1).         const(a_1).
m_tag(node72_24, j______________).         const(j______________).
m_tag0(node72_24,'j'). const('j'). m_tag1(node72_24,'^'). const('^'). 
%%%%%%%% node72_25 %%%%%%%%%%%%%%%%%%%
node(node72_25).
functor(node72_25, act).         const(act).
gram_sempos(node72_25, n_denot_neg).         const(n_denot_neg).
id(node72_25, t_plzensky51278_txt_001_p2s6a16).         const(t_plzensky51278_txt_001_p2s6a16).
t_lemma(node72_25, rozhodnost).         const(rozhodnost).
%%%%%%%% node72_26 %%%%%%%%%%%%%%%%%%%
node(node72_26).
a_afun(node72_26, sb).         const(sb).
m_form(node72_26, rozhodnost).         const(rozhodnost).
m_lemma(node72_26, rozhodnost____3y_).         const(rozhodnost____3y_).
m_tag(node72_26, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node72_26,'n'). const('n'). m_tag1(node72_26,'n'). const('n'). m_tag2(node72_26,'f'). const('f'). m_tag3(node72_26,'s'). const('s'). m_tag4(node72_26,'1'). const('1'). m_tag10(node72_26,'a'). const('a'). 
edge(node72_0, node72_1).
edge(node72_1, node72_2).
edge(node72_2, node72_3).
edge(node72_1, node72_4).
edge(node72_1, node72_5).
edge(node72_5, node72_6).
edge(node72_6, node72_7).
edge(node72_6, node72_8).
edge(node72_8, node72_9).
edge(node72_8, node72_10).
edge(node72_10, node72_11).
edge(node72_10, node72_12).
edge(node72_8, node72_13).
edge(node72_13, node72_14).
edge(node72_8, node72_15).
edge(node72_8, node72_16).
edge(node72_8, node72_17).
edge(node72_8, node72_18).
edge(node72_18, node72_19).
edge(node72_5, node72_20).
edge(node72_20, node72_21).
edge(node72_21, node72_22).
edge(node72_20, node72_23).
edge(node72_5, node72_24).
edge(node72_5, node72_25).
edge(node72_25, node72_26).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% strikalo se na terc a prenaseli se raneni.ukoly soutezni druzstva plnila na nekolika stanovistich. 
tree_root(node73_0).
:- %%%%%%%% node73_0 %%%%%%%%%%%%%%%%%%%
node(node73_0).
id(node73_0, t_plzensky51278_txt_001_p2s7).         const(t_plzensky51278_txt_001_p2s7).
%%%%%%%% node73_1 %%%%%%%%%%%%%%%%%%%
node(node73_1).
functor(node73_1, pred).         const(pred).
gram_sempos(node73_1, v).         const(v).
id(node73_1, t_plzensky51278_txt_001_p2s7a1).         const(t_plzensky51278_txt_001_p2s7a1).
t_lemma(node73_1, plnit).         const(plnit).
%%%%%%%% node73_2 %%%%%%%%%%%%%%%%%%%
node(node73_2).
functor(node73_2, pat).         const(pat).
id(node73_2, t_plzensky51278_txt_001_p2s7a18).         const(t_plzensky51278_txt_001_p2s7a18).
t_lemma(node73_2, x_gen).         const(x_gen).
%%%%%%%% node73_3 %%%%%%%%%%%%%%%%%%%
node(node73_3).
functor(node73_3, act).         const(act).
gram_sempos(node73_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node73_3, t_plzensky51278_txt_001_p2s7a17).         const(t_plzensky51278_txt_001_p2s7a17).
t_lemma(node73_3, x_perspron).         const(x_perspron).
%%%%%%%% node73_4 %%%%%%%%%%%%%%%%%%%
node(node73_4).
functor(node73_4, conj).         const(conj).
id(node73_4, t_plzensky51278_txt_001_p2s7a2).         const(t_plzensky51278_txt_001_p2s7a2).
t_lemma(node73_4, a).         const(a).
%%%%%%%% node73_5 %%%%%%%%%%%%%%%%%%%
node(node73_5).
functor(node73_5, act).         const(act).
gram_sempos(node73_5, n_pron_def_pers).         const(n_pron_def_pers).
id(node73_5, t_plzensky51278_txt_001_p2s7a22).         const(t_plzensky51278_txt_001_p2s7a22).
t_lemma(node73_5, x_perspron).         const(x_perspron).
%%%%%%%% node73_6 %%%%%%%%%%%%%%%%%%%
node(node73_6).
functor(node73_6, rstr).         const(rstr).
gram_sempos(node73_6, v).         const(v).
id(node73_6, t_plzensky51278_txt_001_p2s7a3).         const(t_plzensky51278_txt_001_p2s7a3).
t_lemma(node73_6, strikat).         const(strikat).
%%%%%%%% node73_7 %%%%%%%%%%%%%%%%%%%
node(node73_7).
a_afun(node73_7, obj).         const(obj).
m_form(node73_7, strikalo).         const(strikalo).
m_lemma(node73_7, strikat__t).         const(strikat__t).
m_tag(node73_7, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node73_7,'v'). const('v'). m_tag1(node73_7,'p'). const('p'). m_tag2(node73_7,'n'). const('n'). m_tag3(node73_7,'s'). const('s'). m_tag7(node73_7,'x'). const('x'). m_tag8(node73_7,'r'). const('r'). m_tag10(node73_7,'a'). const('a'). m_tag11(node73_7,'a'). const('a'). 
%%%%%%%% node73_8 %%%%%%%%%%%%%%%%%%%
node(node73_8).
a_afun(node73_8, auxt).         const(auxt).
m_form(node73_8, se).         const(se).
m_lemma(node73_8, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node73_8, p7_x4__________).         const(p7_x4__________).
m_tag0(node73_8,'p'). const('p'). m_tag1(node73_8,'7'). const('7'). m_tag3(node73_8,'x'). const('x'). m_tag4(node73_8,'4'). const('4'). 
%%%%%%%% node73_9 %%%%%%%%%%%%%%%%%%%
node(node73_9).
functor(node73_9, dir3).         const(dir3).
gram_sempos(node73_9, n_denot).         const(n_denot).
id(node73_9, t_plzensky51278_txt_001_p2s7a6).         const(t_plzensky51278_txt_001_p2s7a6).
t_lemma(node73_9, terc).         const(terc).
%%%%%%%% node73_10 %%%%%%%%%%%%%%%%%%%
node(node73_10).
a_afun(node73_10, auxp).         const(auxp).
m_form(node73_10, na).         const(na).
m_lemma(node73_10, na_1).         const(na_1).
m_tag(node73_10, rr__4__________).         const(rr__4__________).
m_tag0(node73_10,'r'). const('r'). m_tag1(node73_10,'r'). const('r'). m_tag4(node73_10,'4'). const('4'). 
%%%%%%%% node73_11 %%%%%%%%%%%%%%%%%%%
node(node73_11).
a_afun(node73_11, adv).         const(adv).
m_form(node73_11, terc).         const(terc).
m_lemma(node73_11, terc).         const(terc).
m_tag(node73_11, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node73_11,'n'). const('n'). m_tag1(node73_11,'n'). const('n'). m_tag2(node73_11,'i'). const('i'). m_tag3(node73_11,'s'). const('s'). m_tag4(node73_11,'4'). const('4'). m_tag10(node73_11,'a'). const('a'). 
%%%%%%%% node73_12 %%%%%%%%%%%%%%%%%%%
node(node73_12).
a_afun(node73_12, coord).         const(coord).
m_form(node73_12, a).         const(a).
m_lemma(node73_12, a_1).         const(a_1).
m_tag(node73_12, j______________).         const(j______________).
m_tag0(node73_12,'j'). const('j'). m_tag1(node73_12,'^'). const('^'). 
%%%%%%%% node73_13 %%%%%%%%%%%%%%%%%%%
node(node73_13).
functor(node73_13, rstr).         const(rstr).
gram_sempos(node73_13, v).         const(v).
id(node73_13, t_plzensky51278_txt_001_p2s7a7).         const(t_plzensky51278_txt_001_p2s7a7).
t_lemma(node73_13, prenaset).         const(prenaset).
%%%%%%%% node73_14 %%%%%%%%%%%%%%%%%%%
node(node73_14).
a_afun(node73_14, obj).         const(obj).
m_form(node73_14, prenaseli).         const(prenaseli).
m_lemma(node73_14, prenaset__t).         const(prenaset__t).
m_tag(node73_14, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node73_14,'v'). const('v'). m_tag1(node73_14,'p'). const('p'). m_tag2(node73_14,'m'). const('m'). m_tag3(node73_14,'p'). const('p'). m_tag7(node73_14,'x'). const('x'). m_tag8(node73_14,'r'). const('r'). m_tag10(node73_14,'a'). const('a'). m_tag11(node73_14,'a'). const('a'). 
%%%%%%%% node73_15 %%%%%%%%%%%%%%%%%%%
node(node73_15).
a_afun(node73_15, auxt).         const(auxt).
m_form(node73_15, se).         const(se).
m_lemma(node73_15, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node73_15, p7_x4__________).         const(p7_x4__________).
m_tag0(node73_15,'p'). const('p'). m_tag1(node73_15,'7'). const('7'). m_tag3(node73_15,'x'). const('x'). m_tag4(node73_15,'4'). const('4'). 
%%%%%%%% node73_16 %%%%%%%%%%%%%%%%%%%
node(node73_16).
functor(node73_16, dir1).         const(dir1).
id(node73_16, t_plzensky51278_txt_001_p2s7a21).         const(t_plzensky51278_txt_001_p2s7a21).
t_lemma(node73_16, x_oblfm).         const(x_oblfm).
%%%%%%%% node73_17 %%%%%%%%%%%%%%%%%%%
node(node73_17).
functor(node73_17, rstr).         const(rstr).
id(node73_17, t_plzensky51278_txt_001_p2s7a9).         const(t_plzensky51278_txt_001_p2s7a9).
t_lemma(node73_17, x_period).         const(x_period).
%%%%%%%% node73_18 %%%%%%%%%%%%%%%%%%%
node(node73_18).
functor(node73_18, rstr).         const(rstr).
gram_sempos(node73_18, n_denot).         const(n_denot).
id(node73_18, t_plzensky51278_txt_001_p2s7a10).         const(t_plzensky51278_txt_001_p2s7a10).
t_lemma(node73_18, raneni).         const(raneni).
%%%%%%%% node73_19 %%%%%%%%%%%%%%%%%%%
node(node73_19).
a_afun(node73_19, sb).         const(sb).
m_form(node73_19, raneni).         const(raneni).
m_lemma(node73_19, raneni___poranit____3it_).         const(raneni___poranit____3it_).
m_tag(node73_19, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node73_19,'n'). const('n'). m_tag1(node73_19,'n'). const('n'). m_tag2(node73_19,'n'). const('n'). m_tag3(node73_19,'s'). const('s'). m_tag4(node73_19,'1'). const('1'). m_tag10(node73_19,'a'). const('a'). 
%%%%%%%% node73_20 %%%%%%%%%%%%%%%%%%%
node(node73_20).
a_afun(node73_20, auxg).         const(auxg).
m_form(node73_20, x_).         const(x_).
m_lemma(node73_20, x_).         const(x_).
m_tag(node73_20, z______________).         const(z______________).
m_tag0(node73_20,'z'). const('z'). m_tag1(node73_20,':'). const(':'). 
%%%%%%%% node73_21 %%%%%%%%%%%%%%%%%%%
node(node73_21).
functor(node73_21, app).         const(app).
gram_sempos(node73_21, n_denot).         const(n_denot).
id(node73_21, t_plzensky51278_txt_001_p2s7a12).         const(t_plzensky51278_txt_001_p2s7a12).
t_lemma(node73_21, druzstvo).         const(druzstvo).
%%%%%%%% node73_22 %%%%%%%%%%%%%%%%%%%
node(node73_22).
functor(node73_22, rstr).         const(rstr).
gram_sempos(node73_22, n_denot).         const(n_denot).
id(node73_22, t_plzensky51278_txt_001_p2s7a11).         const(t_plzensky51278_txt_001_p2s7a11).
t_lemma(node73_22, ukol).         const(ukol).
%%%%%%%% node73_23 %%%%%%%%%%%%%%%%%%%
node(node73_23).
a_afun(node73_23, sb).         const(sb).
m_form(node73_23, ukoly).         const(ukoly).
m_lemma(node73_23, ukol).         const(ukol).
m_tag(node73_23, nnip1_____a____).         const(nnip1_____a____).
m_tag0(node73_23,'n'). const('n'). m_tag1(node73_23,'n'). const('n'). m_tag2(node73_23,'i'). const('i'). m_tag3(node73_23,'p'). const('p'). m_tag4(node73_23,'1'). const('1'). m_tag10(node73_23,'a'). const('a'). 
%%%%%%%% node73_24 %%%%%%%%%%%%%%%%%%%
node(node73_24).
functor(node73_24, rstr).         const(rstr).
gram_sempos(node73_24, adj_denot).         const(adj_denot).
id(node73_24, t_plzensky51278_txt_001_p2s7a13).         const(t_plzensky51278_txt_001_p2s7a13).
t_lemma(node73_24, soutezni).         const(soutezni).
%%%%%%%% node73_25 %%%%%%%%%%%%%%%%%%%
node(node73_25).
a_afun(node73_25, atr).         const(atr).
m_form(node73_25, soutezni).         const(soutezni).
m_lemma(node73_25, soutezni).         const(soutezni).
m_tag(node73_25, aans1____1a____).         const(aans1____1a____).
m_tag0(node73_25,'a'). const('a'). m_tag1(node73_25,'a'). const('a'). m_tag2(node73_25,'n'). const('n'). m_tag3(node73_25,'s'). const('s'). m_tag4(node73_25,'1'). const('1'). m_tag9(node73_25,'1'). const('1'). m_tag10(node73_25,'a'). const('a'). 
%%%%%%%% node73_26 %%%%%%%%%%%%%%%%%%%
node(node73_26).
a_afun(node73_26, atr).         const(atr).
m_form(node73_26, druzstva).         const(druzstva).
m_lemma(node73_26, druzstvo).         const(druzstvo).
m_tag(node73_26, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node73_26,'n'). const('n'). m_tag1(node73_26,'n'). const('n'). m_tag2(node73_26,'n'). const('n'). m_tag3(node73_26,'s'). const('s'). m_tag4(node73_26,'2'). const('2'). m_tag10(node73_26,'a'). const('a'). 
%%%%%%%% node73_27 %%%%%%%%%%%%%%%%%%%
node(node73_27).
a_afun(node73_27, pred).         const(pred).
m_form(node73_27, plnila).         const(plnila).
m_lemma(node73_27, plnit__t).         const(plnit__t).
m_tag(node73_27, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node73_27,'v'). const('v'). m_tag1(node73_27,'p'). const('p'). m_tag2(node73_27,'q'). const('q'). m_tag3(node73_27,'w'). const('w'). m_tag7(node73_27,'x'). const('x'). m_tag8(node73_27,'r'). const('r'). m_tag10(node73_27,'a'). const('a'). m_tag11(node73_27,'a'). const('a'). 
%%%%%%%% node73_28 %%%%%%%%%%%%%%%%%%%
node(node73_28).
functor(node73_28, loc).         const(loc).
gram_sempos(node73_28, n_denot).         const(n_denot).
id(node73_28, t_plzensky51278_txt_001_p2s7a15).         const(t_plzensky51278_txt_001_p2s7a15).
t_lemma(node73_28, stanoviste).         const(stanoviste).
%%%%%%%% node73_29 %%%%%%%%%%%%%%%%%%%
node(node73_29).
functor(node73_29, rstr).         const(rstr).
gram_sempos(node73_29, adj_quant_indef).         const(adj_quant_indef).
id(node73_29, t_plzensky51278_txt_001_p2s7a16).         const(t_plzensky51278_txt_001_p2s7a16).
t_lemma(node73_29, kolik).         const(kolik).
%%%%%%%% node73_30 %%%%%%%%%%%%%%%%%%%
node(node73_30).
a_afun(node73_30, atr).         const(atr).
m_form(node73_30, nekolika).         const(nekolika).
m_lemma(node73_30, nekolik).         const(nekolik).
m_tag(node73_30, ca__6__________).         const(ca__6__________).
m_tag0(node73_30,'c'). const('c'). m_tag1(node73_30,'a'). const('a'). m_tag4(node73_30,'6'). const('6'). 
%%%%%%%% node73_31 %%%%%%%%%%%%%%%%%%%
node(node73_31).
a_afun(node73_31, auxp).         const(auxp).
m_form(node73_31, na).         const(na).
m_lemma(node73_31, na_1).         const(na_1).
m_tag(node73_31, rr__6__________).         const(rr__6__________).
m_tag0(node73_31,'r'). const('r'). m_tag1(node73_31,'r'). const('r'). m_tag4(node73_31,'6'). const('6'). 
%%%%%%%% node73_32 %%%%%%%%%%%%%%%%%%%
node(node73_32).
a_afun(node73_32, adv).         const(adv).
m_form(node73_32, stanovistich).         const(stanovistich).
m_lemma(node73_32, stanoviste).         const(stanoviste).
m_tag(node73_32, nnnp6_____a____).         const(nnnp6_____a____).
m_tag0(node73_32,'n'). const('n'). m_tag1(node73_32,'n'). const('n'). m_tag2(node73_32,'n'). const('n'). m_tag3(node73_32,'p'). const('p'). m_tag4(node73_32,'6'). const('6'). m_tag10(node73_32,'a'). const('a'). 
edge(node73_0, node73_1).
edge(node73_1, node73_2).
edge(node73_1, node73_3).
edge(node73_1, node73_4).
edge(node73_4, node73_5).
edge(node73_4, node73_6).
edge(node73_6, node73_7).
edge(node73_6, node73_8).
edge(node73_6, node73_9).
edge(node73_9, node73_10).
edge(node73_9, node73_11).
edge(node73_4, node73_12).
edge(node73_4, node73_13).
edge(node73_13, node73_14).
edge(node73_13, node73_15).
edge(node73_13, node73_16).
edge(node73_13, node73_17).
edge(node73_17, node73_18).
edge(node73_18, node73_19).
edge(node73_17, node73_20).
edge(node73_17, node73_21).
edge(node73_21, node73_22).
edge(node73_22, node73_23).
edge(node73_21, node73_24).
edge(node73_24, node73_25).
edge(node73_21, node73_26).
edge(node73_1, node73_27).
edge(node73_1, node73_28).
edge(node73_28, node73_29).
edge(node73_29, node73_30).
edge(node73_28, node73_31).
edge(node73_28, node73_32).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% na jednom ze stanovist byly i pracovnice zdravotniho ustavu se sidlem v plzni, kde deti cekaly otazky z problematiky prevence a ochrany zdravi pri sportu, dopravnich nehodach a jinych udalostech. 
tree_root(node74_0).
:- %%%%%%%% node74_0 %%%%%%%%%%%%%%%%%%%
node(node74_0).
id(node74_0, t_plzensky51278_txt_001_p2s8).         const(t_plzensky51278_txt_001_p2s8).
%%%%%%%% node74_1 %%%%%%%%%%%%%%%%%%%
node(node74_1).
functor(node74_1, pred).         const(pred).
gram_sempos(node74_1, v).         const(v).
id(node74_1, t_plzensky51278_txt_001_p2s8a1).         const(t_plzensky51278_txt_001_p2s8a1).
t_lemma(node74_1, byt).         const(byt).
%%%%%%%% node74_2 %%%%%%%%%%%%%%%%%%%
node(node74_2).
functor(node74_2, loc).         const(loc).
gram_sempos(node74_2, n_quant_def).         const(n_quant_def).
id(node74_2, t_plzensky51278_txt_001_p2s8a3).         const(t_plzensky51278_txt_001_p2s8a3).
t_lemma(node74_2, jeden).         const(jeden).
%%%%%%%% node74_3 %%%%%%%%%%%%%%%%%%%
node(node74_3).
a_afun(node74_3, auxp).         const(auxp).
m_form(node74_3, na).         const(na).
m_lemma(node74_3, na_1).         const(na_1).
m_tag(node74_3, rr__6__________).         const(rr__6__________).
m_tag0(node74_3,'r'). const('r'). m_tag1(node74_3,'r'). const('r'). m_tag4(node74_3,'6'). const('6'). 
%%%%%%%% node74_4 %%%%%%%%%%%%%%%%%%%
node(node74_4).
a_afun(node74_4, adv).         const(adv).
m_form(node74_4, jednom).         const(jednom).
m_lemma(node74_4, jeden_1).         const(jeden_1).
m_tag(node74_4, clzs6__________).         const(clzs6__________).
m_tag0(node74_4,'c'). const('c'). m_tag1(node74_4,'l'). const('l'). m_tag2(node74_4,'z'). const('z'). m_tag3(node74_4,'s'). const('s'). m_tag4(node74_4,'6'). const('6'). 
%%%%%%%% node74_5 %%%%%%%%%%%%%%%%%%%
node(node74_5).
functor(node74_5, dir1).         const(dir1).
gram_sempos(node74_5, n_denot).         const(n_denot).
id(node74_5, t_plzensky51278_txt_001_p2s8a5).         const(t_plzensky51278_txt_001_p2s8a5).
t_lemma(node74_5, stanoviste).         const(stanoviste).
%%%%%%%% node74_6 %%%%%%%%%%%%%%%%%%%
node(node74_6).
a_afun(node74_6, auxp).         const(auxp).
m_form(node74_6, ze).         const(ze).
m_lemma(node74_6, z_1).         const(z_1).
m_tag(node74_6, rv__2__________).         const(rv__2__________).
m_tag0(node74_6,'r'). const('r'). m_tag1(node74_6,'v'). const('v'). m_tag4(node74_6,'2'). const('2'). 
%%%%%%%% node74_7 %%%%%%%%%%%%%%%%%%%
node(node74_7).
a_afun(node74_7, atr).         const(atr).
m_form(node74_7, stanovist).         const(stanovist).
m_lemma(node74_7, stanoviste).         const(stanoviste).
m_tag(node74_7, nnnp2_____a____).         const(nnnp2_____a____).
m_tag0(node74_7,'n'). const('n'). m_tag1(node74_7,'n'). const('n'). m_tag2(node74_7,'n'). const('n'). m_tag3(node74_7,'p'). const('p'). m_tag4(node74_7,'2'). const('2'). m_tag10(node74_7,'a'). const('a'). 
%%%%%%%% node74_8 %%%%%%%%%%%%%%%%%%%
node(node74_8).
a_afun(node74_8, pred).         const(pred).
m_form(node74_8, byly).         const(byly).
m_lemma(node74_8, byt).         const(byt).
m_tag(node74_8, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node74_8,'v'). const('v'). m_tag1(node74_8,'p'). const('p'). m_tag2(node74_8,'t'). const('t'). m_tag3(node74_8,'p'). const('p'). m_tag7(node74_8,'x'). const('x'). m_tag8(node74_8,'r'). const('r'). m_tag10(node74_8,'a'). const('a'). m_tag11(node74_8,'a'). const('a'). 
%%%%%%%% node74_9 %%%%%%%%%%%%%%%%%%%
node(node74_9).
functor(node74_9, act).         const(act).
gram_sempos(node74_9, n_denot).         const(n_denot).
id(node74_9, t_plzensky51278_txt_001_p2s8a6).         const(t_plzensky51278_txt_001_p2s8a6).
t_lemma(node74_9, pracovnice).         const(pracovnice).
%%%%%%%% node74_10 %%%%%%%%%%%%%%%%%%%
node(node74_10).
functor(node74_10, conj).         const(conj).
id(node74_10, t_plzensky51278_txt_001_p2s8a7).         const(t_plzensky51278_txt_001_p2s8a7).
t_lemma(node74_10, i).         const(i).
%%%%%%%% node74_11 %%%%%%%%%%%%%%%%%%%
node(node74_11).
a_afun(node74_11, coord).         const(coord).
m_form(node74_11, i).         const(i).
m_lemma(node74_11, i_1).         const(i_1).
m_tag(node74_11, j______________).         const(j______________).
m_tag0(node74_11,'j'). const('j'). m_tag1(node74_11,'^'). const('^'). 
%%%%%%%% node74_12 %%%%%%%%%%%%%%%%%%%
node(node74_12).
a_afun(node74_12, sb).         const(sb).
m_form(node74_12, pracovnice).         const(pracovnice).
m_lemma(node74_12, pracovnice____3ik_).         const(pracovnice____3ik_).
m_tag(node74_12, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node74_12,'n'). const('n'). m_tag1(node74_12,'n'). const('n'). m_tag2(node74_12,'f'). const('f'). m_tag3(node74_12,'p'). const('p'). m_tag4(node74_12,'1'). const('1'). m_tag10(node74_12,'a'). const('a'). 
%%%%%%%% node74_13 %%%%%%%%%%%%%%%%%%%
node(node74_13).
functor(node74_13, app).         const(app).
gram_sempos(node74_13, n_denot).         const(n_denot).
id(node74_13, t_plzensky51278_txt_001_p2s8a8).         const(t_plzensky51278_txt_001_p2s8a8).
t_lemma(node74_13, ustav).         const(ustav).
%%%%%%%% node74_14 %%%%%%%%%%%%%%%%%%%
node(node74_14).
functor(node74_14, rstr).         const(rstr).
gram_sempos(node74_14, adj_denot).         const(adj_denot).
id(node74_14, t_plzensky51278_txt_001_p2s8a9).         const(t_plzensky51278_txt_001_p2s8a9).
t_lemma(node74_14, zdravotni).         const(zdravotni).
%%%%%%%% node74_15 %%%%%%%%%%%%%%%%%%%
node(node74_15).
a_afun(node74_15, atr).         const(atr).
m_form(node74_15, zdravotniho).         const(zdravotniho).
m_lemma(node74_15, zdravotni).         const(zdravotni).
m_tag(node74_15, aais2____1a____).         const(aais2____1a____).
m_tag0(node74_15,'a'). const('a'). m_tag1(node74_15,'a'). const('a'). m_tag2(node74_15,'i'). const('i'). m_tag3(node74_15,'s'). const('s'). m_tag4(node74_15,'2'). const('2'). m_tag9(node74_15,'1'). const('1'). m_tag10(node74_15,'a'). const('a'). 
%%%%%%%% node74_16 %%%%%%%%%%%%%%%%%%%
node(node74_16).
a_afun(node74_16, atr).         const(atr).
m_form(node74_16, ustavu).         const(ustavu).
m_lemma(node74_16, ustav).         const(ustav).
m_tag(node74_16, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node74_16,'n'). const('n'). m_tag1(node74_16,'n'). const('n'). m_tag2(node74_16,'i'). const('i'). m_tag3(node74_16,'s'). const('s'). m_tag4(node74_16,'2'). const('2'). m_tag10(node74_16,'a'). const('a'). 
%%%%%%%% node74_17 %%%%%%%%%%%%%%%%%%%
node(node74_17).
functor(node74_17, acmp).         const(acmp).
gram_sempos(node74_17, n_denot).         const(n_denot).
id(node74_17, t_plzensky51278_txt_001_p2s8a11).         const(t_plzensky51278_txt_001_p2s8a11).
t_lemma(node74_17, sidlo).         const(sidlo).
%%%%%%%% node74_18 %%%%%%%%%%%%%%%%%%%
node(node74_18).
a_afun(node74_18, auxp).         const(auxp).
m_form(node74_18, se).         const(se).
m_lemma(node74_18, s_1).         const(s_1).
m_tag(node74_18, rv__7__________).         const(rv__7__________).
m_tag0(node74_18,'r'). const('r'). m_tag1(node74_18,'v'). const('v'). m_tag4(node74_18,'7'). const('7'). 
%%%%%%%% node74_19 %%%%%%%%%%%%%%%%%%%
node(node74_19).
a_afun(node74_19, atr).         const(atr).
m_form(node74_19, sidlem).         const(sidlem).
m_lemma(node74_19, sidlo).         const(sidlo).
m_tag(node74_19, nnns7_____a____).         const(nnns7_____a____).
m_tag0(node74_19,'n'). const('n'). m_tag1(node74_19,'n'). const('n'). m_tag2(node74_19,'n'). const('n'). m_tag3(node74_19,'s'). const('s'). m_tag4(node74_19,'7'). const('7'). m_tag10(node74_19,'a'). const('a'). 
%%%%%%%% node74_20 %%%%%%%%%%%%%%%%%%%
node(node74_20).
functor(node74_20, loc).         const(loc).
gram_sempos(node74_20, n_denot).         const(n_denot).
id(node74_20, t_plzensky51278_txt_001_p2s8a13).         const(t_plzensky51278_txt_001_p2s8a13).
t_lemma(node74_20, plzen).         const(plzen).
%%%%%%%% node74_21 %%%%%%%%%%%%%%%%%%%
node(node74_21).
a_afun(node74_21, auxp).         const(auxp).
m_form(node74_21, v).         const(v).
m_lemma(node74_21, v_1).         const(v_1).
m_tag(node74_21, rr__6__________).         const(rr__6__________).
m_tag0(node74_21,'r'). const('r'). m_tag1(node74_21,'r'). const('r'). m_tag4(node74_21,'6'). const('6'). 
%%%%%%%% node74_22 %%%%%%%%%%%%%%%%%%%
node(node74_22).
a_afun(node74_22, atr).         const(atr).
m_form(node74_22, plzni).         const(plzni).
m_lemma(node74_22, plzen__g).         const(plzen__g).
m_tag(node74_22, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node74_22,'n'). const('n'). m_tag1(node74_22,'n'). const('n'). m_tag2(node74_22,'f'). const('f'). m_tag3(node74_22,'s'). const('s'). m_tag4(node74_22,'6'). const('6'). m_tag10(node74_22,'a'). const('a'). 
%%%%%%%% node74_23 %%%%%%%%%%%%%%%%%%%
node(node74_23).
functor(node74_23, rstr).         const(rstr).
gram_sempos(node74_23, v).         const(v).
id(node74_23, t_plzensky51278_txt_001_p2s8a14).         const(t_plzensky51278_txt_001_p2s8a14).
t_lemma(node74_23, cekat).         const(cekat).
%%%%%%%% node74_24 %%%%%%%%%%%%%%%%%%%
node(node74_24).
functor(node74_24, loc).         const(loc).
gram_sempos(node74_24, adv_pron_indef).         const(adv_pron_indef).
id(node74_24, t_plzensky51278_txt_001_p2s8a16).         const(t_plzensky51278_txt_001_p2s8a16).
t_lemma(node74_24, kde).         const(kde).
%%%%%%%% node74_25 %%%%%%%%%%%%%%%%%%%
node(node74_25).
a_afun(node74_25, adv).         const(adv).
m_form(node74_25, kde).         const(kde).
m_lemma(node74_25, kde).         const(kde).
m_tag(node74_25, db_____________).         const(db_____________).
m_tag0(node74_25,'d'). const('d'). m_tag1(node74_25,'b'). const('b'). 
%%%%%%%% node74_26 %%%%%%%%%%%%%%%%%%%
node(node74_26).
functor(node74_26, act).         const(act).
gram_sempos(node74_26, n_denot).         const(n_denot).
id(node74_26, t_plzensky51278_txt_001_p2s8a17).         const(t_plzensky51278_txt_001_p2s8a17).
t_lemma(node74_26, dite).         const(dite).
%%%%%%%% node74_27 %%%%%%%%%%%%%%%%%%%
node(node74_27).
a_afun(node74_27, sb).         const(sb).
m_form(node74_27, deti).         const(deti).
m_lemma(node74_27, dite).         const(dite).
m_tag(node74_27, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node74_27,'n'). const('n'). m_tag1(node74_27,'n'). const('n'). m_tag2(node74_27,'f'). const('f'). m_tag3(node74_27,'p'). const('p'). m_tag4(node74_27,'1'). const('1'). m_tag10(node74_27,'a'). const('a'). 
%%%%%%%% node74_28 %%%%%%%%%%%%%%%%%%%
node(node74_28).
a_afun(node74_28, atr).         const(atr).
m_form(node74_28, cekaly).         const(cekaly).
m_lemma(node74_28, cekat__t).         const(cekat__t).
m_tag(node74_28, vptp___xr_aa___).         const(vptp___xr_aa___).
m_tag0(node74_28,'v'). const('v'). m_tag1(node74_28,'p'). const('p'). m_tag2(node74_28,'t'). const('t'). m_tag3(node74_28,'p'). const('p'). m_tag7(node74_28,'x'). const('x'). m_tag8(node74_28,'r'). const('r'). m_tag10(node74_28,'a'). const('a'). m_tag11(node74_28,'a'). const('a'). 
%%%%%%%% node74_29 %%%%%%%%%%%%%%%%%%%
node(node74_29).
functor(node74_29, act).         const(act).
gram_sempos(node74_29, n_denot).         const(n_denot).
id(node74_29, t_plzensky51278_txt_001_p2s8a18).         const(t_plzensky51278_txt_001_p2s8a18).
t_lemma(node74_29, otazka).         const(otazka).
%%%%%%%% node74_30 %%%%%%%%%%%%%%%%%%%
node(node74_30).
a_afun(node74_30, sb).         const(sb).
m_form(node74_30, otazky).         const(otazky).
m_lemma(node74_30, otazka).         const(otazka).
m_tag(node74_30, nnfp1_____a____).         const(nnfp1_____a____).
m_tag0(node74_30,'n'). const('n'). m_tag1(node74_30,'n'). const('n'). m_tag2(node74_30,'f'). const('f'). m_tag3(node74_30,'p'). const('p'). m_tag4(node74_30,'1'). const('1'). m_tag10(node74_30,'a'). const('a'). 
%%%%%%%% node74_31 %%%%%%%%%%%%%%%%%%%
node(node74_31).
functor(node74_31, conj).         const(conj).
id(node74_31, t_plzensky51278_txt_001_p2s8a20).         const(t_plzensky51278_txt_001_p2s8a20).
t_lemma(node74_31, a).         const(a).
%%%%%%%% node74_32 %%%%%%%%%%%%%%%%%%%
node(node74_32).
functor(node74_32, pat).         const(pat).
gram_sempos(node74_32, n_denot).         const(n_denot).
id(node74_32, t_plzensky51278_txt_001_p2s8a21).         const(t_plzensky51278_txt_001_p2s8a21).
t_lemma(node74_32, problematika).         const(problematika).
%%%%%%%% node74_33 %%%%%%%%%%%%%%%%%%%
node(node74_33).
a_afun(node74_33, adv).         const(adv).
m_form(node74_33, problematiky).         const(problematiky).
m_lemma(node74_33, problematika).         const(problematika).
m_tag(node74_33, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node74_33,'n'). const('n'). m_tag1(node74_33,'n'). const('n'). m_tag2(node74_33,'f'). const('f'). m_tag3(node74_33,'s'). const('s'). m_tag4(node74_33,'2'). const('2'). m_tag10(node74_33,'a'). const('a'). 
%%%%%%%% node74_34 %%%%%%%%%%%%%%%%%%%
node(node74_34).
functor(node74_34, pat).         const(pat).
gram_sempos(node74_34, n_denot).         const(n_denot).
id(node74_34, t_plzensky51278_txt_001_p2s8a22).         const(t_plzensky51278_txt_001_p2s8a22).
t_lemma(node74_34, prevence).         const(prevence).
%%%%%%%% node74_35 %%%%%%%%%%%%%%%%%%%
node(node74_35).
a_afun(node74_35, adv).         const(adv).
m_form(node74_35, prevence).         const(prevence).
m_lemma(node74_35, prevence).         const(prevence).
m_tag(node74_35, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node74_35,'n'). const('n'). m_tag1(node74_35,'n'). const('n'). m_tag2(node74_35,'f'). const('f'). m_tag3(node74_35,'s'). const('s'). m_tag4(node74_35,'2'). const('2'). m_tag10(node74_35,'a'). const('a'). 
%%%%%%%% node74_36 %%%%%%%%%%%%%%%%%%%
node(node74_36).
a_afun(node74_36, coord).         const(coord).
m_form(node74_36, a).         const(a).
m_lemma(node74_36, a_1).         const(a_1).
m_tag(node74_36, j______________).         const(j______________).
m_tag0(node74_36,'j'). const('j'). m_tag1(node74_36,'^'). const('^'). 
%%%%%%%% node74_37 %%%%%%%%%%%%%%%%%%%
node(node74_37).
functor(node74_37, pat).         const(pat).
gram_sempos(node74_37, n_denot).         const(n_denot).
id(node74_37, t_plzensky51278_txt_001_p2s8a23).         const(t_plzensky51278_txt_001_p2s8a23).
t_lemma(node74_37, ochrana).         const(ochrana).
%%%%%%%% node74_38 %%%%%%%%%%%%%%%%%%%
node(node74_38).
a_afun(node74_38, adv).         const(adv).
m_form(node74_38, ochrany).         const(ochrany).
m_lemma(node74_38, ochrana).         const(ochrana).
m_tag(node74_38, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node74_38,'n'). const('n'). m_tag1(node74_38,'n'). const('n'). m_tag2(node74_38,'f'). const('f'). m_tag3(node74_38,'s'). const('s'). m_tag4(node74_38,'2'). const('2'). m_tag10(node74_38,'a'). const('a'). 
%%%%%%%% node74_39 %%%%%%%%%%%%%%%%%%%
node(node74_39).
functor(node74_39, pat).         const(pat).
gram_sempos(node74_39, n_denot).         const(n_denot).
id(node74_39, t_plzensky51278_txt_001_p2s8a24).         const(t_plzensky51278_txt_001_p2s8a24).
t_lemma(node74_39, zdravi).         const(zdravi).
%%%%%%%% node74_40 %%%%%%%%%%%%%%%%%%%
node(node74_40).
a_afun(node74_40, atr).         const(atr).
m_form(node74_40, zdravi).         const(zdravi).
m_lemma(node74_40, zdravi).         const(zdravi).
m_tag(node74_40, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node74_40,'n'). const('n'). m_tag1(node74_40,'n'). const('n'). m_tag2(node74_40,'n'). const('n'). m_tag3(node74_40,'s'). const('s'). m_tag4(node74_40,'2'). const('2'). m_tag10(node74_40,'a'). const('a'). 
%%%%%%%% node74_41 %%%%%%%%%%%%%%%%%%%
node(node74_41).
functor(node74_41, conj).         const(conj).
id(node74_41, t_plzensky51278_txt_001_p2s8a26).         const(t_plzensky51278_txt_001_p2s8a26).
t_lemma(node74_41, a).         const(a).
%%%%%%%% node74_42 %%%%%%%%%%%%%%%%%%%
node(node74_42).
functor(node74_42, act).         const(act).
gram_sempos(node74_42, n_denot).         const(n_denot).
id(node74_42, t_plzensky51278_txt_001_p2s8a27).         const(t_plzensky51278_txt_001_p2s8a27).
t_lemma(node74_42, sport).         const(sport).
%%%%%%%% node74_43 %%%%%%%%%%%%%%%%%%%
node(node74_43).
a_afun(node74_43, adv).         const(adv).
m_form(node74_43, sportu).         const(sportu).
m_lemma(node74_43, sport).         const(sport).
m_tag(node74_43, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node74_43,'n'). const('n'). m_tag1(node74_43,'n'). const('n'). m_tag2(node74_43,'i'). const('i'). m_tag3(node74_43,'s'). const('s'). m_tag4(node74_43,'6'). const('6'). m_tag10(node74_43,'a'). const('a'). 
%%%%%%%% node74_44 %%%%%%%%%%%%%%%%%%%
node(node74_44).
functor(node74_44, act).         const(act).
gram_sempos(node74_44, n_denot).         const(n_denot).
id(node74_44, t_plzensky51278_txt_001_p2s8a29).         const(t_plzensky51278_txt_001_p2s8a29).
t_lemma(node74_44, nehoda).         const(nehoda).
%%%%%%%% node74_45 %%%%%%%%%%%%%%%%%%%
node(node74_45).
functor(node74_45, rstr).         const(rstr).
gram_sempos(node74_45, adj_denot).         const(adj_denot).
id(node74_45, t_plzensky51278_txt_001_p2s8a30).         const(t_plzensky51278_txt_001_p2s8a30).
t_lemma(node74_45, dopravni).         const(dopravni).
%%%%%%%% node74_46 %%%%%%%%%%%%%%%%%%%
node(node74_46).
a_afun(node74_46, atr).         const(atr).
m_form(node74_46, dopravnich).         const(dopravnich).
m_lemma(node74_46, dopravni).         const(dopravni).
m_tag(node74_46, aafp6____1a____).         const(aafp6____1a____).
m_tag0(node74_46,'a'). const('a'). m_tag1(node74_46,'a'). const('a'). m_tag2(node74_46,'f'). const('f'). m_tag3(node74_46,'p'). const('p'). m_tag4(node74_46,'6'). const('6'). m_tag9(node74_46,'1'). const('1'). m_tag10(node74_46,'a'). const('a'). 
%%%%%%%% node74_47 %%%%%%%%%%%%%%%%%%%
node(node74_47).
a_afun(node74_47, adv).         const(adv).
m_form(node74_47, nehodach).         const(nehodach).
m_lemma(node74_47, nehoda___pr__automobilova__cokoliv_neprijemneho_).         const(nehoda___pr__automobilova__cokoliv_neprijemneho_).
m_tag(node74_47, nnfp6_____a____).         const(nnfp6_____a____).
m_tag0(node74_47,'n'). const('n'). m_tag1(node74_47,'n'). const('n'). m_tag2(node74_47,'f'). const('f'). m_tag3(node74_47,'p'). const('p'). m_tag4(node74_47,'6'). const('6'). m_tag10(node74_47,'a'). const('a'). 
%%%%%%%% node74_48 %%%%%%%%%%%%%%%%%%%
node(node74_48).
a_afun(node74_48, coord).         const(coord).
m_form(node74_48, a).         const(a).
m_lemma(node74_48, a_1).         const(a_1).
m_tag(node74_48, j______________).         const(j______________).
m_tag0(node74_48,'j'). const('j'). m_tag1(node74_48,'^'). const('^'). 
%%%%%%%% node74_49 %%%%%%%%%%%%%%%%%%%
node(node74_49).
functor(node74_49, act).         const(act).
gram_sempos(node74_49, n_denot_neg).         const(n_denot_neg).
id(node74_49, t_plzensky51278_txt_001_p2s8a31).         const(t_plzensky51278_txt_001_p2s8a31).
t_lemma(node74_49, udalost).         const(udalost).
%%%%%%%% node74_50 %%%%%%%%%%%%%%%%%%%
node(node74_50).
functor(node74_50, rstr).         const(rstr).
gram_sempos(node74_50, adj_denot).         const(adj_denot).
id(node74_50, t_plzensky51278_txt_001_p2s8a32).         const(t_plzensky51278_txt_001_p2s8a32).
t_lemma(node74_50, jiny).         const(jiny).
%%%%%%%% node74_51 %%%%%%%%%%%%%%%%%%%
node(node74_51).
a_afun(node74_51, atr).         const(atr).
m_form(node74_51, jinych).         const(jinych).
m_lemma(node74_51, jiny).         const(jiny).
m_tag(node74_51, aafp6____1a____).         const(aafp6____1a____).
m_tag0(node74_51,'a'). const('a'). m_tag1(node74_51,'a'). const('a'). m_tag2(node74_51,'f'). const('f'). m_tag3(node74_51,'p'). const('p'). m_tag4(node74_51,'6'). const('6'). m_tag9(node74_51,'1'). const('1'). m_tag10(node74_51,'a'). const('a'). 
%%%%%%%% node74_52 %%%%%%%%%%%%%%%%%%%
node(node74_52).
a_afun(node74_52, adv).         const(adv).
m_form(node74_52, udalostech).         const(udalostech).
m_lemma(node74_52, udalost__a____3y_).         const(udalost__a____3y_).
m_tag(node74_52, nnfp6_____a____).         const(nnfp6_____a____).
m_tag0(node74_52,'n'). const('n'). m_tag1(node74_52,'n'). const('n'). m_tag2(node74_52,'f'). const('f'). m_tag3(node74_52,'p'). const('p'). m_tag4(node74_52,'6'). const('6'). m_tag10(node74_52,'a'). const('a'). 
edge(node74_0, node74_1).
edge(node74_1, node74_2).
edge(node74_2, node74_3).
edge(node74_2, node74_4).
edge(node74_2, node74_5).
edge(node74_5, node74_6).
edge(node74_5, node74_7).
edge(node74_1, node74_8).
edge(node74_1, node74_9).
edge(node74_9, node74_10).
edge(node74_10, node74_11).
edge(node74_9, node74_12).
edge(node74_9, node74_13).
edge(node74_13, node74_14).
edge(node74_14, node74_15).
edge(node74_13, node74_16).
edge(node74_13, node74_17).
edge(node74_17, node74_18).
edge(node74_17, node74_19).
edge(node74_17, node74_20).
edge(node74_20, node74_21).
edge(node74_20, node74_22).
edge(node74_13, node74_23).
edge(node74_23, node74_24).
edge(node74_24, node74_25).
edge(node74_23, node74_26).
edge(node74_26, node74_27).
edge(node74_23, node74_28).
edge(node74_23, node74_29).
edge(node74_29, node74_30).
edge(node74_23, node74_31).
edge(node74_31, node74_32).
edge(node74_32, node74_33).
edge(node74_31, node74_34).
edge(node74_34, node74_35).
edge(node74_31, node74_36).
edge(node74_31, node74_37).
edge(node74_37, node74_38).
edge(node74_37, node74_39).
edge(node74_39, node74_40).
edge(node74_23, node74_41).
edge(node74_41, node74_42).
edge(node74_42, node74_43).
edge(node74_41, node74_44).
edge(node74_44, node74_45).
edge(node74_45, node74_46).
edge(node74_44, node74_47).
edge(node74_41, node74_48).
edge(node74_41, node74_49).
edge(node74_49, node74_50).
edge(node74_50, node74_51).
edge(node74_49, node74_52).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pripraven byl i doprovodny program. 
tree_root(node75_0).
:- %%%%%%%% node75_0 %%%%%%%%%%%%%%%%%%%
node(node75_0).
id(node75_0, t_plzensky51278_txt_001_p3s1).         const(t_plzensky51278_txt_001_p3s1).
%%%%%%%% node75_1 %%%%%%%%%%%%%%%%%%%
node(node75_1).
functor(node75_1, pred).         const(pred).
gram_sempos(node75_1, v).         const(v).
id(node75_1, t_plzensky51278_txt_001_p3s1a1).         const(t_plzensky51278_txt_001_p3s1a1).
t_lemma(node75_1, byt).         const(byt).
%%%%%%%% node75_2 %%%%%%%%%%%%%%%%%%%
node(node75_2).
functor(node75_2, pat).         const(pat).
gram_sempos(node75_2, adj_denot).         const(adj_denot).
id(node75_2, t_plzensky51278_txt_001_p3s1a2).         const(t_plzensky51278_txt_001_p3s1a2).
t_lemma(node75_2, pripravit).         const(pripravit).
%%%%%%%% node75_3 %%%%%%%%%%%%%%%%%%%
node(node75_3).
functor(node75_3, pat).         const(pat).
gram_sempos(node75_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node75_3, t_plzensky51278_txt_001_p3s1a6).         const(t_plzensky51278_txt_001_p3s1a6).
t_lemma(node75_3, x_cor).         const(x_cor).
%%%%%%%% node75_4 %%%%%%%%%%%%%%%%%%%
node(node75_4).
a_afun(node75_4, pnom).         const(pnom).
m_form(node75_4, pripraven).         const(pripraven).
m_lemma(node75_4, pripravit__w).         const(pripravit__w).
m_tag(node75_4, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node75_4,'v'). const('v'). m_tag1(node75_4,'s'). const('s'). m_tag2(node75_4,'y'). const('y'). m_tag3(node75_4,'s'). const('s'). m_tag7(node75_4,'x'). const('x'). m_tag8(node75_4,'x'). const('x'). m_tag10(node75_4,'a'). const('a'). m_tag11(node75_4,'p'). const('p'). 
%%%%%%%% node75_5 %%%%%%%%%%%%%%%%%%%
node(node75_5).
a_afun(node75_5, pred).         const(pred).
m_form(node75_5, byl).         const(byl).
m_lemma(node75_5, byt).         const(byt).
m_tag(node75_5, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node75_5,'v'). const('v'). m_tag1(node75_5,'p'). const('p'). m_tag2(node75_5,'y'). const('y'). m_tag3(node75_5,'s'). const('s'). m_tag7(node75_5,'x'). const('x'). m_tag8(node75_5,'r'). const('r'). m_tag10(node75_5,'a'). const('a'). m_tag11(node75_5,'a'). const('a'). 
%%%%%%%% node75_6 %%%%%%%%%%%%%%%%%%%
node(node75_6).
functor(node75_6, act).         const(act).
gram_sempos(node75_6, n_denot).         const(n_denot).
id(node75_6, t_plzensky51278_txt_001_p3s1a3).         const(t_plzensky51278_txt_001_p3s1a3).
t_lemma(node75_6, program).         const(program).
%%%%%%%% node75_7 %%%%%%%%%%%%%%%%%%%
node(node75_7).
functor(node75_7, conj).         const(conj).
id(node75_7, t_plzensky51278_txt_001_p3s1a4).         const(t_plzensky51278_txt_001_p3s1a4).
t_lemma(node75_7, i).         const(i).
%%%%%%%% node75_8 %%%%%%%%%%%%%%%%%%%
node(node75_8).
a_afun(node75_8, coord).         const(coord).
m_form(node75_8, i).         const(i).
m_lemma(node75_8, i_1).         const(i_1).
m_tag(node75_8, j______________).         const(j______________).
m_tag0(node75_8,'j'). const('j'). m_tag1(node75_8,'^'). const('^'). 
%%%%%%%% node75_9 %%%%%%%%%%%%%%%%%%%
node(node75_9).
functor(node75_9, rstr).         const(rstr).
gram_sempos(node75_9, adj_denot).         const(adj_denot).
id(node75_9, t_plzensky51278_txt_001_p3s1a5).         const(t_plzensky51278_txt_001_p3s1a5).
t_lemma(node75_9, doprovodny).         const(doprovodny).
%%%%%%%% node75_10 %%%%%%%%%%%%%%%%%%%
node(node75_10).
a_afun(node75_10, atr).         const(atr).
m_form(node75_10, doprovodny).         const(doprovodny).
m_lemma(node75_10, doprovodny).         const(doprovodny).
m_tag(node75_10, aais1____1a____).         const(aais1____1a____).
m_tag0(node75_10,'a'). const('a'). m_tag1(node75_10,'a'). const('a'). m_tag2(node75_10,'i'). const('i'). m_tag3(node75_10,'s'). const('s'). m_tag4(node75_10,'1'). const('1'). m_tag9(node75_10,'1'). const('1'). m_tag10(node75_10,'a'). const('a'). 
%%%%%%%% node75_11 %%%%%%%%%%%%%%%%%%%
node(node75_11).
a_afun(node75_11, sb).         const(sb).
m_form(node75_11, program).         const(program).
m_lemma(node75_11, program_1).         const(program_1).
m_tag(node75_11, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node75_11,'n'). const('n'). m_tag1(node75_11,'n'). const('n'). m_tag2(node75_11,'i'). const('i'). m_tag3(node75_11,'s'). const('s'). m_tag4(node75_11,'1'). const('1'). m_tag10(node75_11,'a'). const('a'). 
edge(node75_0, node75_1).
edge(node75_1, node75_2).
edge(node75_2, node75_3).
edge(node75_2, node75_4).
edge(node75_1, node75_5).
edge(node75_1, node75_6).
edge(node75_6, node75_7).
edge(node75_7, node75_8).
edge(node75_6, node75_9).
edge(node75_9, node75_10).
edge(node75_6, node75_11).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% krome prohlidky techniky profesionalnich hasicu soutezici ceka i prohlidka pozarni stanice a ukazka zasahu hasicu - lezcu. 
tree_root(node76_0).
:- %%%%%%%% node76_0 %%%%%%%%%%%%%%%%%%%
node(node76_0).
id(node76_0, t_plzensky51278_txt_001_p3s2).         const(t_plzensky51278_txt_001_p3s2).
%%%%%%%% node76_1 %%%%%%%%%%%%%%%%%%%
node(node76_1).
functor(node76_1, pred).         const(pred).
gram_sempos(node76_1, v).         const(v).
id(node76_1, t_plzensky51278_txt_001_p3s2a1).         const(t_plzensky51278_txt_001_p3s2a1).
t_lemma(node76_1, cekat).         const(cekat).
%%%%%%%% node76_2 %%%%%%%%%%%%%%%%%%%
node(node76_2).
functor(node76_2, pat).         const(pat).
id(node76_2, t_plzensky51278_txt_001_p3s2a18).         const(t_plzensky51278_txt_001_p3s2a18).
t_lemma(node76_2, x_gen).         const(x_gen).
%%%%%%%% node76_3 %%%%%%%%%%%%%%%%%%%
node(node76_3).
functor(node76_3, restr).         const(restr).
gram_sempos(node76_3, n_denot).         const(n_denot).
id(node76_3, t_plzensky51278_txt_001_p3s2a3).         const(t_plzensky51278_txt_001_p3s2a3).
t_lemma(node76_3, prohlidka).         const(prohlidka).
%%%%%%%% node76_4 %%%%%%%%%%%%%%%%%%%
node(node76_4).
a_afun(node76_4, auxp).         const(auxp).
m_form(node76_4, krome).         const(krome).
m_lemma(node76_4, krome).         const(krome).
m_tag(node76_4, rr__2__________).         const(rr__2__________).
m_tag0(node76_4,'r'). const('r'). m_tag1(node76_4,'r'). const('r'). m_tag4(node76_4,'2'). const('2'). 
%%%%%%%% node76_5 %%%%%%%%%%%%%%%%%%%
node(node76_5).
a_afun(node76_5, adv).         const(adv).
m_form(node76_5, prohlidky).         const(prohlidky).
m_lemma(node76_5, prohlidka).         const(prohlidka).
m_tag(node76_5, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node76_5,'n'). const('n'). m_tag1(node76_5,'n'). const('n'). m_tag2(node76_5,'f'). const('f'). m_tag3(node76_5,'s'). const('s'). m_tag4(node76_5,'2'). const('2'). m_tag10(node76_5,'a'). const('a'). 
%%%%%%%% node76_6 %%%%%%%%%%%%%%%%%%%
node(node76_6).
functor(node76_6, pat).         const(pat).
gram_sempos(node76_6, n_denot).         const(n_denot).
id(node76_6, t_plzensky51278_txt_001_p3s2a4).         const(t_plzensky51278_txt_001_p3s2a4).
t_lemma(node76_6, technika).         const(technika).
%%%%%%%% node76_7 %%%%%%%%%%%%%%%%%%%
node(node76_7).
a_afun(node76_7, atr).         const(atr).
m_form(node76_7, techniky).         const(techniky).
m_lemma(node76_7, technika).         const(technika).
m_tag(node76_7, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node76_7,'n'). const('n'). m_tag1(node76_7,'n'). const('n'). m_tag2(node76_7,'f'). const('f'). m_tag3(node76_7,'s'). const('s'). m_tag4(node76_7,'2'). const('2'). m_tag10(node76_7,'a'). const('a'). 
%%%%%%%% node76_8 %%%%%%%%%%%%%%%%%%%
node(node76_8).
functor(node76_8, app).         const(app).
gram_sempos(node76_8, n_denot).         const(n_denot).
id(node76_8, t_plzensky51278_txt_001_p3s2a5).         const(t_plzensky51278_txt_001_p3s2a5).
t_lemma(node76_8, hasic).         const(hasic).
%%%%%%%% node76_9 %%%%%%%%%%%%%%%%%%%
node(node76_9).
functor(node76_9, rstr).         const(rstr).
gram_sempos(node76_9, adj_denot).         const(adj_denot).
id(node76_9, t_plzensky51278_txt_001_p3s2a6).         const(t_plzensky51278_txt_001_p3s2a6).
t_lemma(node76_9, profesionalni).         const(profesionalni).
%%%%%%%% node76_10 %%%%%%%%%%%%%%%%%%%
node(node76_10).
a_afun(node76_10, atr).         const(atr).
m_form(node76_10, profesionalnich).         const(profesionalnich).
m_lemma(node76_10, profesionalni).         const(profesionalni).
m_tag(node76_10, aamp2____1a____).         const(aamp2____1a____).
m_tag0(node76_10,'a'). const('a'). m_tag1(node76_10,'a'). const('a'). m_tag2(node76_10,'m'). const('m'). m_tag3(node76_10,'p'). const('p'). m_tag4(node76_10,'2'). const('2'). m_tag9(node76_10,'1'). const('1'). m_tag10(node76_10,'a'). const('a'). 
%%%%%%%% node76_11 %%%%%%%%%%%%%%%%%%%
node(node76_11).
a_afun(node76_11, atr).         const(atr).
m_form(node76_11, hasicu).         const(hasicu).
m_lemma(node76_11, hasic).         const(hasic).
m_tag(node76_11, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node76_11,'n'). const('n'). m_tag1(node76_11,'n'). const('n'). m_tag2(node76_11,'m'). const('m'). m_tag3(node76_11,'p'). const('p'). m_tag4(node76_11,'2'). const('2'). m_tag10(node76_11,'a'). const('a'). 
%%%%%%%% node76_12 %%%%%%%%%%%%%%%%%%%
node(node76_12).
functor(node76_12, act).         const(act).
gram_sempos(node76_12, n_denot).         const(n_denot).
id(node76_12, t_plzensky51278_txt_001_p3s2a7).         const(t_plzensky51278_txt_001_p3s2a7).
t_lemma(node76_12, soutezici).         const(soutezici).
%%%%%%%% node76_13 %%%%%%%%%%%%%%%%%%%
node(node76_13).
a_afun(node76_13, sb).         const(sb).
m_form(node76_13, soutezici).         const(soutezici).
m_lemma(node76_13, soutezici____3it_).         const(soutezici____3it_).
m_tag(node76_13, agfs1_____a____).         const(agfs1_____a____).
m_tag0(node76_13,'a'). const('a'). m_tag1(node76_13,'g'). const('g'). m_tag2(node76_13,'f'). const('f'). m_tag3(node76_13,'s'). const('s'). m_tag4(node76_13,'1'). const('1'). m_tag10(node76_13,'a'). const('a'). 
%%%%%%%% node76_14 %%%%%%%%%%%%%%%%%%%
node(node76_14).
a_afun(node76_14, pred).         const(pred).
m_form(node76_14, ceka).         const(ceka).
m_lemma(node76_14, cekat__t).         const(cekat__t).
m_tag(node76_14, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node76_14,'v'). const('v'). m_tag1(node76_14,'b'). const('b'). m_tag3(node76_14,'s'). const('s'). m_tag7(node76_14,'3'). const('3'). m_tag8(node76_14,'p'). const('p'). m_tag10(node76_14,'a'). const('a'). m_tag11(node76_14,'a'). const('a'). 
%%%%%%%% node76_15 %%%%%%%%%%%%%%%%%%%
node(node76_15).
functor(node76_15, conj).         const(conj).
id(node76_15, t_plzensky51278_txt_001_p3s2a8).         const(t_plzensky51278_txt_001_p3s2a8).
t_lemma(node76_15, a).         const(a).
%%%%%%%% node76_16 %%%%%%%%%%%%%%%%%%%
node(node76_16).
functor(node76_16, act).         const(act).
gram_sempos(node76_16, n_denot).         const(n_denot).
id(node76_16, t_plzensky51278_txt_001_p3s2a9).         const(t_plzensky51278_txt_001_p3s2a9).
t_lemma(node76_16, prohlidka).         const(prohlidka).
%%%%%%%% node76_17 %%%%%%%%%%%%%%%%%%%
node(node76_17).
functor(node76_17, conj).         const(conj).
id(node76_17, t_plzensky51278_txt_001_p3s2a10).         const(t_plzensky51278_txt_001_p3s2a10).
t_lemma(node76_17, i).         const(i).
%%%%%%%% node76_18 %%%%%%%%%%%%%%%%%%%
node(node76_18).
a_afun(node76_18, coord).         const(coord).
m_form(node76_18, i).         const(i).
m_lemma(node76_18, i_1).         const(i_1).
m_tag(node76_18, j______________).         const(j______________).
m_tag0(node76_18,'j'). const('j'). m_tag1(node76_18,'^'). const('^'). 
%%%%%%%% node76_19 %%%%%%%%%%%%%%%%%%%
node(node76_19).
a_afun(node76_19, sb).         const(sb).
m_form(node76_19, prohlidka).         const(prohlidka).
m_lemma(node76_19, prohlidka).         const(prohlidka).
m_tag(node76_19, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node76_19,'n'). const('n'). m_tag1(node76_19,'n'). const('n'). m_tag2(node76_19,'f'). const('f'). m_tag3(node76_19,'s'). const('s'). m_tag4(node76_19,'1'). const('1'). m_tag10(node76_19,'a'). const('a'). 
%%%%%%%% node76_20 %%%%%%%%%%%%%%%%%%%
node(node76_20).
functor(node76_20, pat).         const(pat).
gram_sempos(node76_20, n_denot).         const(n_denot).
id(node76_20, t_plzensky51278_txt_001_p3s2a11).         const(t_plzensky51278_txt_001_p3s2a11).
t_lemma(node76_20, stanice).         const(stanice).
%%%%%%%% node76_21 %%%%%%%%%%%%%%%%%%%
node(node76_21).
functor(node76_21, rstr).         const(rstr).
gram_sempos(node76_21, adj_denot).         const(adj_denot).
id(node76_21, t_plzensky51278_txt_001_p3s2a12).         const(t_plzensky51278_txt_001_p3s2a12).
t_lemma(node76_21, pozarni).         const(pozarni).
%%%%%%%% node76_22 %%%%%%%%%%%%%%%%%%%
node(node76_22).
a_afun(node76_22, atr).         const(atr).
m_form(node76_22, pozarni).         const(pozarni).
m_lemma(node76_22, pozarni).         const(pozarni).
m_tag(node76_22, aafs2____1a____).         const(aafs2____1a____).
m_tag0(node76_22,'a'). const('a'). m_tag1(node76_22,'a'). const('a'). m_tag2(node76_22,'f'). const('f'). m_tag3(node76_22,'s'). const('s'). m_tag4(node76_22,'2'). const('2'). m_tag9(node76_22,'1'). const('1'). m_tag10(node76_22,'a'). const('a'). 
%%%%%%%% node76_23 %%%%%%%%%%%%%%%%%%%
node(node76_23).
a_afun(node76_23, atr).         const(atr).
m_form(node76_23, stanice).         const(stanice).
m_lemma(node76_23, stanice).         const(stanice).
m_tag(node76_23, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node76_23,'n'). const('n'). m_tag1(node76_23,'n'). const('n'). m_tag2(node76_23,'f'). const('f'). m_tag3(node76_23,'s'). const('s'). m_tag4(node76_23,'2'). const('2'). m_tag10(node76_23,'a'). const('a'). 
%%%%%%%% node76_24 %%%%%%%%%%%%%%%%%%%
node(node76_24).
a_afun(node76_24, coord).         const(coord).
m_form(node76_24, a).         const(a).
m_lemma(node76_24, a_1).         const(a_1).
m_tag(node76_24, j______________).         const(j______________).
m_tag0(node76_24,'j'). const('j'). m_tag1(node76_24,'^'). const('^'). 
%%%%%%%% node76_25 %%%%%%%%%%%%%%%%%%%
node(node76_25).
functor(node76_25, act).         const(act).
gram_sempos(node76_25, n_denot).         const(n_denot).
id(node76_25, t_plzensky51278_txt_001_p3s2a13).         const(t_plzensky51278_txt_001_p3s2a13).
t_lemma(node76_25, ukazka).         const(ukazka).
%%%%%%%% node76_26 %%%%%%%%%%%%%%%%%%%
node(node76_26).
a_afun(node76_26, sb).         const(sb).
m_form(node76_26, ukazka).         const(ukazka).
m_lemma(node76_26, ukazka).         const(ukazka).
m_tag(node76_26, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node76_26,'n'). const('n'). m_tag1(node76_26,'n'). const('n'). m_tag2(node76_26,'f'). const('f'). m_tag3(node76_26,'s'). const('s'). m_tag4(node76_26,'1'). const('1'). m_tag10(node76_26,'a'). const('a'). 
%%%%%%%% node76_27 %%%%%%%%%%%%%%%%%%%
node(node76_27).
functor(node76_27, rstr).         const(rstr).
id(node76_27, t_plzensky51278_txt_001_p3s2a14).         const(t_plzensky51278_txt_001_p3s2a14).
t_lemma(node76_27, x_dash).         const(x_dash).
%%%%%%%% node76_28 %%%%%%%%%%%%%%%%%%%
node(node76_28).
functor(node76_28, rstr).         const(rstr).
gram_sempos(node76_28, n_denot).         const(n_denot).
id(node76_28, t_plzensky51278_txt_001_p3s2a15).         const(t_plzensky51278_txt_001_p3s2a15).
t_lemma(node76_28, zasah).         const(zasah).
%%%%%%%% node76_29 %%%%%%%%%%%%%%%%%%%
node(node76_29).
a_afun(node76_29, atr).         const(atr).
m_form(node76_29, zasahu).         const(zasahu).
m_lemma(node76_29, zasah).         const(zasah).
m_tag(node76_29, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node76_29,'n'). const('n'). m_tag1(node76_29,'n'). const('n'). m_tag2(node76_29,'i'). const('i'). m_tag3(node76_29,'s'). const('s'). m_tag4(node76_29,'2'). const('2'). m_tag10(node76_29,'a'). const('a'). 
%%%%%%%% node76_30 %%%%%%%%%%%%%%%%%%%
node(node76_30).
functor(node76_30, act).         const(act).
gram_sempos(node76_30, n_denot).         const(n_denot).
id(node76_30, t_plzensky51278_txt_001_p3s2a16).         const(t_plzensky51278_txt_001_p3s2a16).
t_lemma(node76_30, hasic).         const(hasic).
%%%%%%%% node76_31 %%%%%%%%%%%%%%%%%%%
node(node76_31).
a_afun(node76_31, atr).         const(atr).
m_form(node76_31, hasicu).         const(hasicu).
m_lemma(node76_31, hasic).         const(hasic).
m_tag(node76_31, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node76_31,'n'). const('n'). m_tag1(node76_31,'n'). const('n'). m_tag2(node76_31,'m'). const('m'). m_tag3(node76_31,'p'). const('p'). m_tag4(node76_31,'2'). const('2'). m_tag10(node76_31,'a'). const('a'). 
%%%%%%%% node76_32 %%%%%%%%%%%%%%%%%%%
node(node76_32).
a_afun(node76_32, auxg).         const(auxg).
m_form(node76_32, x_).         const(x_).
m_lemma(node76_32, x_).         const(x_).
m_tag(node76_32, z______________).         const(z______________).
m_tag0(node76_32,'z'). const('z'). m_tag1(node76_32,':'). const(':'). 
%%%%%%%% node76_33 %%%%%%%%%%%%%%%%%%%
node(node76_33).
functor(node76_33, rstr).         const(rstr).
gram_sempos(node76_33, n_denot).         const(n_denot).
id(node76_33, t_plzensky51278_txt_001_p3s2a17).         const(t_plzensky51278_txt_001_p3s2a17).
t_lemma(node76_33, lezec).         const(lezec).
%%%%%%%% node76_34 %%%%%%%%%%%%%%%%%%%
node(node76_34).
a_afun(node76_34, atr).         const(atr).
m_form(node76_34, lezcu).         const(lezcu).
m_lemma(node76_34, lezec).         const(lezec).
m_tag(node76_34, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node76_34,'n'). const('n'). m_tag1(node76_34,'n'). const('n'). m_tag2(node76_34,'m'). const('m'). m_tag3(node76_34,'p'). const('p'). m_tag4(node76_34,'2'). const('2'). m_tag10(node76_34,'a'). const('a'). 
edge(node76_0, node76_1).
edge(node76_1, node76_2).
edge(node76_1, node76_3).
edge(node76_3, node76_4).
edge(node76_3, node76_5).
edge(node76_3, node76_6).
edge(node76_6, node76_7).
edge(node76_6, node76_8).
edge(node76_8, node76_9).
edge(node76_9, node76_10).
edge(node76_8, node76_11).
edge(node76_1, node76_12).
edge(node76_12, node76_13).
edge(node76_1, node76_14).
edge(node76_1, node76_15).
edge(node76_15, node76_16).
edge(node76_16, node76_17).
edge(node76_17, node76_18).
edge(node76_16, node76_19).
edge(node76_16, node76_20).
edge(node76_20, node76_21).
edge(node76_21, node76_22).
edge(node76_20, node76_23).
edge(node76_15, node76_24).
edge(node76_15, node76_25).
edge(node76_25, node76_26).
edge(node76_25, node76_27).
edge(node76_27, node76_28).
edge(node76_28, node76_29).
edge(node76_28, node76_30).
edge(node76_30, node76_31).
edge(node76_27, node76_32).
edge(node76_27, node76_33).
edge(node76_33, node76_34).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% straznici mestske policie predvedli vycvik sluzebniho psa a dopadeni pachatele za jeho pomoci. 
tree_root(node77_0).
:- %%%%%%%% node77_0 %%%%%%%%%%%%%%%%%%%
node(node77_0).
id(node77_0, t_plzensky51278_txt_001_p3s3).         const(t_plzensky51278_txt_001_p3s3).
%%%%%%%% node77_1 %%%%%%%%%%%%%%%%%%%
node(node77_1).
functor(node77_1, pred).         const(pred).
gram_sempos(node77_1, v).         const(v).
id(node77_1, t_plzensky51278_txt_001_p3s3a1).         const(t_plzensky51278_txt_001_p3s3a1).
t_lemma(node77_1, predvest).         const(predvest).
%%%%%%%% node77_2 %%%%%%%%%%%%%%%%%%%
node(node77_2).
functor(node77_2, addr).         const(addr).
id(node77_2, t_plzensky51278_txt_001_p3s3a14).         const(t_plzensky51278_txt_001_p3s3a14).
t_lemma(node77_2, x_gen).         const(x_gen).
%%%%%%%% node77_3 %%%%%%%%%%%%%%%%%%%
node(node77_3).
functor(node77_3, act).         const(act).
gram_sempos(node77_3, n_denot).         const(n_denot).
id(node77_3, t_plzensky51278_txt_001_p3s3a2).         const(t_plzensky51278_txt_001_p3s3a2).
t_lemma(node77_3, straznik).         const(straznik).
%%%%%%%% node77_4 %%%%%%%%%%%%%%%%%%%
node(node77_4).
a_afun(node77_4, sb).         const(sb).
m_form(node77_4, straznici).         const(straznici).
m_lemma(node77_4, straznik___kdo_strazi__clovek_).         const(straznik___kdo_strazi__clovek_).
m_tag(node77_4, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node77_4,'n'). const('n'). m_tag1(node77_4,'n'). const('n'). m_tag2(node77_4,'m'). const('m'). m_tag3(node77_4,'p'). const('p'). m_tag4(node77_4,'1'). const('1'). m_tag10(node77_4,'a'). const('a'). 
%%%%%%%% node77_5 %%%%%%%%%%%%%%%%%%%
node(node77_5).
functor(node77_5, app).         const(app).
gram_sempos(node77_5, n_denot).         const(n_denot).
id(node77_5, t_plzensky51278_txt_001_p3s3a3).         const(t_plzensky51278_txt_001_p3s3a3).
t_lemma(node77_5, policie).         const(policie).
%%%%%%%% node77_6 %%%%%%%%%%%%%%%%%%%
node(node77_6).
functor(node77_6, rstr).         const(rstr).
gram_sempos(node77_6, adj_denot).         const(adj_denot).
id(node77_6, t_plzensky51278_txt_001_p3s3a4).         const(t_plzensky51278_txt_001_p3s3a4).
t_lemma(node77_6, mestsky).         const(mestsky).
%%%%%%%% node77_7 %%%%%%%%%%%%%%%%%%%
node(node77_7).
a_afun(node77_7, atr).         const(atr).
m_form(node77_7, mestske).         const(mestske).
m_lemma(node77_7, mestsky).         const(mestsky).
m_tag(node77_7, aafs2____1a____).         const(aafs2____1a____).
m_tag0(node77_7,'a'). const('a'). m_tag1(node77_7,'a'). const('a'). m_tag2(node77_7,'f'). const('f'). m_tag3(node77_7,'s'). const('s'). m_tag4(node77_7,'2'). const('2'). m_tag9(node77_7,'1'). const('1'). m_tag10(node77_7,'a'). const('a'). 
%%%%%%%% node77_8 %%%%%%%%%%%%%%%%%%%
node(node77_8).
a_afun(node77_8, atr).         const(atr).
m_form(node77_8, policie).         const(policie).
m_lemma(node77_8, policie).         const(policie).
m_tag(node77_8, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node77_8,'n'). const('n'). m_tag1(node77_8,'n'). const('n'). m_tag2(node77_8,'f'). const('f'). m_tag3(node77_8,'s'). const('s'). m_tag4(node77_8,'2'). const('2'). m_tag10(node77_8,'a'). const('a'). 
%%%%%%%% node77_9 %%%%%%%%%%%%%%%%%%%
node(node77_9).
a_afun(node77_9, pred).         const(pred).
m_form(node77_9, predvedli).         const(predvedli).
m_lemma(node77_9, predvest).         const(predvest).
m_tag(node77_9, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node77_9,'v'). const('v'). m_tag1(node77_9,'p'). const('p'). m_tag2(node77_9,'m'). const('m'). m_tag3(node77_9,'p'). const('p'). m_tag7(node77_9,'x'). const('x'). m_tag8(node77_9,'r'). const('r'). m_tag10(node77_9,'a'). const('a'). m_tag11(node77_9,'a'). const('a'). 
%%%%%%%% node77_10 %%%%%%%%%%%%%%%%%%%
node(node77_10).
functor(node77_10, rstr).         const(rstr).
gram_sempos(node77_10, n_denot).         const(n_denot).
id(node77_10, t_plzensky51278_txt_001_p3s3a6).         const(t_plzensky51278_txt_001_p3s3a6).
t_lemma(node77_10, vycvik).         const(vycvik).
%%%%%%%% node77_11 %%%%%%%%%%%%%%%%%%%
node(node77_11).
a_afun(node77_11, obj).         const(obj).
m_form(node77_11, vycvik).         const(vycvik).
m_lemma(node77_11, vycvik).         const(vycvik).
m_tag(node77_11, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node77_11,'n'). const('n'). m_tag1(node77_11,'n'). const('n'). m_tag2(node77_11,'i'). const('i'). m_tag3(node77_11,'s'). const('s'). m_tag4(node77_11,'4'). const('4'). m_tag10(node77_11,'a'). const('a'). 
%%%%%%%% node77_12 %%%%%%%%%%%%%%%%%%%
node(node77_12).
functor(node77_12, conj).         const(conj).
id(node77_12, t_plzensky51278_txt_001_p3s3a5).         const(t_plzensky51278_txt_001_p3s3a5).
t_lemma(node77_12, a).         const(a).
%%%%%%%% node77_13 %%%%%%%%%%%%%%%%%%%
node(node77_13).
functor(node77_13, pat).         const(pat).
gram_sempos(node77_13, n_denot).         const(n_denot).
id(node77_13, t_plzensky51278_txt_001_p3s3a7).         const(t_plzensky51278_txt_001_p3s3a7).
t_lemma(node77_13, pes).         const(pes).
%%%%%%%% node77_14 %%%%%%%%%%%%%%%%%%%
node(node77_14).
functor(node77_14, rstr).         const(rstr).
gram_sempos(node77_14, adj_denot).         const(adj_denot).
id(node77_14, t_plzensky51278_txt_001_p3s3a8).         const(t_plzensky51278_txt_001_p3s3a8).
t_lemma(node77_14, sluzebni).         const(sluzebni).
%%%%%%%% node77_15 %%%%%%%%%%%%%%%%%%%
node(node77_15).
a_afun(node77_15, atr).         const(atr).
m_form(node77_15, sluzebniho).         const(sluzebniho).
m_lemma(node77_15, sluzebni___pomer_byt_zbran_____).         const(sluzebni___pomer_byt_zbran_____).
m_tag(node77_15, aams2____1a____).         const(aams2____1a____).
m_tag0(node77_15,'a'). const('a'). m_tag1(node77_15,'a'). const('a'). m_tag2(node77_15,'m'). const('m'). m_tag3(node77_15,'s'). const('s'). m_tag4(node77_15,'2'). const('2'). m_tag9(node77_15,'1'). const('1'). m_tag10(node77_15,'a'). const('a'). 
%%%%%%%% node77_16 %%%%%%%%%%%%%%%%%%%
node(node77_16).
a_afun(node77_16, atr).         const(atr).
m_form(node77_16, psa).         const(psa).
m_lemma(node77_16, pes___zvire_).         const(pes___zvire_).
m_tag(node77_16, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node77_16,'n'). const('n'). m_tag1(node77_16,'n'). const('n'). m_tag2(node77_16,'m'). const('m'). m_tag3(node77_16,'s'). const('s'). m_tag4(node77_16,'2'). const('2'). m_tag10(node77_16,'a'). const('a'). 
%%%%%%%% node77_17 %%%%%%%%%%%%%%%%%%%
node(node77_17).
a_afun(node77_17, coord).         const(coord).
m_form(node77_17, a).         const(a).
m_lemma(node77_17, a_1).         const(a_1).
m_tag(node77_17, j______________).         const(j______________).
m_tag0(node77_17,'j'). const('j'). m_tag1(node77_17,'^'). const('^'). 
%%%%%%%% node77_18 %%%%%%%%%%%%%%%%%%%
node(node77_18).
functor(node77_18, pat).         const(pat).
gram_sempos(node77_18, n_denot).         const(n_denot).
id(node77_18, t_plzensky51278_txt_001_p3s3a9).         const(t_plzensky51278_txt_001_p3s3a9).
t_lemma(node77_18, dopadeni).         const(dopadeni).
%%%%%%%% node77_19 %%%%%%%%%%%%%%%%%%%
node(node77_19).
a_afun(node77_19, adv).         const(adv).
m_form(node77_19, dopadeni).         const(dopadeni).
m_lemma(node77_19, dopadeni____3nout_).         const(dopadeni____3nout_).
m_tag(node77_19, nnnp2_____a____).         const(nnnp2_____a____).
m_tag0(node77_19,'n'). const('n'). m_tag1(node77_19,'n'). const('n'). m_tag2(node77_19,'n'). const('n'). m_tag3(node77_19,'p'). const('p'). m_tag4(node77_19,'2'). const('2'). m_tag10(node77_19,'a'). const('a'). 
%%%%%%%% node77_20 %%%%%%%%%%%%%%%%%%%
node(node77_20).
functor(node77_20, app).         const(app).
gram_sempos(node77_20, n_denot).         const(n_denot).
id(node77_20, t_plzensky51278_txt_001_p3s3a10).         const(t_plzensky51278_txt_001_p3s3a10).
t_lemma(node77_20, pachatel).         const(pachatel).
%%%%%%%% node77_21 %%%%%%%%%%%%%%%%%%%
node(node77_21).
a_afun(node77_21, atr).         const(atr).
m_form(node77_21, pachatele).         const(pachatele).
m_lemma(node77_21, pachatel).         const(pachatel).
m_tag(node77_21, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node77_21,'n'). const('n'). m_tag1(node77_21,'n'). const('n'). m_tag2(node77_21,'m'). const('m'). m_tag3(node77_21,'s'). const('s'). m_tag4(node77_21,'2'). const('2'). m_tag10(node77_21,'a'). const('a'). 
%%%%%%%% node77_22 %%%%%%%%%%%%%%%%%%%
node(node77_22).
functor(node77_22, act).         const(act).
gram_sempos(node77_22, n_pron_def_pers).         const(n_pron_def_pers).
id(node77_22, t_plzensky51278_txt_001_p3s3a13).         const(t_plzensky51278_txt_001_p3s3a13).
t_lemma(node77_22, x_perspron).         const(x_perspron).
%%%%%%%% node77_23 %%%%%%%%%%%%%%%%%%%
node(node77_23).
a_afun(node77_23, auxp).         const(auxp).
m_form(node77_23, za).         const(za).
m_lemma(node77_23, za_1).         const(za_1).
m_tag(node77_23, rr__4__________).         const(rr__4__________).
m_tag0(node77_23,'r'). const('r'). m_tag1(node77_23,'r'). const('r'). m_tag4(node77_23,'4'). const('4'). 
%%%%%%%% node77_24 %%%%%%%%%%%%%%%%%%%
node(node77_24).
a_afun(node77_24, atr).         const(atr).
m_form(node77_24, jeho).         const(jeho).
m_lemma(node77_24, jeho___privlast__).         const(jeho___privlast__).
m_tag(node77_24, psxxxzs3_______).         const(psxxxzs3_______).
m_tag0(node77_24,'p'). const('p'). m_tag1(node77_24,'s'). const('s'). m_tag2(node77_24,'x'). const('x'). m_tag3(node77_24,'x'). const('x'). m_tag4(node77_24,'x'). const('x'). m_tag5(node77_24,'z'). const('z'). m_tag6(node77_24,'s'). const('s'). m_tag7(node77_24,'3'). const('3'). 
%%%%%%%% node77_25 %%%%%%%%%%%%%%%%%%%
node(node77_25).
a_afun(node77_25, auxp).         const(auxp).
m_form(node77_25, pomoci).         const(pomoci).
m_lemma(node77_25, pomoc).         const(pomoc).
m_tag(node77_25, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node77_25,'n'). const('n'). m_tag1(node77_25,'n'). const('n'). m_tag2(node77_25,'f'). const('f'). m_tag3(node77_25,'s'). const('s'). m_tag4(node77_25,'2'). const('2'). m_tag10(node77_25,'a'). const('a'). 
edge(node77_0, node77_1).
edge(node77_1, node77_2).
edge(node77_1, node77_3).
edge(node77_3, node77_4).
edge(node77_3, node77_5).
edge(node77_5, node77_6).
edge(node77_6, node77_7).
edge(node77_5, node77_8).
edge(node77_1, node77_9).
edge(node77_1, node77_10).
edge(node77_10, node77_11).
edge(node77_10, node77_12).
edge(node77_12, node77_13).
edge(node77_13, node77_14).
edge(node77_14, node77_15).
edge(node77_13, node77_16).
edge(node77_12, node77_17).
edge(node77_12, node77_18).
edge(node77_18, node77_19).
edge(node77_18, node77_20).
edge(node77_20, node77_21).
edge(node77_1, node77_22).
edge(node77_22, node77_23).
edge(node77_22, node77_24).
edge(node77_22, node77_25).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% kazdy soutezici obdrzel drobne vecne ceny a pametni list. 
tree_root(node78_0).
:- %%%%%%%% node78_0 %%%%%%%%%%%%%%%%%%%
node(node78_0).
id(node78_0, t_plzensky51278_txt_001_p4s1).         const(t_plzensky51278_txt_001_p4s1).
%%%%%%%% node78_1 %%%%%%%%%%%%%%%%%%%
node(node78_1).
functor(node78_1, pred).         const(pred).
gram_sempos(node78_1, v).         const(v).
id(node78_1, t_plzensky51278_txt_001_p4s1a1).         const(t_plzensky51278_txt_001_p4s1a1).
t_lemma(node78_1, obdrzet).         const(obdrzet).
%%%%%%%% node78_2 %%%%%%%%%%%%%%%%%%%
node(node78_2).
functor(node78_2, pat).         const(pat).
id(node78_2, t_plzensky51278_txt_001_p4s1a10).         const(t_plzensky51278_txt_001_p4s1a10).
t_lemma(node78_2, x_gen).         const(x_gen).
%%%%%%%% node78_3 %%%%%%%%%%%%%%%%%%%
node(node78_3).
functor(node78_3, act).         const(act).
gram_sempos(node78_3, n_denot).         const(n_denot).
id(node78_3, t_plzensky51278_txt_001_p4s1a2).         const(t_plzensky51278_txt_001_p4s1a2).
t_lemma(node78_3, soutezici).         const(soutezici).
%%%%%%%% node78_4 %%%%%%%%%%%%%%%%%%%
node(node78_4).
functor(node78_4, rstr).         const(rstr).
gram_sempos(node78_4, adj_pron_indef).         const(adj_pron_indef).
id(node78_4, t_plzensky51278_txt_001_p4s1a3).         const(t_plzensky51278_txt_001_p4s1a3).
t_lemma(node78_4, ktery).         const(ktery).
%%%%%%%% node78_5 %%%%%%%%%%%%%%%%%%%
node(node78_5).
a_afun(node78_5, atr).         const(atr).
m_form(node78_5, kazdy).         const(kazdy).
m_lemma(node78_5, kazdy).         const(kazdy).
m_tag(node78_5, aams1____1a____).         const(aams1____1a____).
m_tag0(node78_5,'a'). const('a'). m_tag1(node78_5,'a'). const('a'). m_tag2(node78_5,'m'). const('m'). m_tag3(node78_5,'s'). const('s'). m_tag4(node78_5,'1'). const('1'). m_tag9(node78_5,'1'). const('1'). m_tag10(node78_5,'a'). const('a'). 
%%%%%%%% node78_6 %%%%%%%%%%%%%%%%%%%
node(node78_6).
a_afun(node78_6, sb).         const(sb).
m_form(node78_6, soutezici).         const(soutezici).
m_lemma(node78_6, soutezici____3it_).         const(soutezici____3it_).
m_tag(node78_6, agmp1_____a____).         const(agmp1_____a____).
m_tag0(node78_6,'a'). const('a'). m_tag1(node78_6,'g'). const('g'). m_tag2(node78_6,'m'). const('m'). m_tag3(node78_6,'p'). const('p'). m_tag4(node78_6,'1'). const('1'). m_tag10(node78_6,'a'). const('a'). 
%%%%%%%% node78_7 %%%%%%%%%%%%%%%%%%%
node(node78_7).
a_afun(node78_7, pred).         const(pred).
m_form(node78_7, obdrzel).         const(obdrzel).
m_lemma(node78_7, obdrzet).         const(obdrzet).
m_tag(node78_7, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node78_7,'v'). const('v'). m_tag1(node78_7,'p'). const('p'). m_tag2(node78_7,'y'). const('y'). m_tag3(node78_7,'s'). const('s'). m_tag7(node78_7,'x'). const('x'). m_tag8(node78_7,'r'). const('r'). m_tag10(node78_7,'a'). const('a'). m_tag11(node78_7,'a'). const('a'). 
%%%%%%%% node78_8 %%%%%%%%%%%%%%%%%%%
node(node78_8).
functor(node78_8, conj).         const(conj).
id(node78_8, t_plzensky51278_txt_001_p4s1a4).         const(t_plzensky51278_txt_001_p4s1a4).
t_lemma(node78_8, a).         const(a).
%%%%%%%% node78_9 %%%%%%%%%%%%%%%%%%%
node(node78_9).
functor(node78_9, rstr).         const(rstr).
gram_sempos(node78_9, adj_denot).         const(adj_denot).
id(node78_9, t_plzensky51278_txt_001_p4s1a5).         const(t_plzensky51278_txt_001_p4s1a5).
t_lemma(node78_9, drobny).         const(drobny).
%%%%%%%% node78_10 %%%%%%%%%%%%%%%%%%%
node(node78_10).
a_afun(node78_10, atr).         const(atr).
m_form(node78_10, drobne).         const(drobne).
m_lemma(node78_10, drobny).         const(drobny).
m_tag(node78_10, aans4____1a____).         const(aans4____1a____).
m_tag0(node78_10,'a'). const('a'). m_tag1(node78_10,'a'). const('a'). m_tag2(node78_10,'n'). const('n'). m_tag3(node78_10,'s'). const('s'). m_tag4(node78_10,'4'). const('4'). m_tag9(node78_10,'1'). const('1'). m_tag10(node78_10,'a'). const('a'). 
%%%%%%%% node78_11 %%%%%%%%%%%%%%%%%%%
node(node78_11).
functor(node78_11, rstr).         const(rstr).
gram_sempos(node78_11, n_denot).         const(n_denot).
id(node78_11, t_plzensky51278_txt_001_p4s1a6).         const(t_plzensky51278_txt_001_p4s1a6).
t_lemma(node78_11, cena).         const(cena).
%%%%%%%% node78_12 %%%%%%%%%%%%%%%%%%%
node(node78_12).
functor(node78_12, rstr).         const(rstr).
gram_sempos(node78_12, adj_denot).         const(adj_denot).
id(node78_12, t_plzensky51278_txt_001_p4s1a7).         const(t_plzensky51278_txt_001_p4s1a7).
t_lemma(node78_12, vecny).         const(vecny).
%%%%%%%% node78_13 %%%%%%%%%%%%%%%%%%%
node(node78_13).
a_afun(node78_13, atr).         const(atr).
m_form(node78_13, vecne).         const(vecne).
m_lemma(node78_13, vecny).         const(vecny).
m_tag(node78_13, aafp4____1a____).         const(aafp4____1a____).
m_tag0(node78_13,'a'). const('a'). m_tag1(node78_13,'a'). const('a'). m_tag2(node78_13,'f'). const('f'). m_tag3(node78_13,'p'). const('p'). m_tag4(node78_13,'4'). const('4'). m_tag9(node78_13,'1'). const('1'). m_tag10(node78_13,'a'). const('a'). 
%%%%%%%% node78_14 %%%%%%%%%%%%%%%%%%%
node(node78_14).
a_afun(node78_14, obj).         const(obj).
m_form(node78_14, ceny).         const(ceny).
m_lemma(node78_14, cena_1___v_penezich__naturalni__nevycislitelna_____).         const(cena_1___v_penezich__naturalni__nevycislitelna_____).
m_tag(node78_14, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node78_14,'n'). const('n'). m_tag1(node78_14,'n'). const('n'). m_tag2(node78_14,'f'). const('f'). m_tag3(node78_14,'p'). const('p'). m_tag4(node78_14,'4'). const('4'). m_tag10(node78_14,'a'). const('a'). 
%%%%%%%% node78_15 %%%%%%%%%%%%%%%%%%%
node(node78_15).
a_afun(node78_15, coord).         const(coord).
m_form(node78_15, a).         const(a).
m_lemma(node78_15, a_1).         const(a_1).
m_tag(node78_15, j______________).         const(j______________).
m_tag0(node78_15,'j'). const('j'). m_tag1(node78_15,'^'). const('^'). 
%%%%%%%% node78_16 %%%%%%%%%%%%%%%%%%%
node(node78_16).
functor(node78_16, rstr).         const(rstr).
gram_sempos(node78_16, n_denot).         const(n_denot).
id(node78_16, t_plzensky51278_txt_001_p4s1a8).         const(t_plzensky51278_txt_001_p4s1a8).
t_lemma(node78_16, list).         const(list).
%%%%%%%% node78_17 %%%%%%%%%%%%%%%%%%%
node(node78_17).
functor(node78_17, rstr).         const(rstr).
gram_sempos(node78_17, adj_denot).         const(adj_denot).
id(node78_17, t_plzensky51278_txt_001_p4s1a9).         const(t_plzensky51278_txt_001_p4s1a9).
t_lemma(node78_17, pametni).         const(pametni).
%%%%%%%% node78_18 %%%%%%%%%%%%%%%%%%%
node(node78_18).
a_afun(node78_18, atr).         const(atr).
m_form(node78_18, pametni).         const(pametni).
m_lemma(node78_18, pametni).         const(pametni).
m_tag(node78_18, aais4____1a____).         const(aais4____1a____).
m_tag0(node78_18,'a'). const('a'). m_tag1(node78_18,'a'). const('a'). m_tag2(node78_18,'i'). const('i'). m_tag3(node78_18,'s'). const('s'). m_tag4(node78_18,'4'). const('4'). m_tag9(node78_18,'1'). const('1'). m_tag10(node78_18,'a'). const('a'). 
%%%%%%%% node78_19 %%%%%%%%%%%%%%%%%%%
node(node78_19).
a_afun(node78_19, obj).         const(obj).
m_form(node78_19, list).         const(list).
m_lemma(node78_19, list).         const(list).
m_tag(node78_19, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node78_19,'n'). const('n'). m_tag1(node78_19,'n'). const('n'). m_tag2(node78_19,'i'). const('i'). m_tag3(node78_19,'s'). const('s'). m_tag4(node78_19,'4'). const('4'). m_tag10(node78_19,'a'). const('a'). 
edge(node78_0, node78_1).
edge(node78_1, node78_2).
edge(node78_1, node78_3).
edge(node78_3, node78_4).
edge(node78_4, node78_5).
edge(node78_3, node78_6).
edge(node78_1, node78_7).
edge(node78_1, node78_8).
edge(node78_8, node78_9).
edge(node78_9, node78_10).
edge(node78_8, node78_11).
edge(node78_11, node78_12).
edge(node78_12, node78_13).
edge(node78_11, node78_14).
edge(node78_8, node78_15).
edge(node78_8, node78_16).
edge(node78_16, node78_17).
edge(node78_17, node78_18).
edge(node78_16, node78_19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tri vitezna druzstva obdrzela hodnotne ceny a medaile. 
tree_root(node79_0).
:- %%%%%%%% node79_0 %%%%%%%%%%%%%%%%%%%
node(node79_0).
id(node79_0, t_plzensky51278_txt_001_p4s2).         const(t_plzensky51278_txt_001_p4s2).
%%%%%%%% node79_1 %%%%%%%%%%%%%%%%%%%
node(node79_1).
functor(node79_1, pred).         const(pred).
gram_sempos(node79_1, v).         const(v).
id(node79_1, t_plzensky51278_txt_001_p4s2a1).         const(t_plzensky51278_txt_001_p4s2a1).
t_lemma(node79_1, obdrzet).         const(obdrzet).
%%%%%%%% node79_2 %%%%%%%%%%%%%%%%%%%
node(node79_2).
functor(node79_2, pat).         const(pat).
id(node79_2, t_plzensky51278_txt_001_p4s2a9).         const(t_plzensky51278_txt_001_p4s2a9).
t_lemma(node79_2, x_gen).         const(x_gen).
%%%%%%%% node79_3 %%%%%%%%%%%%%%%%%%%
node(node79_3).
functor(node79_3, act).         const(act).
gram_sempos(node79_3, n_denot).         const(n_denot).
id(node79_3, t_plzensky51278_txt_001_p4s2a2).         const(t_plzensky51278_txt_001_p4s2a2).
t_lemma(node79_3, druzstvo).         const(druzstvo).
%%%%%%%% node79_4 %%%%%%%%%%%%%%%%%%%
node(node79_4).
functor(node79_4, rstr).         const(rstr).
gram_sempos(node79_4, adj_quant_def).         const(adj_quant_def).
id(node79_4, t_plzensky51278_txt_001_p4s2a3).         const(t_plzensky51278_txt_001_p4s2a3).
t_lemma(node79_4, tri).         const(tri).
%%%%%%%% node79_5 %%%%%%%%%%%%%%%%%%%
node(node79_5).
a_afun(node79_5, atr).         const(atr).
m_form(node79_5, tri).         const(tri).
m_lemma(node79_5, tri_3).         const(tri_3).
m_tag(node79_5, clxp1__________).         const(clxp1__________).
m_tag0(node79_5,'c'). const('c'). m_tag1(node79_5,'l'). const('l'). m_tag2(node79_5,'x'). const('x'). m_tag3(node79_5,'p'). const('p'). m_tag4(node79_5,'1'). const('1'). 
%%%%%%%% node79_6 %%%%%%%%%%%%%%%%%%%
node(node79_6).
functor(node79_6, rstr).         const(rstr).
gram_sempos(node79_6, adj_denot).         const(adj_denot).
id(node79_6, t_plzensky51278_txt_001_p4s2a4).         const(t_plzensky51278_txt_001_p4s2a4).
t_lemma(node79_6, vitezny).         const(vitezny).
%%%%%%%% node79_7 %%%%%%%%%%%%%%%%%%%
node(node79_7).
a_afun(node79_7, atr).         const(atr).
m_form(node79_7, vitezna).         const(vitezna).
m_lemma(node79_7, vitezny).         const(vitezny).
m_tag(node79_7, aanp1____1a____).         const(aanp1____1a____).
m_tag0(node79_7,'a'). const('a'). m_tag1(node79_7,'a'). const('a'). m_tag2(node79_7,'n'). const('n'). m_tag3(node79_7,'p'). const('p'). m_tag4(node79_7,'1'). const('1'). m_tag9(node79_7,'1'). const('1'). m_tag10(node79_7,'a'). const('a'). 
%%%%%%%% node79_8 %%%%%%%%%%%%%%%%%%%
node(node79_8).
a_afun(node79_8, sb).         const(sb).
m_form(node79_8, druzstva).         const(druzstva).
m_lemma(node79_8, druzstvo).         const(druzstvo).
m_tag(node79_8, nnnp1_____a____).         const(nnnp1_____a____).
m_tag0(node79_8,'n'). const('n'). m_tag1(node79_8,'n'). const('n'). m_tag2(node79_8,'n'). const('n'). m_tag3(node79_8,'p'). const('p'). m_tag4(node79_8,'1'). const('1'). m_tag10(node79_8,'a'). const('a'). 
%%%%%%%% node79_9 %%%%%%%%%%%%%%%%%%%
node(node79_9).
a_afun(node79_9, pred).         const(pred).
m_form(node79_9, obdrzela).         const(obdrzela).
m_lemma(node79_9, obdrzet).         const(obdrzet).
m_tag(node79_9, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node79_9,'v'). const('v'). m_tag1(node79_9,'p'). const('p'). m_tag2(node79_9,'q'). const('q'). m_tag3(node79_9,'w'). const('w'). m_tag7(node79_9,'x'). const('x'). m_tag8(node79_9,'r'). const('r'). m_tag10(node79_9,'a'). const('a'). m_tag11(node79_9,'a'). const('a'). 
%%%%%%%% node79_10 %%%%%%%%%%%%%%%%%%%
node(node79_10).
functor(node79_10, conj).         const(conj).
id(node79_10, t_plzensky51278_txt_001_p4s2a5).         const(t_plzensky51278_txt_001_p4s2a5).
t_lemma(node79_10, a).         const(a).
%%%%%%%% node79_11 %%%%%%%%%%%%%%%%%%%
node(node79_11).
functor(node79_11, rstr).         const(rstr).
gram_sempos(node79_11, n_denot).         const(n_denot).
id(node79_11, t_plzensky51278_txt_001_p4s2a6).         const(t_plzensky51278_txt_001_p4s2a6).
t_lemma(node79_11, cena).         const(cena).
%%%%%%%% node79_12 %%%%%%%%%%%%%%%%%%%
node(node79_12).
functor(node79_12, rstr).         const(rstr).
gram_sempos(node79_12, adj_denot).         const(adj_denot).
id(node79_12, t_plzensky51278_txt_001_p4s2a7).         const(t_plzensky51278_txt_001_p4s2a7).
t_lemma(node79_12, hodnotny).         const(hodnotny).
%%%%%%%% node79_13 %%%%%%%%%%%%%%%%%%%
node(node79_13).
a_afun(node79_13, atr).         const(atr).
m_form(node79_13, hodnotne).         const(hodnotne).
m_lemma(node79_13, hodnotny).         const(hodnotny).
m_tag(node79_13, aafp4____1a____).         const(aafp4____1a____).
m_tag0(node79_13,'a'). const('a'). m_tag1(node79_13,'a'). const('a'). m_tag2(node79_13,'f'). const('f'). m_tag3(node79_13,'p'). const('p'). m_tag4(node79_13,'4'). const('4'). m_tag9(node79_13,'1'). const('1'). m_tag10(node79_13,'a'). const('a'). 
%%%%%%%% node79_14 %%%%%%%%%%%%%%%%%%%
node(node79_14).
a_afun(node79_14, obj).         const(obj).
m_form(node79_14, ceny).         const(ceny).
m_lemma(node79_14, cena_1___v_penezich__naturalni__nevycislitelna_____).         const(cena_1___v_penezich__naturalni__nevycislitelna_____).
m_tag(node79_14, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node79_14,'n'). const('n'). m_tag1(node79_14,'n'). const('n'). m_tag2(node79_14,'f'). const('f'). m_tag3(node79_14,'p'). const('p'). m_tag4(node79_14,'4'). const('4'). m_tag10(node79_14,'a'). const('a'). 
%%%%%%%% node79_15 %%%%%%%%%%%%%%%%%%%
node(node79_15).
a_afun(node79_15, coord).         const(coord).
m_form(node79_15, a).         const(a).
m_lemma(node79_15, a_1).         const(a_1).
m_tag(node79_15, j______________).         const(j______________).
m_tag0(node79_15,'j'). const('j'). m_tag1(node79_15,'^'). const('^'). 
%%%%%%%% node79_16 %%%%%%%%%%%%%%%%%%%
node(node79_16).
functor(node79_16, rstr).         const(rstr).
gram_sempos(node79_16, n_denot).         const(n_denot).
id(node79_16, t_plzensky51278_txt_001_p4s2a8).         const(t_plzensky51278_txt_001_p4s2a8).
t_lemma(node79_16, medaile).         const(medaile).
%%%%%%%% node79_17 %%%%%%%%%%%%%%%%%%%
node(node79_17).
a_afun(node79_17, obj).         const(obj).
m_form(node79_17, medaile).         const(medaile).
m_lemma(node79_17, medaile).         const(medaile).
m_tag(node79_17, nnfp4_____a____).         const(nnfp4_____a____).
m_tag0(node79_17,'n'). const('n'). m_tag1(node79_17,'n'). const('n'). m_tag2(node79_17,'f'). const('f'). m_tag3(node79_17,'p'). const('p'). m_tag4(node79_17,'4'). const('4'). m_tag10(node79_17,'a'). const('a'). 
edge(node79_0, node79_1).
edge(node79_1, node79_2).
edge(node79_1, node79_3).
edge(node79_3, node79_4).
edge(node79_4, node79_5).
edge(node79_3, node79_6).
edge(node79_6, node79_7).
edge(node79_3, node79_8).
edge(node79_1, node79_9).
edge(node79_1, node79_10).
edge(node79_10, node79_11).
edge(node79_11, node79_12).
edge(node79_12, node79_13).
edge(node79_11, node79_14).
edge(node79_10, node79_15).
edge(node79_10, node79_16).
edge(node79_16, node79_17).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prvni dva vitezne kolektivy postoupili do krajskeho kola, ktere se uskutecni v roce 2008. 
tree_root(node80_0).
:- %%%%%%%% node80_0 %%%%%%%%%%%%%%%%%%%
node(node80_0).
id(node80_0, t_plzensky51278_txt_001_p4s3).         const(t_plzensky51278_txt_001_p4s3).
%%%%%%%% node80_1 %%%%%%%%%%%%%%%%%%%
node(node80_1).
functor(node80_1, pred).         const(pred).
gram_sempos(node80_1, v).         const(v).
id(node80_1, t_plzensky51278_txt_001_p4s3a1).         const(t_plzensky51278_txt_001_p4s3a1).
t_lemma(node80_1, postoupit).         const(postoupit).
%%%%%%%% node80_2 %%%%%%%%%%%%%%%%%%%
node(node80_2).
functor(node80_2, act).         const(act).
gram_sempos(node80_2, n_denot).         const(n_denot).
id(node80_2, t_plzensky51278_txt_001_p4s3a2).         const(t_plzensky51278_txt_001_p4s3a2).
t_lemma(node80_2, kolektiv).         const(kolektiv).
%%%%%%%% node80_3 %%%%%%%%%%%%%%%%%%%
node(node80_3).
functor(node80_3, rstr).         const(rstr).
gram_sempos(node80_3, adj_quant_def).         const(adj_quant_def).
id(node80_3, t_plzensky51278_txt_001_p4s3a3).         const(t_plzensky51278_txt_001_p4s3a3).
t_lemma(node80_3, jeden).         const(jeden).
%%%%%%%% node80_4 %%%%%%%%%%%%%%%%%%%
node(node80_4).
a_afun(node80_4, atr).         const(atr).
m_form(node80_4, prvni).         const(prvni).
m_lemma(node80_4, prvni).         const(prvni).
m_tag(node80_4, crip1__________).         const(crip1__________).
m_tag0(node80_4,'c'). const('c'). m_tag1(node80_4,'r'). const('r'). m_tag2(node80_4,'i'). const('i'). m_tag3(node80_4,'p'). const('p'). m_tag4(node80_4,'1'). const('1'). 
%%%%%%%% node80_5 %%%%%%%%%%%%%%%%%%%
node(node80_5).
functor(node80_5, rstr).         const(rstr).
gram_sempos(node80_5, adj_quant_def).         const(adj_quant_def).
id(node80_5, t_plzensky51278_txt_001_p4s3a4).         const(t_plzensky51278_txt_001_p4s3a4).
t_lemma(node80_5, dva).         const(dva).
%%%%%%%% node80_6 %%%%%%%%%%%%%%%%%%%
node(node80_6).
a_afun(node80_6, atr).         const(atr).
m_form(node80_6, dva).         const(dva).
m_lemma(node80_6, dva_2).         const(dva_2).
m_tag(node80_6, clyp1__________).         const(clyp1__________).
m_tag0(node80_6,'c'). const('c'). m_tag1(node80_6,'l'). const('l'). m_tag2(node80_6,'y'). const('y'). m_tag3(node80_6,'p'). const('p'). m_tag4(node80_6,'1'). const('1'). 
%%%%%%%% node80_7 %%%%%%%%%%%%%%%%%%%
node(node80_7).
functor(node80_7, rstr).         const(rstr).
gram_sempos(node80_7, adj_denot).         const(adj_denot).
id(node80_7, t_plzensky51278_txt_001_p4s3a5).         const(t_plzensky51278_txt_001_p4s3a5).
t_lemma(node80_7, vitezny).         const(vitezny).
%%%%%%%% node80_8 %%%%%%%%%%%%%%%%%%%
node(node80_8).
a_afun(node80_8, atr).         const(atr).
m_form(node80_8, vitezne).         const(vitezne).
m_lemma(node80_8, vitezny).         const(vitezny).
m_tag(node80_8, aaip1____1a____).         const(aaip1____1a____).
m_tag0(node80_8,'a'). const('a'). m_tag1(node80_8,'a'). const('a'). m_tag2(node80_8,'i'). const('i'). m_tag3(node80_8,'p'). const('p'). m_tag4(node80_8,'1'). const('1'). m_tag9(node80_8,'1'). const('1'). m_tag10(node80_8,'a'). const('a'). 
%%%%%%%% node80_9 %%%%%%%%%%%%%%%%%%%
node(node80_9).
a_afun(node80_9, sb).         const(sb).
m_form(node80_9, kolektivy).         const(kolektivy).
m_lemma(node80_9, kolektiv).         const(kolektiv).
m_tag(node80_9, nnip1_____a____).         const(nnip1_____a____).
m_tag0(node80_9,'n'). const('n'). m_tag1(node80_9,'n'). const('n'). m_tag2(node80_9,'i'). const('i'). m_tag3(node80_9,'p'). const('p'). m_tag4(node80_9,'1'). const('1'). m_tag10(node80_9,'a'). const('a'). 
%%%%%%%% node80_10 %%%%%%%%%%%%%%%%%%%
node(node80_10).
a_afun(node80_10, pred).         const(pred).
m_form(node80_10, postoupili).         const(postoupili).
m_lemma(node80_10, postoupit__w).         const(postoupit__w).
m_tag(node80_10, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node80_10,'v'). const('v'). m_tag1(node80_10,'p'). const('p'). m_tag2(node80_10,'m'). const('m'). m_tag3(node80_10,'p'). const('p'). m_tag7(node80_10,'x'). const('x'). m_tag8(node80_10,'r'). const('r'). m_tag10(node80_10,'a'). const('a'). m_tag11(node80_10,'a'). const('a'). 
%%%%%%%% node80_11 %%%%%%%%%%%%%%%%%%%
node(node80_11).
functor(node80_11, dir3).         const(dir3).
gram_sempos(node80_11, n_denot).         const(n_denot).
id(node80_11, t_plzensky51278_txt_001_p4s3a7).         const(t_plzensky51278_txt_001_p4s3a7).
t_lemma(node80_11, kolo).         const(kolo).
%%%%%%%% node80_12 %%%%%%%%%%%%%%%%%%%
node(node80_12).
functor(node80_12, rstr).         const(rstr).
gram_sempos(node80_12, adj_denot).         const(adj_denot).
id(node80_12, t_plzensky51278_txt_001_p4s3a8).         const(t_plzensky51278_txt_001_p4s3a8).
t_lemma(node80_12, krajsky).         const(krajsky).
%%%%%%%% node80_13 %%%%%%%%%%%%%%%%%%%
node(node80_13).
a_afun(node80_13, atr).         const(atr).
m_form(node80_13, krajskeho).         const(krajskeho).
m_lemma(node80_13, krajsky).         const(krajsky).
m_tag(node80_13, aans2____1a____).         const(aans2____1a____).
m_tag0(node80_13,'a'). const('a'). m_tag1(node80_13,'a'). const('a'). m_tag2(node80_13,'n'). const('n'). m_tag3(node80_13,'s'). const('s'). m_tag4(node80_13,'2'). const('2'). m_tag9(node80_13,'1'). const('1'). m_tag10(node80_13,'a'). const('a'). 
%%%%%%%% node80_14 %%%%%%%%%%%%%%%%%%%
node(node80_14).
a_afun(node80_14, auxp).         const(auxp).
m_form(node80_14, do).         const(do).
m_lemma(node80_14, do_1).         const(do_1).
m_tag(node80_14, rr__2__________).         const(rr__2__________).
m_tag0(node80_14,'r'). const('r'). m_tag1(node80_14,'r'). const('r'). m_tag4(node80_14,'2'). const('2'). 
%%%%%%%% node80_15 %%%%%%%%%%%%%%%%%%%
node(node80_15).
a_afun(node80_15, adv).         const(adv).
m_form(node80_15, kola).         const(kola).
m_lemma(node80_15, kolo).         const(kolo).
m_tag(node80_15, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node80_15,'n'). const('n'). m_tag1(node80_15,'n'). const('n'). m_tag2(node80_15,'n'). const('n'). m_tag3(node80_15,'s'). const('s'). m_tag4(node80_15,'2'). const('2'). m_tag10(node80_15,'a'). const('a'). 
%%%%%%%% node80_16 %%%%%%%%%%%%%%%%%%%
node(node80_16).
functor(node80_16, rstr).         const(rstr).
gram_sempos(node80_16, v).         const(v).
id(node80_16, t_plzensky51278_txt_001_p4s3a9).         const(t_plzensky51278_txt_001_p4s3a9).
t_lemma(node80_16, uskutecnit_se).         const(uskutecnit_se).
%%%%%%%% node80_17 %%%%%%%%%%%%%%%%%%%
node(node80_17).
functor(node80_17, act).         const(act).
gram_sempos(node80_17, n_pron_indef).         const(n_pron_indef).
id(node80_17, t_plzensky51278_txt_001_p4s3a11).         const(t_plzensky51278_txt_001_p4s3a11).
t_lemma(node80_17, ktery).         const(ktery).
%%%%%%%% node80_18 %%%%%%%%%%%%%%%%%%%
node(node80_18).
a_afun(node80_18, sb).         const(sb).
m_form(node80_18, ktere).         const(ktere).
m_lemma(node80_18, ktery).         const(ktery).
m_tag(node80_18, p4ns1__________).         const(p4ns1__________).
m_tag0(node80_18,'p'). const('p'). m_tag1(node80_18,'4'). const('4'). m_tag2(node80_18,'n'). const('n'). m_tag3(node80_18,'s'). const('s'). m_tag4(node80_18,'1'). const('1'). 
%%%%%%%% node80_19 %%%%%%%%%%%%%%%%%%%
node(node80_19).
a_afun(node80_19, auxt).         const(auxt).
m_form(node80_19, se).         const(se).
m_lemma(node80_19, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node80_19, p7_x4__________).         const(p7_x4__________).
m_tag0(node80_19,'p'). const('p'). m_tag1(node80_19,'7'). const('7'). m_tag3(node80_19,'x'). const('x'). m_tag4(node80_19,'4'). const('4'). 
%%%%%%%% node80_20 %%%%%%%%%%%%%%%%%%%
node(node80_20).
a_afun(node80_20, atr).         const(atr).
m_form(node80_20, uskutecni).         const(uskutecni).
m_lemma(node80_20, uskutecnit__w).         const(uskutecnit__w).
m_tag(node80_20, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node80_20,'v'). const('v'). m_tag1(node80_20,'b'). const('b'). m_tag3(node80_20,'s'). const('s'). m_tag7(node80_20,'3'). const('3'). m_tag8(node80_20,'p'). const('p'). m_tag10(node80_20,'a'). const('a'). m_tag11(node80_20,'a'). const('a'). 
%%%%%%%% node80_21 %%%%%%%%%%%%%%%%%%%
node(node80_21).
functor(node80_21, twhen).         const(twhen).
gram_sempos(node80_21, n_denot).         const(n_denot).
id(node80_21, t_plzensky51278_txt_001_p4s3a14).         const(t_plzensky51278_txt_001_p4s3a14).
t_lemma(node80_21, rok).         const(rok).
%%%%%%%% node80_22 %%%%%%%%%%%%%%%%%%%
node(node80_22).
a_afun(node80_22, auxp).         const(auxp).
m_form(node80_22, v).         const(v).
m_lemma(node80_22, v_1).         const(v_1).
m_tag(node80_22, rr__6__________).         const(rr__6__________).
m_tag0(node80_22,'r'). const('r'). m_tag1(node80_22,'r'). const('r'). m_tag4(node80_22,'6'). const('6'). 
%%%%%%%% node80_23 %%%%%%%%%%%%%%%%%%%
node(node80_23).
a_afun(node80_23, adv).         const(adv).
m_form(node80_23, roce).         const(roce).
m_lemma(node80_23, rok).         const(rok).
m_tag(node80_23, nnis6_____a___1).         const(nnis6_____a___1).
m_tag0(node80_23,'n'). const('n'). m_tag1(node80_23,'n'). const('n'). m_tag2(node80_23,'i'). const('i'). m_tag3(node80_23,'s'). const('s'). m_tag4(node80_23,'6'). const('6'). m_tag10(node80_23,'a'). const('a'). m_tag14(node80_23,'1'). const('1'). 
%%%%%%%% node80_24 %%%%%%%%%%%%%%%%%%%
node(node80_24).
functor(node80_24, rstr).         const(rstr).
gram_sempos(node80_24, n_quant_def).         const(n_quant_def).
id(node80_24, t_plzensky51278_txt_001_p4s3a15).         const(t_plzensky51278_txt_001_p4s3a15).
t_lemma(node80_24, 2008).         const(2008).
%%%%%%%% node80_25 %%%%%%%%%%%%%%%%%%%
node(node80_25).
a_afun(node80_25, atr).         const(atr).
m_form(node80_25, 2008).         const(2008).
m_lemma(node80_25, 2008).         const(2008).
m_tag(node80_25, c=_____________).         const(c=_____________).
m_tag0(node80_25,'c'). const('c'). m_tag1(node80_25,'='). const('='). 
edge(node80_0, node80_1).
edge(node80_1, node80_2).
edge(node80_2, node80_3).
edge(node80_3, node80_4).
edge(node80_2, node80_5).
edge(node80_5, node80_6).
edge(node80_2, node80_7).
edge(node80_7, node80_8).
edge(node80_2, node80_9).
edge(node80_1, node80_10).
edge(node80_1, node80_11).
edge(node80_11, node80_12).
edge(node80_12, node80_13).
edge(node80_11, node80_14).
edge(node80_11, node80_15).
edge(node80_11, node80_16).
edge(node80_16, node80_17).
edge(node80_17, node80_18).
edge(node80_16, node80_19).
edge(node80_16, node80_20).
edge(node80_16, node80_21).
edge(node80_21, node80_22).
edge(node80_21, node80_23).
edge(node80_21, node80_24).
edge(node80_24, node80_25).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vysledky: vitezem se stalo druzstvo c. 6 ze 4. 
tree_root(node81_0).
:- %%%%%%%% node81_0 %%%%%%%%%%%%%%%%%%%
node(node81_0).
id(node81_0, t_plzensky51278_txt_001_p5s1).         const(t_plzensky51278_txt_001_p5s1).
%%%%%%%% node81_1 %%%%%%%%%%%%%%%%%%%
node(node81_1).
functor(node81_1, apps).         const(apps).
id(node81_1, t_plzensky51278_txt_001_p5s1a1).         const(t_plzensky51278_txt_001_p5s1a1).
t_lemma(node81_1, x_colon).         const(x_colon).
%%%%%%%% node81_2 %%%%%%%%%%%%%%%%%%%
node(node81_2).
functor(node81_2, denom).         const(denom).
gram_sempos(node81_2, n_denot).         const(n_denot).
id(node81_2, t_plzensky51278_txt_001_p5s1a2).         const(t_plzensky51278_txt_001_p5s1a2).
t_lemma(node81_2, vysledek).         const(vysledek).
%%%%%%%% node81_3 %%%%%%%%%%%%%%%%%%%
node(node81_3).
a_afun(node81_3, exd).         const(exd).
m_form(node81_3, vysledky).         const(vysledky).
m_lemma(node81_3, vysledek).         const(vysledek).
m_tag(node81_3, nnip1_____a____).         const(nnip1_____a____).
m_tag0(node81_3,'n'). const('n'). m_tag1(node81_3,'n'). const('n'). m_tag2(node81_3,'i'). const('i'). m_tag3(node81_3,'p'). const('p'). m_tag4(node81_3,'1'). const('1'). m_tag10(node81_3,'a'). const('a'). 
%%%%%%%% node81_4 %%%%%%%%%%%%%%%%%%%
node(node81_4).
a_afun(node81_4, apos).         const(apos).
m_form(node81_4, x_).         const(x_).
m_lemma(node81_4, x_).         const(x_).
m_tag(node81_4, z______________).         const(z______________).
m_tag0(node81_4,'z'). const('z'). m_tag1(node81_4,':'). const(':'). 
%%%%%%%% node81_5 %%%%%%%%%%%%%%%%%%%
node(node81_5).
functor(node81_5, par).         const(par).
gram_sempos(node81_5, v).         const(v).
id(node81_5, t_plzensky51278_txt_001_p5s1a3).         const(t_plzensky51278_txt_001_p5s1a3).
t_lemma(node81_5, stat_se).         const(stat_se).
%%%%%%%% node81_6 %%%%%%%%%%%%%%%%%%%
node(node81_6).
functor(node81_6, means).         const(means).
gram_sempos(node81_6, n_denot).         const(n_denot).
id(node81_6, t_plzensky51278_txt_001_p5s1a4).         const(t_plzensky51278_txt_001_p5s1a4).
t_lemma(node81_6, vitez).         const(vitez).
%%%%%%%% node81_7 %%%%%%%%%%%%%%%%%%%
node(node81_7).
a_afun(node81_7, adv).         const(adv).
m_form(node81_7, vitezem).         const(vitezem).
m_lemma(node81_7, vitez).         const(vitez).
m_tag(node81_7, nnms7_____a____).         const(nnms7_____a____).
m_tag0(node81_7,'n'). const('n'). m_tag1(node81_7,'n'). const('n'). m_tag2(node81_7,'m'). const('m'). m_tag3(node81_7,'s'). const('s'). m_tag4(node81_7,'7'). const('7'). m_tag10(node81_7,'a'). const('a'). 
%%%%%%%% node81_8 %%%%%%%%%%%%%%%%%%%
node(node81_8).
a_afun(node81_8, auxt).         const(auxt).
m_form(node81_8, se).         const(se).
m_lemma(node81_8, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node81_8, p7_x4__________).         const(p7_x4__________).
m_tag0(node81_8,'p'). const('p'). m_tag1(node81_8,'7'). const('7'). m_tag3(node81_8,'x'). const('x'). m_tag4(node81_8,'4'). const('4'). 
%%%%%%%% node81_9 %%%%%%%%%%%%%%%%%%%
node(node81_9).
a_afun(node81_9, pred).         const(pred).
m_form(node81_9, stalo).         const(stalo).
m_lemma(node81_9, stat_2___neco_se_prihodilo_).         const(stat_2___neco_se_prihodilo_).
m_tag(node81_9, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node81_9,'v'). const('v'). m_tag1(node81_9,'p'). const('p'). m_tag2(node81_9,'n'). const('n'). m_tag3(node81_9,'s'). const('s'). m_tag7(node81_9,'x'). const('x'). m_tag8(node81_9,'r'). const('r'). m_tag10(node81_9,'a'). const('a'). m_tag11(node81_9,'a'). const('a'). 
%%%%%%%% node81_10 %%%%%%%%%%%%%%%%%%%
node(node81_10).
functor(node81_10, act).         const(act).
gram_sempos(node81_10, n_denot).         const(n_denot).
id(node81_10, t_plzensky51278_txt_001_p5s1a6).         const(t_plzensky51278_txt_001_p5s1a6).
t_lemma(node81_10, druzstvo).         const(druzstvo).
%%%%%%%% node81_11 %%%%%%%%%%%%%%%%%%%
node(node81_11).
a_afun(node81_11, sb).         const(sb).
m_form(node81_11, druzstvo).         const(druzstvo).
m_lemma(node81_11, druzstvo).         const(druzstvo).
m_tag(node81_11, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node81_11,'n'). const('n'). m_tag1(node81_11,'n'). const('n'). m_tag2(node81_11,'n'). const('n'). m_tag3(node81_11,'s'). const('s'). m_tag4(node81_11,'1'). const('1'). m_tag10(node81_11,'a'). const('a'). 
%%%%%%%% node81_12 %%%%%%%%%%%%%%%%%%%
node(node81_12).
functor(node81_12, app).         const(app).
gram_sempos(node81_12, n_denot).         const(n_denot).
id(node81_12, t_plzensky51278_txt_001_p5s1a7).         const(t_plzensky51278_txt_001_p5s1a7).
t_lemma(node81_12, cislo).         const(cislo).
%%%%%%%% node81_13 %%%%%%%%%%%%%%%%%%%
node(node81_13).
a_afun(node81_13, atr).         const(atr).
m_form(node81_13, c_).         const(c_).
m_lemma(node81_13, cislo__b).         const(cislo__b).
m_tag(node81_13, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node81_13,'n'). const('n'). m_tag1(node81_13,'n'). const('n'). m_tag2(node81_13,'n'). const('n'). m_tag3(node81_13,'x'). const('x'). m_tag4(node81_13,'x'). const('x'). m_tag10(node81_13,'a'). const('a'). m_tag14(node81_13,'8'). const('8'). 
%%%%%%%% node81_14 %%%%%%%%%%%%%%%%%%%
node(node81_14).
functor(node81_14, rstr).         const(rstr).
gram_sempos(node81_14, adj_quant_def).         const(adj_quant_def).
id(node81_14, t_plzensky51278_txt_001_p5s1a8).         const(t_plzensky51278_txt_001_p5s1a8).
t_lemma(node81_14, 6).         const(6).
%%%%%%%% node81_15 %%%%%%%%%%%%%%%%%%%
node(node81_15).
a_afun(node81_15, atr).         const(atr).
m_form(node81_15, 6).         const(6).
m_lemma(node81_15, 6).         const(6).
m_tag(node81_15, c=_____________).         const(c=_____________).
m_tag0(node81_15,'c'). const('c'). m_tag1(node81_15,'='). const('='). 
%%%%%%%% node81_16 %%%%%%%%%%%%%%%%%%%
node(node81_16).
functor(node81_16, pat).         const(pat).
gram_sempos(node81_16, n_quant_def).         const(n_quant_def).
id(node81_16, t_plzensky51278_txt_001_p5s1a10).         const(t_plzensky51278_txt_001_p5s1a10).
t_lemma(node81_16, 4).         const(4).
%%%%%%%% node81_17 %%%%%%%%%%%%%%%%%%%
node(node81_17).
a_afun(node81_17, auxp).         const(auxp).
m_form(node81_17, ze).         const(ze).
m_lemma(node81_17, z_1).         const(z_1).
m_tag(node81_17, rv__2__________).         const(rv__2__________).
m_tag0(node81_17,'r'). const('r'). m_tag1(node81_17,'v'). const('v'). m_tag4(node81_17,'2'). const('2'). 
%%%%%%%% node81_18 %%%%%%%%%%%%%%%%%%%
node(node81_18).
a_afun(node81_18, exd).         const(exd).
m_form(node81_18, 4).         const(4).
m_lemma(node81_18, 4).         const(4).
m_tag(node81_18, c=_____________).         const(c=_____________).
m_tag0(node81_18,'c'). const('c'). m_tag1(node81_18,'='). const('='). 
edge(node81_0, node81_1).
edge(node81_1, node81_2).
edge(node81_2, node81_3).
edge(node81_1, node81_4).
edge(node81_1, node81_5).
edge(node81_5, node81_6).
edge(node81_6, node81_7).
edge(node81_5, node81_8).
edge(node81_5, node81_9).
edge(node81_5, node81_10).
edge(node81_10, node81_11).
edge(node81_10, node81_12).
edge(node81_12, node81_13).
edge(node81_12, node81_14).
edge(node81_14, node81_15).
edge(node81_5, node81_16).
edge(node81_16, node81_17).
edge(node81_16, node81_18).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zs kralovicka ulice plzen s poctem bodu 105. 
tree_root(node82_0).
:- %%%%%%%% node82_0 %%%%%%%%%%%%%%%%%%%
node(node82_0).
id(node82_0, t_plzensky51278_txt_001_p5s2).         const(t_plzensky51278_txt_001_p5s2).
%%%%%%%% node82_1 %%%%%%%%%%%%%%%%%%%
node(node82_1).
functor(node82_1, denom).         const(denom).
gram_sempos(node82_1, n_denot).         const(n_denot).
id(node82_1, t_plzensky51278_txt_001_p5s2a1).         const(t_plzensky51278_txt_001_p5s2a1).
t_lemma(node82_1, ulice).         const(ulice).
%%%%%%%% node82_2 %%%%%%%%%%%%%%%%%%%
node(node82_2).
functor(node82_2, rstr).         const(rstr).
gram_sempos(node82_2, n_denot).         const(n_denot).
id(node82_2, t_plzensky51278_txt_001_p5s2a2).         const(t_plzensky51278_txt_001_p5s2a2).
t_lemma(node82_2, zs).         const(zs).
%%%%%%%% node82_3 %%%%%%%%%%%%%%%%%%%
node(node82_3).
a_afun(node82_3, atr).         const(atr).
m_form(node82_3, zs).         const(zs).
m_lemma(node82_3, zs__b___zakladni_skola_).         const(zs__b___zakladni_skola_).
m_tag(node82_3, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node82_3,'n'). const('n'). m_tag1(node82_3,'n'). const('n'). m_tag2(node82_3,'f'). const('f'). m_tag3(node82_3,'x'). const('x'). m_tag4(node82_3,'x'). const('x'). m_tag10(node82_3,'a'). const('a'). 
%%%%%%%% node82_4 %%%%%%%%%%%%%%%%%%%
node(node82_4).
functor(node82_4, rstr).         const(rstr).
gram_sempos(node82_4, adj_denot).         const(adj_denot).
id(node82_4, t_plzensky51278_txt_001_p5s2a3).         const(t_plzensky51278_txt_001_p5s2a3).
t_lemma(node82_4, kralovicky).         const(kralovicky).
%%%%%%%% node82_5 %%%%%%%%%%%%%%%%%%%
node(node82_5).
a_afun(node82_5, atr).         const(atr).
m_form(node82_5, kralovicka).         const(kralovicka).
m_lemma(node82_5, kralovicky).         const(kralovicky).
m_tag(node82_5, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node82_5,'a'). const('a'). m_tag1(node82_5,'a'). const('a'). m_tag2(node82_5,'f'). const('f'). m_tag3(node82_5,'s'). const('s'). m_tag4(node82_5,'1'). const('1'). m_tag9(node82_5,'1'). const('1'). m_tag10(node82_5,'a'). const('a'). 
%%%%%%%% node82_6 %%%%%%%%%%%%%%%%%%%
node(node82_6).
a_afun(node82_6, exd).         const(exd).
m_form(node82_6, ulice).         const(ulice).
m_lemma(node82_6, ulice).         const(ulice).
m_tag(node82_6, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node82_6,'n'). const('n'). m_tag1(node82_6,'n'). const('n'). m_tag2(node82_6,'f'). const('f'). m_tag3(node82_6,'s'). const('s'). m_tag4(node82_6,'1'). const('1'). m_tag10(node82_6,'a'). const('a'). 
%%%%%%%% node82_7 %%%%%%%%%%%%%%%%%%%
node(node82_7).
functor(node82_7, rstr).         const(rstr).
gram_sempos(node82_7, n_denot).         const(n_denot).
id(node82_7, t_plzensky51278_txt_001_p5s2a4).         const(t_plzensky51278_txt_001_p5s2a4).
t_lemma(node82_7, plzen).         const(plzen).
%%%%%%%% node82_8 %%%%%%%%%%%%%%%%%%%
node(node82_8).
a_afun(node82_8, atr).         const(atr).
m_form(node82_8, plzen).         const(plzen).
m_lemma(node82_8, plzen__g).         const(plzen__g).
m_tag(node82_8, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node82_8,'n'). const('n'). m_tag1(node82_8,'n'). const('n'). m_tag2(node82_8,'f'). const('f'). m_tag3(node82_8,'s'). const('s'). m_tag4(node82_8,'1'). const('1'). m_tag10(node82_8,'a'). const('a'). 
%%%%%%%% node82_9 %%%%%%%%%%%%%%%%%%%
node(node82_9).
functor(node82_9, acmp).         const(acmp).
gram_sempos(node82_9, n_denot).         const(n_denot).
id(node82_9, t_plzensky51278_txt_001_p5s2a6).         const(t_plzensky51278_txt_001_p5s2a6).
t_lemma(node82_9, pocet).         const(pocet).
%%%%%%%% node82_10 %%%%%%%%%%%%%%%%%%%
node(node82_10).
a_afun(node82_10, auxp).         const(auxp).
m_form(node82_10, s).         const(s).
m_lemma(node82_10, s_1).         const(s_1).
m_tag(node82_10, rr__7__________).         const(rr__7__________).
m_tag0(node82_10,'r'). const('r'). m_tag1(node82_10,'r'). const('r'). m_tag4(node82_10,'7'). const('7'). 
%%%%%%%% node82_11 %%%%%%%%%%%%%%%%%%%
node(node82_11).
a_afun(node82_11, exd).         const(exd).
m_form(node82_11, poctem).         const(poctem).
m_lemma(node82_11, pocet).         const(pocet).
m_tag(node82_11, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node82_11,'n'). const('n'). m_tag1(node82_11,'n'). const('n'). m_tag2(node82_11,'i'). const('i'). m_tag3(node82_11,'s'). const('s'). m_tag4(node82_11,'7'). const('7'). m_tag10(node82_11,'a'). const('a'). 
%%%%%%%% node82_12 %%%%%%%%%%%%%%%%%%%
node(node82_12).
functor(node82_12, mat).         const(mat).
gram_sempos(node82_12, n_denot).         const(n_denot).
id(node82_12, t_plzensky51278_txt_001_p5s2a7).         const(t_plzensky51278_txt_001_p5s2a7).
t_lemma(node82_12, bod).         const(bod).
%%%%%%%% node82_13 %%%%%%%%%%%%%%%%%%%
node(node82_13).
a_afun(node82_13, atr).         const(atr).
m_form(node82_13, bodu).         const(bodu).
m_lemma(node82_13, bod).         const(bod).
m_tag(node82_13, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node82_13,'n'). const('n'). m_tag1(node82_13,'n'). const('n'). m_tag2(node82_13,'i'). const('i'). m_tag3(node82_13,'p'). const('p'). m_tag4(node82_13,'2'). const('2'). m_tag10(node82_13,'a'). const('a'). 
%%%%%%%% node82_14 %%%%%%%%%%%%%%%%%%%
node(node82_14).
functor(node82_14, twhen).         const(twhen).
gram_sempos(node82_14, n_quant_def).         const(n_quant_def).
id(node82_14, t_plzensky51278_txt_001_p5s2a8).         const(t_plzensky51278_txt_001_p5s2a8).
t_lemma(node82_14, 105).         const(105).
%%%%%%%% node82_15 %%%%%%%%%%%%%%%%%%%
node(node82_15).
a_afun(node82_15, exd).         const(exd).
m_form(node82_15, 105).         const(105).
m_lemma(node82_15, 105).         const(105).
m_tag(node82_15, c=_____________).         const(c=_____________).
m_tag0(node82_15,'c'). const('c'). m_tag1(node82_15,'='). const('='). 
edge(node82_0, node82_1).
edge(node82_1, node82_2).
edge(node82_2, node82_3).
edge(node82_1, node82_4).
edge(node82_4, node82_5).
edge(node82_1, node82_6).
edge(node82_1, node82_7).
edge(node82_7, node82_8).
edge(node82_0, node82_9).
edge(node82_9, node82_10).
edge(node82_9, node82_11).
edge(node82_9, node82_12).
edge(node82_12, node82_13).
edge(node82_0, node82_14).
edge(node82_14, node82_15).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% druhe misto obsadilo druzstvo c. 1 ze 14 zs zabelska ulice plzen s poctem bodu 102 a treti druzstvo c. 11 z 11.zs v baarove ulici v plzen s poctem bodu 101.5. 
tree_root(node83_0).
:- %%%%%%%% node83_0 %%%%%%%%%%%%%%%%%%%
node(node83_0).
id(node83_0, t_plzensky51278_txt_001_p5s3).         const(t_plzensky51278_txt_001_p5s3).
%%%%%%%% node83_1 %%%%%%%%%%%%%%%%%%%
node(node83_1).
functor(node83_1, pred).         const(pred).
gram_sempos(node83_1, v).         const(v).
id(node83_1, t_plzensky51278_txt_001_p5s3a1).         const(t_plzensky51278_txt_001_p5s3a1).
t_lemma(node83_1, obsadit).         const(obsadit).
%%%%%%%% node83_2 %%%%%%%%%%%%%%%%%%%
node(node83_2).
functor(node83_2, pat).         const(pat).
gram_sempos(node83_2, n_denot).         const(n_denot).
id(node83_2, t_plzensky51278_txt_001_p5s3a2).         const(t_plzensky51278_txt_001_p5s3a2).
t_lemma(node83_2, misto).         const(misto).
%%%%%%%% node83_3 %%%%%%%%%%%%%%%%%%%
node(node83_3).
functor(node83_3, rstr).         const(rstr).
gram_sempos(node83_3, adj_quant_def).         const(adj_quant_def).
id(node83_3, t_plzensky51278_txt_001_p5s3a3).         const(t_plzensky51278_txt_001_p5s3a3).
t_lemma(node83_3, dva).         const(dva).
%%%%%%%% node83_4 %%%%%%%%%%%%%%%%%%%
node(node83_4).
a_afun(node83_4, atr).         const(atr).
m_form(node83_4, druhe).         const(druhe).
m_lemma(node83_4, druhy_1___jiny_).         const(druhy_1___jiny_).
m_tag(node83_4, aans4____1a____).         const(aans4____1a____).
m_tag0(node83_4,'a'). const('a'). m_tag1(node83_4,'a'). const('a'). m_tag2(node83_4,'n'). const('n'). m_tag3(node83_4,'s'). const('s'). m_tag4(node83_4,'4'). const('4'). m_tag9(node83_4,'1'). const('1'). m_tag10(node83_4,'a'). const('a'). 
%%%%%%%% node83_5 %%%%%%%%%%%%%%%%%%%
node(node83_5).
a_afun(node83_5, obj).         const(obj).
m_form(node83_5, misto).         const(misto).
m_lemma(node83_5, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node83_5, nnns4_____a____).         const(nnns4_____a____).
m_tag0(node83_5,'n'). const('n'). m_tag1(node83_5,'n'). const('n'). m_tag2(node83_5,'n'). const('n'). m_tag3(node83_5,'s'). const('s'). m_tag4(node83_5,'4'). const('4'). m_tag10(node83_5,'a'). const('a'). 
%%%%%%%% node83_6 %%%%%%%%%%%%%%%%%%%
node(node83_6).
a_afun(node83_6, pred).         const(pred).
m_form(node83_6, obsadilo).         const(obsadilo).
m_lemma(node83_6, obsadit__w).         const(obsadit__w).
m_tag(node83_6, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node83_6,'v'). const('v'). m_tag1(node83_6,'p'). const('p'). m_tag2(node83_6,'n'). const('n'). m_tag3(node83_6,'s'). const('s'). m_tag7(node83_6,'x'). const('x'). m_tag8(node83_6,'r'). const('r'). m_tag10(node83_6,'a'). const('a'). m_tag11(node83_6,'a'). const('a'). 
%%%%%%%% node83_7 %%%%%%%%%%%%%%%%%%%
node(node83_7).
functor(node83_7, act).         const(act).
gram_sempos(node83_7, n_denot).         const(n_denot).
id(node83_7, t_plzensky51278_txt_001_p5s3a4).         const(t_plzensky51278_txt_001_p5s3a4).
t_lemma(node83_7, druzstvo).         const(druzstvo).
%%%%%%%% node83_8 %%%%%%%%%%%%%%%%%%%
node(node83_8).
a_afun(node83_8, sb).         const(sb).
m_form(node83_8, druzstvo).         const(druzstvo).
m_lemma(node83_8, druzstvo).         const(druzstvo).
m_tag(node83_8, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node83_8,'n'). const('n'). m_tag1(node83_8,'n'). const('n'). m_tag2(node83_8,'n'). const('n'). m_tag3(node83_8,'s'). const('s'). m_tag4(node83_8,'1'). const('1'). m_tag10(node83_8,'a'). const('a'). 
%%%%%%%% node83_9 %%%%%%%%%%%%%%%%%%%
node(node83_9).
functor(node83_9, app).         const(app).
gram_sempos(node83_9, n_denot).         const(n_denot).
id(node83_9, t_plzensky51278_txt_001_p5s3a5).         const(t_plzensky51278_txt_001_p5s3a5).
t_lemma(node83_9, cislo).         const(cislo).
%%%%%%%% node83_10 %%%%%%%%%%%%%%%%%%%
node(node83_10).
a_afun(node83_10, atr).         const(atr).
m_form(node83_10, c_).         const(c_).
m_lemma(node83_10, cislo__b).         const(cislo__b).
m_tag(node83_10, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node83_10,'n'). const('n'). m_tag1(node83_10,'n'). const('n'). m_tag2(node83_10,'n'). const('n'). m_tag3(node83_10,'x'). const('x'). m_tag4(node83_10,'x'). const('x'). m_tag10(node83_10,'a'). const('a'). m_tag14(node83_10,'8'). const('8'). 
%%%%%%%% node83_11 %%%%%%%%%%%%%%%%%%%
node(node83_11).
functor(node83_11, rstr).         const(rstr).
gram_sempos(node83_11, adj_quant_def).         const(adj_quant_def).
id(node83_11, t_plzensky51278_txt_001_p5s3a6).         const(t_plzensky51278_txt_001_p5s3a6).
t_lemma(node83_11, 1).         const(1).
%%%%%%%% node83_12 %%%%%%%%%%%%%%%%%%%
node(node83_12).
a_afun(node83_12, atr).         const(atr).
m_form(node83_12, 1).         const(1).
m_lemma(node83_12, 1).         const(1).
m_tag(node83_12, c=_____________).         const(c=_____________).
m_tag0(node83_12,'c'). const('c'). m_tag1(node83_12,'='). const('='). 
%%%%%%%% node83_13 %%%%%%%%%%%%%%%%%%%
node(node83_13).
functor(node83_13, dir1).         const(dir1).
gram_sempos(node83_13, n_denot).         const(n_denot).
id(node83_13, t_plzensky51278_txt_001_p5s3a8).         const(t_plzensky51278_txt_001_p5s3a8).
t_lemma(node83_13, zs).         const(zs).
%%%%%%%% node83_14 %%%%%%%%%%%%%%%%%%%
node(node83_14).
functor(node83_14, rstr).         const(rstr).
gram_sempos(node83_14, adj_quant_def).         const(adj_quant_def).
id(node83_14, t_plzensky51278_txt_001_p5s3a9).         const(t_plzensky51278_txt_001_p5s3a9).
t_lemma(node83_14, 14).         const(14).
%%%%%%%% node83_15 %%%%%%%%%%%%%%%%%%%
node(node83_15).
a_afun(node83_15, atr).         const(atr).
m_form(node83_15, 14).         const(14).
m_lemma(node83_15, 14).         const(14).
m_tag(node83_15, c=_____________).         const(c=_____________).
m_tag0(node83_15,'c'). const('c'). m_tag1(node83_15,'='). const('='). 
%%%%%%%% node83_16 %%%%%%%%%%%%%%%%%%%
node(node83_16).
a_afun(node83_16, auxp).         const(auxp).
m_form(node83_16, ze).         const(ze).
m_lemma(node83_16, z_1).         const(z_1).
m_tag(node83_16, rv__2__________).         const(rv__2__________).
m_tag0(node83_16,'r'). const('r'). m_tag1(node83_16,'v'). const('v'). m_tag4(node83_16,'2'). const('2'). 
%%%%%%%% node83_17 %%%%%%%%%%%%%%%%%%%
node(node83_17).
a_afun(node83_17, adv).         const(adv).
m_form(node83_17, zs).         const(zs).
m_lemma(node83_17, zs__b___zakladni_skola_).         const(zs__b___zakladni_skola_).
m_tag(node83_17, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node83_17,'n'). const('n'). m_tag1(node83_17,'n'). const('n'). m_tag2(node83_17,'f'). const('f'). m_tag3(node83_17,'x'). const('x'). m_tag4(node83_17,'x'). const('x'). m_tag10(node83_17,'a'). const('a'). 
%%%%%%%% node83_18 %%%%%%%%%%%%%%%%%%%
node(node83_18).
functor(node83_18, conj).         const(conj).
id(node83_18, t_plzensky51278_txt_001_p5s3a10).         const(t_plzensky51278_txt_001_p5s3a10).
t_lemma(node83_18, a).         const(a).
%%%%%%%% node83_19 %%%%%%%%%%%%%%%%%%%
node(node83_19).
functor(node83_19, rstr).         const(rstr).
gram_sempos(node83_19, n_denot).         const(n_denot).
id(node83_19, t_plzensky51278_txt_001_p5s3a11).         const(t_plzensky51278_txt_001_p5s3a11).
t_lemma(node83_19, ulice).         const(ulice).
%%%%%%%% node83_20 %%%%%%%%%%%%%%%%%%%
node(node83_20).
functor(node83_20, rstr).         const(rstr).
gram_sempos(node83_20, adj_denot).         const(adj_denot).
id(node83_20, t_plzensky51278_txt_001_p5s3a12).         const(t_plzensky51278_txt_001_p5s3a12).
t_lemma(node83_20, zabelsky).         const(zabelsky).
%%%%%%%% node83_21 %%%%%%%%%%%%%%%%%%%
node(node83_21).
a_afun(node83_21, atr).         const(atr).
m_form(node83_21, zabelska).         const(zabelska).
m_lemma(node83_21, zabelsky).         const(zabelsky).
m_tag(node83_21, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node83_21,'a'). const('a'). m_tag1(node83_21,'a'). const('a'). m_tag2(node83_21,'f'). const('f'). m_tag3(node83_21,'s'). const('s'). m_tag4(node83_21,'1'). const('1'). m_tag9(node83_21,'1'). const('1'). m_tag10(node83_21,'a'). const('a'). 
%%%%%%%% node83_22 %%%%%%%%%%%%%%%%%%%
node(node83_22).
a_afun(node83_22, atr).         const(atr).
m_form(node83_22, ulice).         const(ulice).
m_lemma(node83_22, ulice).         const(ulice).
m_tag(node83_22, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node83_22,'n'). const('n'). m_tag1(node83_22,'n'). const('n'). m_tag2(node83_22,'f'). const('f'). m_tag3(node83_22,'s'). const('s'). m_tag4(node83_22,'1'). const('1'). m_tag10(node83_22,'a'). const('a'). 
%%%%%%%% node83_23 %%%%%%%%%%%%%%%%%%%
node(node83_23).
functor(node83_23, rstr).         const(rstr).
gram_sempos(node83_23, n_denot).         const(n_denot).
id(node83_23, t_plzensky51278_txt_001_p5s3a13).         const(t_plzensky51278_txt_001_p5s3a13).
t_lemma(node83_23, plzen).         const(plzen).
%%%%%%%% node83_24 %%%%%%%%%%%%%%%%%%%
node(node83_24).
a_afun(node83_24, atr).         const(atr).
m_form(node83_24, plzen).         const(plzen).
m_lemma(node83_24, plzen__g).         const(plzen__g).
m_tag(node83_24, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node83_24,'n'). const('n'). m_tag1(node83_24,'n'). const('n'). m_tag2(node83_24,'f'). const('f'). m_tag3(node83_24,'s'). const('s'). m_tag4(node83_24,'1'). const('1'). m_tag10(node83_24,'a'). const('a'). 
%%%%%%%% node83_25 %%%%%%%%%%%%%%%%%%%
node(node83_25).
functor(node83_25, acmp).         const(acmp).
gram_sempos(node83_25, n_denot).         const(n_denot).
id(node83_25, t_plzensky51278_txt_001_p5s3a15).         const(t_plzensky51278_txt_001_p5s3a15).
t_lemma(node83_25, pocet).         const(pocet).
%%%%%%%% node83_26 %%%%%%%%%%%%%%%%%%%
node(node83_26).
a_afun(node83_26, auxp).         const(auxp).
m_form(node83_26, s).         const(s).
m_lemma(node83_26, s_1).         const(s_1).
m_tag(node83_26, rr__7__________).         const(rr__7__________).
m_tag0(node83_26,'r'). const('r'). m_tag1(node83_26,'r'). const('r'). m_tag4(node83_26,'7'). const('7'). 
%%%%%%%% node83_27 %%%%%%%%%%%%%%%%%%%
node(node83_27).
a_afun(node83_27, atr).         const(atr).
m_form(node83_27, poctem).         const(poctem).
m_lemma(node83_27, pocet).         const(pocet).
m_tag(node83_27, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node83_27,'n'). const('n'). m_tag1(node83_27,'n'). const('n'). m_tag2(node83_27,'i'). const('i'). m_tag3(node83_27,'s'). const('s'). m_tag4(node83_27,'7'). const('7'). m_tag10(node83_27,'a'). const('a'). 
%%%%%%%% node83_28 %%%%%%%%%%%%%%%%%%%
node(node83_28).
functor(node83_28, mat).         const(mat).
gram_sempos(node83_28, n_denot).         const(n_denot).
id(node83_28, t_plzensky51278_txt_001_p5s3a16).         const(t_plzensky51278_txt_001_p5s3a16).
t_lemma(node83_28, bod).         const(bod).
%%%%%%%% node83_29 %%%%%%%%%%%%%%%%%%%
node(node83_29).
a_afun(node83_29, atr).         const(atr).
m_form(node83_29, bodu).         const(bodu).
m_lemma(node83_29, bod).         const(bod).
m_tag(node83_29, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node83_29,'n'). const('n'). m_tag1(node83_29,'n'). const('n'). m_tag2(node83_29,'i'). const('i'). m_tag3(node83_29,'p'). const('p'). m_tag4(node83_29,'2'). const('2'). m_tag10(node83_29,'a'). const('a'). 
%%%%%%%% node83_30 %%%%%%%%%%%%%%%%%%%
node(node83_30).
functor(node83_30, rstr).         const(rstr).
gram_sempos(node83_30, adj_quant_def).         const(adj_quant_def).
id(node83_30, t_plzensky51278_txt_001_p5s3a17).         const(t_plzensky51278_txt_001_p5s3a17).
t_lemma(node83_30, 102).         const(102).
%%%%%%%% node83_31 %%%%%%%%%%%%%%%%%%%
node(node83_31).
a_afun(node83_31, atr).         const(atr).
m_form(node83_31, 102).         const(102).
m_lemma(node83_31, 102).         const(102).
m_tag(node83_31, c=_____________).         const(c=_____________).
m_tag0(node83_31,'c'). const('c'). m_tag1(node83_31,'='). const('='). 
%%%%%%%% node83_32 %%%%%%%%%%%%%%%%%%%
node(node83_32).
a_afun(node83_32, coord).         const(coord).
m_form(node83_32, a).         const(a).
m_lemma(node83_32, a_1).         const(a_1).
m_tag(node83_32, j______________).         const(j______________).
m_tag0(node83_32,'j'). const('j'). m_tag1(node83_32,'^'). const('^'). 
%%%%%%%% node83_33 %%%%%%%%%%%%%%%%%%%
node(node83_33).
functor(node83_33, rstr).         const(rstr).
gram_sempos(node83_33, n_denot).         const(n_denot).
id(node83_33, t_plzensky51278_txt_001_p5s3a18).         const(t_plzensky51278_txt_001_p5s3a18).
t_lemma(node83_33, druzstvo).         const(druzstvo).
%%%%%%%% node83_34 %%%%%%%%%%%%%%%%%%%
node(node83_34).
functor(node83_34, rstr).         const(rstr).
gram_sempos(node83_34, adj_quant_def).         const(adj_quant_def).
id(node83_34, t_plzensky51278_txt_001_p5s3a19).         const(t_plzensky51278_txt_001_p5s3a19).
t_lemma(node83_34, tri).         const(tri).
%%%%%%%% node83_35 %%%%%%%%%%%%%%%%%%%
node(node83_35).
a_afun(node83_35, atr).         const(atr).
m_form(node83_35, treti).         const(treti).
m_lemma(node83_35, treti).         const(treti).
m_tag(node83_35, crns1__________).         const(crns1__________).
m_tag0(node83_35,'c'). const('c'). m_tag1(node83_35,'r'). const('r'). m_tag2(node83_35,'n'). const('n'). m_tag3(node83_35,'s'). const('s'). m_tag4(node83_35,'1'). const('1'). 
%%%%%%%% node83_36 %%%%%%%%%%%%%%%%%%%
node(node83_36).
a_afun(node83_36, atr).         const(atr).
m_form(node83_36, druzstvo).         const(druzstvo).
m_lemma(node83_36, druzstvo).         const(druzstvo).
m_tag(node83_36, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node83_36,'n'). const('n'). m_tag1(node83_36,'n'). const('n'). m_tag2(node83_36,'n'). const('n'). m_tag3(node83_36,'s'). const('s'). m_tag4(node83_36,'1'). const('1'). m_tag10(node83_36,'a'). const('a'). 
%%%%%%%% node83_37 %%%%%%%%%%%%%%%%%%%
node(node83_37).
functor(node83_37, app).         const(app).
gram_sempos(node83_37, n_denot).         const(n_denot).
id(node83_37, t_plzensky51278_txt_001_p5s3a20).         const(t_plzensky51278_txt_001_p5s3a20).
t_lemma(node83_37, cislo).         const(cislo).
%%%%%%%% node83_38 %%%%%%%%%%%%%%%%%%%
node(node83_38).
a_afun(node83_38, atr).         const(atr).
m_form(node83_38, c_).         const(c_).
m_lemma(node83_38, cislo__b).         const(cislo__b).
m_tag(node83_38, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node83_38,'n'). const('n'). m_tag1(node83_38,'n'). const('n'). m_tag2(node83_38,'n'). const('n'). m_tag3(node83_38,'x'). const('x'). m_tag4(node83_38,'x'). const('x'). m_tag10(node83_38,'a'). const('a'). m_tag14(node83_38,'8'). const('8'). 
%%%%%%%% node83_39 %%%%%%%%%%%%%%%%%%%
node(node83_39).
functor(node83_39, rstr).         const(rstr).
gram_sempos(node83_39, adj_quant_def).         const(adj_quant_def).
id(node83_39, t_plzensky51278_txt_001_p5s3a21).         const(t_plzensky51278_txt_001_p5s3a21).
t_lemma(node83_39, 11).         const(11).
%%%%%%%% node83_40 %%%%%%%%%%%%%%%%%%%
node(node83_40).
a_afun(node83_40, atr).         const(atr).
m_form(node83_40, 11).         const(11).
m_lemma(node83_40, 11).         const(11).
m_tag(node83_40, c=_____________).         const(c=_____________).
m_tag0(node83_40,'c'). const('c'). m_tag1(node83_40,'='). const('='). 
%%%%%%%% node83_41 %%%%%%%%%%%%%%%%%%%
node(node83_41).
functor(node83_41, dir1).         const(dir1).
gram_sempos(node83_41, n_denot).         const(n_denot).
id(node83_41, t_plzensky51278_txt_001_p5s3a23).         const(t_plzensky51278_txt_001_p5s3a23).
t_lemma(node83_41, x11_zs).         const(x11_zs).
%%%%%%%% node83_42 %%%%%%%%%%%%%%%%%%%
node(node83_42).
a_afun(node83_42, auxp).         const(auxp).
m_form(node83_42, z).         const(z).
m_lemma(node83_42, z_1).         const(z_1).
m_tag(node83_42, rr__2__________).         const(rr__2__________).
m_tag0(node83_42,'r'). const('r'). m_tag1(node83_42,'r'). const('r'). m_tag4(node83_42,'2'). const('2'). 
%%%%%%%% node83_43 %%%%%%%%%%%%%%%%%%%
node(node83_43).
a_afun(node83_43, adv).         const(adv).
m_form(node83_43, x11_zs).         const(x11_zs).
m_lemma(node83_43, x11_zs).         const(x11_zs).
m_tag(node83_43, nnixx_____a____).         const(nnixx_____a____).
m_tag0(node83_43,'n'). const('n'). m_tag1(node83_43,'n'). const('n'). m_tag2(node83_43,'i'). const('i'). m_tag3(node83_43,'x'). const('x'). m_tag4(node83_43,'x'). const('x'). m_tag10(node83_43,'a'). const('a'). 
%%%%%%%% node83_44 %%%%%%%%%%%%%%%%%%%
node(node83_44).
functor(node83_44, loc).         const(loc).
gram_sempos(node83_44, n_denot).         const(n_denot).
id(node83_44, t_plzensky51278_txt_001_p5s3a25).         const(t_plzensky51278_txt_001_p5s3a25).
t_lemma(node83_44, ulice).         const(ulice).
%%%%%%%% node83_45 %%%%%%%%%%%%%%%%%%%
node(node83_45).
functor(node83_45, rstr).         const(rstr).
gram_sempos(node83_45, n_denot).         const(n_denot).
id(node83_45, t_plzensky51278_txt_001_p5s3a26).         const(t_plzensky51278_txt_001_p5s3a26).
t_lemma(node83_45, baaruv).         const(baaruv).
%%%%%%%% node83_46 %%%%%%%%%%%%%%%%%%%
node(node83_46).
a_afun(node83_46, atr).         const(atr).
m_form(node83_46, baarove).         const(baarove).
m_lemma(node83_46, baaruv__s____2_).         const(baaruv__s____2_).
m_tag(node83_46, aufs6m_________).         const(aufs6m_________).
m_tag0(node83_46,'a'). const('a'). m_tag1(node83_46,'u'). const('u'). m_tag2(node83_46,'f'). const('f'). m_tag3(node83_46,'s'). const('s'). m_tag4(node83_46,'6'). const('6'). m_tag5(node83_46,'m'). const('m'). 
%%%%%%%% node83_47 %%%%%%%%%%%%%%%%%%%
node(node83_47).
a_afun(node83_47, auxp).         const(auxp).
m_form(node83_47, v).         const(v).
m_lemma(node83_47, v_1).         const(v_1).
m_tag(node83_47, rr__6__________).         const(rr__6__________).
m_tag0(node83_47,'r'). const('r'). m_tag1(node83_47,'r'). const('r'). m_tag4(node83_47,'6'). const('6'). 
%%%%%%%% node83_48 %%%%%%%%%%%%%%%%%%%
node(node83_48).
a_afun(node83_48, atr).         const(atr).
m_form(node83_48, ulici).         const(ulici).
m_lemma(node83_48, ulice).         const(ulice).
m_tag(node83_48, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node83_48,'n'). const('n'). m_tag1(node83_48,'n'). const('n'). m_tag2(node83_48,'f'). const('f'). m_tag3(node83_48,'s'). const('s'). m_tag4(node83_48,'6'). const('6'). m_tag10(node83_48,'a'). const('a'). 
%%%%%%%% node83_49 %%%%%%%%%%%%%%%%%%%
node(node83_49).
functor(node83_49, pat).         const(pat).
gram_sempos(node83_49, n_denot).         const(n_denot).
id(node83_49, t_plzensky51278_txt_001_p5s3a28).         const(t_plzensky51278_txt_001_p5s3a28).
t_lemma(node83_49, plzen).         const(plzen).
%%%%%%%% node83_50 %%%%%%%%%%%%%%%%%%%
node(node83_50).
a_afun(node83_50, auxp).         const(auxp).
m_form(node83_50, v).         const(v).
m_lemma(node83_50, v_1).         const(v_1).
m_tag(node83_50, rr__4__________).         const(rr__4__________).
m_tag0(node83_50,'r'). const('r'). m_tag1(node83_50,'r'). const('r'). m_tag4(node83_50,'4'). const('4'). 
%%%%%%%% node83_51 %%%%%%%%%%%%%%%%%%%
node(node83_51).
a_afun(node83_51, atr).         const(atr).
m_form(node83_51, plzen).         const(plzen).
m_lemma(node83_51, plzen__g).         const(plzen__g).
m_tag(node83_51, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node83_51,'n'). const('n'). m_tag1(node83_51,'n'). const('n'). m_tag2(node83_51,'f'). const('f'). m_tag3(node83_51,'s'). const('s'). m_tag4(node83_51,'4'). const('4'). m_tag10(node83_51,'a'). const('a'). 
%%%%%%%% node83_52 %%%%%%%%%%%%%%%%%%%
node(node83_52).
functor(node83_52, acmp).         const(acmp).
gram_sempos(node83_52, n_denot).         const(n_denot).
id(node83_52, t_plzensky51278_txt_001_p5s3a30).         const(t_plzensky51278_txt_001_p5s3a30).
t_lemma(node83_52, pocet).         const(pocet).
%%%%%%%% node83_53 %%%%%%%%%%%%%%%%%%%
node(node83_53).
a_afun(node83_53, auxp).         const(auxp).
m_form(node83_53, s).         const(s).
m_lemma(node83_53, s_1).         const(s_1).
m_tag(node83_53, rr__7__________).         const(rr__7__________).
m_tag0(node83_53,'r'). const('r'). m_tag1(node83_53,'r'). const('r'). m_tag4(node83_53,'7'). const('7'). 
%%%%%%%% node83_54 %%%%%%%%%%%%%%%%%%%
node(node83_54).
a_afun(node83_54, atr).         const(atr).
m_form(node83_54, poctem).         const(poctem).
m_lemma(node83_54, pocet).         const(pocet).
m_tag(node83_54, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node83_54,'n'). const('n'). m_tag1(node83_54,'n'). const('n'). m_tag2(node83_54,'i'). const('i'). m_tag3(node83_54,'s'). const('s'). m_tag4(node83_54,'7'). const('7'). m_tag10(node83_54,'a'). const('a'). 
%%%%%%%% node83_55 %%%%%%%%%%%%%%%%%%%
node(node83_55).
functor(node83_55, mat).         const(mat).
gram_sempos(node83_55, n_denot).         const(n_denot).
id(node83_55, t_plzensky51278_txt_001_p5s3a31).         const(t_plzensky51278_txt_001_p5s3a31).
t_lemma(node83_55, bod).         const(bod).
%%%%%%%% node83_56 %%%%%%%%%%%%%%%%%%%
node(node83_56).
a_afun(node83_56, atr).         const(atr).
m_form(node83_56, bodu).         const(bodu).
m_lemma(node83_56, bod).         const(bod).
m_tag(node83_56, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node83_56,'n'). const('n'). m_tag1(node83_56,'n'). const('n'). m_tag2(node83_56,'i'). const('i'). m_tag3(node83_56,'p'). const('p'). m_tag4(node83_56,'2'). const('2'). m_tag10(node83_56,'a'). const('a'). 
%%%%%%%% node83_57 %%%%%%%%%%%%%%%%%%%
node(node83_57).
functor(node83_57, rstr).         const(rstr).
gram_sempos(node83_57, adj_quant_def).         const(adj_quant_def).
id(node83_57, t_plzensky51278_txt_001_p5s3a32).         const(t_plzensky51278_txt_001_p5s3a32).
t_lemma(node83_57, x101_5).         const(x101_5).
%%%%%%%% node83_58 %%%%%%%%%%%%%%%%%%%
node(node83_58).
a_afun(node83_58, atr).         const(atr).
m_form(node83_58, x101_5).         const(x101_5).
m_lemma(node83_58, x101_5).         const(x101_5).
m_tag(node83_58, c=_____________).         const(c=_____________).
m_tag0(node83_58,'c'). const('c'). m_tag1(node83_58,'='). const('='). 
edge(node83_0, node83_1).
edge(node83_1, node83_2).
edge(node83_2, node83_3).
edge(node83_3, node83_4).
edge(node83_2, node83_5).
edge(node83_1, node83_6).
edge(node83_1, node83_7).
edge(node83_7, node83_8).
edge(node83_7, node83_9).
edge(node83_9, node83_10).
edge(node83_9, node83_11).
edge(node83_11, node83_12).
edge(node83_1, node83_13).
edge(node83_13, node83_14).
edge(node83_14, node83_15).
edge(node83_13, node83_16).
edge(node83_13, node83_17).
edge(node83_13, node83_18).
edge(node83_18, node83_19).
edge(node83_19, node83_20).
edge(node83_20, node83_21).
edge(node83_19, node83_22).
edge(node83_19, node83_23).
edge(node83_23, node83_24).
edge(node83_19, node83_25).
edge(node83_25, node83_26).
edge(node83_25, node83_27).
edge(node83_25, node83_28).
edge(node83_28, node83_29).
edge(node83_28, node83_30).
edge(node83_30, node83_31).
edge(node83_18, node83_32).
edge(node83_18, node83_33).
edge(node83_33, node83_34).
edge(node83_34, node83_35).
edge(node83_33, node83_36).
edge(node83_33, node83_37).
edge(node83_37, node83_38).
edge(node83_13, node83_39).
edge(node83_39, node83_40).
edge(node83_1, node83_41).
edge(node83_41, node83_42).
edge(node83_41, node83_43).
edge(node83_41, node83_44).
edge(node83_44, node83_45).
edge(node83_45, node83_46).
edge(node83_44, node83_47).
edge(node83_44, node83_48).
edge(node83_44, node83_49).
edge(node83_49, node83_50).
edge(node83_49, node83_51).
edge(node83_49, node83_52).
edge(node83_52, node83_53).
edge(node83_52, node83_54).
edge(node83_52, node83_55).
edge(node83_55, node83_56).
edge(node83_41, node83_57).
edge(node83_57, node83_58).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% na ctvrtem miste skoncilo druzstvo c. 10 ze sportovniho gymnazia a pate druzstvo c. 4 z gymnazia v opavske ulici v plzni. 
tree_root(node84_0).
:- %%%%%%%% node84_0 %%%%%%%%%%%%%%%%%%%
node(node84_0).
id(node84_0, t_plzensky51278_txt_001_p5s4).         const(t_plzensky51278_txt_001_p5s4).
%%%%%%%% node84_1 %%%%%%%%%%%%%%%%%%%
node(node84_1).
functor(node84_1, pred).         const(pred).
gram_sempos(node84_1, v).         const(v).
id(node84_1, t_plzensky51278_txt_001_p5s4a1).         const(t_plzensky51278_txt_001_p5s4a1).
t_lemma(node84_1, skoncit).         const(skoncit).
%%%%%%%% node84_2 %%%%%%%%%%%%%%%%%%%
node(node84_2).
functor(node84_2, loc).         const(loc).
gram_sempos(node84_2, n_denot).         const(n_denot).
id(node84_2, t_plzensky51278_txt_001_p5s4a3).         const(t_plzensky51278_txt_001_p5s4a3).
t_lemma(node84_2, misto).         const(misto).
%%%%%%%% node84_3 %%%%%%%%%%%%%%%%%%%
node(node84_3).
functor(node84_3, rstr).         const(rstr).
gram_sempos(node84_3, adj_quant_def).         const(adj_quant_def).
id(node84_3, t_plzensky51278_txt_001_p5s4a4).         const(t_plzensky51278_txt_001_p5s4a4).
t_lemma(node84_3, ctyri).         const(ctyri).
%%%%%%%% node84_4 %%%%%%%%%%%%%%%%%%%
node(node84_4).
a_afun(node84_4, atr).         const(atr).
m_form(node84_4, ctvrtem).         const(ctvrtem).
m_lemma(node84_4, ctvrty).         const(ctvrty).
m_tag(node84_4, crns6__________).         const(crns6__________).
m_tag0(node84_4,'c'). const('c'). m_tag1(node84_4,'r'). const('r'). m_tag2(node84_4,'n'). const('n'). m_tag3(node84_4,'s'). const('s'). m_tag4(node84_4,'6'). const('6'). 
%%%%%%%% node84_5 %%%%%%%%%%%%%%%%%%%
node(node84_5).
a_afun(node84_5, auxp).         const(auxp).
m_form(node84_5, na).         const(na).
m_lemma(node84_5, na_1).         const(na_1).
m_tag(node84_5, rr__6__________).         const(rr__6__________).
m_tag0(node84_5,'r'). const('r'). m_tag1(node84_5,'r'). const('r'). m_tag4(node84_5,'6'). const('6'). 
%%%%%%%% node84_6 %%%%%%%%%%%%%%%%%%%
node(node84_6).
a_afun(node84_6, adv).         const(adv).
m_form(node84_6, miste).         const(miste).
m_lemma(node84_6, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node84_6, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node84_6,'n'). const('n'). m_tag1(node84_6,'n'). const('n'). m_tag2(node84_6,'n'). const('n'). m_tag3(node84_6,'s'). const('s'). m_tag4(node84_6,'6'). const('6'). m_tag10(node84_6,'a'). const('a'). 
%%%%%%%% node84_7 %%%%%%%%%%%%%%%%%%%
node(node84_7).
a_afun(node84_7, pred).         const(pred).
m_form(node84_7, skoncilo).         const(skoncilo).
m_lemma(node84_7, skoncit__w).         const(skoncit__w).
m_tag(node84_7, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node84_7,'v'). const('v'). m_tag1(node84_7,'p'). const('p'). m_tag2(node84_7,'n'). const('n'). m_tag3(node84_7,'s'). const('s'). m_tag7(node84_7,'x'). const('x'). m_tag8(node84_7,'r'). const('r'). m_tag10(node84_7,'a'). const('a'). m_tag11(node84_7,'a'). const('a'). 
%%%%%%%% node84_8 %%%%%%%%%%%%%%%%%%%
node(node84_8).
functor(node84_8, conj).         const(conj).
id(node84_8, t_plzensky51278_txt_001_p5s4a5).         const(t_plzensky51278_txt_001_p5s4a5).
t_lemma(node84_8, a).         const(a).
%%%%%%%% node84_9 %%%%%%%%%%%%%%%%%%%
node(node84_9).
functor(node84_9, act).         const(act).
gram_sempos(node84_9, n_denot).         const(n_denot).
id(node84_9, t_plzensky51278_txt_001_p5s4a6).         const(t_plzensky51278_txt_001_p5s4a6).
t_lemma(node84_9, druzstvo).         const(druzstvo).
%%%%%%%% node84_10 %%%%%%%%%%%%%%%%%%%
node(node84_10).
a_afun(node84_10, sb).         const(sb).
m_form(node84_10, druzstvo).         const(druzstvo).
m_lemma(node84_10, druzstvo).         const(druzstvo).
m_tag(node84_10, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node84_10,'n'). const('n'). m_tag1(node84_10,'n'). const('n'). m_tag2(node84_10,'n'). const('n'). m_tag3(node84_10,'s'). const('s'). m_tag4(node84_10,'1'). const('1'). m_tag10(node84_10,'a'). const('a'). 
%%%%%%%% node84_11 %%%%%%%%%%%%%%%%%%%
node(node84_11).
functor(node84_11, act).         const(act).
gram_sempos(node84_11, n_denot).         const(n_denot).
id(node84_11, t_plzensky51278_txt_001_p5s4a7).         const(t_plzensky51278_txt_001_p5s4a7).
t_lemma(node84_11, cislo).         const(cislo).
%%%%%%%% node84_12 %%%%%%%%%%%%%%%%%%%
node(node84_12).
a_afun(node84_12, sb).         const(sb).
m_form(node84_12, c_).         const(c_).
m_lemma(node84_12, cislo__b).         const(cislo__b).
m_tag(node84_12, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node84_12,'n'). const('n'). m_tag1(node84_12,'n'). const('n'). m_tag2(node84_12,'n'). const('n'). m_tag3(node84_12,'x'). const('x'). m_tag4(node84_12,'x'). const('x'). m_tag10(node84_12,'a'). const('a'). m_tag14(node84_12,'8'). const('8'). 
%%%%%%%% node84_13 %%%%%%%%%%%%%%%%%%%
node(node84_13).
functor(node84_13, rstr).         const(rstr).
gram_sempos(node84_13, adj_quant_def).         const(adj_quant_def).
id(node84_13, t_plzensky51278_txt_001_p5s4a8).         const(t_plzensky51278_txt_001_p5s4a8).
t_lemma(node84_13, 10).         const(10).
%%%%%%%% node84_14 %%%%%%%%%%%%%%%%%%%
node(node84_14).
a_afun(node84_14, atr).         const(atr).
m_form(node84_14, 10).         const(10).
m_lemma(node84_14, 10).         const(10).
m_tag(node84_14, c=_____________).         const(c=_____________).
m_tag0(node84_14,'c'). const('c'). m_tag1(node84_14,'='). const('='). 
%%%%%%%% node84_15 %%%%%%%%%%%%%%%%%%%
node(node84_15).
functor(node84_15, dir1).         const(dir1).
gram_sempos(node84_15, n_denot).         const(n_denot).
id(node84_15, t_plzensky51278_txt_001_p5s4a10).         const(t_plzensky51278_txt_001_p5s4a10).
t_lemma(node84_15, gymnazium).         const(gymnazium).
%%%%%%%% node84_16 %%%%%%%%%%%%%%%%%%%
node(node84_16).
functor(node84_16, rstr).         const(rstr).
gram_sempos(node84_16, adj_denot).         const(adj_denot).
id(node84_16, t_plzensky51278_txt_001_p5s4a11).         const(t_plzensky51278_txt_001_p5s4a11).
t_lemma(node84_16, sportovni).         const(sportovni).
%%%%%%%% node84_17 %%%%%%%%%%%%%%%%%%%
node(node84_17).
a_afun(node84_17, atr).         const(atr).
m_form(node84_17, sportovniho).         const(sportovniho).
m_lemma(node84_17, sportovni).         const(sportovni).
m_tag(node84_17, aans2____1a____).         const(aans2____1a____).
m_tag0(node84_17,'a'). const('a'). m_tag1(node84_17,'a'). const('a'). m_tag2(node84_17,'n'). const('n'). m_tag3(node84_17,'s'). const('s'). m_tag4(node84_17,'2'). const('2'). m_tag9(node84_17,'1'). const('1'). m_tag10(node84_17,'a'). const('a'). 
%%%%%%%% node84_18 %%%%%%%%%%%%%%%%%%%
node(node84_18).
a_afun(node84_18, auxp).         const(auxp).
m_form(node84_18, ze).         const(ze).
m_lemma(node84_18, z_1).         const(z_1).
m_tag(node84_18, rv__2__________).         const(rv__2__________).
m_tag0(node84_18,'r'). const('r'). m_tag1(node84_18,'v'). const('v'). m_tag4(node84_18,'2'). const('2'). 
%%%%%%%% node84_19 %%%%%%%%%%%%%%%%%%%
node(node84_19).
a_afun(node84_19, atr).         const(atr).
m_form(node84_19, gymnazia).         const(gymnazia).
m_lemma(node84_19, gymnazium).         const(gymnazium).
m_tag(node84_19, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node84_19,'n'). const('n'). m_tag1(node84_19,'n'). const('n'). m_tag2(node84_19,'n'). const('n'). m_tag3(node84_19,'s'). const('s'). m_tag4(node84_19,'2'). const('2'). m_tag10(node84_19,'a'). const('a'). 
%%%%%%%% node84_20 %%%%%%%%%%%%%%%%%%%
node(node84_20).
a_afun(node84_20, coord).         const(coord).
m_form(node84_20, a).         const(a).
m_lemma(node84_20, a_1).         const(a_1).
m_tag(node84_20, j______________).         const(j______________).
m_tag0(node84_20,'j'). const('j'). m_tag1(node84_20,'^'). const('^'). 
%%%%%%%% node84_21 %%%%%%%%%%%%%%%%%%%
node(node84_21).
functor(node84_21, act).         const(act).
gram_sempos(node84_21, n_denot).         const(n_denot).
id(node84_21, t_plzensky51278_txt_001_p5s4a12).         const(t_plzensky51278_txt_001_p5s4a12).
t_lemma(node84_21, druzstvo).         const(druzstvo).
%%%%%%%% node84_22 %%%%%%%%%%%%%%%%%%%
node(node84_22).
functor(node84_22, rstr).         const(rstr).
gram_sempos(node84_22, adj_quant_def).         const(adj_quant_def).
id(node84_22, t_plzensky51278_txt_001_p5s4a13).         const(t_plzensky51278_txt_001_p5s4a13).
t_lemma(node84_22, pet).         const(pet).
%%%%%%%% node84_23 %%%%%%%%%%%%%%%%%%%
node(node84_23).
a_afun(node84_23, atr).         const(atr).
m_form(node84_23, pate).         const(pate).
m_lemma(node84_23, paty).         const(paty).
m_tag(node84_23, crns1__________).         const(crns1__________).
m_tag0(node84_23,'c'). const('c'). m_tag1(node84_23,'r'). const('r'). m_tag2(node84_23,'n'). const('n'). m_tag3(node84_23,'s'). const('s'). m_tag4(node84_23,'1'). const('1'). 
%%%%%%%% node84_24 %%%%%%%%%%%%%%%%%%%
node(node84_24).
a_afun(node84_24, sb).         const(sb).
m_form(node84_24, druzstvo).         const(druzstvo).
m_lemma(node84_24, druzstvo).         const(druzstvo).
m_tag(node84_24, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node84_24,'n'). const('n'). m_tag1(node84_24,'n'). const('n'). m_tag2(node84_24,'n'). const('n'). m_tag3(node84_24,'s'). const('s'). m_tag4(node84_24,'1'). const('1'). m_tag10(node84_24,'a'). const('a'). 
%%%%%%%% node84_25 %%%%%%%%%%%%%%%%%%%
node(node84_25).
functor(node84_25, app).         const(app).
gram_sempos(node84_25, n_denot).         const(n_denot).
id(node84_25, t_plzensky51278_txt_001_p5s4a14).         const(t_plzensky51278_txt_001_p5s4a14).
t_lemma(node84_25, cislo).         const(cislo).
%%%%%%%% node84_26 %%%%%%%%%%%%%%%%%%%
node(node84_26).
a_afun(node84_26, atr).         const(atr).
m_form(node84_26, c_).         const(c_).
m_lemma(node84_26, cislo__b).         const(cislo__b).
m_tag(node84_26, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node84_26,'n'). const('n'). m_tag1(node84_26,'n'). const('n'). m_tag2(node84_26,'n'). const('n'). m_tag3(node84_26,'x'). const('x'). m_tag4(node84_26,'x'). const('x'). m_tag10(node84_26,'a'). const('a'). m_tag14(node84_26,'8'). const('8'). 
%%%%%%%% node84_27 %%%%%%%%%%%%%%%%%%%
node(node84_27).
functor(node84_27, rstr).         const(rstr).
gram_sempos(node84_27, adj_quant_def).         const(adj_quant_def).
id(node84_27, t_plzensky51278_txt_001_p5s4a15).         const(t_plzensky51278_txt_001_p5s4a15).
t_lemma(node84_27, 4).         const(4).
%%%%%%%% node84_28 %%%%%%%%%%%%%%%%%%%
node(node84_28).
a_afun(node84_28, atr).         const(atr).
m_form(node84_28, 4).         const(4).
m_lemma(node84_28, 4).         const(4).
m_tag(node84_28, c=_____________).         const(c=_____________).
m_tag0(node84_28,'c'). const('c'). m_tag1(node84_28,'='). const('='). 
%%%%%%%% node84_29 %%%%%%%%%%%%%%%%%%%
node(node84_29).
functor(node84_29, dir1).         const(dir1).
gram_sempos(node84_29, n_denot).         const(n_denot).
id(node84_29, t_plzensky51278_txt_001_p5s4a17).         const(t_plzensky51278_txt_001_p5s4a17).
t_lemma(node84_29, gymnazium).         const(gymnazium).
%%%%%%%% node84_30 %%%%%%%%%%%%%%%%%%%
node(node84_30).
a_afun(node84_30, auxp).         const(auxp).
m_form(node84_30, z).         const(z).
m_lemma(node84_30, z_1).         const(z_1).
m_tag(node84_30, rr__2__________).         const(rr__2__________).
m_tag0(node84_30,'r'). const('r'). m_tag1(node84_30,'r'). const('r'). m_tag4(node84_30,'2'). const('2'). 
%%%%%%%% node84_31 %%%%%%%%%%%%%%%%%%%
node(node84_31).
a_afun(node84_31, adv).         const(adv).
m_form(node84_31, gymnazia).         const(gymnazia).
m_lemma(node84_31, gymnazium).         const(gymnazium).
m_tag(node84_31, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node84_31,'n'). const('n'). m_tag1(node84_31,'n'). const('n'). m_tag2(node84_31,'n'). const('n'). m_tag3(node84_31,'s'). const('s'). m_tag4(node84_31,'2'). const('2'). m_tag10(node84_31,'a'). const('a'). 
%%%%%%%% node84_32 %%%%%%%%%%%%%%%%%%%
node(node84_32).
functor(node84_32, loc).         const(loc).
gram_sempos(node84_32, n_denot).         const(n_denot).
id(node84_32, t_plzensky51278_txt_001_p5s4a19).         const(t_plzensky51278_txt_001_p5s4a19).
t_lemma(node84_32, ulice).         const(ulice).
%%%%%%%% node84_33 %%%%%%%%%%%%%%%%%%%
node(node84_33).
functor(node84_33, rstr).         const(rstr).
gram_sempos(node84_33, adj_denot).         const(adj_denot).
id(node84_33, t_plzensky51278_txt_001_p5s4a20).         const(t_plzensky51278_txt_001_p5s4a20).
t_lemma(node84_33, opavsky).         const(opavsky).
%%%%%%%% node84_34 %%%%%%%%%%%%%%%%%%%
node(node84_34).
a_afun(node84_34, atr).         const(atr).
m_form(node84_34, opavske).         const(opavske).
m_lemma(node84_34, opavsky).         const(opavsky).
m_tag(node84_34, aafs6____1a____).         const(aafs6____1a____).
m_tag0(node84_34,'a'). const('a'). m_tag1(node84_34,'a'). const('a'). m_tag2(node84_34,'f'). const('f'). m_tag3(node84_34,'s'). const('s'). m_tag4(node84_34,'6'). const('6'). m_tag9(node84_34,'1'). const('1'). m_tag10(node84_34,'a'). const('a'). 
%%%%%%%% node84_35 %%%%%%%%%%%%%%%%%%%
node(node84_35).
a_afun(node84_35, auxp).         const(auxp).
m_form(node84_35, v).         const(v).
m_lemma(node84_35, v_1).         const(v_1).
m_tag(node84_35, rr__6__________).         const(rr__6__________).
m_tag0(node84_35,'r'). const('r'). m_tag1(node84_35,'r'). const('r'). m_tag4(node84_35,'6'). const('6'). 
%%%%%%%% node84_36 %%%%%%%%%%%%%%%%%%%
node(node84_36).
a_afun(node84_36, adv).         const(adv).
m_form(node84_36, ulici).         const(ulici).
m_lemma(node84_36, ulice).         const(ulice).
m_tag(node84_36, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node84_36,'n'). const('n'). m_tag1(node84_36,'n'). const('n'). m_tag2(node84_36,'f'). const('f'). m_tag3(node84_36,'s'). const('s'). m_tag4(node84_36,'6'). const('6'). m_tag10(node84_36,'a'). const('a'). 
%%%%%%%% node84_37 %%%%%%%%%%%%%%%%%%%
node(node84_37).
functor(node84_37, loc).         const(loc).
gram_sempos(node84_37, n_denot).         const(n_denot).
id(node84_37, t_plzensky51278_txt_001_p5s4a22).         const(t_plzensky51278_txt_001_p5s4a22).
t_lemma(node84_37, plzen).         const(plzen).
%%%%%%%% node84_38 %%%%%%%%%%%%%%%%%%%
node(node84_38).
a_afun(node84_38, auxp).         const(auxp).
m_form(node84_38, v).         const(v).
m_lemma(node84_38, v_1).         const(v_1).
m_tag(node84_38, rr__6__________).         const(rr__6__________).
m_tag0(node84_38,'r'). const('r'). m_tag1(node84_38,'r'). const('r'). m_tag4(node84_38,'6'). const('6'). 
%%%%%%%% node84_39 %%%%%%%%%%%%%%%%%%%
node(node84_39).
a_afun(node84_39, atr).         const(atr).
m_form(node84_39, plzni).         const(plzni).
m_lemma(node84_39, plzen__g).         const(plzen__g).
m_tag(node84_39, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node84_39,'n'). const('n'). m_tag1(node84_39,'n'). const('n'). m_tag2(node84_39,'f'). const('f'). m_tag3(node84_39,'s'). const('s'). m_tag4(node84_39,'6'). const('6'). m_tag10(node84_39,'a'). const('a'). 
edge(node84_0, node84_1).
edge(node84_1, node84_2).
edge(node84_2, node84_3).
edge(node84_3, node84_4).
edge(node84_2, node84_5).
edge(node84_2, node84_6).
edge(node84_1, node84_7).
edge(node84_1, node84_8).
edge(node84_8, node84_9).
edge(node84_9, node84_10).
edge(node84_8, node84_11).
edge(node84_11, node84_12).
edge(node84_11, node84_13).
edge(node84_13, node84_14).
edge(node84_11, node84_15).
edge(node84_15, node84_16).
edge(node84_16, node84_17).
edge(node84_15, node84_18).
edge(node84_15, node84_19).
edge(node84_8, node84_20).
edge(node84_8, node84_21).
edge(node84_21, node84_22).
edge(node84_22, node84_23).
edge(node84_21, node84_24).
edge(node84_21, node84_25).
edge(node84_25, node84_26).
edge(node84_25, node84_27).
edge(node84_27, node84_28).
edge(node84_8, node84_29).
edge(node84_29, node84_30).
edge(node84_29, node84_31).
edge(node84_1, node84_32).
edge(node84_32, node84_33).
edge(node84_33, node84_34).
edge(node84_32, node84_35).
edge(node84_32, node84_36).
edge(node84_32, node84_37).
edge(node84_37, node84_38).
edge(node84_37, node84_39).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% souteze se zucastnilo 15 druzstev. 
tree_root(node85_0).
:- %%%%%%%% node85_0 %%%%%%%%%%%%%%%%%%%
node(node85_0).
id(node85_0, t_plzensky51278_txt_001_p5s5).         const(t_plzensky51278_txt_001_p5s5).
%%%%%%%% node85_1 %%%%%%%%%%%%%%%%%%%
node(node85_1).
functor(node85_1, pred).         const(pred).
gram_sempos(node85_1, v).         const(v).
id(node85_1, t_plzensky51278_txt_001_p5s5a1).         const(t_plzensky51278_txt_001_p5s5a1).
t_lemma(node85_1, zucastnit_se).         const(zucastnit_se).
%%%%%%%% node85_2 %%%%%%%%%%%%%%%%%%%
node(node85_2).
functor(node85_2, act).         const(act).
gram_sempos(node85_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node85_2, t_plzensky51278_txt_001_p5s5a6).         const(t_plzensky51278_txt_001_p5s5a6).
t_lemma(node85_2, x_perspron).         const(x_perspron).
%%%%%%%% node85_3 %%%%%%%%%%%%%%%%%%%
node(node85_3).
functor(node85_3, pat).         const(pat).
gram_sempos(node85_3, n_denot).         const(n_denot).
id(node85_3, t_plzensky51278_txt_001_p5s5a2).         const(t_plzensky51278_txt_001_p5s5a2).
t_lemma(node85_3, soutez).         const(soutez).
%%%%%%%% node85_4 %%%%%%%%%%%%%%%%%%%
node(node85_4).
a_afun(node85_4, obj).         const(obj).
m_form(node85_4, souteze).         const(souteze).
m_lemma(node85_4, soutez).         const(soutez).
m_tag(node85_4, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node85_4,'n'). const('n'). m_tag1(node85_4,'n'). const('n'). m_tag2(node85_4,'f'). const('f'). m_tag3(node85_4,'s'). const('s'). m_tag4(node85_4,'2'). const('2'). m_tag10(node85_4,'a'). const('a'). 
%%%%%%%% node85_5 %%%%%%%%%%%%%%%%%%%
node(node85_5).
a_afun(node85_5, auxt).         const(auxt).
m_form(node85_5, se).         const(se).
m_lemma(node85_5, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node85_5, p7_x4__________).         const(p7_x4__________).
m_tag0(node85_5,'p'). const('p'). m_tag1(node85_5,'7'). const('7'). m_tag3(node85_5,'x'). const('x'). m_tag4(node85_5,'4'). const('4'). 
%%%%%%%% node85_6 %%%%%%%%%%%%%%%%%%%
node(node85_6).
a_afun(node85_6, pred).         const(pred).
m_form(node85_6, zucastnilo).         const(zucastnilo).
m_lemma(node85_6, zucastnit__w).         const(zucastnit__w).
m_tag(node85_6, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node85_6,'v'). const('v'). m_tag1(node85_6,'p'). const('p'). m_tag2(node85_6,'n'). const('n'). m_tag3(node85_6,'s'). const('s'). m_tag7(node85_6,'x'). const('x'). m_tag8(node85_6,'r'). const('r'). m_tag10(node85_6,'a'). const('a'). m_tag11(node85_6,'a'). const('a'). 
%%%%%%%% node85_7 %%%%%%%%%%%%%%%%%%%
node(node85_7).
functor(node85_7, pat).         const(pat).
gram_sempos(node85_7, n_denot).         const(n_denot).
id(node85_7, t_plzensky51278_txt_001_p5s5a5).         const(t_plzensky51278_txt_001_p5s5a5).
t_lemma(node85_7, druzstvo).         const(druzstvo).
%%%%%%%% node85_8 %%%%%%%%%%%%%%%%%%%
node(node85_8).
functor(node85_8, rstr).         const(rstr).
gram_sempos(node85_8, adj_quant_def).         const(adj_quant_def).
id(node85_8, t_plzensky51278_txt_001_p5s5a4).         const(t_plzensky51278_txt_001_p5s5a4).
t_lemma(node85_8, 15).         const(15).
%%%%%%%% node85_9 %%%%%%%%%%%%%%%%%%%
node(node85_9).
a_afun(node85_9, obj).         const(obj).
m_form(node85_9, 15).         const(15).
m_lemma(node85_9, 15).         const(15).
m_tag(node85_9, c=_____________).         const(c=_____________).
m_tag0(node85_9,'c'). const('c'). m_tag1(node85_9,'='). const('='). 
%%%%%%%% node85_10 %%%%%%%%%%%%%%%%%%%
node(node85_10).
a_afun(node85_10, atr).         const(atr).
m_form(node85_10, druzstev).         const(druzstev).
m_lemma(node85_10, druzstvo).         const(druzstvo).
m_tag(node85_10, nnnp2_____a____).         const(nnnp2_____a____).
m_tag0(node85_10,'n'). const('n'). m_tag1(node85_10,'n'). const('n'). m_tag2(node85_10,'n'). const('n'). m_tag3(node85_10,'p'). const('p'). m_tag4(node85_10,'2'). const('2'). m_tag10(node85_10,'a'). const('a'). 
edge(node85_0, node85_1).
edge(node85_1, node85_2).
edge(node85_1, node85_3).
edge(node85_3, node85_4).
edge(node85_1, node85_5).
edge(node85_1, node85_6).
edge(node85_1, node85_7).
edge(node85_7, node85_8).
edge(node85_8, node85_9).
edge(node85_7, node85_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vyhodnoceni byli take nejlepsi jednotlivci s nejvyssim poctem dosazenych bodu ve znalostnim testu. 
tree_root(node86_0).
:- %%%%%%%% node86_0 %%%%%%%%%%%%%%%%%%%
node(node86_0).
id(node86_0, t_plzensky51278_txt_001_p5s6).         const(t_plzensky51278_txt_001_p5s6).
%%%%%%%% node86_1 %%%%%%%%%%%%%%%%%%%
node(node86_1).
functor(node86_1, pred).         const(pred).
gram_sempos(node86_1, v).         const(v).
id(node86_1, t_plzensky51278_txt_001_p5s6a2).         const(t_plzensky51278_txt_001_p5s6a2).
t_lemma(node86_1, vyhodnotit).         const(vyhodnotit).
%%%%%%%% node86_2 %%%%%%%%%%%%%%%%%%%
node(node86_2).
functor(node86_2, pat).         const(pat).
gram_sempos(node86_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node86_2, t_plzensky51278_txt_001_p5s6a14).         const(t_plzensky51278_txt_001_p5s6a14).
t_lemma(node86_2, x_perspron).         const(x_perspron).
%%%%%%%% node86_3 %%%%%%%%%%%%%%%%%%%
node(node86_3).
a_afun(node86_3, pnom).         const(pnom).
m_form(node86_3, vyhodnoceni).         const(vyhodnoceni).
m_lemma(node86_3, vyhodnotit__w).         const(vyhodnotit__w).
m_tag(node86_3, vsmp___xx_ap___).         const(vsmp___xx_ap___).
m_tag0(node86_3,'v'). const('v'). m_tag1(node86_3,'s'). const('s'). m_tag2(node86_3,'m'). const('m'). m_tag3(node86_3,'p'). const('p'). m_tag7(node86_3,'x'). const('x'). m_tag8(node86_3,'x'). const('x'). m_tag10(node86_3,'a'). const('a'). m_tag11(node86_3,'p'). const('p'). 
%%%%%%%% node86_4 %%%%%%%%%%%%%%%%%%%
node(node86_4).
a_afun(node86_4, pred).         const(pred).
m_form(node86_4, byli).         const(byli).
m_lemma(node86_4, byt).         const(byt).
m_tag(node86_4, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node86_4,'v'). const('v'). m_tag1(node86_4,'p'). const('p'). m_tag2(node86_4,'m'). const('m'). m_tag3(node86_4,'p'). const('p'). m_tag7(node86_4,'x'). const('x'). m_tag8(node86_4,'r'). const('r'). m_tag10(node86_4,'a'). const('a'). m_tag11(node86_4,'a'). const('a'). 
%%%%%%%% node86_5 %%%%%%%%%%%%%%%%%%%
node(node86_5).
functor(node86_5, rhem).         const(rhem).
id(node86_5, t_plzensky51278_txt_001_p5s6a3).         const(t_plzensky51278_txt_001_p5s6a3).
t_lemma(node86_5, take).         const(take).
%%%%%%%% node86_6 %%%%%%%%%%%%%%%%%%%
node(node86_6).
a_afun(node86_6, adv).         const(adv).
m_form(node86_6, take).         const(take).
m_lemma(node86_6, take___rovnez_).         const(take___rovnez_).
m_tag(node86_6, db_____________).         const(db_____________).
m_tag0(node86_6,'d'). const('d'). m_tag1(node86_6,'b'). const('b'). 
%%%%%%%% node86_7 %%%%%%%%%%%%%%%%%%%
node(node86_7).
functor(node86_7, act).         const(act).
gram_sempos(node86_7, n_denot).         const(n_denot).
id(node86_7, t_plzensky51278_txt_001_p5s6a4).         const(t_plzensky51278_txt_001_p5s6a4).
t_lemma(node86_7, jednotlivec).         const(jednotlivec).
%%%%%%%% node86_8 %%%%%%%%%%%%%%%%%%%
node(node86_8).
functor(node86_8, rstr).         const(rstr).
gram_sempos(node86_8, adj_denot).         const(adj_denot).
id(node86_8, t_plzensky51278_txt_001_p5s6a5).         const(t_plzensky51278_txt_001_p5s6a5).
t_lemma(node86_8, dobry).         const(dobry).
%%%%%%%% node86_9 %%%%%%%%%%%%%%%%%%%
node(node86_9).
a_afun(node86_9, atr).         const(atr).
m_form(node86_9, nejlepsi).         const(nejlepsi).
m_lemma(node86_9, dobry).         const(dobry).
m_tag(node86_9, aamp1____3a____).         const(aamp1____3a____).
m_tag0(node86_9,'a'). const('a'). m_tag1(node86_9,'a'). const('a'). m_tag2(node86_9,'m'). const('m'). m_tag3(node86_9,'p'). const('p'). m_tag4(node86_9,'1'). const('1'). m_tag9(node86_9,'3'). const('3'). m_tag10(node86_9,'a'). const('a'). 
%%%%%%%% node86_10 %%%%%%%%%%%%%%%%%%%
node(node86_10).
a_afun(node86_10, sb).         const(sb).
m_form(node86_10, jednotlivci).         const(jednotlivci).
m_lemma(node86_10, jednotlivec).         const(jednotlivec).
m_tag(node86_10, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node86_10,'n'). const('n'). m_tag1(node86_10,'n'). const('n'). m_tag2(node86_10,'m'). const('m'). m_tag3(node86_10,'p'). const('p'). m_tag4(node86_10,'1'). const('1'). m_tag10(node86_10,'a'). const('a'). 
%%%%%%%% node86_11 %%%%%%%%%%%%%%%%%%%
node(node86_11).
functor(node86_11, acmp).         const(acmp).
gram_sempos(node86_11, n_denot).         const(n_denot).
id(node86_11, t_plzensky51278_txt_001_p5s6a7).         const(t_plzensky51278_txt_001_p5s6a7).
t_lemma(node86_11, pocet).         const(pocet).
%%%%%%%% node86_12 %%%%%%%%%%%%%%%%%%%
node(node86_12).
functor(node86_12, rstr).         const(rstr).
gram_sempos(node86_12, adj_denot).         const(adj_denot).
id(node86_12, t_plzensky51278_txt_001_p5s6a8).         const(t_plzensky51278_txt_001_p5s6a8).
t_lemma(node86_12, vysoky).         const(vysoky).
%%%%%%%% node86_13 %%%%%%%%%%%%%%%%%%%
node(node86_13).
a_afun(node86_13, atr).         const(atr).
m_form(node86_13, nejvyssim).         const(nejvyssim).
m_lemma(node86_13, vysoky).         const(vysoky).
m_tag(node86_13, aais7____3a____).         const(aais7____3a____).
m_tag0(node86_13,'a'). const('a'). m_tag1(node86_13,'a'). const('a'). m_tag2(node86_13,'i'). const('i'). m_tag3(node86_13,'s'). const('s'). m_tag4(node86_13,'7'). const('7'). m_tag9(node86_13,'3'). const('3'). m_tag10(node86_13,'a'). const('a'). 
%%%%%%%% node86_14 %%%%%%%%%%%%%%%%%%%
node(node86_14).
a_afun(node86_14, auxp).         const(auxp).
m_form(node86_14, s).         const(s).
m_lemma(node86_14, s_1).         const(s_1).
m_tag(node86_14, rr__7__________).         const(rr__7__________).
m_tag0(node86_14,'r'). const('r'). m_tag1(node86_14,'r'). const('r'). m_tag4(node86_14,'7'). const('7'). 
%%%%%%%% node86_15 %%%%%%%%%%%%%%%%%%%
node(node86_15).
a_afun(node86_15, atr).         const(atr).
m_form(node86_15, poctem).         const(poctem).
m_lemma(node86_15, pocet).         const(pocet).
m_tag(node86_15, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node86_15,'n'). const('n'). m_tag1(node86_15,'n'). const('n'). m_tag2(node86_15,'i'). const('i'). m_tag3(node86_15,'s'). const('s'). m_tag4(node86_15,'7'). const('7'). m_tag10(node86_15,'a'). const('a'). 
%%%%%%%% node86_16 %%%%%%%%%%%%%%%%%%%
node(node86_16).
functor(node86_16, mat).         const(mat).
gram_sempos(node86_16, n_denot).         const(n_denot).
id(node86_16, t_plzensky51278_txt_001_p5s6a9).         const(t_plzensky51278_txt_001_p5s6a9).
t_lemma(node86_16, bod).         const(bod).
%%%%%%%% node86_17 %%%%%%%%%%%%%%%%%%%
node(node86_17).
functor(node86_17, rstr).         const(rstr).
gram_sempos(node86_17, adj_denot).         const(adj_denot).
id(node86_17, t_plzensky51278_txt_001_p5s6a10).         const(t_plzensky51278_txt_001_p5s6a10).
t_lemma(node86_17, dosazeny).         const(dosazeny).
%%%%%%%% node86_18 %%%%%%%%%%%%%%%%%%%
node(node86_18).
a_afun(node86_18, atr).         const(atr).
m_form(node86_18, dosazenych).         const(dosazenych).
m_lemma(node86_18, dosazeny____5ahnout_).         const(dosazeny____5ahnout_).
m_tag(node86_18, aaip2____1a____).         const(aaip2____1a____).
m_tag0(node86_18,'a'). const('a'). m_tag1(node86_18,'a'). const('a'). m_tag2(node86_18,'i'). const('i'). m_tag3(node86_18,'p'). const('p'). m_tag4(node86_18,'2'). const('2'). m_tag9(node86_18,'1'). const('1'). m_tag10(node86_18,'a'). const('a'). 
%%%%%%%% node86_19 %%%%%%%%%%%%%%%%%%%
node(node86_19).
a_afun(node86_19, atr).         const(atr).
m_form(node86_19, bodu).         const(bodu).
m_lemma(node86_19, bod).         const(bod).
m_tag(node86_19, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node86_19,'n'). const('n'). m_tag1(node86_19,'n'). const('n'). m_tag2(node86_19,'i'). const('i'). m_tag3(node86_19,'p'). const('p'). m_tag4(node86_19,'2'). const('2'). m_tag10(node86_19,'a'). const('a'). 
%%%%%%%% node86_20 %%%%%%%%%%%%%%%%%%%
node(node86_20).
functor(node86_20, loc).         const(loc).
gram_sempos(node86_20, n_denot).         const(n_denot).
id(node86_20, t_plzensky51278_txt_001_p5s6a12).         const(t_plzensky51278_txt_001_p5s6a12).
t_lemma(node86_20, test).         const(test).
%%%%%%%% node86_21 %%%%%%%%%%%%%%%%%%%
node(node86_21).
functor(node86_21, rstr).         const(rstr).
gram_sempos(node86_21, adj_denot).         const(adj_denot).
id(node86_21, t_plzensky51278_txt_001_p5s6a13).         const(t_plzensky51278_txt_001_p5s6a13).
t_lemma(node86_21, znalostni).         const(znalostni).
%%%%%%%% node86_22 %%%%%%%%%%%%%%%%%%%
node(node86_22).
a_afun(node86_22, atr).         const(atr).
m_form(node86_22, znalostnim).         const(znalostnim).
m_lemma(node86_22, znalostni).         const(znalostni).
m_tag(node86_22, aais6____1a____).         const(aais6____1a____).
m_tag0(node86_22,'a'). const('a'). m_tag1(node86_22,'a'). const('a'). m_tag2(node86_22,'i'). const('i'). m_tag3(node86_22,'s'). const('s'). m_tag4(node86_22,'6'). const('6'). m_tag9(node86_22,'1'). const('1'). m_tag10(node86_22,'a'). const('a'). 
%%%%%%%% node86_23 %%%%%%%%%%%%%%%%%%%
node(node86_23).
a_afun(node86_23, auxp).         const(auxp).
m_form(node86_23, ve).         const(ve).
m_lemma(node86_23, v_1).         const(v_1).
m_tag(node86_23, rv__6__________).         const(rv__6__________).
m_tag0(node86_23,'r'). const('r'). m_tag1(node86_23,'v'). const('v'). m_tag4(node86_23,'6'). const('6'). 
%%%%%%%% node86_24 %%%%%%%%%%%%%%%%%%%
node(node86_24).
a_afun(node86_24, adv).         const(adv).
m_form(node86_24, testu).         const(testu).
m_lemma(node86_24, test).         const(test).
m_tag(node86_24, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node86_24,'n'). const('n'). m_tag1(node86_24,'n'). const('n'). m_tag2(node86_24,'i'). const('i'). m_tag3(node86_24,'s'). const('s'). m_tag4(node86_24,'6'). const('6'). m_tag10(node86_24,'a'). const('a'). 
edge(node86_0, node86_1).
edge(node86_1, node86_2).
edge(node86_1, node86_3).
edge(node86_1, node86_4).
edge(node86_1, node86_5).
edge(node86_5, node86_6).
edge(node86_1, node86_7).
edge(node86_7, node86_8).
edge(node86_8, node86_9).
edge(node86_7, node86_10).
edge(node86_7, node86_11).
edge(node86_11, node86_12).
edge(node86_12, node86_13).
edge(node86_11, node86_14).
edge(node86_11, node86_15).
edge(node86_11, node86_16).
edge(node86_16, node86_17).
edge(node86_17, node86_18).
edge(node86_16, node86_19).
edge(node86_1, node86_20).
edge(node86_20, node86_21).
edge(node86_21, node86_22).
edge(node86_20, node86_23).
edge(node86_20, node86_24).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% z ucastniku z prvniho stupne zakladnich skol dosahla jako jedina nejvyssiho poctu bodu, deset, diana rehackova z druzstva c. 11 z 11. 
tree_root(node87_0).
:- %%%%%%%% node87_0 %%%%%%%%%%%%%%%%%%%
node(node87_0).
id(node87_0, t_plzensky51278_txt_001_p5s7).         const(t_plzensky51278_txt_001_p5s7).
%%%%%%%% node87_1 %%%%%%%%%%%%%%%%%%%
node(node87_1).
functor(node87_1, pred).         const(pred).
gram_sempos(node87_1, v).         const(v).
id(node87_1, t_plzensky51278_txt_001_p5s7a1).         const(t_plzensky51278_txt_001_p5s7a1).
t_lemma(node87_1, dosahnout).         const(dosahnout).
%%%%%%%% node87_2 %%%%%%%%%%%%%%%%%%%
node(node87_2).
functor(node87_2, pat).         const(pat).
id(node87_2, t_plzensky51278_txt_001_p5s7a26).         const(t_plzensky51278_txt_001_p5s7a26).
t_lemma(node87_2, x_gen).         const(x_gen).
%%%%%%%% node87_3 %%%%%%%%%%%%%%%%%%%
node(node87_3).
functor(node87_3, act).         const(act).
gram_sempos(node87_3, n_pron_def_pers).         const(n_pron_def_pers).
id(node87_3, t_plzensky51278_txt_001_p5s7a25).         const(t_plzensky51278_txt_001_p5s7a25).
t_lemma(node87_3, x_perspron).         const(x_perspron).
%%%%%%%% node87_4 %%%%%%%%%%%%%%%%%%%
node(node87_4).
functor(node87_4, dir1).         const(dir1).
gram_sempos(node87_4, n_denot).         const(n_denot).
id(node87_4, t_plzensky51278_txt_001_p5s7a3).         const(t_plzensky51278_txt_001_p5s7a3).
t_lemma(node87_4, ucastnik).         const(ucastnik).
%%%%%%%% node87_5 %%%%%%%%%%%%%%%%%%%
node(node87_5).
a_afun(node87_5, auxp).         const(auxp).
m_form(node87_5, z).         const(z).
m_lemma(node87_5, z_1).         const(z_1).
m_tag(node87_5, rr__2__________).         const(rr__2__________).
m_tag0(node87_5,'r'). const('r'). m_tag1(node87_5,'r'). const('r'). m_tag4(node87_5,'2'). const('2'). 
%%%%%%%% node87_6 %%%%%%%%%%%%%%%%%%%
node(node87_6).
a_afun(node87_6, adv).         const(adv).
m_form(node87_6, ucastniku).         const(ucastniku).
m_lemma(node87_6, ucastnik).         const(ucastnik).
m_tag(node87_6, nnmp2_____a____).         const(nnmp2_____a____).
m_tag0(node87_6,'n'). const('n'). m_tag1(node87_6,'n'). const('n'). m_tag2(node87_6,'m'). const('m'). m_tag3(node87_6,'p'). const('p'). m_tag4(node87_6,'2'). const('2'). m_tag10(node87_6,'a'). const('a'). 
%%%%%%%% node87_7 %%%%%%%%%%%%%%%%%%%
node(node87_7).
functor(node87_7, dir1).         const(dir1).
gram_sempos(node87_7, n_denot).         const(n_denot).
id(node87_7, t_plzensky51278_txt_001_p5s7a5).         const(t_plzensky51278_txt_001_p5s7a5).
t_lemma(node87_7, stupen).         const(stupen).
%%%%%%%% node87_8 %%%%%%%%%%%%%%%%%%%
node(node87_8).
functor(node87_8, rstr).         const(rstr).
gram_sempos(node87_8, adj_quant_def).         const(adj_quant_def).
id(node87_8, t_plzensky51278_txt_001_p5s7a6).         const(t_plzensky51278_txt_001_p5s7a6).
t_lemma(node87_8, jeden).         const(jeden).
%%%%%%%% node87_9 %%%%%%%%%%%%%%%%%%%
node(node87_9).
a_afun(node87_9, atr).         const(atr).
m_form(node87_9, prvniho).         const(prvniho).
m_lemma(node87_9, prvni).         const(prvni).
m_tag(node87_9, cris2__________).         const(cris2__________).
m_tag0(node87_9,'c'). const('c'). m_tag1(node87_9,'r'). const('r'). m_tag2(node87_9,'i'). const('i'). m_tag3(node87_9,'s'). const('s'). m_tag4(node87_9,'2'). const('2'). 
%%%%%%%% node87_10 %%%%%%%%%%%%%%%%%%%
node(node87_10).
a_afun(node87_10, auxp).         const(auxp).
m_form(node87_10, z).         const(z).
m_lemma(node87_10, z_1).         const(z_1).
m_tag(node87_10, rr__2__________).         const(rr__2__________).
m_tag0(node87_10,'r'). const('r'). m_tag1(node87_10,'r'). const('r'). m_tag4(node87_10,'2'). const('2'). 
%%%%%%%% node87_11 %%%%%%%%%%%%%%%%%%%
node(node87_11).
a_afun(node87_11, atr).         const(atr).
m_form(node87_11, stupne).         const(stupne).
m_lemma(node87_11, stupen).         const(stupen).
m_tag(node87_11, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node87_11,'n'). const('n'). m_tag1(node87_11,'n'). const('n'). m_tag2(node87_11,'i'). const('i'). m_tag3(node87_11,'s'). const('s'). m_tag4(node87_11,'2'). const('2'). m_tag10(node87_11,'a'). const('a'). 
%%%%%%%% node87_12 %%%%%%%%%%%%%%%%%%%
node(node87_12).
functor(node87_12, app).         const(app).
gram_sempos(node87_12, n_denot).         const(n_denot).
id(node87_12, t_plzensky51278_txt_001_p5s7a7).         const(t_plzensky51278_txt_001_p5s7a7).
t_lemma(node87_12, skola).         const(skola).
%%%%%%%% node87_13 %%%%%%%%%%%%%%%%%%%
node(node87_13).
functor(node87_13, rstr).         const(rstr).
gram_sempos(node87_13, adj_denot).         const(adj_denot).
id(node87_13, t_plzensky51278_txt_001_p5s7a8).         const(t_plzensky51278_txt_001_p5s7a8).
t_lemma(node87_13, zakladni).         const(zakladni).
%%%%%%%% node87_14 %%%%%%%%%%%%%%%%%%%
node(node87_14).
a_afun(node87_14, atr).         const(atr).
m_form(node87_14, zakladnich).         const(zakladnich).
m_lemma(node87_14, zakladni).         const(zakladni).
m_tag(node87_14, aafp2____1a____).         const(aafp2____1a____).
m_tag0(node87_14,'a'). const('a'). m_tag1(node87_14,'a'). const('a'). m_tag2(node87_14,'f'). const('f'). m_tag3(node87_14,'p'). const('p'). m_tag4(node87_14,'2'). const('2'). m_tag9(node87_14,'1'). const('1'). m_tag10(node87_14,'a'). const('a'). 
%%%%%%%% node87_15 %%%%%%%%%%%%%%%%%%%
node(node87_15).
a_afun(node87_15, atr).         const(atr).
m_form(node87_15, skol).         const(skol).
m_lemma(node87_15, skola).         const(skola).
m_tag(node87_15, nnfp2_____a____).         const(nnfp2_____a____).
m_tag0(node87_15,'n'). const('n'). m_tag1(node87_15,'n'). const('n'). m_tag2(node87_15,'f'). const('f'). m_tag3(node87_15,'p'). const('p'). m_tag4(node87_15,'2'). const('2'). m_tag10(node87_15,'a'). const('a'). 
%%%%%%%% node87_16 %%%%%%%%%%%%%%%%%%%
node(node87_16).
a_afun(node87_16, pred).         const(pred).
m_form(node87_16, dosahla).         const(dosahla).
m_lemma(node87_16, dosahnout).         const(dosahnout).
m_tag(node87_16, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node87_16,'v'). const('v'). m_tag1(node87_16,'p'). const('p'). m_tag2(node87_16,'q'). const('q'). m_tag3(node87_16,'w'). const('w'). m_tag7(node87_16,'x'). const('x'). m_tag8(node87_16,'r'). const('r'). m_tag10(node87_16,'a'). const('a'). m_tag11(node87_16,'a'). const('a'). 
%%%%%%%% node87_17 %%%%%%%%%%%%%%%%%%%
node(node87_17).
functor(node87_17, rstr).         const(rstr).
id(node87_17, t_plzensky51278_txt_001_p5s7a9).         const(t_plzensky51278_txt_001_p5s7a9).
t_lemma(node87_17, x_comma).         const(x_comma).
%%%%%%%% node87_18 %%%%%%%%%%%%%%%%%%%
node(node87_18).
functor(node87_18, mat).         const(mat).
gram_sempos(node87_18, n_denot).         const(n_denot).
id(node87_18, t_plzensky51278_txt_001_p5s7a14).         const(t_plzensky51278_txt_001_p5s7a14).
t_lemma(node87_18, bod).         const(bod).
%%%%%%%% node87_19 %%%%%%%%%%%%%%%%%%%
node(node87_19).
functor(node87_19, pat).         const(pat).
gram_sempos(node87_19, n_denot).         const(n_denot).
id(node87_19, t_plzensky51278_txt_001_p5s7a12).         const(t_plzensky51278_txt_001_p5s7a12).
t_lemma(node87_19, pocet).         const(pocet).
%%%%%%%% node87_20 %%%%%%%%%%%%%%%%%%%
node(node87_20).
functor(node87_20, rstr).         const(rstr).
gram_sempos(node87_20, adj_denot).         const(adj_denot).
id(node87_20, t_plzensky51278_txt_001_p5s7a10).         const(t_plzensky51278_txt_001_p5s7a10).
t_lemma(node87_20, jediny).         const(jediny).
%%%%%%%% node87_21 %%%%%%%%%%%%%%%%%%%
node(node87_21).
a_afun(node87_21, auxy).         const(auxy).
m_form(node87_21, jako).         const(jako).
m_lemma(node87_21, jako).         const(jako).
m_tag(node87_21, j______________).         const(j______________).
m_tag0(node87_21,'j'). const('j'). m_tag1(node87_21,','). const(','). 
%%%%%%%% node87_22 %%%%%%%%%%%%%%%%%%%
node(node87_22).
a_afun(node87_22, sb).         const(sb).
m_form(node87_22, jedina).         const(jedina).
m_lemma(node87_22, jediny).         const(jediny).
m_tag(node87_22, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node87_22,'a'). const('a'). m_tag1(node87_22,'a'). const('a'). m_tag2(node87_22,'f'). const('f'). m_tag3(node87_22,'s'). const('s'). m_tag4(node87_22,'1'). const('1'). m_tag9(node87_22,'1'). const('1'). m_tag10(node87_22,'a'). const('a'). 
%%%%%%%% node87_23 %%%%%%%%%%%%%%%%%%%
node(node87_23).
functor(node87_23, rstr).         const(rstr).
gram_sempos(node87_23, adj_denot).         const(adj_denot).
id(node87_23, t_plzensky51278_txt_001_p5s7a13).         const(t_plzensky51278_txt_001_p5s7a13).
t_lemma(node87_23, vysoky).         const(vysoky).
%%%%%%%% node87_24 %%%%%%%%%%%%%%%%%%%
node(node87_24).
a_afun(node87_24, atr).         const(atr).
m_form(node87_24, nejvyssiho).         const(nejvyssiho).
m_lemma(node87_24, vysoky).         const(vysoky).
m_tag(node87_24, aais2____3a____).         const(aais2____3a____).
m_tag0(node87_24,'a'). const('a'). m_tag1(node87_24,'a'). const('a'). m_tag2(node87_24,'i'). const('i'). m_tag3(node87_24,'s'). const('s'). m_tag4(node87_24,'2'). const('2'). m_tag9(node87_24,'3'). const('3'). m_tag10(node87_24,'a'). const('a'). 
%%%%%%%% node87_25 %%%%%%%%%%%%%%%%%%%
node(node87_25).
a_afun(node87_25, obj).         const(obj).
m_form(node87_25, poctu).         const(poctu).
m_lemma(node87_25, pocet).         const(pocet).
m_tag(node87_25, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node87_25,'n'). const('n'). m_tag1(node87_25,'n'). const('n'). m_tag2(node87_25,'i'). const('i'). m_tag3(node87_25,'s'). const('s'). m_tag4(node87_25,'2'). const('2'). m_tag10(node87_25,'a'). const('a'). 
%%%%%%%% node87_26 %%%%%%%%%%%%%%%%%%%
node(node87_26).
a_afun(node87_26, atr).         const(atr).
m_form(node87_26, bodu).         const(bodu).
m_lemma(node87_26, bod).         const(bod).
m_tag(node87_26, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node87_26,'n'). const('n'). m_tag1(node87_26,'n'). const('n'). m_tag2(node87_26,'i'). const('i'). m_tag3(node87_26,'p'). const('p'). m_tag4(node87_26,'2'). const('2'). m_tag10(node87_26,'a'). const('a'). 
%%%%%%%% node87_27 %%%%%%%%%%%%%%%%%%%
node(node87_27).
a_afun(node87_27, auxx).         const(auxx).
m_form(node87_27, x_).         const(x_).
m_lemma(node87_27, x_).         const(x_).
m_tag(node87_27, z______________).         const(z______________).
m_tag0(node87_27,'z'). const('z'). m_tag1(node87_27,':'). const(':'). 
%%%%%%%% node87_28 %%%%%%%%%%%%%%%%%%%
node(node87_28).
functor(node87_28, rstr).         const(rstr).
gram_sempos(node87_28, adj_quant_def).         const(adj_quant_def).
id(node87_28, t_plzensky51278_txt_001_p5s7a15).         const(t_plzensky51278_txt_001_p5s7a15).
t_lemma(node87_28, deset).         const(deset).
%%%%%%%% node87_29 %%%%%%%%%%%%%%%%%%%
node(node87_29).
a_afun(node87_29, sb).         const(sb).
m_form(node87_29, deset).         const(deset).
m_lemma(node87_29, deset_10).         const(deset_10).
m_tag(node87_29, cn_s1__________).         const(cn_s1__________).
m_tag0(node87_29,'c'). const('c'). m_tag1(node87_29,'n'). const('n'). m_tag3(node87_29,'s'). const('s'). m_tag4(node87_29,'1'). const('1'). 
%%%%%%%% node87_30 %%%%%%%%%%%%%%%%%%%
node(node87_30).
functor(node87_30, rstr).         const(rstr).
gram_sempos(node87_30, n_denot).         const(n_denot).
id(node87_30, t_plzensky51278_txt_001_p5s7a17).         const(t_plzensky51278_txt_001_p5s7a17).
t_lemma(node87_30, rehackova).         const(rehackova).
%%%%%%%% node87_31 %%%%%%%%%%%%%%%%%%%
node(node87_31).
functor(node87_31, rstr).         const(rstr).
gram_sempos(node87_31, n_denot).         const(n_denot).
id(node87_31, t_plzensky51278_txt_001_p5s7a18).         const(t_plzensky51278_txt_001_p5s7a18).
t_lemma(node87_31, diana).         const(diana).
%%%%%%%% node87_32 %%%%%%%%%%%%%%%%%%%
node(node87_32).
a_afun(node87_32, atr).         const(atr).
m_form(node87_32, diana).         const(diana).
m_lemma(node87_32, diana__y).         const(diana__y).
m_tag(node87_32, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node87_32,'n'). const('n'). m_tag1(node87_32,'n'). const('n'). m_tag2(node87_32,'f'). const('f'). m_tag3(node87_32,'s'). const('s'). m_tag4(node87_32,'1'). const('1'). m_tag10(node87_32,'a'). const('a'). 
%%%%%%%% node87_33 %%%%%%%%%%%%%%%%%%%
node(node87_33).
a_afun(node87_33, sb).         const(sb).
m_form(node87_33, rehackova).         const(rehackova).
m_lemma(node87_33, rehackova__s).         const(rehackova__s).
m_tag(node87_33, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node87_33,'n'). const('n'). m_tag1(node87_33,'n'). const('n'). m_tag2(node87_33,'f'). const('f'). m_tag3(node87_33,'s'). const('s'). m_tag4(node87_33,'1'). const('1'). m_tag10(node87_33,'a'). const('a'). 
%%%%%%%% node87_34 %%%%%%%%%%%%%%%%%%%
node(node87_34).
functor(node87_34, dir1).         const(dir1).
gram_sempos(node87_34, n_denot).         const(n_denot).
id(node87_34, t_plzensky51278_txt_001_p5s7a20).         const(t_plzensky51278_txt_001_p5s7a20).
t_lemma(node87_34, druzstvo).         const(druzstvo).
%%%%%%%% node87_35 %%%%%%%%%%%%%%%%%%%
node(node87_35).
a_afun(node87_35, auxp).         const(auxp).
m_form(node87_35, z).         const(z).
m_lemma(node87_35, z_1).         const(z_1).
m_tag(node87_35, rr__2__________).         const(rr__2__________).
m_tag0(node87_35,'r'). const('r'). m_tag1(node87_35,'r'). const('r'). m_tag4(node87_35,'2'). const('2'). 
%%%%%%%% node87_36 %%%%%%%%%%%%%%%%%%%
node(node87_36).
a_afun(node87_36, atr).         const(atr).
m_form(node87_36, druzstva).         const(druzstva).
m_lemma(node87_36, druzstvo).         const(druzstvo).
m_tag(node87_36, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node87_36,'n'). const('n'). m_tag1(node87_36,'n'). const('n'). m_tag2(node87_36,'n'). const('n'). m_tag3(node87_36,'s'). const('s'). m_tag4(node87_36,'2'). const('2'). m_tag10(node87_36,'a'). const('a'). 
%%%%%%%% node87_37 %%%%%%%%%%%%%%%%%%%
node(node87_37).
functor(node87_37, rstr).         const(rstr).
gram_sempos(node87_37, n_denot).         const(n_denot).
id(node87_37, t_plzensky51278_txt_001_p5s7a21).         const(t_plzensky51278_txt_001_p5s7a21).
t_lemma(node87_37, cislo).         const(cislo).
%%%%%%%% node87_38 %%%%%%%%%%%%%%%%%%%
node(node87_38).
a_afun(node87_38, atr).         const(atr).
m_form(node87_38, c_).         const(c_).
m_lemma(node87_38, cislo__b).         const(cislo__b).
m_tag(node87_38, nnnxx_____a___8).         const(nnnxx_____a___8).
m_tag0(node87_38,'n'). const('n'). m_tag1(node87_38,'n'). const('n'). m_tag2(node87_38,'n'). const('n'). m_tag3(node87_38,'x'). const('x'). m_tag4(node87_38,'x'). const('x'). m_tag10(node87_38,'a'). const('a'). m_tag14(node87_38,'8'). const('8'). 
%%%%%%%% node87_39 %%%%%%%%%%%%%%%%%%%
node(node87_39).
functor(node87_39, rstr).         const(rstr).
gram_sempos(node87_39, adj_quant_def).         const(adj_quant_def).
id(node87_39, t_plzensky51278_txt_001_p5s7a22).         const(t_plzensky51278_txt_001_p5s7a22).
t_lemma(node87_39, 11).         const(11).
%%%%%%%% node87_40 %%%%%%%%%%%%%%%%%%%
node(node87_40).
a_afun(node87_40, atr).         const(atr).
m_form(node87_40, 11).         const(11).
m_lemma(node87_40, 11).         const(11).
m_tag(node87_40, c=_____________).         const(c=_____________).
m_tag0(node87_40,'c'). const('c'). m_tag1(node87_40,'='). const('='). 
%%%%%%%% node87_41 %%%%%%%%%%%%%%%%%%%
node(node87_41).
functor(node87_41, rstr).         const(rstr).
id(node87_41, t_plzensky51278_txt_001_p5s7a23).         const(t_plzensky51278_txt_001_p5s7a23).
t_lemma(node87_41, z).         const(z).
%%%%%%%% node87_42 %%%%%%%%%%%%%%%%%%%
node(node87_42).
a_afun(node87_42, auxp).         const(auxp).
m_form(node87_42, z).         const(z).
m_lemma(node87_42, z_1).         const(z_1).
m_tag(node87_42, rr__2__________).         const(rr__2__________).
m_tag0(node87_42,'r'). const('r'). m_tag1(node87_42,'r'). const('r'). m_tag4(node87_42,'2'). const('2'). 
%%%%%%%% node87_43 %%%%%%%%%%%%%%%%%%%
node(node87_43).
functor(node87_43, rstr).         const(rstr).
gram_sempos(node87_43, adj_quant_def).         const(adj_quant_def).
id(node87_43, t_plzensky51278_txt_001_p5s7a24).         const(t_plzensky51278_txt_001_p5s7a24).
t_lemma(node87_43, 11).         const(11).
%%%%%%%% node87_44 %%%%%%%%%%%%%%%%%%%
node(node87_44).
a_afun(node87_44, adv).         const(adv).
m_form(node87_44, 11).         const(11).
m_lemma(node87_44, 11).         const(11).
m_tag(node87_44, c=_____________).         const(c=_____________).
m_tag0(node87_44,'c'). const('c'). m_tag1(node87_44,'='). const('='). 
edge(node87_0, node87_1).
edge(node87_1, node87_2).
edge(node87_1, node87_3).
edge(node87_1, node87_4).
edge(node87_4, node87_5).
edge(node87_4, node87_6).
edge(node87_4, node87_7).
edge(node87_7, node87_8).
edge(node87_8, node87_9).
edge(node87_7, node87_10).
edge(node87_7, node87_11).
edge(node87_7, node87_12).
edge(node87_12, node87_13).
edge(node87_13, node87_14).
edge(node87_12, node87_15).
edge(node87_1, node87_16).
edge(node87_1, node87_17).
edge(node87_17, node87_18).
edge(node87_18, node87_19).
edge(node87_19, node87_20).
edge(node87_20, node87_21).
edge(node87_20, node87_22).
edge(node87_19, node87_23).
edge(node87_23, node87_24).
edge(node87_19, node87_25).
edge(node87_18, node87_26).
edge(node87_17, node87_27).
edge(node87_17, node87_28).
edge(node87_28, node87_29).
edge(node87_17, node87_30).
edge(node87_30, node87_31).
edge(node87_31, node87_32).
edge(node87_30, node87_33).
edge(node87_30, node87_34).
edge(node87_34, node87_35).
edge(node87_34, node87_36).
edge(node87_30, node87_37).
edge(node87_37, node87_38).
edge(node87_37, node87_39).
edge(node87_39, node87_40).
edge(node87_17, node87_41).
edge(node87_41, node87_42).
edge(node87_41, node87_43).
edge(node87_43, node87_44).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zs baarova ul. plzen. 
tree_root(node88_0).
:- %%%%%%%% node88_0 %%%%%%%%%%%%%%%%%%%
node(node88_0).
id(node88_0, t_plzensky51278_txt_001_p5s8).         const(t_plzensky51278_txt_001_p5s8).
%%%%%%%% node88_1 %%%%%%%%%%%%%%%%%%%
node(node88_1).
functor(node88_1, act).         const(act).
gram_sempos(node88_1, n_denot).         const(n_denot).
id(node88_1, t_plzensky51278_txt_001_p5s8a1).         const(t_plzensky51278_txt_001_p5s8a1).
t_lemma(node88_1, ulice).         const(ulice).
%%%%%%%% node88_2 %%%%%%%%%%%%%%%%%%%
node(node88_2).
functor(node88_2, fphr).         const(fphr).
id(node88_2, t_plzensky51278_txt_001_p5s8a2).         const(t_plzensky51278_txt_001_p5s8a2).
t_lemma(node88_2, zs).         const(zs).
%%%%%%%% node88_3 %%%%%%%%%%%%%%%%%%%
node(node88_3).
a_afun(node88_3, atr).         const(atr).
m_form(node88_3, zs).         const(zs).
m_lemma(node88_3, zs__b___zakladni_skola_).         const(zs__b___zakladni_skola_).
m_tag(node88_3, nnfxx_____a____).         const(nnfxx_____a____).
m_tag0(node88_3,'n'). const('n'). m_tag1(node88_3,'n'). const('n'). m_tag2(node88_3,'f'). const('f'). m_tag3(node88_3,'x'). const('x'). m_tag4(node88_3,'x'). const('x'). m_tag10(node88_3,'a'). const('a'). 
%%%%%%%% node88_4 %%%%%%%%%%%%%%%%%%%
node(node88_4).
functor(node88_4, rstr).         const(rstr).
gram_sempos(node88_4, n_denot).         const(n_denot).
id(node88_4, t_plzensky51278_txt_001_p5s8a3).         const(t_plzensky51278_txt_001_p5s8a3).
t_lemma(node88_4, baaruv).         const(baaruv).
%%%%%%%% node88_5 %%%%%%%%%%%%%%%%%%%
node(node88_5).
a_afun(node88_5, atr).         const(atr).
m_form(node88_5, baarova).         const(baarova).
m_lemma(node88_5, baaruv__s____2_).         const(baaruv__s____2_).
m_tag(node88_5, aufs1m_________).         const(aufs1m_________).
m_tag0(node88_5,'a'). const('a'). m_tag1(node88_5,'u'). const('u'). m_tag2(node88_5,'f'). const('f'). m_tag3(node88_5,'s'). const('s'). m_tag4(node88_5,'1'). const('1'). m_tag5(node88_5,'m'). const('m'). 
%%%%%%%% node88_6 %%%%%%%%%%%%%%%%%%%
node(node88_6).
a_afun(node88_6, exd).         const(exd).
m_form(node88_6, ul_).         const(ul_).
m_lemma(node88_6, ulice__b).         const(ulice__b).
m_tag(node88_6, nnfxx_____a___8).         const(nnfxx_____a___8).
m_tag0(node88_6,'n'). const('n'). m_tag1(node88_6,'n'). const('n'). m_tag2(node88_6,'f'). const('f'). m_tag3(node88_6,'x'). const('x'). m_tag4(node88_6,'x'). const('x'). m_tag10(node88_6,'a'). const('a'). m_tag14(node88_6,'8'). const('8'). 
%%%%%%%% node88_7 %%%%%%%%%%%%%%%%%%%
node(node88_7).
functor(node88_7, rstr).         const(rstr).
gram_sempos(node88_7, n_denot).         const(n_denot).
id(node88_7, t_plzensky51278_txt_001_p5s8a4).         const(t_plzensky51278_txt_001_p5s8a4).
t_lemma(node88_7, plzen).         const(plzen).
%%%%%%%% node88_8 %%%%%%%%%%%%%%%%%%%
node(node88_8).
a_afun(node88_8, atr).         const(atr).
m_form(node88_8, plzen).         const(plzen).
m_lemma(node88_8, plzen__g).         const(plzen__g).
m_tag(node88_8, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node88_8,'n'). const('n'). m_tag1(node88_8,'n'). const('n'). m_tag2(node88_8,'f'). const('f'). m_tag3(node88_8,'s'). const('s'). m_tag4(node88_8,'1'). const('1'). m_tag10(node88_8,'a'). const('a'). 
edge(node88_0, node88_1).
edge(node88_1, node88_2).
edge(node88_2, node88_3).
edge(node88_1, node88_4).
edge(node88_4, node88_5).
edge(node88_1, node88_6).
edge(node88_1, node88_7).
edge(node88_7, node88_8).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nejlepsim jednotlivcem z druheho stupne byl jan zdebor z druzstva c. 4 z gymnazia v opavske ulici, ktery ziskal devet bodu. 
tree_root(node89_0).
:- %%%%%%%% node89_0 %%%%%%%%%%%%%%%%%%%
node(node89_0).
id(node89_0, t_plzensky51278_txt_001_p5s9).         const(t_plzensky51278_txt_001_p5s9).
%%%%%%%% node89_1 %%%%%%%%%%%%%%%%%%%
node(node89_1).
functor(node89_1, pred).         const(pred).
gram_sempos(node89_1, v).         const(v).
id(node89_1, t_plzensky51278_txt_001_p5s9a1).         const(t_plzensky51278_txt_001_p5s9a1).
t_lemma(node89_1, byt).         const(byt).
%%%%%%%% node89_2 %%%%%%%%%%%%%%%%%%%
node(node89_2).
functor(node89_2, pat).         const(pat).
gram_sempos(node89_2, n_denot).         const(n_denot).
id(node89_2, t_plzensky51278_txt_001_p5s9a2).         const(t_plzensky51278_txt_001_p5s9a2).
t_lemma(node89_2, jednotlivec).         const(jednotlivec).
%%%%%%%% node89_3 %%%%%%%%%%%%%%%%%%%
node(node89_3).
functor(node89_3, rstr).         const(rstr).
gram_sempos(node89_3, adj_denot).         const(adj_denot).
id(node89_3, t_plzensky51278_txt_001_p5s9a3).         const(t_plzensky51278_txt_001_p5s9a3).
t_lemma(node89_3, dobry).         const(dobry).
%%%%%%%% node89_4 %%%%%%%%%%%%%%%%%%%
node(node89_4).
a_afun(node89_4, atr).         const(atr).
m_form(node89_4, nejlepsim).         const(nejlepsim).
m_lemma(node89_4, dobry).         const(dobry).
m_tag(node89_4, aams7____3a____).         const(aams7____3a____).
m_tag0(node89_4,'a'). const('a'). m_tag1(node89_4,'a'). const('a'). m_tag2(node89_4,'m'). const('m'). m_tag3(node89_4,'s'). const('s'). m_tag4(node89_4,'7'). const('7'). m_tag9(node89_4,'3'). const('3'). m_tag10(node89_4,'a'). const('a'). 
%%%%%%%% node89_5 %%%%%%%%%%%%%%%%%%%
node(node89_5).
a_afun(node89_5, pnom).         const(pnom).
m_form(node89_5, jednotlivcem).         const(jednotlivcem).
m_lemma(node89_5, jednotlivec).         const(jednotlivec).
m_tag(node89_5, nnms7_____a____).         const(nnms7_____a____).
m_tag0(node89_5,'n'). const('n'). m_tag1(node89_5,'n'). const('n'). m_tag2(node89_5,'m'). const('m'). m_tag3(node89_5,'s'). const('s'). m_tag4(node89_5,'7'). const('7'). m_tag10(node89_5,'a'). const('a'). 
%%%%%%%% node89_6 %%%%%%%%%%%%%%%%%%%
node(node89_6).
functor(node89_6, dir1).         const(dir1).
gram_sempos(node89_6, n_denot).         const(n_denot).
id(node89_6, t_plzensky51278_txt_001_p5s9a5).         const(t_plzensky51278_txt_001_p5s9a5).
t_lemma(node89_6, stupen).         const(stupen).
%%%%%%%% node89_7 %%%%%%%%%%%%%%%%%%%
node(node89_7).
functor(node89_7, rstr).         const(rstr).
gram_sempos(node89_7, adj_quant_def).         const(adj_quant_def).
id(node89_7, t_plzensky51278_txt_001_p5s9a6).         const(t_plzensky51278_txt_001_p5s9a6).
t_lemma(node89_7, dva).         const(dva).
%%%%%%%% node89_8 %%%%%%%%%%%%%%%%%%%
node(node89_8).
a_afun(node89_8, atr).         const(atr).
m_form(node89_8, druheho).         const(druheho).
m_lemma(node89_8, druhy_1___jiny_).         const(druhy_1___jiny_).
m_tag(node89_8, aais2____1a____).         const(aais2____1a____).
m_tag0(node89_8,'a'). const('a'). m_tag1(node89_8,'a'). const('a'). m_tag2(node89_8,'i'). const('i'). m_tag3(node89_8,'s'). const('s'). m_tag4(node89_8,'2'). const('2'). m_tag9(node89_8,'1'). const('1'). m_tag10(node89_8,'a'). const('a'). 
%%%%%%%% node89_9 %%%%%%%%%%%%%%%%%%%
node(node89_9).
a_afun(node89_9, auxp).         const(auxp).
m_form(node89_9, z).         const(z).
m_lemma(node89_9, z_1).         const(z_1).
m_tag(node89_9, rr__2__________).         const(rr__2__________).
m_tag0(node89_9,'r'). const('r'). m_tag1(node89_9,'r'). const('r'). m_tag4(node89_9,'2'). const('2'). 
%%%%%%%% node89_10 %%%%%%%%%%%%%%%%%%%
node(node89_10).
a_afun(node89_10, atr).         const(atr).
m_form(node89_10, stupne).         const(stupne).
m_lemma(node89_10, stupen).         const(stupen).
m_tag(node89_10, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node89_10,'n'). const('n'). m_tag1(node89_10,'n'). const('n'). m_tag2(node89_10,'i'). const('i'). m_tag3(node89_10,'s'). const('s'). m_tag4(node89_10,'2'). const('2'). m_tag10(node89_10,'a'). const('a'). 
%%%%%%%% node89_11 %%%%%%%%%%%%%%%%%%%
node(node89_11).
a_afun(node89_11, pred).         const(pred).
m_form(node89_11, byl).         const(byl).
m_lemma(node89_11, byt).         const(byt).
m_tag(node89_11, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node89_11,'v'). const('v'). m_tag1(node89_11,'p'). const('p'). m_tag2(node89_11,'y'). const('y'). m_tag3(node89_11,'s'). const('s'). m_tag7(node89_11,'x'). const('x'). m_tag8(node89_11,'r'). const('r'). m_tag10(node89_11,'a'). const('a'). m_tag11(node89_11,'a'). const('a'). 
%%%%%%%% node89_12 %%%%%%%%%%%%%%%%%%%
node(node89_12).
functor(node89_12, act).         const(act).
gram_sempos(node89_12, n_denot).         const(n_denot).
id(node89_12, t_plzensky51278_txt_001_p5s9a7).         const(t_plzensky51278_txt_001_p5s9a7).
t_lemma(node89_12, zdebor).         const(zdebor).
%%%%%%%% node89_13 %%%%%%%%%%%%%%%%%%%
node(node89_13).
functor(node89_13, rstr).         const(rstr).
gram_sempos(node89_13, n_denot).         const(n_denot).
id(node89_13, t_plzensky51278_txt_001_p5s9a8).         const(t_plzensky51278_txt_001_p5s9a8).
t_lemma(node89_13, jan).         const(jan).
%%%%%%%% node89_14 %%%%%%%%%%%%%%%%%%%
node(node89_14).
a_afun(node89_14, atr).         const(atr).
m_form(node89_14, jan).         const(jan).
m_lemma(node89_14, jan__y).         const(jan__y).
m_tag(node89_14, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node89_14,'n'). const('n'). m_tag1(node89_14,'n'). const('n'). m_tag2(node89_14,'m'). const('m'). m_tag3(node89_14,'s'). const('s'). m_tag4(node89_14,'1'). const('1'). m_tag10(node89_14,'a'). const('a'). 
%%%%%%%% node89_15 %%%%%%%%%%%%%%%%%%%
node(node89_15).
a_afun(node89_15, sb).         const(sb).
m_form(node89_15, zdebor).         const(zdebor).
m_lemma(node89_15, zdebor).         const(zdebor).
m_tag(node89_15, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node89_15,'n'). const('n'). m_tag1(node89_15,'n'). const('n'). m_tag2(node89_15,'m'). const('m'). m_tag3(node89_15,'s'). const('s'). m_tag4(node89_15,'1'). const('1'). m_tag10(node89_15,'a'). const('a'). 
%%%%%%%% node89_16 %%%%%%%%%%%%%%%%%%%
node(node89_16).
functor(node89_16, dir1).         const(dir1).
gram_sempos(node89_16, n_denot).         const(n_denot).
id(node89_16, t_plzensky51278_txt_001_p5s9a10).         const(t_plzensky51278_txt_001_p5s9a10).
t_lemma(node89_16, druzstvo).         const(druzstvo).
%%%%%%%% node89_17 %%%%%%%%%%%%%%%%%%%
node(node89_17).
a_afun(node89_17, auxp).         const(auxp).
m_form(node89_17, z).         const(z).
m_lemma(node89_17, z_1).         const(z_1).
m_tag(node89_17, rr__2__________).         const(rr__2__________).
m_tag0(node89_17,'r'). const('r'). m_tag1(node89_17,'r'). const('r'). m_tag4(node89_17,'2'). const('2'). 
%%%%%%%% node89_18 %%%%%%%%%%%%%%%%%%%
node(node89_18).
a_afun(node89_18, atr).         const(atr).
m_form(node89_18, druzstva).         const(druzstva).
m_lemma(node89_18, druzstvo).         const(druzstvo).
m_tag(node89_18, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node89_18,'n'). const('n'). m_tag1(node89_18,'n'). const('n'). m_tag2(node89_18,'n'). const('n'). m_tag3(node89_18,'s'). const('s'). m_tag4(node89_18,'2'). const('2'). m_tag10(node89_18,'a'). const('a'). 
%%%%%%%% node89_19 %%%%%%%%%%%%%%%%%%%
node(node89_19).
functor(node89_19, rstr).         const(rstr).
gram_sempos(node89_19, n_denot).         const(n_denot).
id(node89_19, t_plzensky51278_txt_001_p5s9a11).         const(t_plzensky51278_txt_001_p5s9a11).
t_lemma(node89_19, c).         const(c).
%%%%%%%% node89_20 %%%%%%%%%%%%%%%%%%%
node(node89_20).
a_afun(node89_20, atr).         const(atr).
m_form(node89_20, c_).         const(c_).
m_lemma(node89_20, c_3___oznaceni_pomoci_pismene_).         const(c_3___oznaceni_pomoci_pismene_).
m_tag(node89_20, nnnxx_____a____).         const(nnnxx_____a____).
m_tag0(node89_20,'n'). const('n'). m_tag1(node89_20,'n'). const('n'). m_tag2(node89_20,'n'). const('n'). m_tag3(node89_20,'x'). const('x'). m_tag4(node89_20,'x'). const('x'). m_tag10(node89_20,'a'). const('a'). 
%%%%%%%% node89_21 %%%%%%%%%%%%%%%%%%%
node(node89_21).
functor(node89_21, rstr).         const(rstr).
gram_sempos(node89_21, adj_quant_def).         const(adj_quant_def).
id(node89_21, t_plzensky51278_txt_001_p5s9a12).         const(t_plzensky51278_txt_001_p5s9a12).
t_lemma(node89_21, 4).         const(4).
%%%%%%%% node89_22 %%%%%%%%%%%%%%%%%%%
node(node89_22).
a_afun(node89_22, atr).         const(atr).
m_form(node89_22, 4).         const(4).
m_lemma(node89_22, 4).         const(4).
m_tag(node89_22, c=_____________).         const(c=_____________).
m_tag0(node89_22,'c'). const('c'). m_tag1(node89_22,'='). const('='). 
%%%%%%%% node89_23 %%%%%%%%%%%%%%%%%%%
node(node89_23).
functor(node89_23, dir1).         const(dir1).
gram_sempos(node89_23, n_denot).         const(n_denot).
id(node89_23, t_plzensky51278_txt_001_p5s9a14).         const(t_plzensky51278_txt_001_p5s9a14).
t_lemma(node89_23, gymnazium).         const(gymnazium).
%%%%%%%% node89_24 %%%%%%%%%%%%%%%%%%%
node(node89_24).
a_afun(node89_24, auxp).         const(auxp).
m_form(node89_24, z).         const(z).
m_lemma(node89_24, z_1).         const(z_1).
m_tag(node89_24, rr__2__________).         const(rr__2__________).
m_tag0(node89_24,'r'). const('r'). m_tag1(node89_24,'r'). const('r'). m_tag4(node89_24,'2'). const('2'). 
%%%%%%%% node89_25 %%%%%%%%%%%%%%%%%%%
node(node89_25).
a_afun(node89_25, atr).         const(atr).
m_form(node89_25, gymnazia).         const(gymnazia).
m_lemma(node89_25, gymnazium).         const(gymnazium).
m_tag(node89_25, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node89_25,'n'). const('n'). m_tag1(node89_25,'n'). const('n'). m_tag2(node89_25,'n'). const('n'). m_tag3(node89_25,'s'). const('s'). m_tag4(node89_25,'2'). const('2'). m_tag10(node89_25,'a'). const('a'). 
%%%%%%%% node89_26 %%%%%%%%%%%%%%%%%%%
node(node89_26).
functor(node89_26, loc).         const(loc).
gram_sempos(node89_26, n_denot).         const(n_denot).
id(node89_26, t_plzensky51278_txt_001_p5s9a16).         const(t_plzensky51278_txt_001_p5s9a16).
t_lemma(node89_26, ulice).         const(ulice).
%%%%%%%% node89_27 %%%%%%%%%%%%%%%%%%%
node(node89_27).
functor(node89_27, rstr).         const(rstr).
gram_sempos(node89_27, adj_denot).         const(adj_denot).
id(node89_27, t_plzensky51278_txt_001_p5s9a17).         const(t_plzensky51278_txt_001_p5s9a17).
t_lemma(node89_27, opavsky).         const(opavsky).
%%%%%%%% node89_28 %%%%%%%%%%%%%%%%%%%
node(node89_28).
a_afun(node89_28, atr).         const(atr).
m_form(node89_28, opavske).         const(opavske).
m_lemma(node89_28, opavsky).         const(opavsky).
m_tag(node89_28, aafs6____1a____).         const(aafs6____1a____).
m_tag0(node89_28,'a'). const('a'). m_tag1(node89_28,'a'). const('a'). m_tag2(node89_28,'f'). const('f'). m_tag3(node89_28,'s'). const('s'). m_tag4(node89_28,'6'). const('6'). m_tag9(node89_28,'1'). const('1'). m_tag10(node89_28,'a'). const('a'). 
%%%%%%%% node89_29 %%%%%%%%%%%%%%%%%%%
node(node89_29).
a_afun(node89_29, auxp).         const(auxp).
m_form(node89_29, v).         const(v).
m_lemma(node89_29, v_1).         const(v_1).
m_tag(node89_29, rr__6__________).         const(rr__6__________).
m_tag0(node89_29,'r'). const('r'). m_tag1(node89_29,'r'). const('r'). m_tag4(node89_29,'6'). const('6'). 
%%%%%%%% node89_30 %%%%%%%%%%%%%%%%%%%
node(node89_30).
a_afun(node89_30, adv).         const(adv).
m_form(node89_30, ulici).         const(ulici).
m_lemma(node89_30, ulice).         const(ulice).
m_tag(node89_30, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node89_30,'n'). const('n'). m_tag1(node89_30,'n'). const('n'). m_tag2(node89_30,'f'). const('f'). m_tag3(node89_30,'s'). const('s'). m_tag4(node89_30,'6'). const('6'). m_tag10(node89_30,'a'). const('a'). 
%%%%%%%% node89_31 %%%%%%%%%%%%%%%%%%%
node(node89_31).
functor(node89_31, rstr).         const(rstr).
gram_sempos(node89_31, v).         const(v).
id(node89_31, t_plzensky51278_txt_001_p5s9a18).         const(t_plzensky51278_txt_001_p5s9a18).
t_lemma(node89_31, ziskat).         const(ziskat).
%%%%%%%% node89_32 %%%%%%%%%%%%%%%%%%%
node(node89_32).
functor(node89_32, act).         const(act).
gram_sempos(node89_32, n_pron_indef).         const(n_pron_indef).
id(node89_32, t_plzensky51278_txt_001_p5s9a20).         const(t_plzensky51278_txt_001_p5s9a20).
t_lemma(node89_32, ktery).         const(ktery).
%%%%%%%% node89_33 %%%%%%%%%%%%%%%%%%%
node(node89_33).
a_afun(node89_33, sb).         const(sb).
m_form(node89_33, ktery).         const(ktery).
m_lemma(node89_33, ktery).         const(ktery).
m_tag(node89_33, p4ys1__________).         const(p4ys1__________).
m_tag0(node89_33,'p'). const('p'). m_tag1(node89_33,'4'). const('4'). m_tag2(node89_33,'y'). const('y'). m_tag3(node89_33,'s'). const('s'). m_tag4(node89_33,'1'). const('1'). 
%%%%%%%% node89_34 %%%%%%%%%%%%%%%%%%%
node(node89_34).
a_afun(node89_34, atr).         const(atr).
m_form(node89_34, ziskal).         const(ziskal).
m_lemma(node89_34, ziskat__w).         const(ziskat__w).
m_tag(node89_34, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node89_34,'v'). const('v'). m_tag1(node89_34,'p'). const('p'). m_tag2(node89_34,'y'). const('y'). m_tag3(node89_34,'s'). const('s'). m_tag7(node89_34,'x'). const('x'). m_tag8(node89_34,'r'). const('r'). m_tag10(node89_34,'a'). const('a'). m_tag11(node89_34,'a'). const('a'). 
%%%%%%%% node89_35 %%%%%%%%%%%%%%%%%%%
node(node89_35).
functor(node89_35, pat).         const(pat).
gram_sempos(node89_35, n_denot).         const(n_denot).
id(node89_35, t_plzensky51278_txt_001_p5s9a22).         const(t_plzensky51278_txt_001_p5s9a22).
t_lemma(node89_35, bod).         const(bod).
%%%%%%%% node89_36 %%%%%%%%%%%%%%%%%%%
node(node89_36).
functor(node89_36, rstr).         const(rstr).
gram_sempos(node89_36, adj_quant_def).         const(adj_quant_def).
id(node89_36, t_plzensky51278_txt_001_p5s9a21).         const(t_plzensky51278_txt_001_p5s9a21).
t_lemma(node89_36, devet).         const(devet).
%%%%%%%% node89_37 %%%%%%%%%%%%%%%%%%%
node(node89_37).
a_afun(node89_37, obj).         const(obj).
m_form(node89_37, devet).         const(devet).
m_lemma(node89_37, devet_9).         const(devet_9).
m_tag(node89_37, cn_s4__________).         const(cn_s4__________).
m_tag0(node89_37,'c'). const('c'). m_tag1(node89_37,'n'). const('n'). m_tag3(node89_37,'s'). const('s'). m_tag4(node89_37,'4'). const('4'). 
%%%%%%%% node89_38 %%%%%%%%%%%%%%%%%%%
node(node89_38).
a_afun(node89_38, atr).         const(atr).
m_form(node89_38, bodu).         const(bodu).
m_lemma(node89_38, bod).         const(bod).
m_tag(node89_38, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node89_38,'n'). const('n'). m_tag1(node89_38,'n'). const('n'). m_tag2(node89_38,'i'). const('i'). m_tag3(node89_38,'p'). const('p'). m_tag4(node89_38,'2'). const('2'). m_tag10(node89_38,'a'). const('a'). 
edge(node89_0, node89_1).
edge(node89_1, node89_2).
edge(node89_2, node89_3).
edge(node89_3, node89_4).
edge(node89_2, node89_5).
edge(node89_2, node89_6).
edge(node89_6, node89_7).
edge(node89_7, node89_8).
edge(node89_6, node89_9).
edge(node89_6, node89_10).
edge(node89_1, node89_11).
edge(node89_1, node89_12).
edge(node89_12, node89_13).
edge(node89_13, node89_14).
edge(node89_12, node89_15).
edge(node89_12, node89_16).
edge(node89_16, node89_17).
edge(node89_16, node89_18).
edge(node89_12, node89_19).
edge(node89_19, node89_20).
edge(node89_19, node89_21).
edge(node89_21, node89_22).
edge(node89_12, node89_23).
edge(node89_23, node89_24).
edge(node89_23, node89_25).
edge(node89_1, node89_26).
edge(node89_26, node89_27).
edge(node89_27, node89_28).
edge(node89_26, node89_29).
edge(node89_26, node89_30).
edge(node89_26, node89_31).
edge(node89_31, node89_32).
edge(node89_32, node89_33).
edge(node89_31, node89_34).
edge(node89_31, node89_35).
edge(node89_35, node89_36).
edge(node89_36, node89_37).
edge(node89_35, node89_38).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% na unik alarmem upozornilo obsluhu bazenu detekcni zarizeni. 
tree_root(node90_0).
:- %%%%%%%% node90_0 %%%%%%%%%%%%%%%%%%%
node(node90_0).
id(node90_0, t_plzensky58468_txt_001_p1s1).         const(t_plzensky58468_txt_001_p1s1).
%%%%%%%% node90_1 %%%%%%%%%%%%%%%%%%%
node(node90_1).
functor(node90_1, pred).         const(pred).
gram_sempos(node90_1, v).         const(v).
id(node90_1, t_plzensky58468_txt_001_p1s1a1).         const(t_plzensky58468_txt_001_p1s1a1).
t_lemma(node90_1, upozornit).         const(upozornit).
%%%%%%%% node90_2 %%%%%%%%%%%%%%%%%%%
node(node90_2).
functor(node90_2, pat).         const(pat).
id(node90_2, t_plzensky58468_txt_001_p1s1a9).         const(t_plzensky58468_txt_001_p1s1a9).
t_lemma(node90_2, x_gen).         const(x_gen).
%%%%%%%% node90_3 %%%%%%%%%%%%%%%%%%%
node(node90_3).
functor(node90_3, act).         const(act).
gram_sempos(node90_3, n_denot).         const(n_denot).
id(node90_3, t_plzensky58468_txt_001_p1s1a3).         const(t_plzensky58468_txt_001_p1s1a3).
t_lemma(node90_3, unik).         const(unik).
%%%%%%%% node90_4 %%%%%%%%%%%%%%%%%%%
node(node90_4).
a_afun(node90_4, auxp).         const(auxp).
m_form(node90_4, na).         const(na).
m_lemma(node90_4, na_1).         const(na_1).
m_tag(node90_4, rr__4__________).         const(rr__4__________).
m_tag0(node90_4,'r'). const('r'). m_tag1(node90_4,'r'). const('r'). m_tag4(node90_4,'4'). const('4'). 
%%%%%%%% node90_5 %%%%%%%%%%%%%%%%%%%
node(node90_5).
a_afun(node90_5, adv).         const(adv).
m_form(node90_5, unik).         const(unik).
m_lemma(node90_5, unik).         const(unik).
m_tag(node90_5, nnis4_____a____).         const(nnis4_____a____).
m_tag0(node90_5,'n'). const('n'). m_tag1(node90_5,'n'). const('n'). m_tag2(node90_5,'i'). const('i'). m_tag3(node90_5,'s'). const('s'). m_tag4(node90_5,'4'). const('4'). m_tag10(node90_5,'a'). const('a'). 
%%%%%%%% node90_6 %%%%%%%%%%%%%%%%%%%
node(node90_6).
functor(node90_6, means).         const(means).
gram_sempos(node90_6, n_denot).         const(n_denot).
id(node90_6, t_plzensky58468_txt_001_p1s1a4).         const(t_plzensky58468_txt_001_p1s1a4).
t_lemma(node90_6, alarm).         const(alarm).
%%%%%%%% node90_7 %%%%%%%%%%%%%%%%%%%
node(node90_7).
a_afun(node90_7, adv).         const(adv).
m_form(node90_7, alarmem).         const(alarmem).
m_lemma(node90_7, alarm).         const(alarm).
m_tag(node90_7, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node90_7,'n'). const('n'). m_tag1(node90_7,'n'). const('n'). m_tag2(node90_7,'i'). const('i'). m_tag3(node90_7,'s'). const('s'). m_tag4(node90_7,'7'). const('7'). m_tag10(node90_7,'a'). const('a'). 
%%%%%%%% node90_8 %%%%%%%%%%%%%%%%%%%
node(node90_8).
a_afun(node90_8, pred).         const(pred).
m_form(node90_8, upozornilo).         const(upozornilo).
m_lemma(node90_8, upozornit__w).         const(upozornit__w).
m_tag(node90_8, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node90_8,'v'). const('v'). m_tag1(node90_8,'p'). const('p'). m_tag2(node90_8,'n'). const('n'). m_tag3(node90_8,'s'). const('s'). m_tag7(node90_8,'x'). const('x'). m_tag8(node90_8,'r'). const('r'). m_tag10(node90_8,'a'). const('a'). m_tag11(node90_8,'a'). const('a'). 
%%%%%%%% node90_9 %%%%%%%%%%%%%%%%%%%
node(node90_9).
functor(node90_9, addr).         const(addr).
gram_sempos(node90_9, n_denot).         const(n_denot).
id(node90_9, t_plzensky58468_txt_001_p1s1a5).         const(t_plzensky58468_txt_001_p1s1a5).
t_lemma(node90_9, obsluha).         const(obsluha).
%%%%%%%% node90_10 %%%%%%%%%%%%%%%%%%%
node(node90_10).
a_afun(node90_10, obj).         const(obj).
m_form(node90_10, obsluhu).         const(obsluhu).
m_lemma(node90_10, obsluha).         const(obsluha).
m_tag(node90_10, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node90_10,'n'). const('n'). m_tag1(node90_10,'n'). const('n'). m_tag2(node90_10,'f'). const('f'). m_tag3(node90_10,'s'). const('s'). m_tag4(node90_10,'4'). const('4'). m_tag10(node90_10,'a'). const('a'). 
%%%%%%%% node90_11 %%%%%%%%%%%%%%%%%%%
node(node90_11).
functor(node90_11, pat).         const(pat).
gram_sempos(node90_11, n_denot).         const(n_denot).
id(node90_11, t_plzensky58468_txt_001_p1s1a6).         const(t_plzensky58468_txt_001_p1s1a6).
t_lemma(node90_11, bazen).         const(bazen).
%%%%%%%% node90_12 %%%%%%%%%%%%%%%%%%%
node(node90_12).
a_afun(node90_12, atr).         const(atr).
m_form(node90_12, bazenu).         const(bazenu).
m_lemma(node90_12, bazen).         const(bazen).
m_tag(node90_12, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node90_12,'n'). const('n'). m_tag1(node90_12,'n'). const('n'). m_tag2(node90_12,'i'). const('i'). m_tag3(node90_12,'s'). const('s'). m_tag4(node90_12,'2'). const('2'). m_tag10(node90_12,'a'). const('a'). 
%%%%%%%% node90_13 %%%%%%%%%%%%%%%%%%%
node(node90_13).
functor(node90_13, act).         const(act).
gram_sempos(node90_13, n_denot_neg).         const(n_denot_neg).
id(node90_13, t_plzensky58468_txt_001_p1s1a7).         const(t_plzensky58468_txt_001_p1s1a7).
t_lemma(node90_13, zarizeni).         const(zarizeni).
%%%%%%%% node90_14 %%%%%%%%%%%%%%%%%%%
node(node90_14).
functor(node90_14, rstr).         const(rstr).
gram_sempos(node90_14, adj_denot).         const(adj_denot).
id(node90_14, t_plzensky58468_txt_001_p1s1a8).         const(t_plzensky58468_txt_001_p1s1a8).
t_lemma(node90_14, detekcni).         const(detekcni).
%%%%%%%% node90_15 %%%%%%%%%%%%%%%%%%%
node(node90_15).
a_afun(node90_15, atr).         const(atr).
m_form(node90_15, detekcni).         const(detekcni).
m_lemma(node90_15, detekcni).         const(detekcni).
m_tag(node90_15, aans1____1a____).         const(aans1____1a____).
m_tag0(node90_15,'a'). const('a'). m_tag1(node90_15,'a'). const('a'). m_tag2(node90_15,'n'). const('n'). m_tag3(node90_15,'s'). const('s'). m_tag4(node90_15,'1'). const('1'). m_tag9(node90_15,'1'). const('1'). m_tag10(node90_15,'a'). const('a'). 
%%%%%%%% node90_16 %%%%%%%%%%%%%%%%%%%
node(node90_16).
a_afun(node90_16, sb).         const(sb).
m_form(node90_16, zarizeni).         const(zarizeni).
m_lemma(node90_16, zarizeni____4dit_).         const(zarizeni____4dit_).
m_tag(node90_16, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node90_16,'n'). const('n'). m_tag1(node90_16,'n'). const('n'). m_tag2(node90_16,'n'). const('n'). m_tag3(node90_16,'s'). const('s'). m_tag4(node90_16,'1'). const('1'). m_tag10(node90_16,'a'). const('a'). 
edge(node90_0, node90_1).
edge(node90_1, node90_2).
edge(node90_1, node90_3).
edge(node90_3, node90_4).
edge(node90_3, node90_5).
edge(node90_1, node90_6).
edge(node90_6, node90_7).
edge(node90_1, node90_8).
edge(node90_1, node90_9).
edge(node90_9, node90_10).
edge(node90_9, node90_11).
edge(node90_11, node90_12).
edge(node90_1, node90_13).
edge(node90_13, node90_14).
edge(node90_14, node90_15).
edge(node90_13, node90_16).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% obsluha si okamzite oblekla ochranne prostredky a vypnula celou technologii. 
tree_root(node91_0).
:- %%%%%%%% node91_0 %%%%%%%%%%%%%%%%%%%
node(node91_0).
id(node91_0, t_plzensky58468_txt_001_p1s2).         const(t_plzensky58468_txt_001_p1s2).
%%%%%%%% node91_1 %%%%%%%%%%%%%%%%%%%
node(node91_1).
functor(node91_1, conj).         const(conj).
id(node91_1, t_plzensky58468_txt_001_p1s2a1).         const(t_plzensky58468_txt_001_p1s2a1).
t_lemma(node91_1, a).         const(a).
%%%%%%%% node91_2 %%%%%%%%%%%%%%%%%%%
node(node91_2).
functor(node91_2, act).         const(act).
gram_sempos(node91_2, n_denot).         const(n_denot).
id(node91_2, t_plzensky58468_txt_001_p1s2a2).         const(t_plzensky58468_txt_001_p1s2a2).
t_lemma(node91_2, obsluha).         const(obsluha).
%%%%%%%% node91_3 %%%%%%%%%%%%%%%%%%%
node(node91_3).
a_afun(node91_3, sb).         const(sb).
m_form(node91_3, obsluha).         const(obsluha).
m_lemma(node91_3, obsluha).         const(obsluha).
m_tag(node91_3, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node91_3,'n'). const('n'). m_tag1(node91_3,'n'). const('n'). m_tag2(node91_3,'f'). const('f'). m_tag3(node91_3,'s'). const('s'). m_tag4(node91_3,'1'). const('1'). m_tag10(node91_3,'a'). const('a'). 
%%%%%%%% node91_4 %%%%%%%%%%%%%%%%%%%
node(node91_4).
functor(node91_4, pred).         const(pred).
gram_sempos(node91_4, v).         const(v).
id(node91_4, t_plzensky58468_txt_001_p1s2a3).         const(t_plzensky58468_txt_001_p1s2a3).
t_lemma(node91_4, obleceny).         const(obleceny).
%%%%%%%% node91_5 %%%%%%%%%%%%%%%%%%%
node(node91_5).
functor(node91_5, twhen).         const(twhen).
gram_sempos(node91_5, adj_denot).         const(adj_denot).
id(node91_5, t_plzensky58468_txt_001_p1s2a5).         const(t_plzensky58468_txt_001_p1s2a5).
t_lemma(node91_5, okamzity).         const(okamzity).
%%%%%%%% node91_6 %%%%%%%%%%%%%%%%%%%
node(node91_6).
a_afun(node91_6, adv).         const(adv).
m_form(node91_6, okamzite).         const(okamzite).
m_lemma(node91_6, okamzite____1y_).         const(okamzite____1y_).
m_tag(node91_6, dg_______1a____).         const(dg_______1a____).
m_tag0(node91_6,'d'). const('d'). m_tag1(node91_6,'g'). const('g'). m_tag9(node91_6,'1'). const('1'). m_tag10(node91_6,'a'). const('a'). 
%%%%%%%% node91_7 %%%%%%%%%%%%%%%%%%%
node(node91_7).
a_afun(node91_7, auxt).         const(auxt).
m_form(node91_7, si).         const(si).
m_lemma(node91_7, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node91_7, p7_x3__________).         const(p7_x3__________).
m_tag0(node91_7,'p'). const('p'). m_tag1(node91_7,'7'). const('7'). m_tag3(node91_7,'x'). const('x'). m_tag4(node91_7,'3'). const('3'). 
%%%%%%%% node91_8 %%%%%%%%%%%%%%%%%%%
node(node91_8).
a_afun(node91_8, pred).         const(pred).
m_form(node91_8, oblekla).         const(oblekla).
m_lemma(node91_8, obleci).         const(obleci).
m_tag(node91_8, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node91_8,'v'). const('v'). m_tag1(node91_8,'p'). const('p'). m_tag2(node91_8,'q'). const('q'). m_tag3(node91_8,'w'). const('w'). m_tag7(node91_8,'x'). const('x'). m_tag8(node91_8,'r'). const('r'). m_tag10(node91_8,'a'). const('a'). m_tag11(node91_8,'a'). const('a'). 
%%%%%%%% node91_9 %%%%%%%%%%%%%%%%%%%
node(node91_9).
functor(node91_9, pat).         const(pat).
gram_sempos(node91_9, n_denot).         const(n_denot).
id(node91_9, t_plzensky58468_txt_001_p1s2a6).         const(t_plzensky58468_txt_001_p1s2a6).
t_lemma(node91_9, prostredek).         const(prostredek).
%%%%%%%% node91_10 %%%%%%%%%%%%%%%%%%%
node(node91_10).
functor(node91_10, rstr).         const(rstr).
gram_sempos(node91_10, adj_denot).         const(adj_denot).
id(node91_10, t_plzensky58468_txt_001_p1s2a7).         const(t_plzensky58468_txt_001_p1s2a7).
t_lemma(node91_10, ochranny).         const(ochranny).
%%%%%%%% node91_11 %%%%%%%%%%%%%%%%%%%
node(node91_11).
a_afun(node91_11, atr).         const(atr).
m_form(node91_11, ochranne).         const(ochranne).
m_lemma(node91_11, ochranny).         const(ochranny).
m_tag(node91_11, aaip4____1a____).         const(aaip4____1a____).
m_tag0(node91_11,'a'). const('a'). m_tag1(node91_11,'a'). const('a'). m_tag2(node91_11,'i'). const('i'). m_tag3(node91_11,'p'). const('p'). m_tag4(node91_11,'4'). const('4'). m_tag9(node91_11,'1'). const('1'). m_tag10(node91_11,'a'). const('a'). 
%%%%%%%% node91_12 %%%%%%%%%%%%%%%%%%%
node(node91_12).
a_afun(node91_12, obj).         const(obj).
m_form(node91_12, prostredky).         const(prostredky).
m_lemma(node91_12, prostredek_1___stred_).         const(prostredek_1___stred_).
m_tag(node91_12, nnip4_____a____).         const(nnip4_____a____).
m_tag0(node91_12,'n'). const('n'). m_tag1(node91_12,'n'). const('n'). m_tag2(node91_12,'i'). const('i'). m_tag3(node91_12,'p'). const('p'). m_tag4(node91_12,'4'). const('4'). m_tag10(node91_12,'a'). const('a'). 
%%%%%%%% node91_13 %%%%%%%%%%%%%%%%%%%
node(node91_13).
a_afun(node91_13, coord).         const(coord).
m_form(node91_13, a).         const(a).
m_lemma(node91_13, a_1).         const(a_1).
m_tag(node91_13, j______________).         const(j______________).
m_tag0(node91_13,'j'). const('j'). m_tag1(node91_13,'^'). const('^'). 
%%%%%%%% node91_14 %%%%%%%%%%%%%%%%%%%
node(node91_14).
functor(node91_14, pred).         const(pred).
gram_sempos(node91_14, v).         const(v).
id(node91_14, t_plzensky58468_txt_001_p1s2a8).         const(t_plzensky58468_txt_001_p1s2a8).
t_lemma(node91_14, vypnout).         const(vypnout).
%%%%%%%% node91_15 %%%%%%%%%%%%%%%%%%%
node(node91_15).
a_afun(node91_15, pred).         const(pred).
m_form(node91_15, vypnula).         const(vypnula).
m_lemma(node91_15, vypnout).         const(vypnout).
m_tag(node91_15, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node91_15,'v'). const('v'). m_tag1(node91_15,'p'). const('p'). m_tag2(node91_15,'q'). const('q'). m_tag3(node91_15,'w'). const('w'). m_tag7(node91_15,'x'). const('x'). m_tag8(node91_15,'r'). const('r'). m_tag10(node91_15,'a'). const('a'). m_tag11(node91_15,'a'). const('a'). 
%%%%%%%% node91_16 %%%%%%%%%%%%%%%%%%%
node(node91_16).
functor(node91_16, pat).         const(pat).
gram_sempos(node91_16, n_denot).         const(n_denot).
id(node91_16, t_plzensky58468_txt_001_p1s2a9).         const(t_plzensky58468_txt_001_p1s2a9).
t_lemma(node91_16, technologie).         const(technologie).
%%%%%%%% node91_17 %%%%%%%%%%%%%%%%%%%
node(node91_17).
functor(node91_17, rstr).         const(rstr).
gram_sempos(node91_17, adj_denot).         const(adj_denot).
id(node91_17, t_plzensky58468_txt_001_p1s2a10).         const(t_plzensky58468_txt_001_p1s2a10).
t_lemma(node91_17, cely).         const(cely).
%%%%%%%% node91_18 %%%%%%%%%%%%%%%%%%%
node(node91_18).
a_afun(node91_18, atr).         const(atr).
m_form(node91_18, celou).         const(celou).
m_lemma(node91_18, cely).         const(cely).
m_tag(node91_18, aafs4____1a____).         const(aafs4____1a____).
m_tag0(node91_18,'a'). const('a'). m_tag1(node91_18,'a'). const('a'). m_tag2(node91_18,'f'). const('f'). m_tag3(node91_18,'s'). const('s'). m_tag4(node91_18,'4'). const('4'). m_tag9(node91_18,'1'). const('1'). m_tag10(node91_18,'a'). const('a'). 
%%%%%%%% node91_19 %%%%%%%%%%%%%%%%%%%
node(node91_19).
a_afun(node91_19, obj).         const(obj).
m_form(node91_19, technologii).         const(technologii).
m_lemma(node91_19, technologie).         const(technologie).
m_tag(node91_19, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node91_19,'n'). const('n'). m_tag1(node91_19,'n'). const('n'). m_tag2(node91_19,'f'). const('f'). m_tag3(node91_19,'s'). const('s'). m_tag4(node91_19,'4'). const('4'). m_tag10(node91_19,'a'). const('a'). 
edge(node91_0, node91_1).
edge(node91_1, node91_2).
edge(node91_2, node91_3).
edge(node91_1, node91_4).
edge(node91_4, node91_5).
edge(node91_5, node91_6).
edge(node91_4, node91_7).
edge(node91_4, node91_8).
edge(node91_4, node91_9).
edge(node91_9, node91_10).
edge(node91_10, node91_11).
edge(node91_9, node91_12).
edge(node91_1, node91_13).
edge(node91_1, node91_14).
edge(node91_14, node91_15).
edge(node91_14, node91_16).
edge(node91_16, node91_17).
edge(node91_17, node91_18).
edge(node91_16, node91_19).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% doslo take k odvetrani prostor. 
tree_root(node92_0).
:- %%%%%%%% node92_0 %%%%%%%%%%%%%%%%%%%
node(node92_0).
id(node92_0, t_plzensky58468_txt_001_p1s3).         const(t_plzensky58468_txt_001_p1s3).
%%%%%%%% node92_1 %%%%%%%%%%%%%%%%%%%
node(node92_1).
functor(node92_1, pred).         const(pred).
gram_sempos(node92_1, v).         const(v).
id(node92_1, t_plzensky58468_txt_001_p1s3a1).         const(t_plzensky58468_txt_001_p1s3a1).
t_lemma(node92_1, dojit).         const(dojit).
%%%%%%%% node92_2 %%%%%%%%%%%%%%%%%%%
node(node92_2).
functor(node92_2, act).         const(act).
gram_sempos(node92_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node92_2, t_plzensky58468_txt_001_p1s3a6).         const(t_plzensky58468_txt_001_p1s3a6).
t_lemma(node92_2, x_perspron).         const(x_perspron).
%%%%%%%% node92_3 %%%%%%%%%%%%%%%%%%%
node(node92_3).
a_afun(node92_3, pred).         const(pred).
m_form(node92_3, doslo).         const(doslo).
m_lemma(node92_3, dojit).         const(dojit).
m_tag(node92_3, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node92_3,'v'). const('v'). m_tag1(node92_3,'p'). const('p'). m_tag2(node92_3,'n'). const('n'). m_tag3(node92_3,'s'). const('s'). m_tag7(node92_3,'x'). const('x'). m_tag8(node92_3,'r'). const('r'). m_tag10(node92_3,'a'). const('a'). m_tag11(node92_3,'a'). const('a'). 
%%%%%%%% node92_4 %%%%%%%%%%%%%%%%%%%
node(node92_4).
functor(node92_4, rhem).         const(rhem).
id(node92_4, t_plzensky58468_txt_001_p1s3a2).         const(t_plzensky58468_txt_001_p1s3a2).
t_lemma(node92_4, take).         const(take).
%%%%%%%% node92_5 %%%%%%%%%%%%%%%%%%%
node(node92_5).
a_afun(node92_5, adv).         const(adv).
m_form(node92_5, take).         const(take).
m_lemma(node92_5, take___rovnez_).         const(take___rovnez_).
m_tag(node92_5, db_____________).         const(db_____________).
m_tag0(node92_5,'d'). const('d'). m_tag1(node92_5,'b'). const('b'). 
%%%%%%%% node92_6 %%%%%%%%%%%%%%%%%%%
node(node92_6).
functor(node92_6, aim).         const(aim).
gram_sempos(node92_6, n_denot).         const(n_denot).
id(node92_6, t_plzensky58468_txt_001_p1s3a4).         const(t_plzensky58468_txt_001_p1s3a4).
t_lemma(node92_6, odvetrani).         const(odvetrani).
%%%%%%%% node92_7 %%%%%%%%%%%%%%%%%%%
node(node92_7).
a_afun(node92_7, auxp).         const(auxp).
m_form(node92_7, k).         const(k).
m_lemma(node92_7, k_1).         const(k_1).
m_tag(node92_7, rr__3__________).         const(rr__3__________).
m_tag0(node92_7,'r'). const('r'). m_tag1(node92_7,'r'). const('r'). m_tag4(node92_7,'3'). const('3'). 
%%%%%%%% node92_8 %%%%%%%%%%%%%%%%%%%
node(node92_8).
a_afun(node92_8, adv).         const(adv).
m_form(node92_8, odvetrani).         const(odvetrani).
m_lemma(node92_8, odvetrani____3at_).         const(odvetrani____3at_).
m_tag(node92_8, nnns3_____a____).         const(nnns3_____a____).
m_tag0(node92_8,'n'). const('n'). m_tag1(node92_8,'n'). const('n'). m_tag2(node92_8,'n'). const('n'). m_tag3(node92_8,'s'). const('s'). m_tag4(node92_8,'3'). const('3'). m_tag10(node92_8,'a'). const('a'). 
%%%%%%%% node92_9 %%%%%%%%%%%%%%%%%%%
node(node92_9).
functor(node92_9, id).         const(id).
gram_sempos(node92_9, n_denot).         const(n_denot).
id(node92_9, t_plzensky58468_txt_001_p1s3a5).         const(t_plzensky58468_txt_001_p1s3a5).
t_lemma(node92_9, prostor).         const(prostor).
%%%%%%%% node92_10 %%%%%%%%%%%%%%%%%%%
node(node92_10).
a_afun(node92_10, atr).         const(atr).
m_form(node92_10, prostor).         const(prostor).
m_lemma(node92_10, prostor).         const(prostor).
m_tag(node92_10, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node92_10,'n'). const('n'). m_tag1(node92_10,'n'). const('n'). m_tag2(node92_10,'i'). const('i'). m_tag3(node92_10,'s'). const('s'). m_tag4(node92_10,'1'). const('1'). m_tag10(node92_10,'a'). const('a'). 
edge(node92_0, node92_1).
edge(node92_1, node92_2).
edge(node92_1, node92_3).
edge(node92_1, node92_4).
edge(node92_4, node92_5).
edge(node92_1, node92_6).
edge(node92_6, node92_7).
edge(node92_6, node92_8).
edge(node92_6, node92_9).
edge(node92_9, node92_10).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% koncentrace chloru v mistnosti, o rozmeru asi 2 x 1 metr, kde doslo k uniku, cinila dle obsluhy v dobe zjisteni uniku 21 ppm. 
tree_root(node93_0).
:- %%%%%%%% node93_0 %%%%%%%%%%%%%%%%%%%
node(node93_0).
id(node93_0, t_plzensky58468_txt_001_p1s4).         const(t_plzensky58468_txt_001_p1s4).
%%%%%%%% node93_1 %%%%%%%%%%%%%%%%%%%
node(node93_1).
functor(node93_1, pred).         const(pred).
gram_sempos(node93_1, v).         const(v).
id(node93_1, t_plzensky58468_txt_001_p1s4a1).         const(t_plzensky58468_txt_001_p1s4a1).
t_lemma(node93_1, cinit).         const(cinit).
%%%%%%%% node93_2 %%%%%%%%%%%%%%%%%%%
node(node93_2).
functor(node93_2, act).         const(act).
gram_sempos(node93_2, n_denot).         const(n_denot).
id(node93_2, t_plzensky58468_txt_001_p1s4a2).         const(t_plzensky58468_txt_001_p1s4a2).
t_lemma(node93_2, koncentrace).         const(koncentrace).
%%%%%%%% node93_3 %%%%%%%%%%%%%%%%%%%
node(node93_3).
a_afun(node93_3, sb).         const(sb).
m_form(node93_3, koncentrace).         const(koncentrace).
m_lemma(node93_3, koncentrace).         const(koncentrace).
m_tag(node93_3, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node93_3,'n'). const('n'). m_tag1(node93_3,'n'). const('n'). m_tag2(node93_3,'f'). const('f'). m_tag3(node93_3,'s'). const('s'). m_tag4(node93_3,'1'). const('1'). m_tag10(node93_3,'a'). const('a'). 
%%%%%%%% node93_4 %%%%%%%%%%%%%%%%%%%
node(node93_4).
functor(node93_4, app).         const(app).
gram_sempos(node93_4, n_denot).         const(n_denot).
id(node93_4, t_plzensky58468_txt_001_p1s4a3).         const(t_plzensky58468_txt_001_p1s4a3).
t_lemma(node93_4, chlor).         const(chlor).
%%%%%%%% node93_5 %%%%%%%%%%%%%%%%%%%
node(node93_5).
a_afun(node93_5, atr).         const(atr).
m_form(node93_5, chloru).         const(chloru).
m_lemma(node93_5, chlor).         const(chlor).
m_tag(node93_5, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node93_5,'n'). const('n'). m_tag1(node93_5,'n'). const('n'). m_tag2(node93_5,'i'). const('i'). m_tag3(node93_5,'s'). const('s'). m_tag4(node93_5,'2'). const('2'). m_tag10(node93_5,'a'). const('a'). 
%%%%%%%% node93_6 %%%%%%%%%%%%%%%%%%%
node(node93_6).
functor(node93_6, rstr).         const(rstr).
id(node93_6, t_plzensky58468_txt_001_p1s4a4).         const(t_plzensky58468_txt_001_p1s4a4).
t_lemma(node93_6, x_comma).         const(x_comma).
%%%%%%%% node93_7 %%%%%%%%%%%%%%%%%%%
node(node93_7).
functor(node93_7, loc).         const(loc).
gram_sempos(node93_7, n_denot).         const(n_denot).
id(node93_7, t_plzensky58468_txt_001_p1s4a6).         const(t_plzensky58468_txt_001_p1s4a6).
t_lemma(node93_7, mistnost).         const(mistnost).
%%%%%%%% node93_8 %%%%%%%%%%%%%%%%%%%
node(node93_8).
a_afun(node93_8, auxp).         const(auxp).
m_form(node93_8, v).         const(v).
m_lemma(node93_8, v_1).         const(v_1).
m_tag(node93_8, rr__6__________).         const(rr__6__________).
m_tag0(node93_8,'r'). const('r'). m_tag1(node93_8,'r'). const('r'). m_tag4(node93_8,'6'). const('6'). 
%%%%%%%% node93_9 %%%%%%%%%%%%%%%%%%%
node(node93_9).
a_afun(node93_9, atr).         const(atr).
m_form(node93_9, mistnosti).         const(mistnosti).
m_lemma(node93_9, mistnost).         const(mistnost).
m_tag(node93_9, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node93_9,'n'). const('n'). m_tag1(node93_9,'n'). const('n'). m_tag2(node93_9,'f'). const('f'). m_tag3(node93_9,'s'). const('s'). m_tag4(node93_9,'6'). const('6'). m_tag10(node93_9,'a'). const('a'). 
%%%%%%%% node93_10 %%%%%%%%%%%%%%%%%%%
node(node93_10).
a_afun(node93_10, auxx).         const(auxx).
m_form(node93_10, x_).         const(x_).
m_lemma(node93_10, x_).         const(x_).
m_tag(node93_10, z______________).         const(z______________).
m_tag0(node93_10,'z'). const('z'). m_tag1(node93_10,':'). const(':'). 
%%%%%%%% node93_11 %%%%%%%%%%%%%%%%%%%
node(node93_11).
functor(node93_11, pat).         const(pat).
gram_sempos(node93_11, n_denot).         const(n_denot).
id(node93_11, t_plzensky58468_txt_001_p1s4a8).         const(t_plzensky58468_txt_001_p1s4a8).
t_lemma(node93_11, rozmer).         const(rozmer).
%%%%%%%% node93_12 %%%%%%%%%%%%%%%%%%%
node(node93_12).
a_afun(node93_12, auxp).         const(auxp).
m_form(node93_12, o).         const(o).
m_lemma(node93_12, o_1).         const(o_1).
m_tag(node93_12, rr__6__________).         const(rr__6__________).
m_tag0(node93_12,'r'). const('r'). m_tag1(node93_12,'r'). const('r'). m_tag4(node93_12,'6'). const('6'). 
%%%%%%%% node93_13 %%%%%%%%%%%%%%%%%%%
node(node93_13).
a_afun(node93_13, atr).         const(atr).
m_form(node93_13, rozmeru).         const(rozmeru).
m_lemma(node93_13, rozmer).         const(rozmer).
m_tag(node93_13, nnis6_____a____).         const(nnis6_____a____).
m_tag0(node93_13,'n'). const('n'). m_tag1(node93_13,'n'). const('n'). m_tag2(node93_13,'i'). const('i'). m_tag3(node93_13,'s'). const('s'). m_tag4(node93_13,'6'). const('6'). m_tag10(node93_13,'a'). const('a'). 
%%%%%%%% node93_14 %%%%%%%%%%%%%%%%%%%
node(node93_14).
functor(node93_14, oper).         const(oper).
id(node93_14, t_plzensky58468_txt_001_p1s4a9).         const(t_plzensky58468_txt_001_p1s4a9).
t_lemma(node93_14, x).         const(x).
%%%%%%%% node93_15 %%%%%%%%%%%%%%%%%%%
node(node93_15).
functor(node93_15, ext).         const(ext).
gram_sempos(node93_15, adv_denot_ngrad_nneg).         const(adv_denot_ngrad_nneg).
id(node93_15, t_plzensky58468_txt_001_p1s4a10).         const(t_plzensky58468_txt_001_p1s4a10).
t_lemma(node93_15, asi).         const(asi).
%%%%%%%% node93_16 %%%%%%%%%%%%%%%%%%%
node(node93_16).
a_afun(node93_16, auxz).         const(auxz).
m_form(node93_16, asi).         const(asi).
m_lemma(node93_16, asi).         const(asi).
m_tag(node93_16, tt_____________).         const(tt_____________).
m_tag0(node93_16,'t'). const('t'). m_tag1(node93_16,'t'). const('t'). 
%%%%%%%% node93_17 %%%%%%%%%%%%%%%%%%%
node(node93_17).
functor(node93_17, rstr).         const(rstr).
gram_sempos(node93_17, adj_quant_def).         const(adj_quant_def).
id(node93_17, t_plzensky58468_txt_001_p1s4a11).         const(t_plzensky58468_txt_001_p1s4a11).
t_lemma(node93_17, 2).         const(2).
%%%%%%%% node93_18 %%%%%%%%%%%%%%%%%%%
node(node93_18).
a_afun(node93_18, atr).         const(atr).
m_form(node93_18, 2).         const(2).
m_lemma(node93_18, 2).         const(2).
m_tag(node93_18, c=_____________).         const(c=_____________).
m_tag0(node93_18,'c'). const('c'). m_tag1(node93_18,'='). const('='). 
%%%%%%%% node93_19 %%%%%%%%%%%%%%%%%%%
node(node93_19).
a_afun(node93_19, coord).         const(coord).
m_form(node93_19, x).         const(x).
m_lemma(node93_19, x_5___nahr__symbolu_krat__mat__symbol_).         const(x_5___nahr__symbolu_krat__mat__symbol_).
m_tag(node93_19, j______________).         const(j______________).
m_tag0(node93_19,'j'). const('j'). m_tag1(node93_19,'*'). const('*'). 
%%%%%%%% node93_20 %%%%%%%%%%%%%%%%%%%
node(node93_20).
functor(node93_20, rstr).         const(rstr).
gram_sempos(node93_20, adj_quant_def).         const(adj_quant_def).
id(node93_20, t_plzensky58468_txt_001_p1s4a12).         const(t_plzensky58468_txt_001_p1s4a12).
t_lemma(node93_20, 1).         const(1).
%%%%%%%% node93_21 %%%%%%%%%%%%%%%%%%%
node(node93_21).
a_afun(node93_21, atr).         const(atr).
m_form(node93_21, 1).         const(1).
m_lemma(node93_21, 1).         const(1).
m_tag(node93_21, c=_____________).         const(c=_____________).
m_tag0(node93_21,'c'). const('c'). m_tag1(node93_21,'='). const('='). 
%%%%%%%% node93_22 %%%%%%%%%%%%%%%%%%%
node(node93_22).
functor(node93_22, rstr).         const(rstr).
gram_sempos(node93_22, n_denot).         const(n_denot).
id(node93_22, t_plzensky58468_txt_001_p1s4a13).         const(t_plzensky58468_txt_001_p1s4a13).
t_lemma(node93_22, metr).         const(metr).
%%%%%%%% node93_23 %%%%%%%%%%%%%%%%%%%
node(node93_23).
a_afun(node93_23, atr).         const(atr).
m_form(node93_23, metr).         const(metr).
m_lemma(node93_23, metr).         const(metr).
m_tag(node93_23, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node93_23,'n'). const('n'). m_tag1(node93_23,'n'). const('n'). m_tag2(node93_23,'i'). const('i'). m_tag3(node93_23,'s'). const('s'). m_tag4(node93_23,'1'). const('1'). m_tag10(node93_23,'a'). const('a'). 
%%%%%%%% node93_24 %%%%%%%%%%%%%%%%%%%
node(node93_24).
functor(node93_24, rstr).         const(rstr).
gram_sempos(node93_24, v).         const(v).
id(node93_24, t_plzensky58468_txt_001_p1s4a14).         const(t_plzensky58468_txt_001_p1s4a14).
t_lemma(node93_24, dojit).         const(dojit).
%%%%%%%% node93_25 %%%%%%%%%%%%%%%%%%%
node(node93_25).
functor(node93_25, loc).         const(loc).
gram_sempos(node93_25, adv_pron_indef).         const(adv_pron_indef).
id(node93_25, t_plzensky58468_txt_001_p1s4a16).         const(t_plzensky58468_txt_001_p1s4a16).
t_lemma(node93_25, kde).         const(kde).
%%%%%%%% node93_26 %%%%%%%%%%%%%%%%%%%
node(node93_26).
a_afun(node93_26, adv).         const(adv).
m_form(node93_26, kde).         const(kde).
m_lemma(node93_26, kde).         const(kde).
m_tag(node93_26, db_____________).         const(db_____________).
m_tag0(node93_26,'d'). const('d'). m_tag1(node93_26,'b'). const('b'). 
%%%%%%%% node93_27 %%%%%%%%%%%%%%%%%%%
node(node93_27).
a_afun(node93_27, atr).         const(atr).
m_form(node93_27, doslo).         const(doslo).
m_lemma(node93_27, dojit).         const(dojit).
m_tag(node93_27, vpns___xr_aa___).         const(vpns___xr_aa___).
m_tag0(node93_27,'v'). const('v'). m_tag1(node93_27,'p'). const('p'). m_tag2(node93_27,'n'). const('n'). m_tag3(node93_27,'s'). const('s'). m_tag7(node93_27,'x'). const('x'). m_tag8(node93_27,'r'). const('r'). m_tag10(node93_27,'a'). const('a'). m_tag11(node93_27,'a'). const('a'). 
%%%%%%%% node93_28 %%%%%%%%%%%%%%%%%%%
node(node93_28).
functor(node93_28, act).         const(act).
gram_sempos(node93_28, n_denot).         const(n_denot).
id(node93_28, t_plzensky58468_txt_001_p1s4a18).         const(t_plzensky58468_txt_001_p1s4a18).
t_lemma(node93_28, unik).         const(unik).
%%%%%%%% node93_29 %%%%%%%%%%%%%%%%%%%
node(node93_29).
a_afun(node93_29, auxp).         const(auxp).
m_form(node93_29, k).         const(k).
m_lemma(node93_29, k_1).         const(k_1).
m_tag(node93_29, rr__3__________).         const(rr__3__________).
m_tag0(node93_29,'r'). const('r'). m_tag1(node93_29,'r'). const('r'). m_tag4(node93_29,'3'). const('3'). 
%%%%%%%% node93_30 %%%%%%%%%%%%%%%%%%%
node(node93_30).
a_afun(node93_30, adv).         const(adv).
m_form(node93_30, uniku).         const(uniku).
m_lemma(node93_30, unik).         const(unik).
m_tag(node93_30, nnis3_____a____).         const(nnis3_____a____).
m_tag0(node93_30,'n'). const('n'). m_tag1(node93_30,'n'). const('n'). m_tag2(node93_30,'i'). const('i'). m_tag3(node93_30,'s'). const('s'). m_tag4(node93_30,'3'). const('3'). m_tag10(node93_30,'a'). const('a'). 
%%%%%%%% node93_31 %%%%%%%%%%%%%%%%%%%
node(node93_31).
a_afun(node93_31, pred).         const(pred).
m_form(node93_31, cinila).         const(cinila).
m_lemma(node93_31, cinit__t).         const(cinit__t).
m_tag(node93_31, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node93_31,'v'). const('v'). m_tag1(node93_31,'p'). const('p'). m_tag2(node93_31,'q'). const('q'). m_tag3(node93_31,'w'). const('w'). m_tag7(node93_31,'x'). const('x'). m_tag8(node93_31,'r'). const('r'). m_tag10(node93_31,'a'). const('a'). m_tag11(node93_31,'a'). const('a'). 
%%%%%%%% node93_32 %%%%%%%%%%%%%%%%%%%
node(node93_32).
functor(node93_32, crit).         const(crit).
gram_sempos(node93_32, n_denot).         const(n_denot).
id(node93_32, t_plzensky58468_txt_001_p1s4a21).         const(t_plzensky58468_txt_001_p1s4a21).
t_lemma(node93_32, obsluha).         const(obsluha).
%%%%%%%% node93_33 %%%%%%%%%%%%%%%%%%%
node(node93_33).
a_afun(node93_33, auxp).         const(auxp).
m_form(node93_33, dle).         const(dle).
m_lemma(node93_33, dle).         const(dle).
m_tag(node93_33, rr__2__________).         const(rr__2__________).
m_tag0(node93_33,'r'). const('r'). m_tag1(node93_33,'r'). const('r'). m_tag4(node93_33,'2'). const('2'). 
%%%%%%%% node93_34 %%%%%%%%%%%%%%%%%%%
node(node93_34).
a_afun(node93_34, adv).         const(adv).
m_form(node93_34, obsluhy).         const(obsluhy).
m_lemma(node93_34, obsluha).         const(obsluha).
m_tag(node93_34, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node93_34,'n'). const('n'). m_tag1(node93_34,'n'). const('n'). m_tag2(node93_34,'f'). const('f'). m_tag3(node93_34,'s'). const('s'). m_tag4(node93_34,'2'). const('2'). m_tag10(node93_34,'a'). const('a'). 
%%%%%%%% node93_35 %%%%%%%%%%%%%%%%%%%
node(node93_35).
functor(node93_35, twhen).         const(twhen).
gram_sempos(node93_35, n_denot).         const(n_denot).
id(node93_35, t_plzensky58468_txt_001_p1s4a23).         const(t_plzensky58468_txt_001_p1s4a23).
t_lemma(node93_35, doba).         const(doba).
%%%%%%%% node93_36 %%%%%%%%%%%%%%%%%%%
node(node93_36).
a_afun(node93_36, auxp).         const(auxp).
m_form(node93_36, v).         const(v).
m_lemma(node93_36, v_1).         const(v_1).
m_tag(node93_36, rr__6__________).         const(rr__6__________).
m_tag0(node93_36,'r'). const('r'). m_tag1(node93_36,'r'). const('r'). m_tag4(node93_36,'6'). const('6'). 
%%%%%%%% node93_37 %%%%%%%%%%%%%%%%%%%
node(node93_37).
a_afun(node93_37, adv).         const(adv).
m_form(node93_37, dobe).         const(dobe).
m_lemma(node93_37, doba).         const(doba).
m_tag(node93_37, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node93_37,'n'). const('n'). m_tag1(node93_37,'n'). const('n'). m_tag2(node93_37,'f'). const('f'). m_tag3(node93_37,'s'). const('s'). m_tag4(node93_37,'6'). const('6'). m_tag10(node93_37,'a'). const('a'). 
%%%%%%%% node93_38 %%%%%%%%%%%%%%%%%%%
node(node93_38).
functor(node93_38, ext).         const(ext).
gram_sempos(node93_38, n_denot_neg).         const(n_denot_neg).
id(node93_38, t_plzensky58468_txt_001_p1s4a24).         const(t_plzensky58468_txt_001_p1s4a24).
t_lemma(node93_38, zjisteni).         const(zjisteni).
%%%%%%%% node93_39 %%%%%%%%%%%%%%%%%%%
node(node93_39).
a_afun(node93_39, obj).         const(obj).
m_form(node93_39, zjisteni).         const(zjisteni).
m_lemma(node93_39, zjisteni____5stit_).         const(zjisteni____5stit_).
m_tag(node93_39, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node93_39,'n'). const('n'). m_tag1(node93_39,'n'). const('n'). m_tag2(node93_39,'n'). const('n'). m_tag3(node93_39,'s'). const('s'). m_tag4(node93_39,'2'). const('2'). m_tag10(node93_39,'a'). const('a'). 
%%%%%%%% node93_40 %%%%%%%%%%%%%%%%%%%
node(node93_40).
functor(node93_40, pat).         const(pat).
gram_sempos(node93_40, n_denot).         const(n_denot).
id(node93_40, t_plzensky58468_txt_001_p1s4a25).         const(t_plzensky58468_txt_001_p1s4a25).
t_lemma(node93_40, unik).         const(unik).
%%%%%%%% node93_41 %%%%%%%%%%%%%%%%%%%
node(node93_41).
a_afun(node93_41, atr).         const(atr).
m_form(node93_41, uniku).         const(uniku).
m_lemma(node93_41, unik).         const(unik).
m_tag(node93_41, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node93_41,'n'). const('n'). m_tag1(node93_41,'n'). const('n'). m_tag2(node93_41,'i'). const('i'). m_tag3(node93_41,'s'). const('s'). m_tag4(node93_41,'2'). const('2'). m_tag10(node93_41,'a'). const('a'). 
%%%%%%%% node93_42 %%%%%%%%%%%%%%%%%%%
node(node93_42).
functor(node93_42, ext).         const(ext).
gram_sempos(node93_42, n_denot).         const(n_denot).
id(node93_42, t_plzensky58468_txt_001_p1s4a27).         const(t_plzensky58468_txt_001_p1s4a27).
t_lemma(node93_42, ppm).         const(ppm).
%%%%%%%% node93_43 %%%%%%%%%%%%%%%%%%%
node(node93_43).
functor(node93_43, rstr).         const(rstr).
gram_sempos(node93_43, adj_quant_def).         const(adj_quant_def).
id(node93_43, t_plzensky58468_txt_001_p1s4a26).         const(t_plzensky58468_txt_001_p1s4a26).
t_lemma(node93_43, 21).         const(21).
%%%%%%%% node93_44 %%%%%%%%%%%%%%%%%%%
node(node93_44).
a_afun(node93_44, obj).         const(obj).
m_form(node93_44, 21).         const(21).
m_lemma(node93_44, 21).         const(21).
m_tag(node93_44, c=_____________).         const(c=_____________).
m_tag0(node93_44,'c'). const('c'). m_tag1(node93_44,'='). const('='). 
%%%%%%%% node93_45 %%%%%%%%%%%%%%%%%%%
node(node93_45).
a_afun(node93_45, atr).         const(atr).
m_form(node93_45, ppm).         const(ppm).
m_lemma(node93_45, ppm__b___partes_per_milion_).         const(ppm__b___partes_per_milion_).
m_tag(node93_45, nnfxx_____a___8).         const(nnfxx_____a___8).
m_tag0(node93_45,'n'). const('n'). m_tag1(node93_45,'n'). const('n'). m_tag2(node93_45,'f'). const('f'). m_tag3(node93_45,'x'). const('x'). m_tag4(node93_45,'x'). const('x'). m_tag10(node93_45,'a'). const('a'). m_tag14(node93_45,'8'). const('8'). 
edge(node93_0, node93_1).
edge(node93_1, node93_2).
edge(node93_2, node93_3).
edge(node93_2, node93_4).
edge(node93_4, node93_5).
edge(node93_2, node93_6).
edge(node93_6, node93_7).
edge(node93_7, node93_8).
edge(node93_7, node93_9).
edge(node93_6, node93_10).
edge(node93_6, node93_11).
edge(node93_11, node93_12).
edge(node93_11, node93_13).
edge(node93_11, node93_14).
edge(node93_14, node93_15).
edge(node93_15, node93_16).
edge(node93_14, node93_17).
edge(node93_17, node93_18).
edge(node93_14, node93_19).
edge(node93_14, node93_20).
edge(node93_20, node93_21).
edge(node93_6, node93_22).
edge(node93_22, node93_23).
edge(node93_22, node93_24).
edge(node93_24, node93_25).
edge(node93_25, node93_26).
edge(node93_24, node93_27).
edge(node93_24, node93_28).
edge(node93_28, node93_29).
edge(node93_28, node93_30).
edge(node93_1, node93_31).
edge(node93_1, node93_32).
edge(node93_32, node93_33).
edge(node93_32, node93_34).
edge(node93_1, node93_35).
edge(node93_35, node93_36).
edge(node93_35, node93_37).
edge(node93_1, node93_38).
edge(node93_38, node93_39).
edge(node93_38, node93_40).
edge(node93_40, node93_41).
edge(node93_1, node93_42).
edge(node93_42, node93_43).
edge(node93_43, node93_44).
edge(node93_42, node93_45).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% k bazenu vyjeli ihned mistni profesionalni hasici. 
tree_root(node94_0).
:- %%%%%%%% node94_0 %%%%%%%%%%%%%%%%%%%
node(node94_0).
id(node94_0, t_plzensky58468_txt_001_p1s5).         const(t_plzensky58468_txt_001_p1s5).
%%%%%%%% node94_1 %%%%%%%%%%%%%%%%%%%
node(node94_1).
functor(node94_1, pred).         const(pred).
gram_sempos(node94_1, v).         const(v).
id(node94_1, t_plzensky58468_txt_001_p1s5a1).         const(t_plzensky58468_txt_001_p1s5a1).
t_lemma(node94_1, vyjet).         const(vyjet).
%%%%%%%% node94_2 %%%%%%%%%%%%%%%%%%%
node(node94_2).
functor(node94_2, pat).         const(pat).
gram_sempos(node94_2, n_denot).         const(n_denot).
id(node94_2, t_plzensky58468_txt_001_p1s5a3).         const(t_plzensky58468_txt_001_p1s5a3).
t_lemma(node94_2, bazen).         const(bazen).
%%%%%%%% node94_3 %%%%%%%%%%%%%%%%%%%
node(node94_3).
a_afun(node94_3, auxp).         const(auxp).
m_form(node94_3, k).         const(k).
m_lemma(node94_3, k_1).         const(k_1).
m_tag(node94_3, rr__3__________).         const(rr__3__________).
m_tag0(node94_3,'r'). const('r'). m_tag1(node94_3,'r'). const('r'). m_tag4(node94_3,'3'). const('3'). 
%%%%%%%% node94_4 %%%%%%%%%%%%%%%%%%%
node(node94_4).
a_afun(node94_4, adv).         const(adv).
m_form(node94_4, bazenu).         const(bazenu).
m_lemma(node94_4, bazen).         const(bazen).
m_tag(node94_4, nnis3_____a____).         const(nnis3_____a____).
m_tag0(node94_4,'n'). const('n'). m_tag1(node94_4,'n'). const('n'). m_tag2(node94_4,'i'). const('i'). m_tag3(node94_4,'s'). const('s'). m_tag4(node94_4,'3'). const('3'). m_tag10(node94_4,'a'). const('a'). 
%%%%%%%% node94_5 %%%%%%%%%%%%%%%%%%%
node(node94_5).
a_afun(node94_5, pred).         const(pred).
m_form(node94_5, vyjeli).         const(vyjeli).
m_lemma(node94_5, vyjet).         const(vyjet).
m_tag(node94_5, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node94_5,'v'). const('v'). m_tag1(node94_5,'p'). const('p'). m_tag2(node94_5,'m'). const('m'). m_tag3(node94_5,'p'). const('p'). m_tag7(node94_5,'x'). const('x'). m_tag8(node94_5,'r'). const('r'). m_tag10(node94_5,'a'). const('a'). m_tag11(node94_5,'a'). const('a'). 
%%%%%%%% node94_6 %%%%%%%%%%%%%%%%%%%
node(node94_6).
functor(node94_6, rhem).         const(rhem).
id(node94_6, t_plzensky58468_txt_001_p1s5a5).         const(t_plzensky58468_txt_001_p1s5a5).
t_lemma(node94_6, ihned).         const(ihned).
%%%%%%%% node94_7 %%%%%%%%%%%%%%%%%%%
node(node94_7).
a_afun(node94_7, auxz).         const(auxz).
m_form(node94_7, ihned).         const(ihned).
m_lemma(node94_7, ihned).         const(ihned).
m_tag(node94_7, db_____________).         const(db_____________).
m_tag0(node94_7,'d'). const('d'). m_tag1(node94_7,'b'). const('b'). 
%%%%%%%% node94_8 %%%%%%%%%%%%%%%%%%%
node(node94_8).
functor(node94_8, act).         const(act).
gram_sempos(node94_8, n_denot).         const(n_denot).
id(node94_8, t_plzensky58468_txt_001_p1s5a4).         const(t_plzensky58468_txt_001_p1s5a4).
t_lemma(node94_8, hasic).         const(hasic).
%%%%%%%% node94_9 %%%%%%%%%%%%%%%%%%%
node(node94_9).
functor(node94_9, rstr).         const(rstr).
gram_sempos(node94_9, adj_denot).         const(adj_denot).
id(node94_9, t_plzensky58468_txt_001_p1s5a6).         const(t_plzensky58468_txt_001_p1s5a6).
t_lemma(node94_9, mistni).         const(mistni).
%%%%%%%% node94_10 %%%%%%%%%%%%%%%%%%%
node(node94_10).
a_afun(node94_10, atr).         const(atr).
m_form(node94_10, mistni).         const(mistni).
m_lemma(node94_10, mistni).         const(mistni).
m_tag(node94_10, aamp1____1a____).         const(aamp1____1a____).
m_tag0(node94_10,'a'). const('a'). m_tag1(node94_10,'a'). const('a'). m_tag2(node94_10,'m'). const('m'). m_tag3(node94_10,'p'). const('p'). m_tag4(node94_10,'1'). const('1'). m_tag9(node94_10,'1'). const('1'). m_tag10(node94_10,'a'). const('a'). 
%%%%%%%% node94_11 %%%%%%%%%%%%%%%%%%%
node(node94_11).
functor(node94_11, rstr).         const(rstr).
gram_sempos(node94_11, adj_denot).         const(adj_denot).
id(node94_11, t_plzensky58468_txt_001_p1s5a7).         const(t_plzensky58468_txt_001_p1s5a7).
t_lemma(node94_11, profesionalni).         const(profesionalni).
%%%%%%%% node94_12 %%%%%%%%%%%%%%%%%%%
node(node94_12).
a_afun(node94_12, atr).         const(atr).
m_form(node94_12, profesionalni).         const(profesionalni).
m_lemma(node94_12, profesionalni).         const(profesionalni).
m_tag(node94_12, aamp1____1a____).         const(aamp1____1a____).
m_tag0(node94_12,'a'). const('a'). m_tag1(node94_12,'a'). const('a'). m_tag2(node94_12,'m'). const('m'). m_tag3(node94_12,'p'). const('p'). m_tag4(node94_12,'1'). const('1'). m_tag9(node94_12,'1'). const('1'). m_tag10(node94_12,'a'). const('a'). 
%%%%%%%% node94_13 %%%%%%%%%%%%%%%%%%%
node(node94_13).
a_afun(node94_13, sb).         const(sb).
m_form(node94_13, hasici).         const(hasici).
m_lemma(node94_13, hasic).         const(hasic).
m_tag(node94_13, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node94_13,'n'). const('n'). m_tag1(node94_13,'n'). const('n'). m_tag2(node94_13,'m'). const('m'). m_tag3(node94_13,'p'). const('p'). m_tag4(node94_13,'1'). const('1'). m_tag10(node94_13,'a'). const('a'). 
edge(node94_0, node94_1).
edge(node94_1, node94_2).
edge(node94_2, node94_3).
edge(node94_2, node94_4).
edge(node94_1, node94_5).
edge(node94_1, node94_6).
edge(node94_6, node94_7).
edge(node94_1, node94_8).
edge(node94_8, node94_9).
edge(node94_9, node94_10).
edge(node94_8, node94_11).
edge(node94_11, node94_12).
edge(node94_8, node94_13).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% po prijezdu provedli v dychaci technice pruzkum a mereni koncentrace chloru v mistnosti s negativnim vysledkem. 
tree_root(node95_0).
:- %%%%%%%% node95_0 %%%%%%%%%%%%%%%%%%%
node(node95_0).
id(node95_0, t_plzensky58468_txt_001_p1s6).         const(t_plzensky58468_txt_001_p1s6).
%%%%%%%% node95_1 %%%%%%%%%%%%%%%%%%%
node(node95_1).
functor(node95_1, pred).         const(pred).
gram_sempos(node95_1, v).         const(v).
id(node95_1, t_plzensky58468_txt_001_p1s6a1).         const(t_plzensky58468_txt_001_p1s6a1).
t_lemma(node95_1, provest).         const(provest).
%%%%%%%% node95_2 %%%%%%%%%%%%%%%%%%%
node(node95_2).
functor(node95_2, twhen).         const(twhen).
gram_sempos(node95_2, n_denot).         const(n_denot).
id(node95_2, t_plzensky58468_txt_001_p1s6a3).         const(t_plzensky58468_txt_001_p1s6a3).
t_lemma(node95_2, prijezd).         const(prijezd).
%%%%%%%% node95_3 %%%%%%%%%%%%%%%%%%%
node(node95_3).
a_afun(node95_3, auxp).         const(auxp).
m_form(node95_3, po).         const(po).
m_lemma(node95_3, po_1).         const(po_1).
m_tag(node95_3, rr__6__________).         const(rr__6__________).
m_tag0(node95_3,'r'). const('r'). m_tag1(node95_3,'r'). const('r'). m_tag4(node95_3,'6'). const('6'). 
%%%%%%%% node95_4 %%%%%%%%%%%%%%%%%%%
node(node95_4).
a_afun(node95_4, adv).         const(adv).
m_form(node95_4, prijezdu).         const(prijezdu).
m_lemma(node95_4, prijezd).         const(prijezd).
m_tag(node95_4, nnis6_____a___1).         const(nnis6_____a___1).
m_tag0(node95_4,'n'). const('n'). m_tag1(node95_4,'n'). const('n'). m_tag2(node95_4,'i'). const('i'). m_tag3(node95_4,'s'). const('s'). m_tag4(node95_4,'6'). const('6'). m_tag10(node95_4,'a'). const('a'). m_tag14(node95_4,'1'). const('1'). 
%%%%%%%% node95_5 %%%%%%%%%%%%%%%%%%%
node(node95_5).
a_afun(node95_5, pred).         const(pred).
m_form(node95_5, provedli).         const(provedli).
m_lemma(node95_5, provest).         const(provest).
m_tag(node95_5, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node95_5,'v'). const('v'). m_tag1(node95_5,'p'). const('p'). m_tag2(node95_5,'m'). const('m'). m_tag3(node95_5,'p'). const('p'). m_tag7(node95_5,'x'). const('x'). m_tag8(node95_5,'r'). const('r'). m_tag10(node95_5,'a'). const('a'). m_tag11(node95_5,'a'). const('a'). 
%%%%%%%% node95_6 %%%%%%%%%%%%%%%%%%%
node(node95_6).
functor(node95_6, conj).         const(conj).
id(node95_6, t_plzensky58468_txt_001_p1s6a5).         const(t_plzensky58468_txt_001_p1s6a5).
t_lemma(node95_6, a).         const(a).
%%%%%%%% node95_7 %%%%%%%%%%%%%%%%%%%
node(node95_7).
functor(node95_7, act).         const(act).
gram_sempos(node95_7, n_denot).         const(n_denot).
id(node95_7, t_plzensky58468_txt_001_p1s6a6).         const(t_plzensky58468_txt_001_p1s6a6).
t_lemma(node95_7, technika).         const(technika).
%%%%%%%% node95_8 %%%%%%%%%%%%%%%%%%%
node(node95_8).
functor(node95_8, rstr).         const(rstr).
gram_sempos(node95_8, adj_denot).         const(adj_denot).
id(node95_8, t_plzensky58468_txt_001_p1s6a7).         const(t_plzensky58468_txt_001_p1s6a7).
t_lemma(node95_8, dychaci).         const(dychaci).
%%%%%%%% node95_9 %%%%%%%%%%%%%%%%%%%
node(node95_9).
a_afun(node95_9, atr).         const(atr).
m_form(node95_9, dychaci).         const(dychaci).
m_lemma(node95_9, dychaci____2t_).         const(dychaci____2t_).
m_tag(node95_9, aafs6____1a____).         const(aafs6____1a____).
m_tag0(node95_9,'a'). const('a'). m_tag1(node95_9,'a'). const('a'). m_tag2(node95_9,'f'). const('f'). m_tag3(node95_9,'s'). const('s'). m_tag4(node95_9,'6'). const('6'). m_tag9(node95_9,'1'). const('1'). m_tag10(node95_9,'a'). const('a'). 
%%%%%%%% node95_10 %%%%%%%%%%%%%%%%%%%
node(node95_10).
a_afun(node95_10, adv).         const(adv).
m_form(node95_10, technice).         const(technice).
m_lemma(node95_10, technika).         const(technika).
m_tag(node95_10, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node95_10,'n'). const('n'). m_tag1(node95_10,'n'). const('n'). m_tag2(node95_10,'f'). const('f'). m_tag3(node95_10,'s'). const('s'). m_tag4(node95_10,'6'). const('6'). m_tag10(node95_10,'a'). const('a'). 
%%%%%%%% node95_11 %%%%%%%%%%%%%%%%%%%
node(node95_11).
functor(node95_11, id).         const(id).
gram_sempos(node95_11, n_denot).         const(n_denot).
id(node95_11, t_plzensky58468_txt_001_p1s6a8).         const(t_plzensky58468_txt_001_p1s6a8).
t_lemma(node95_11, pruzkum).         const(pruzkum).
%%%%%%%% node95_12 %%%%%%%%%%%%%%%%%%%
node(node95_12).
a_afun(node95_12, atr).         const(atr).
m_form(node95_12, pruzkum).         const(pruzkum).
m_lemma(node95_12, pruzkum).         const(pruzkum).
m_tag(node95_12, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node95_12,'n'). const('n'). m_tag1(node95_12,'n'). const('n'). m_tag2(node95_12,'i'). const('i'). m_tag3(node95_12,'s'). const('s'). m_tag4(node95_12,'1'). const('1'). m_tag10(node95_12,'a'). const('a'). 
%%%%%%%% node95_13 %%%%%%%%%%%%%%%%%%%
node(node95_13).
a_afun(node95_13, coord).         const(coord).
m_form(node95_13, a).         const(a).
m_lemma(node95_13, a_1).         const(a_1).
m_tag(node95_13, j______________).         const(j______________).
m_tag0(node95_13,'j'). const('j'). m_tag1(node95_13,'^'). const('^'). 
%%%%%%%% node95_14 %%%%%%%%%%%%%%%%%%%
node(node95_14).
functor(node95_14, act).         const(act).
gram_sempos(node95_14, n_denot_neg).         const(n_denot_neg).
id(node95_14, t_plzensky58468_txt_001_p1s6a9).         const(t_plzensky58468_txt_001_p1s6a9).
t_lemma(node95_14, mereni).         const(mereni).
%%%%%%%% node95_15 %%%%%%%%%%%%%%%%%%%
node(node95_15).
functor(node95_15, act).         const(act).
id(node95_15, t_plzensky58468_txt_001_p1s6a17).         const(t_plzensky58468_txt_001_p1s6a17).
t_lemma(node95_15, x_gen).         const(x_gen).
%%%%%%%% node95_16 %%%%%%%%%%%%%%%%%%%
node(node95_16).
a_afun(node95_16, sb).         const(sb).
m_form(node95_16, mereni).         const(mereni).
m_lemma(node95_16, mereni____3it_).         const(mereni____3it_).
m_tag(node95_16, nnns1_____a____).         const(nnns1_____a____).
m_tag0(node95_16,'n'). const('n'). m_tag1(node95_16,'n'). const('n'). m_tag2(node95_16,'n'). const('n'). m_tag3(node95_16,'s'). const('s'). m_tag4(node95_16,'1'). const('1'). m_tag10(node95_16,'a'). const('a'). 
%%%%%%%% node95_17 %%%%%%%%%%%%%%%%%%%
node(node95_17).
functor(node95_17, pat).         const(pat).
gram_sempos(node95_17, n_denot).         const(n_denot).
id(node95_17, t_plzensky58468_txt_001_p1s6a10).         const(t_plzensky58468_txt_001_p1s6a10).
t_lemma(node95_17, koncentrace).         const(koncentrace).
%%%%%%%% node95_18 %%%%%%%%%%%%%%%%%%%
node(node95_18).
a_afun(node95_18, atr).         const(atr).
m_form(node95_18, koncentrace).         const(koncentrace).
m_lemma(node95_18, koncentrace).         const(koncentrace).
m_tag(node95_18, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node95_18,'n'). const('n'). m_tag1(node95_18,'n'). const('n'). m_tag2(node95_18,'f'). const('f'). m_tag3(node95_18,'s'). const('s'). m_tag4(node95_18,'2'). const('2'). m_tag10(node95_18,'a'). const('a'). 
%%%%%%%% node95_19 %%%%%%%%%%%%%%%%%%%
node(node95_19).
functor(node95_19, app).         const(app).
gram_sempos(node95_19, n_denot).         const(n_denot).
id(node95_19, t_plzensky58468_txt_001_p1s6a11).         const(t_plzensky58468_txt_001_p1s6a11).
t_lemma(node95_19, chlor).         const(chlor).
%%%%%%%% node95_20 %%%%%%%%%%%%%%%%%%%
node(node95_20).
a_afun(node95_20, atr).         const(atr).
m_form(node95_20, chloru).         const(chloru).
m_lemma(node95_20, chlor).         const(chlor).
m_tag(node95_20, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node95_20,'n'). const('n'). m_tag1(node95_20,'n'). const('n'). m_tag2(node95_20,'i'). const('i'). m_tag3(node95_20,'s'). const('s'). m_tag4(node95_20,'2'). const('2'). m_tag10(node95_20,'a'). const('a'). 
%%%%%%%% node95_21 %%%%%%%%%%%%%%%%%%%
node(node95_21).
functor(node95_21, loc).         const(loc).
gram_sempos(node95_21, n_denot).         const(n_denot).
id(node95_21, t_plzensky58468_txt_001_p1s6a13).         const(t_plzensky58468_txt_001_p1s6a13).
t_lemma(node95_21, mistnost).         const(mistnost).
%%%%%%%% node95_22 %%%%%%%%%%%%%%%%%%%
node(node95_22).
a_afun(node95_22, auxp).         const(auxp).
m_form(node95_22, v).         const(v).
m_lemma(node95_22, v_1).         const(v_1).
m_tag(node95_22, rr__6__________).         const(rr__6__________).
m_tag0(node95_22,'r'). const('r'). m_tag1(node95_22,'r'). const('r'). m_tag4(node95_22,'6'). const('6'). 
%%%%%%%% node95_23 %%%%%%%%%%%%%%%%%%%
node(node95_23).
a_afun(node95_23, atr).         const(atr).
m_form(node95_23, mistnosti).         const(mistnosti).
m_lemma(node95_23, mistnost).         const(mistnost).
m_tag(node95_23, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node95_23,'n'). const('n'). m_tag1(node95_23,'n'). const('n'). m_tag2(node95_23,'f'). const('f'). m_tag3(node95_23,'s'). const('s'). m_tag4(node95_23,'6'). const('6'). m_tag10(node95_23,'a'). const('a'). 
%%%%%%%% node95_24 %%%%%%%%%%%%%%%%%%%
node(node95_24).
functor(node95_24, acmp).         const(acmp).
gram_sempos(node95_24, n_denot).         const(n_denot).
id(node95_24, t_plzensky58468_txt_001_p1s6a15).         const(t_plzensky58468_txt_001_p1s6a15).
t_lemma(node95_24, vysledek).         const(vysledek).
%%%%%%%% node95_25 %%%%%%%%%%%%%%%%%%%
node(node95_25).
functor(node95_25, rstr).         const(rstr).
gram_sempos(node95_25, adj_denot).         const(adj_denot).
id(node95_25, t_plzensky58468_txt_001_p1s6a16).         const(t_plzensky58468_txt_001_p1s6a16).
t_lemma(node95_25, negativni).         const(negativni).
%%%%%%%% node95_26 %%%%%%%%%%%%%%%%%%%
node(node95_26).
a_afun(node95_26, atr).         const(atr).
m_form(node95_26, negativnim).         const(negativnim).
m_lemma(node95_26, negativni).         const(negativni).
m_tag(node95_26, aais7____1a____).         const(aais7____1a____).
m_tag0(node95_26,'a'). const('a'). m_tag1(node95_26,'a'). const('a'). m_tag2(node95_26,'i'). const('i'). m_tag3(node95_26,'s'). const('s'). m_tag4(node95_26,'7'). const('7'). m_tag9(node95_26,'1'). const('1'). m_tag10(node95_26,'a'). const('a'). 
%%%%%%%% node95_27 %%%%%%%%%%%%%%%%%%%
node(node95_27).
a_afun(node95_27, auxp).         const(auxp).
m_form(node95_27, s).         const(s).
m_lemma(node95_27, s_1).         const(s_1).
m_tag(node95_27, rr__7__________).         const(rr__7__________).
m_tag0(node95_27,'r'). const('r'). m_tag1(node95_27,'r'). const('r'). m_tag4(node95_27,'7'). const('7'). 
%%%%%%%% node95_28 %%%%%%%%%%%%%%%%%%%
node(node95_28).
a_afun(node95_28, atr).         const(atr).
m_form(node95_28, vysledkem).         const(vysledkem).
m_lemma(node95_28, vysledek).         const(vysledek).
m_tag(node95_28, nnis7_____a____).         const(nnis7_____a____).
m_tag0(node95_28,'n'). const('n'). m_tag1(node95_28,'n'). const('n'). m_tag2(node95_28,'i'). const('i'). m_tag3(node95_28,'s'). const('s'). m_tag4(node95_28,'7'). const('7'). m_tag10(node95_28,'a'). const('a'). 
edge(node95_0, node95_1).
edge(node95_1, node95_2).
edge(node95_2, node95_3).
edge(node95_2, node95_4).
edge(node95_1, node95_5).
edge(node95_1, node95_6).
edge(node95_6, node95_7).
edge(node95_7, node95_8).
edge(node95_8, node95_9).
edge(node95_7, node95_10).
edge(node95_7, node95_11).
edge(node95_11, node95_12).
edge(node95_6, node95_13).
edge(node95_6, node95_14).
edge(node95_14, node95_15).
edge(node95_14, node95_16).
edge(node95_14, node95_17).
edge(node95_17, node95_18).
edge(node95_17, node95_19).
edge(node95_19, node95_20).
edge(node95_17, node95_21).
edge(node95_21, node95_22).
edge(node95_21, node95_23).
edge(node95_14, node95_24).
edge(node95_24, node95_25).
edge(node95_25, node95_26).
edge(node95_24, node95_27).
edge(node95_24, node95_28).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% po zjisteni mista drobneho uniku byla informovana servisni firma, ktera provede opravu do budovy bazenu se dostavil starosta mesta i zastupce odboru zivotniho prostredi. 
tree_root(node96_0).
:- %%%%%%%% node96_0 %%%%%%%%%%%%%%%%%%%
node(node96_0).
id(node96_0, t_plzensky58468_txt_001_p1s7).         const(t_plzensky58468_txt_001_p1s7).
%%%%%%%% node96_1 %%%%%%%%%%%%%%%%%%%
node(node96_1).
functor(node96_1, pred).         const(pred).
gram_sempos(node96_1, v).         const(v).
id(node96_1, t_plzensky58468_txt_001_p1s7a1).         const(t_plzensky58468_txt_001_p1s7a1).
t_lemma(node96_1, informovat).         const(informovat).
%%%%%%%% node96_2 %%%%%%%%%%%%%%%%%%%
node(node96_2).
functor(node96_2, pat).         const(pat).
gram_sempos(node96_2, n_pron_def_pers).         const(n_pron_def_pers).
id(node96_2, t_plzensky58468_txt_001_p1s7a27).         const(t_plzensky58468_txt_001_p1s7a27).
t_lemma(node96_2, x_perspron).         const(x_perspron).
%%%%%%%% node96_3 %%%%%%%%%%%%%%%%%%%
node(node96_3).
functor(node96_3, act).         const(act).
id(node96_3, t_plzensky58468_txt_001_p1s7a26).         const(t_plzensky58468_txt_001_p1s7a26).
t_lemma(node96_3, x_gen).         const(x_gen).
%%%%%%%% node96_4 %%%%%%%%%%%%%%%%%%%
node(node96_4).
functor(node96_4, twhen).         const(twhen).
gram_sempos(node96_4, n_denot_neg).         const(n_denot_neg).
id(node96_4, t_plzensky58468_txt_001_p1s7a3).         const(t_plzensky58468_txt_001_p1s7a3).
t_lemma(node96_4, zjisteni).         const(zjisteni).
%%%%%%%% node96_5 %%%%%%%%%%%%%%%%%%%
node(node96_5).
functor(node96_5, pat).         const(pat).
id(node96_5, t_plzensky58468_txt_001_p1s7a28).         const(t_plzensky58468_txt_001_p1s7a28).
t_lemma(node96_5, x_gen).         const(x_gen).
%%%%%%%% node96_6 %%%%%%%%%%%%%%%%%%%
node(node96_6).
a_afun(node96_6, auxp).         const(auxp).
m_form(node96_6, po).         const(po).
m_lemma(node96_6, po_1).         const(po_1).
m_tag(node96_6, rr__6__________).         const(rr__6__________).
m_tag0(node96_6,'r'). const('r'). m_tag1(node96_6,'r'). const('r'). m_tag4(node96_6,'6'). const('6'). 
%%%%%%%% node96_7 %%%%%%%%%%%%%%%%%%%
node(node96_7).
a_afun(node96_7, adv).         const(adv).
m_form(node96_7, zjisteni).         const(zjisteni).
m_lemma(node96_7, zjisteni____5stit_).         const(zjisteni____5stit_).
m_tag(node96_7, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node96_7,'n'). const('n'). m_tag1(node96_7,'n'). const('n'). m_tag2(node96_7,'n'). const('n'). m_tag3(node96_7,'s'). const('s'). m_tag4(node96_7,'6'). const('6'). m_tag10(node96_7,'a'). const('a'). 
%%%%%%%% node96_8 %%%%%%%%%%%%%%%%%%%
node(node96_8).
functor(node96_8, twhen).         const(twhen).
gram_sempos(node96_8, n_denot).         const(n_denot).
id(node96_8, t_plzensky58468_txt_001_p1s7a4).         const(t_plzensky58468_txt_001_p1s7a4).
t_lemma(node96_8, misto).         const(misto).
%%%%%%%% node96_9 %%%%%%%%%%%%%%%%%%%
node(node96_9).
a_afun(node96_9, adv).         const(adv).
m_form(node96_9, mista).         const(mista).
m_lemma(node96_9, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node96_9, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node96_9,'n'). const('n'). m_tag1(node96_9,'n'). const('n'). m_tag2(node96_9,'n'). const('n'). m_tag3(node96_9,'s'). const('s'). m_tag4(node96_9,'2'). const('2'). m_tag10(node96_9,'a'). const('a'). 
%%%%%%%% node96_10 %%%%%%%%%%%%%%%%%%%
node(node96_10).
functor(node96_10, app).         const(app).
gram_sempos(node96_10, n_denot).         const(n_denot).
id(node96_10, t_plzensky58468_txt_001_p1s7a5).         const(t_plzensky58468_txt_001_p1s7a5).
t_lemma(node96_10, unik).         const(unik).
%%%%%%%% node96_11 %%%%%%%%%%%%%%%%%%%
node(node96_11).
functor(node96_11, rstr).         const(rstr).
gram_sempos(node96_11, adj_denot).         const(adj_denot).
id(node96_11, t_plzensky58468_txt_001_p1s7a6).         const(t_plzensky58468_txt_001_p1s7a6).
t_lemma(node96_11, drobny).         const(drobny).
%%%%%%%% node96_12 %%%%%%%%%%%%%%%%%%%
node(node96_12).
a_afun(node96_12, atr).         const(atr).
m_form(node96_12, drobneho).         const(drobneho).
m_lemma(node96_12, drobny).         const(drobny).
m_tag(node96_12, aais2____1a____).         const(aais2____1a____).
m_tag0(node96_12,'a'). const('a'). m_tag1(node96_12,'a'). const('a'). m_tag2(node96_12,'i'). const('i'). m_tag3(node96_12,'s'). const('s'). m_tag4(node96_12,'2'). const('2'). m_tag9(node96_12,'1'). const('1'). m_tag10(node96_12,'a'). const('a'). 
%%%%%%%% node96_13 %%%%%%%%%%%%%%%%%%%
node(node96_13).
a_afun(node96_13, atr).         const(atr).
m_form(node96_13, uniku).         const(uniku).
m_lemma(node96_13, unik).         const(unik).
m_tag(node96_13, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node96_13,'n'). const('n'). m_tag1(node96_13,'n'). const('n'). m_tag2(node96_13,'i'). const('i'). m_tag3(node96_13,'s'). const('s'). m_tag4(node96_13,'2'). const('2'). m_tag10(node96_13,'a'). const('a'). 
%%%%%%%% node96_14 %%%%%%%%%%%%%%%%%%%
node(node96_14).
a_afun(node96_14, auxv).         const(auxv).
m_form(node96_14, byla).         const(byla).
m_lemma(node96_14, byt).         const(byt).
m_tag(node96_14, vpqw___xr_aa___).         const(vpqw___xr_aa___).
m_tag0(node96_14,'v'). const('v'). m_tag1(node96_14,'p'). const('p'). m_tag2(node96_14,'q'). const('q'). m_tag3(node96_14,'w'). const('w'). m_tag7(node96_14,'x'). const('x'). m_tag8(node96_14,'r'). const('r'). m_tag10(node96_14,'a'). const('a'). m_tag11(node96_14,'a'). const('a'). 
%%%%%%%% node96_15 %%%%%%%%%%%%%%%%%%%
node(node96_15).
a_afun(node96_15, pred).         const(pred).
m_form(node96_15, informovana).         const(informovana).
m_lemma(node96_15, informovat__t__w).         const(informovat__t__w).
m_tag(node96_15, vsqw___xx_ap___).         const(vsqw___xx_ap___).
m_tag0(node96_15,'v'). const('v'). m_tag1(node96_15,'s'). const('s'). m_tag2(node96_15,'q'). const('q'). m_tag3(node96_15,'w'). const('w'). m_tag7(node96_15,'x'). const('x'). m_tag8(node96_15,'x'). const('x'). m_tag10(node96_15,'a'). const('a'). m_tag11(node96_15,'p'). const('p'). 
%%%%%%%% node96_16 %%%%%%%%%%%%%%%%%%%
node(node96_16).
functor(node96_16, addr).         const(addr).
gram_sempos(node96_16, n_denot).         const(n_denot).
id(node96_16, t_plzensky58468_txt_001_p1s7a8).         const(t_plzensky58468_txt_001_p1s7a8).
t_lemma(node96_16, firma).         const(firma).
%%%%%%%% node96_17 %%%%%%%%%%%%%%%%%%%
node(node96_17).
functor(node96_17, rstr).         const(rstr).
gram_sempos(node96_17, adj_denot).         const(adj_denot).
id(node96_17, t_plzensky58468_txt_001_p1s7a9).         const(t_plzensky58468_txt_001_p1s7a9).
t_lemma(node96_17, servisni).         const(servisni).
%%%%%%%% node96_18 %%%%%%%%%%%%%%%%%%%
node(node96_18).
a_afun(node96_18, atr).         const(atr).
m_form(node96_18, servisni).         const(servisni).
m_lemma(node96_18, servisni).         const(servisni).
m_tag(node96_18, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node96_18,'a'). const('a'). m_tag1(node96_18,'a'). const('a'). m_tag2(node96_18,'f'). const('f'). m_tag3(node96_18,'s'). const('s'). m_tag4(node96_18,'1'). const('1'). m_tag9(node96_18,'1'). const('1'). m_tag10(node96_18,'a'). const('a'). 
%%%%%%%% node96_19 %%%%%%%%%%%%%%%%%%%
node(node96_19).
a_afun(node96_19, sb).         const(sb).
m_form(node96_19, firma).         const(firma).
m_lemma(node96_19, firma).         const(firma).
m_tag(node96_19, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node96_19,'n'). const('n'). m_tag1(node96_19,'n'). const('n'). m_tag2(node96_19,'f'). const('f'). m_tag3(node96_19,'s'). const('s'). m_tag4(node96_19,'1'). const('1'). m_tag10(node96_19,'a'). const('a'). 
%%%%%%%% node96_20 %%%%%%%%%%%%%%%%%%%
node(node96_20).
functor(node96_20, rstr).         const(rstr).
gram_sempos(node96_20, v).         const(v).
id(node96_20, t_plzensky58468_txt_001_p1s7a10).         const(t_plzensky58468_txt_001_p1s7a10).
t_lemma(node96_20, dostavit_se).         const(dostavit_se).
%%%%%%%% node96_21 %%%%%%%%%%%%%%%%%%%
node(node96_21).
functor(node96_21, act).         const(act).
gram_sempos(node96_21, n_pron_indef).         const(n_pron_indef).
id(node96_21, t_plzensky58468_txt_001_p1s7a12).         const(t_plzensky58468_txt_001_p1s7a12).
t_lemma(node96_21, ktery).         const(ktery).
%%%%%%%% node96_22 %%%%%%%%%%%%%%%%%%%
node(node96_22).
a_afun(node96_22, sb).         const(sb).
m_form(node96_22, ktera).         const(ktera).
m_lemma(node96_22, ktery).         const(ktery).
m_tag(node96_22, p4fs1__________).         const(p4fs1__________).
m_tag0(node96_22,'p'). const('p'). m_tag1(node96_22,'4'). const('4'). m_tag2(node96_22,'f'). const('f'). m_tag3(node96_22,'s'). const('s'). m_tag4(node96_22,'1'). const('1'). 
%%%%%%%% node96_23 %%%%%%%%%%%%%%%%%%%
node(node96_23).
functor(node96_23, pat).         const(pat).
gram_sempos(node96_23, v).         const(v).
id(node96_23, t_plzensky58468_txt_001_p1s7a13).         const(t_plzensky58468_txt_001_p1s7a13).
t_lemma(node96_23, provest).         const(provest).
%%%%%%%% node96_24 %%%%%%%%%%%%%%%%%%%
node(node96_24).
functor(node96_24, act).         const(act).
gram_sempos(node96_24, n_pron_def_pers).         const(n_pron_def_pers).
id(node96_24, t_plzensky58468_txt_001_p1s7a29).         const(t_plzensky58468_txt_001_p1s7a29).
t_lemma(node96_24, x_perspron).         const(x_perspron).
%%%%%%%% node96_25 %%%%%%%%%%%%%%%%%%%
node(node96_25).
a_afun(node96_25, obj).         const(obj).
m_form(node96_25, provede).         const(provede).
m_lemma(node96_25, provest).         const(provest).
m_tag(node96_25, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node96_25,'v'). const('v'). m_tag1(node96_25,'b'). const('b'). m_tag3(node96_25,'s'). const('s'). m_tag7(node96_25,'3'). const('3'). m_tag8(node96_25,'p'). const('p'). m_tag10(node96_25,'a'). const('a'). m_tag11(node96_25,'a'). const('a'). 
%%%%%%%% node96_26 %%%%%%%%%%%%%%%%%%%
node(node96_26).
functor(node96_26, pat).         const(pat).
gram_sempos(node96_26, n_denot).         const(n_denot).
id(node96_26, t_plzensky58468_txt_001_p1s7a14).         const(t_plzensky58468_txt_001_p1s7a14).
t_lemma(node96_26, oprava).         const(oprava).
%%%%%%%% node96_27 %%%%%%%%%%%%%%%%%%%
node(node96_27).
a_afun(node96_27, obj).         const(obj).
m_form(node96_27, opravu).         const(opravu).
m_lemma(node96_27, oprava).         const(oprava).
m_tag(node96_27, nnfs4_____a____).         const(nnfs4_____a____).
m_tag0(node96_27,'n'). const('n'). m_tag1(node96_27,'n'). const('n'). m_tag2(node96_27,'f'). const('f'). m_tag3(node96_27,'s'). const('s'). m_tag4(node96_27,'4'). const('4'). m_tag10(node96_27,'a'). const('a'). 
%%%%%%%% node96_28 %%%%%%%%%%%%%%%%%%%
node(node96_28).
functor(node96_28, dir3).         const(dir3).
gram_sempos(node96_28, n_denot).         const(n_denot).
id(node96_28, t_plzensky58468_txt_001_p1s7a16).         const(t_plzensky58468_txt_001_p1s7a16).
t_lemma(node96_28, budova).         const(budova).
%%%%%%%% node96_29 %%%%%%%%%%%%%%%%%%%
node(node96_29).
a_afun(node96_29, auxp).         const(auxp).
m_form(node96_29, do).         const(do).
m_lemma(node96_29, do_1).         const(do_1).
m_tag(node96_29, rr__2__________).         const(rr__2__________).
m_tag0(node96_29,'r'). const('r'). m_tag1(node96_29,'r'). const('r'). m_tag4(node96_29,'2'). const('2'). 
%%%%%%%% node96_30 %%%%%%%%%%%%%%%%%%%
node(node96_30).
a_afun(node96_30, adv).         const(adv).
m_form(node96_30, budovy).         const(budovy).
m_lemma(node96_30, budova).         const(budova).
m_tag(node96_30, nnfs2_____a____).         const(nnfs2_____a____).
m_tag0(node96_30,'n'). const('n'). m_tag1(node96_30,'n'). const('n'). m_tag2(node96_30,'f'). const('f'). m_tag3(node96_30,'s'). const('s'). m_tag4(node96_30,'2'). const('2'). m_tag10(node96_30,'a'). const('a'). 
%%%%%%%% node96_31 %%%%%%%%%%%%%%%%%%%
node(node96_31).
functor(node96_31, app).         const(app).
gram_sempos(node96_31, n_denot).         const(n_denot).
id(node96_31, t_plzensky58468_txt_001_p1s7a17).         const(t_plzensky58468_txt_001_p1s7a17).
t_lemma(node96_31, bazen).         const(bazen).
%%%%%%%% node96_32 %%%%%%%%%%%%%%%%%%%
node(node96_32).
a_afun(node96_32, atr).         const(atr).
m_form(node96_32, bazenu).         const(bazenu).
m_lemma(node96_32, bazen).         const(bazen).
m_tag(node96_32, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node96_32,'n'). const('n'). m_tag1(node96_32,'n'). const('n'). m_tag2(node96_32,'i'). const('i'). m_tag3(node96_32,'s'). const('s'). m_tag4(node96_32,'2'). const('2'). m_tag10(node96_32,'a'). const('a'). 
%%%%%%%% node96_33 %%%%%%%%%%%%%%%%%%%
node(node96_33).
a_afun(node96_33, auxt).         const(auxt).
m_form(node96_33, se).         const(se).
m_lemma(node96_33, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node96_33, p7_x4__________).         const(p7_x4__________).
m_tag0(node96_33,'p'). const('p'). m_tag1(node96_33,'7'). const('7'). m_tag3(node96_33,'x'). const('x'). m_tag4(node96_33,'4'). const('4'). 
%%%%%%%% node96_34 %%%%%%%%%%%%%%%%%%%
node(node96_34).
a_afun(node96_34, atr).         const(atr).
m_form(node96_34, dostavil).         const(dostavil).
m_lemma(node96_34, dostavit__w___se___na_dane_misto_).         const(dostavit__w___se___na_dane_misto_).
m_tag(node96_34, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node96_34,'v'). const('v'). m_tag1(node96_34,'p'). const('p'). m_tag2(node96_34,'y'). const('y'). m_tag3(node96_34,'s'). const('s'). m_tag7(node96_34,'x'). const('x'). m_tag8(node96_34,'r'). const('r'). m_tag10(node96_34,'a'). const('a'). m_tag11(node96_34,'a'). const('a'). 
%%%%%%%% node96_35 %%%%%%%%%%%%%%%%%%%
node(node96_35).
functor(node96_35, pat).         const(pat).
gram_sempos(node96_35, n_denot).         const(n_denot).
id(node96_35, t_plzensky58468_txt_001_p1s7a19).         const(t_plzensky58468_txt_001_p1s7a19).
t_lemma(node96_35, zastupce).         const(zastupce).
%%%%%%%% node96_36 %%%%%%%%%%%%%%%%%%%
node(node96_36).
functor(node96_36, pat).         const(pat).
gram_sempos(node96_36, n_denot).         const(n_denot).
id(node96_36, t_plzensky58468_txt_001_p1s7a20).         const(t_plzensky58468_txt_001_p1s7a20).
t_lemma(node96_36, starosta).         const(starosta).
%%%%%%%% node96_37 %%%%%%%%%%%%%%%%%%%
node(node96_37).
a_afun(node96_37, atr).         const(atr).
m_form(node96_37, starosta).         const(starosta).
m_lemma(node96_37, starosta).         const(starosta).
m_tag(node96_37, nnms1_____a____).         const(nnms1_____a____).
m_tag0(node96_37,'n'). const('n'). m_tag1(node96_37,'n'). const('n'). m_tag2(node96_37,'m'). const('m'). m_tag3(node96_37,'s'). const('s'). m_tag4(node96_37,'1'). const('1'). m_tag10(node96_37,'a'). const('a'). 
%%%%%%%% node96_38 %%%%%%%%%%%%%%%%%%%
node(node96_38).
functor(node96_38, app).         const(app).
gram_sempos(node96_38, n_denot).         const(n_denot).
id(node96_38, t_plzensky58468_txt_001_p1s7a21).         const(t_plzensky58468_txt_001_p1s7a21).
t_lemma(node96_38, mesto).         const(mesto).
%%%%%%%% node96_39 %%%%%%%%%%%%%%%%%%%
node(node96_39).
a_afun(node96_39, atr).         const(atr).
m_form(node96_39, mesta).         const(mesta).
m_lemma(node96_39, mesto).         const(mesto).
m_tag(node96_39, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node96_39,'n'). const('n'). m_tag1(node96_39,'n'). const('n'). m_tag2(node96_39,'n'). const('n'). m_tag3(node96_39,'s'). const('s'). m_tag4(node96_39,'2'). const('2'). m_tag10(node96_39,'a'). const('a'). 
%%%%%%%% node96_40 %%%%%%%%%%%%%%%%%%%
node(node96_40).
functor(node96_40, conj).         const(conj).
id(node96_40, t_plzensky58468_txt_001_p1s7a22).         const(t_plzensky58468_txt_001_p1s7a22).
t_lemma(node96_40, i).         const(i).
%%%%%%%% node96_41 %%%%%%%%%%%%%%%%%%%
node(node96_41).
a_afun(node96_41, coord).         const(coord).
m_form(node96_41, i).         const(i).
m_lemma(node96_41, i_1).         const(i_1).
m_tag(node96_41, j______________).         const(j______________).
m_tag0(node96_41,'j'). const('j'). m_tag1(node96_41,'^'). const('^'). 
%%%%%%%% node96_42 %%%%%%%%%%%%%%%%%%%
node(node96_42).
a_afun(node96_42, obj).         const(obj).
m_form(node96_42, zastupce).         const(zastupce).
m_lemma(node96_42, zastupce).         const(zastupce).
m_tag(node96_42, nnms2_____a____).         const(nnms2_____a____).
m_tag0(node96_42,'n'). const('n'). m_tag1(node96_42,'n'). const('n'). m_tag2(node96_42,'m'). const('m'). m_tag3(node96_42,'s'). const('s'). m_tag4(node96_42,'2'). const('2'). m_tag10(node96_42,'a'). const('a'). 
%%%%%%%% node96_43 %%%%%%%%%%%%%%%%%%%
node(node96_43).
functor(node96_43, pat).         const(pat).
gram_sempos(node96_43, n_denot).         const(n_denot).
id(node96_43, t_plzensky58468_txt_001_p1s7a23).         const(t_plzensky58468_txt_001_p1s7a23).
t_lemma(node96_43, odbor).         const(odbor).
%%%%%%%% node96_44 %%%%%%%%%%%%%%%%%%%
node(node96_44).
a_afun(node96_44, atr).         const(atr).
m_form(node96_44, odboru).         const(odboru).
m_lemma(node96_44, odbor___na_urade_).         const(odbor___na_urade_).
m_tag(node96_44, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node96_44,'n'). const('n'). m_tag1(node96_44,'n'). const('n'). m_tag2(node96_44,'i'). const('i'). m_tag3(node96_44,'s'). const('s'). m_tag4(node96_44,'2'). const('2'). m_tag10(node96_44,'a'). const('a'). 
%%%%%%%% node96_45 %%%%%%%%%%%%%%%%%%%
node(node96_45).
functor(node96_45, app).         const(app).
gram_sempos(node96_45, n_denot).         const(n_denot).
id(node96_45, t_plzensky58468_txt_001_p1s7a24).         const(t_plzensky58468_txt_001_p1s7a24).
t_lemma(node96_45, prostredi).         const(prostredi).
%%%%%%%% node96_46 %%%%%%%%%%%%%%%%%%%
node(node96_46).
functor(node96_46, rstr).         const(rstr).
gram_sempos(node96_46, adj_denot).         const(adj_denot).
id(node96_46, t_plzensky58468_txt_001_p1s7a25).         const(t_plzensky58468_txt_001_p1s7a25).
t_lemma(node96_46, zivotni).         const(zivotni).
%%%%%%%% node96_47 %%%%%%%%%%%%%%%%%%%
node(node96_47).
a_afun(node96_47, atr).         const(atr).
m_form(node96_47, zivotniho).         const(zivotniho).
m_lemma(node96_47, zivotni___souvisi_se_zivotem__prostredi_____).         const(zivotni___souvisi_se_zivotem__prostredi_____).
m_tag(node96_47, aans2____1a____).         const(aans2____1a____).
m_tag0(node96_47,'a'). const('a'). m_tag1(node96_47,'a'). const('a'). m_tag2(node96_47,'n'). const('n'). m_tag3(node96_47,'s'). const('s'). m_tag4(node96_47,'2'). const('2'). m_tag9(node96_47,'1'). const('1'). m_tag10(node96_47,'a'). const('a'). 
%%%%%%%% node96_48 %%%%%%%%%%%%%%%%%%%
node(node96_48).
a_afun(node96_48, atr).         const(atr).
m_form(node96_48, prostredi).         const(prostredi).
m_lemma(node96_48, prostredi).         const(prostredi).
m_tag(node96_48, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node96_48,'n'). const('n'). m_tag1(node96_48,'n'). const('n'). m_tag2(node96_48,'n'). const('n'). m_tag3(node96_48,'s'). const('s'). m_tag4(node96_48,'2'). const('2'). m_tag10(node96_48,'a'). const('a'). 
edge(node96_0, node96_1).
edge(node96_1, node96_2).
edge(node96_1, node96_3).
edge(node96_1, node96_4).
edge(node96_4, node96_5).
edge(node96_4, node96_6).
edge(node96_4, node96_7).
edge(node96_1, node96_8).
edge(node96_8, node96_9).
edge(node96_8, node96_10).
edge(node96_10, node96_11).
edge(node96_11, node96_12).
edge(node96_10, node96_13).
edge(node96_1, node96_14).
edge(node96_1, node96_15).
edge(node96_1, node96_16).
edge(node96_16, node96_17).
edge(node96_17, node96_18).
edge(node96_16, node96_19).
edge(node96_16, node96_20).
edge(node96_20, node96_21).
edge(node96_21, node96_22).
edge(node96_20, node96_23).
edge(node96_23, node96_24).
edge(node96_23, node96_25).
edge(node96_23, node96_26).
edge(node96_26, node96_27).
edge(node96_20, node96_28).
edge(node96_28, node96_29).
edge(node96_28, node96_30).
edge(node96_28, node96_31).
edge(node96_31, node96_32).
edge(node96_20, node96_33).
edge(node96_20, node96_34).
edge(node96_20, node96_35).
edge(node96_35, node96_36).
edge(node96_36, node96_37).
edge(node96_36, node96_38).
edge(node96_38, node96_39).
edge(node96_35, node96_40).
edge(node96_40, node96_41).
edge(node96_35, node96_42).
edge(node96_35, node96_43).
edge(node96_43, node96_44).
edge(node96_43, node96_45).
edge(node96_45, node96_46).
edge(node96_46, node96_47).
edge(node96_45, node96_48).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% po predani mista spravci bazenu v 8.43 se hasici vratili na stanici. 
tree_root(node97_0).
:- %%%%%%%% node97_0 %%%%%%%%%%%%%%%%%%%
node(node97_0).
id(node97_0, t_plzensky58468_txt_001_p1s8).         const(t_plzensky58468_txt_001_p1s8).
%%%%%%%% node97_1 %%%%%%%%%%%%%%%%%%%
node(node97_1).
functor(node97_1, pred).         const(pred).
gram_sempos(node97_1, v).         const(v).
id(node97_1, t_plzensky58468_txt_001_p1s8a1).         const(t_plzensky58468_txt_001_p1s8a1).
t_lemma(node97_1, vratit_se).         const(vratit_se).
%%%%%%%% node97_2 %%%%%%%%%%%%%%%%%%%
node(node97_2).
functor(node97_2, twhen).         const(twhen).
gram_sempos(node97_2, n_denot_neg).         const(n_denot_neg).
id(node97_2, t_plzensky58468_txt_001_p1s8a3).         const(t_plzensky58468_txt_001_p1s8a3).
t_lemma(node97_2, predani).         const(predani).
%%%%%%%% node97_3 %%%%%%%%%%%%%%%%%%%
node(node97_3).
functor(node97_3, addr).         const(addr).
id(node97_3, t_plzensky58468_txt_001_p1s8a14).         const(t_plzensky58468_txt_001_p1s8a14).
t_lemma(node97_3, x_gen).         const(x_gen).
%%%%%%%% node97_4 %%%%%%%%%%%%%%%%%%%
node(node97_4).
functor(node97_4, act).         const(act).
id(node97_4, t_plzensky58468_txt_001_p1s8a13).         const(t_plzensky58468_txt_001_p1s8a13).
t_lemma(node97_4, x_gen).         const(x_gen).
%%%%%%%% node97_5 %%%%%%%%%%%%%%%%%%%
node(node97_5).
a_afun(node97_5, auxp).         const(auxp).
m_form(node97_5, po).         const(po).
m_lemma(node97_5, po_1).         const(po_1).
m_tag(node97_5, rr__6__________).         const(rr__6__________).
m_tag0(node97_5,'r'). const('r'). m_tag1(node97_5,'r'). const('r'). m_tag4(node97_5,'6'). const('6'). 
%%%%%%%% node97_6 %%%%%%%%%%%%%%%%%%%
node(node97_6).
a_afun(node97_6, adv).         const(adv).
m_form(node97_6, predani).         const(predani).
m_lemma(node97_6, predani_1__a___prist____5at_1_).         const(predani_1__a___prist____5at_1_).
m_tag(node97_6, nnns6_____a____).         const(nnns6_____a____).
m_tag0(node97_6,'n'). const('n'). m_tag1(node97_6,'n'). const('n'). m_tag2(node97_6,'n'). const('n'). m_tag3(node97_6,'s'). const('s'). m_tag4(node97_6,'6'). const('6'). m_tag10(node97_6,'a'). const('a'). 
%%%%%%%% node97_7 %%%%%%%%%%%%%%%%%%%
node(node97_7).
functor(node97_7, pat).         const(pat).
gram_sempos(node97_7, n_denot).         const(n_denot).
id(node97_7, t_plzensky58468_txt_001_p1s8a4).         const(t_plzensky58468_txt_001_p1s8a4).
t_lemma(node97_7, misto).         const(misto).
%%%%%%%% node97_8 %%%%%%%%%%%%%%%%%%%
node(node97_8).
a_afun(node97_8, atr).         const(atr).
m_form(node97_8, mista).         const(mista).
m_lemma(node97_8, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node97_8, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node97_8,'n'). const('n'). m_tag1(node97_8,'n'). const('n'). m_tag2(node97_8,'n'). const('n'). m_tag3(node97_8,'s'). const('s'). m_tag4(node97_8,'2'). const('2'). m_tag10(node97_8,'a'). const('a'). 
%%%%%%%% node97_9 %%%%%%%%%%%%%%%%%%%
node(node97_9).
functor(node97_9, id).         const(id).
gram_sempos(node97_9, n_denot).         const(n_denot).
id(node97_9, t_plzensky58468_txt_001_p1s8a5).         const(t_plzensky58468_txt_001_p1s8a5).
t_lemma(node97_9, spravce).         const(spravce).
%%%%%%%% node97_10 %%%%%%%%%%%%%%%%%%%
node(node97_10).
a_afun(node97_10, atr).         const(atr).
m_form(node97_10, spravci).         const(spravci).
m_lemma(node97_10, spravce).         const(spravce).
m_tag(node97_10, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node97_10,'n'). const('n'). m_tag1(node97_10,'n'). const('n'). m_tag2(node97_10,'m'). const('m'). m_tag3(node97_10,'p'). const('p'). m_tag4(node97_10,'1'). const('1'). m_tag10(node97_10,'a'). const('a'). 
%%%%%%%% node97_11 %%%%%%%%%%%%%%%%%%%
node(node97_11).
functor(node97_11, pat).         const(pat).
gram_sempos(node97_11, n_denot).         const(n_denot).
id(node97_11, t_plzensky58468_txt_001_p1s8a6).         const(t_plzensky58468_txt_001_p1s8a6).
t_lemma(node97_11, bazen).         const(bazen).
%%%%%%%% node97_12 %%%%%%%%%%%%%%%%%%%
node(node97_12).
a_afun(node97_12, atr).         const(atr).
m_form(node97_12, bazenu).         const(bazenu).
m_lemma(node97_12, bazen).         const(bazen).
m_tag(node97_12, nnis2_____a____).         const(nnis2_____a____).
m_tag0(node97_12,'n'). const('n'). m_tag1(node97_12,'n'). const('n'). m_tag2(node97_12,'i'). const('i'). m_tag3(node97_12,'s'). const('s'). m_tag4(node97_12,'2'). const('2'). m_tag10(node97_12,'a'). const('a'). 
%%%%%%%% node97_13 %%%%%%%%%%%%%%%%%%%
node(node97_13).
functor(node97_13, rstr).         const(rstr).
gram_sempos(node97_13, adj_quant_def).         const(adj_quant_def).
id(node97_13, t_plzensky58468_txt_001_p1s8a8).         const(t_plzensky58468_txt_001_p1s8a8).
t_lemma(node97_13, x8_43).         const(x8_43).
%%%%%%%% node97_14 %%%%%%%%%%%%%%%%%%%
node(node97_14).
a_afun(node97_14, auxp).         const(auxp).
m_form(node97_14, v).         const(v).
m_lemma(node97_14, v_1).         const(v_1).
m_tag(node97_14, rr__4__________).         const(rr__4__________).
m_tag0(node97_14,'r'). const('r'). m_tag1(node97_14,'r'). const('r'). m_tag4(node97_14,'4'). const('4'). 
%%%%%%%% node97_15 %%%%%%%%%%%%%%%%%%%
node(node97_15).
a_afun(node97_15, adv).         const(adv).
m_form(node97_15, x8_43).         const(x8_43).
m_lemma(node97_15, x8_43).         const(x8_43).
m_tag(node97_15, c=_____________).         const(c=_____________).
m_tag0(node97_15,'c'). const('c'). m_tag1(node97_15,'='). const('='). 
%%%%%%%% node97_16 %%%%%%%%%%%%%%%%%%%
node(node97_16).
functor(node97_16, act).         const(act).
gram_sempos(node97_16, n_denot).         const(n_denot).
id(node97_16, t_plzensky58468_txt_001_p1s8a10).         const(t_plzensky58468_txt_001_p1s8a10).
t_lemma(node97_16, hasic).         const(hasic).
%%%%%%%% node97_17 %%%%%%%%%%%%%%%%%%%
node(node97_17).
a_afun(node97_17, sb).         const(sb).
m_form(node97_17, hasici).         const(hasici).
m_lemma(node97_17, hasic).         const(hasic).
m_tag(node97_17, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node97_17,'n'). const('n'). m_tag1(node97_17,'n'). const('n'). m_tag2(node97_17,'m'). const('m'). m_tag3(node97_17,'p'). const('p'). m_tag4(node97_17,'1'). const('1'). m_tag10(node97_17,'a'). const('a'). 
%%%%%%%% node97_18 %%%%%%%%%%%%%%%%%%%
node(node97_18).
a_afun(node97_18, auxt).         const(auxt).
m_form(node97_18, se).         const(se).
m_lemma(node97_18, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node97_18, p7_x4__________).         const(p7_x4__________).
m_tag0(node97_18,'p'). const('p'). m_tag1(node97_18,'7'). const('7'). m_tag3(node97_18,'x'). const('x'). m_tag4(node97_18,'4'). const('4'). 
%%%%%%%% node97_19 %%%%%%%%%%%%%%%%%%%
node(node97_19).
a_afun(node97_19, pred).         const(pred).
m_form(node97_19, vratili).         const(vratili).
m_lemma(node97_19, vratit__w).         const(vratit__w).
m_tag(node97_19, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node97_19,'v'). const('v'). m_tag1(node97_19,'p'). const('p'). m_tag2(node97_19,'m'). const('m'). m_tag3(node97_19,'p'). const('p'). m_tag7(node97_19,'x'). const('x'). m_tag8(node97_19,'r'). const('r'). m_tag10(node97_19,'a'). const('a'). m_tag11(node97_19,'a'). const('a'). 
%%%%%%%% node97_20 %%%%%%%%%%%%%%%%%%%
node(node97_20).
functor(node97_20, means).         const(means).
gram_sempos(node97_20, n_denot).         const(n_denot).
id(node97_20, t_plzensky58468_txt_001_p1s8a12).         const(t_plzensky58468_txt_001_p1s8a12).
t_lemma(node97_20, stanice).         const(stanice).
%%%%%%%% node97_21 %%%%%%%%%%%%%%%%%%%
node(node97_21).
a_afun(node97_21, auxp).         const(auxp).
m_form(node97_21, na).         const(na).
m_lemma(node97_21, na_1).         const(na_1).
m_tag(node97_21, rr__6__________).         const(rr__6__________).
m_tag0(node97_21,'r'). const('r'). m_tag1(node97_21,'r'). const('r'). m_tag4(node97_21,'6'). const('6'). 
%%%%%%%% node97_22 %%%%%%%%%%%%%%%%%%%
node(node97_22).
a_afun(node97_22, adv).         const(adv).
m_form(node97_22, stanici).         const(stanici).
m_lemma(node97_22, stanice).         const(stanice).
m_tag(node97_22, nnfs6_____a____).         const(nnfs6_____a____).
m_tag0(node97_22,'n'). const('n'). m_tag1(node97_22,'n'). const('n'). m_tag2(node97_22,'f'). const('f'). m_tag3(node97_22,'s'). const('s'). m_tag4(node97_22,'6'). const('6'). m_tag10(node97_22,'a'). const('a'). 
edge(node97_0, node97_1).
edge(node97_1, node97_2).
edge(node97_2, node97_3).
edge(node97_2, node97_4).
edge(node97_2, node97_5).
edge(node97_2, node97_6).
edge(node97_2, node97_7).
edge(node97_7, node97_8).
edge(node97_2, node97_9).
edge(node97_9, node97_10).
edge(node97_9, node97_11).
edge(node97_11, node97_12).
edge(node97_1, node97_13).
edge(node97_13, node97_14).
edge(node97_13, node97_15).
edge(node97_1, node97_16).
edge(node97_16, node97_17).
edge(node97_1, node97_18).
edge(node97_1, node97_19).
edge(node97_1, node97_20).
edge(node97_20, node97_21).
edge(node97_20, node97_22).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prehled zasahu (v pdf) ( 74kb ) 
tree_root(node98_0).
:- %%%%%%%% node98_0 %%%%%%%%%%%%%%%%%%%
node(node98_0).
id(node98_0, t_plzensky81415_txt_001_p1s1).         const(t_plzensky81415_txt_001_p1s1).
%%%%%%%% node98_1 %%%%%%%%%%%%%%%%%%%
node(node98_1).
functor(node98_1, denom).         const(denom).
gram_sempos(node98_1, n_denot).         const(n_denot).
id(node98_1, t_plzensky81415_txt_001_p1s1a1).         const(t_plzensky81415_txt_001_p1s1a1).
t_lemma(node98_1, prehled).         const(prehled).
%%%%%%%% node98_2 %%%%%%%%%%%%%%%%%%%
node(node98_2).
a_afun(node98_2, exd).         const(exd).
m_form(node98_2, prehled).         const(prehled).
m_lemma(node98_2, prehled).         const(prehled).
m_tag(node98_2, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node98_2,'n'). const('n'). m_tag1(node98_2,'n'). const('n'). m_tag2(node98_2,'i'). const('i'). m_tag3(node98_2,'s'). const('s'). m_tag4(node98_2,'1'). const('1'). m_tag10(node98_2,'a'). const('a'). 
%%%%%%%% node98_3 %%%%%%%%%%%%%%%%%%%
node(node98_3).
functor(node98_3, app).         const(app).
gram_sempos(node98_3, n_denot).         const(n_denot).
id(node98_3, t_plzensky81415_txt_001_p1s1a2).         const(t_plzensky81415_txt_001_p1s1a2).
t_lemma(node98_3, zasah).         const(zasah).
%%%%%%%% node98_4 %%%%%%%%%%%%%%%%%%%
node(node98_4).
a_afun(node98_4, atr).         const(atr).
m_form(node98_4, zasahu).         const(zasahu).
m_lemma(node98_4, zasah).         const(zasah).
m_tag(node98_4, nnip2_____a____).         const(nnip2_____a____).
m_tag0(node98_4,'n'). const('n'). m_tag1(node98_4,'n'). const('n'). m_tag2(node98_4,'i'). const('i'). m_tag3(node98_4,'p'). const('p'). m_tag4(node98_4,'2'). const('2'). m_tag10(node98_4,'a'). const('a'). 
%%%%%%%% node98_5 %%%%%%%%%%%%%%%%%%%
node(node98_5).
functor(node98_5, loc).         const(loc).
gram_sempos(node98_5, n_denot).         const(n_denot).
id(node98_5, t_plzensky81415_txt_001_p1s1a5).         const(t_plzensky81415_txt_001_p1s1a5).
t_lemma(node98_5, pdf).         const(pdf).
%%%%%%%% node98_6 %%%%%%%%%%%%%%%%%%%
node(node98_6).
a_afun(node98_6, auxp).         const(auxp).
m_form(node98_6, v).         const(v).
m_lemma(node98_6, v_1).         const(v_1).
m_tag(node98_6, rr__6__________).         const(rr__6__________).
m_tag0(node98_6,'r'). const('r'). m_tag1(node98_6,'r'). const('r'). m_tag4(node98_6,'6'). const('6'). 
%%%%%%%% node98_7 %%%%%%%%%%%%%%%%%%%
node(node98_7).
a_afun(node98_7, exd).         const(exd).
m_form(node98_7, pdf).         const(pdf).
m_lemma(node98_7, pdf).         const(pdf).
m_tag(node98_7, nnxxx_____a____).         const(nnxxx_____a____).
m_tag0(node98_7,'n'). const('n'). m_tag1(node98_7,'n'). const('n'). m_tag2(node98_7,'x'). const('x'). m_tag3(node98_7,'x'). const('x'). m_tag4(node98_7,'x'). const('x'). m_tag10(node98_7,'a'). const('a'). 
%%%%%%%% node98_8 %%%%%%%%%%%%%%%%%%%
node(node98_8).
functor(node98_8, par).         const(par).
gram_sempos(node98_8, n_denot).         const(n_denot).
id(node98_8, t_plzensky81415_txt_001_p1s1a8).         const(t_plzensky81415_txt_001_p1s1a8).
t_lemma(node98_8, x74kb).         const(x74kb).
%%%%%%%% node98_9 %%%%%%%%%%%%%%%%%%%
node(node98_9).
a_afun(node98_9, exd).         const(exd).
m_form(node98_9, x74kb).         const(x74kb).
m_lemma(node98_9, x74kb).         const(x74kb).
m_tag(node98_9, nnxxx_____a____).         const(nnxxx_____a____).
m_tag0(node98_9,'n'). const('n'). m_tag1(node98_9,'n'). const('n'). m_tag2(node98_9,'x'). const('x'). m_tag3(node98_9,'x'). const('x'). m_tag4(node98_9,'x'). const('x'). m_tag10(node98_9,'a'). const('a'). 
edge(node98_0, node98_1).
edge(node98_1, node98_2).
edge(node98_1, node98_3).
edge(node98_3, node98_4).
edge(node98_0, node98_5).
edge(node98_5, node98_6).
edge(node98_5, node98_7).
edge(node98_0, node98_8).
edge(node98_8, node98_9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prohlidkou mista hasici zjistili, ze se uvnitr nachazi mrtva, dvaasedmdesatileta zena.. 
tree_root(node99_0).
:- %%%%%%%% node99_0 %%%%%%%%%%%%%%%%%%%
node(node99_0).
id(node99_0, t_plzensky79543_txt_001_p1s1).         const(t_plzensky79543_txt_001_p1s1).
%%%%%%%% node99_1 %%%%%%%%%%%%%%%%%%%
node(node99_1).
functor(node99_1, pred).         const(pred).
gram_sempos(node99_1, v).         const(v).
id(node99_1, t_plzensky79543_txt_001_p1s1a1).         const(t_plzensky79543_txt_001_p1s1a1).
t_lemma(node99_1, zjistit).         const(zjistit).
%%%%%%%% node99_2 %%%%%%%%%%%%%%%%%%%
node(node99_2).
functor(node99_2, caus).         const(caus).
id(node99_2, t_plzensky79543_txt_001_p1s1a14).         const(t_plzensky79543_txt_001_p1s1a14).
t_lemma(node99_2, x___).         const(x___).
%%%%%%%% node99_3 %%%%%%%%%%%%%%%%%%%
node(node99_3).
functor(node99_3, means).         const(means).
gram_sempos(node99_3, n_denot).         const(n_denot).
id(node99_3, t_plzensky79543_txt_001_p1s1a2).         const(t_plzensky79543_txt_001_p1s1a2).
t_lemma(node99_3, prohlidka).         const(prohlidka).
%%%%%%%% node99_4 %%%%%%%%%%%%%%%%%%%
node(node99_4).
a_afun(node99_4, adv).         const(adv).
m_form(node99_4, prohlidkou).         const(prohlidkou).
m_lemma(node99_4, prohlidka).         const(prohlidka).
m_tag(node99_4, nnfs7_____a____).         const(nnfs7_____a____).
m_tag0(node99_4,'n'). const('n'). m_tag1(node99_4,'n'). const('n'). m_tag2(node99_4,'f'). const('f'). m_tag3(node99_4,'s'). const('s'). m_tag4(node99_4,'7'). const('7'). m_tag10(node99_4,'a'). const('a'). 
%%%%%%%% node99_5 %%%%%%%%%%%%%%%%%%%
node(node99_5).
functor(node99_5, pat).         const(pat).
gram_sempos(node99_5, n_denot).         const(n_denot).
id(node99_5, t_plzensky79543_txt_001_p1s1a3).         const(t_plzensky79543_txt_001_p1s1a3).
t_lemma(node99_5, misto).         const(misto).
%%%%%%%% node99_6 %%%%%%%%%%%%%%%%%%%
node(node99_6).
a_afun(node99_6, atr).         const(atr).
m_form(node99_6, mista).         const(mista).
m_lemma(node99_6, misto_1___fyzicke_umisteni_).         const(misto_1___fyzicke_umisteni_).
m_tag(node99_6, nnns2_____a____).         const(nnns2_____a____).
m_tag0(node99_6,'n'). const('n'). m_tag1(node99_6,'n'). const('n'). m_tag2(node99_6,'n'). const('n'). m_tag3(node99_6,'s'). const('s'). m_tag4(node99_6,'2'). const('2'). m_tag10(node99_6,'a'). const('a'). 
%%%%%%%% node99_7 %%%%%%%%%%%%%%%%%%%
node(node99_7).
functor(node99_7, act).         const(act).
gram_sempos(node99_7, n_denot).         const(n_denot).
id(node99_7, t_plzensky79543_txt_001_p1s1a4).         const(t_plzensky79543_txt_001_p1s1a4).
t_lemma(node99_7, hasic).         const(hasic).
%%%%%%%% node99_8 %%%%%%%%%%%%%%%%%%%
node(node99_8).
a_afun(node99_8, sb).         const(sb).
m_form(node99_8, hasici).         const(hasici).
m_lemma(node99_8, hasic).         const(hasic).
m_tag(node99_8, nnmp1_____a____).         const(nnmp1_____a____).
m_tag0(node99_8,'n'). const('n'). m_tag1(node99_8,'n'). const('n'). m_tag2(node99_8,'m'). const('m'). m_tag3(node99_8,'p'). const('p'). m_tag4(node99_8,'1'). const('1'). m_tag10(node99_8,'a'). const('a'). 
%%%%%%%% node99_9 %%%%%%%%%%%%%%%%%%%
node(node99_9).
a_afun(node99_9, pred).         const(pred).
m_form(node99_9, zjistili).         const(zjistili).
m_lemma(node99_9, zjistit__w).         const(zjistit__w).
m_tag(node99_9, vpmp___xr_aa___).         const(vpmp___xr_aa___).
m_tag0(node99_9,'v'). const('v'). m_tag1(node99_9,'p'). const('p'). m_tag2(node99_9,'m'). const('m'). m_tag3(node99_9,'p'). const('p'). m_tag7(node99_9,'x'). const('x'). m_tag8(node99_9,'r'). const('r'). m_tag10(node99_9,'a'). const('a'). m_tag11(node99_9,'a'). const('a'). 
%%%%%%%% node99_10 %%%%%%%%%%%%%%%%%%%
node(node99_10).
functor(node99_10, pat).         const(pat).
gram_sempos(node99_10, v).         const(v).
id(node99_10, t_plzensky79543_txt_001_p1s1a7).         const(t_plzensky79543_txt_001_p1s1a7).
t_lemma(node99_10, nachazet_se).         const(nachazet_se).
%%%%%%%% node99_11 %%%%%%%%%%%%%%%%%%%
node(node99_11).
functor(node99_11, twhen).         const(twhen).
gram_sempos(node99_11, adv_denot_ngrad_nneg).         const(adv_denot_ngrad_nneg).
id(node99_11, t_plzensky79543_txt_001_p1s1a9).         const(t_plzensky79543_txt_001_p1s1a9).
t_lemma(node99_11, uvnitr).         const(uvnitr).
%%%%%%%% node99_12 %%%%%%%%%%%%%%%%%%%
node(node99_12).
a_afun(node99_12, adv).         const(adv).
m_form(node99_12, uvnitr).         const(uvnitr).
m_lemma(node99_12, uvnitr_2).         const(uvnitr_2).
m_tag(node99_12, db_____________).         const(db_____________).
m_tag0(node99_12,'d'). const('d'). m_tag1(node99_12,'b'). const('b'). 
%%%%%%%% node99_13 %%%%%%%%%%%%%%%%%%%
node(node99_13).
a_afun(node99_13, auxc).         const(auxc).
m_form(node99_13, ze).         const(ze).
m_lemma(node99_13, ze).         const(ze).
m_tag(node99_13, j______________).         const(j______________).
m_tag0(node99_13,'j'). const('j'). m_tag1(node99_13,','). const(','). 
%%%%%%%% node99_14 %%%%%%%%%%%%%%%%%%%
node(node99_14).
a_afun(node99_14, auxt).         const(auxt).
m_form(node99_14, se).         const(se).
m_lemma(node99_14, se___zvr__zajmeno_castice_).         const(se___zvr__zajmeno_castice_).
m_tag(node99_14, p7_x4__________).         const(p7_x4__________).
m_tag0(node99_14,'p'). const('p'). m_tag1(node99_14,'7'). const('7'). m_tag3(node99_14,'x'). const('x'). m_tag4(node99_14,'4'). const('4'). 
%%%%%%%% node99_15 %%%%%%%%%%%%%%%%%%%
node(node99_15).
a_afun(node99_15, adv).         const(adv).
m_form(node99_15, nachazi).         const(nachazi).
m_lemma(node99_15, nachazet__t).         const(nachazet__t).
m_tag(node99_15, vb_s___3p_aa___).         const(vb_s___3p_aa___).
m_tag0(node99_15,'v'). const('v'). m_tag1(node99_15,'b'). const('b'). m_tag3(node99_15,'s'). const('s'). m_tag7(node99_15,'3'). const('3'). m_tag8(node99_15,'p'). const('p'). m_tag10(node99_15,'a'). const('a'). m_tag11(node99_15,'a'). const('a'). 
%%%%%%%% node99_16 %%%%%%%%%%%%%%%%%%%
node(node99_16).
functor(node99_16, act).         const(act).
gram_sempos(node99_16, n_denot).         const(n_denot).
id(node99_16, t_plzensky79543_txt_001_p1s1a10).         const(t_plzensky79543_txt_001_p1s1a10).
t_lemma(node99_16, mrtvy).         const(mrtvy).
%%%%%%%% node99_17 %%%%%%%%%%%%%%%%%%%
node(node99_17).
a_afun(node99_17, sb).         const(sb).
m_form(node99_17, mrtva).         const(mrtva).
m_lemma(node99_17, mrtvy).         const(mrtvy).
m_tag(node99_17, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node99_17,'a'). const('a'). m_tag1(node99_17,'a'). const('a'). m_tag2(node99_17,'f'). const('f'). m_tag3(node99_17,'s'). const('s'). m_tag4(node99_17,'1'). const('1'). m_tag9(node99_17,'1'). const('1'). m_tag10(node99_17,'a'). const('a'). 
%%%%%%%% node99_18 %%%%%%%%%%%%%%%%%%%
node(node99_18).
functor(node99_18, act).         const(act).
gram_sempos(node99_18, n_denot).         const(n_denot).
id(node99_18, t_plzensky79543_txt_001_p1s1a12).         const(t_plzensky79543_txt_001_p1s1a12).
t_lemma(node99_18, zena).         const(zena).
%%%%%%%% node99_19 %%%%%%%%%%%%%%%%%%%
node(node99_19).
functor(node99_19, rstr).         const(rstr).
gram_sempos(node99_19, adj_denot).         const(adj_denot).
id(node99_19, t_plzensky79543_txt_001_p1s1a13).         const(t_plzensky79543_txt_001_p1s1a13).
t_lemma(node99_19, dvaasedmdesatilety).         const(dvaasedmdesatilety).
%%%%%%%% node99_20 %%%%%%%%%%%%%%%%%%%
node(node99_20).
a_afun(node99_20, atr).         const(atr).
m_form(node99_20, dvaasedmdesatileta).         const(dvaasedmdesatileta).
m_lemma(node99_20, dvaasedmdesatilety).         const(dvaasedmdesatilety).
m_tag(node99_20, aafs1____1a____).         const(aafs1____1a____).
m_tag0(node99_20,'a'). const('a'). m_tag1(node99_20,'a'). const('a'). m_tag2(node99_20,'f'). const('f'). m_tag3(node99_20,'s'). const('s'). m_tag4(node99_20,'1'). const('1'). m_tag9(node99_20,'1'). const('1'). m_tag10(node99_20,'a'). const('a'). 
%%%%%%%% node99_21 %%%%%%%%%%%%%%%%%%%
node(node99_21).
a_afun(node99_21, sb).         const(sb).
m_form(node99_21, zena).         const(zena).
m_lemma(node99_21, zena).         const(zena).
m_tag(node99_21, nnfs1_____a____).         const(nnfs1_____a____).
m_tag0(node99_21,'n'). const('n'). m_tag1(node99_21,'n'). const('n'). m_tag2(node99_21,'f'). const('f'). m_tag3(node99_21,'s'). const('s'). m_tag4(node99_21,'1'). const('1'). m_tag10(node99_21,'a'). const('a'). 
edge(node99_0, node99_1).
edge(node99_1, node99_2).
edge(node99_1, node99_3).
edge(node99_3, node99_4).
edge(node99_3, node99_5).
edge(node99_5, node99_6).
edge(node99_1, node99_7).
edge(node99_7, node99_8).
edge(node99_1, node99_9).
edge(node99_1, node99_10).
edge(node99_10, node99_11).
edge(node99_11, node99_12).
edge(node99_10, node99_13).
edge(node99_10, node99_14).
edge(node99_10, node99_15).
edge(node99_10, node99_16).
edge(node99_16, node99_17).
edge(node99_10, node99_18).
edge(node99_18, node99_19).
edge(node99_19, node99_20).
edge(node99_18, node99_21).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% byt byl zakouren. 
tree_root(node100_0).
:- %%%%%%%% node100_0 %%%%%%%%%%%%%%%%%%%
node(node100_0).
id(node100_0, t_plzensky79543_txt_001_p1s2).         const(t_plzensky79543_txt_001_p1s2).
%%%%%%%% node100_1 %%%%%%%%%%%%%%%%%%%
node(node100_1).
functor(node100_1, pred).         const(pred).
gram_sempos(node100_1, v).         const(v).
id(node100_1, t_plzensky79543_txt_001_p1s2a1).         const(t_plzensky79543_txt_001_p1s2a1).
t_lemma(node100_1, zakourit).         const(zakourit).
%%%%%%%% node100_2 %%%%%%%%%%%%%%%%%%%
node(node100_2).
functor(node100_2, act).         const(act).
id(node100_2, t_plzensky79543_txt_001_p1s2a3).         const(t_plzensky79543_txt_001_p1s2a3).
t_lemma(node100_2, x_gen).         const(x_gen).
%%%%%%%% node100_3 %%%%%%%%%%%%%%%%%%%
node(node100_3).
functor(node100_3, pat).         const(pat).
gram_sempos(node100_3, n_denot).         const(n_denot).
id(node100_3, t_plzensky79543_txt_001_p1s2a2).         const(t_plzensky79543_txt_001_p1s2a2).
t_lemma(node100_3, byt).         const(byt).
%%%%%%%% node100_4 %%%%%%%%%%%%%%%%%%%
node(node100_4).
a_afun(node100_4, sb).         const(sb).
m_form(node100_4, byt).         const(byt).
m_lemma(node100_4, byt___misto_k_bydleni_).         const(byt___misto_k_bydleni_).
m_tag(node100_4, nnis1_____a____).         const(nnis1_____a____).
m_tag0(node100_4,'n'). const('n'). m_tag1(node100_4,'n'). const('n'). m_tag2(node100_4,'i'). const('i'). m_tag3(node100_4,'s'). const('s'). m_tag4(node100_4,'1'). const('1'). m_tag10(node100_4,'a'). const('a'). 
%%%%%%%% node100_5 %%%%%%%%%%%%%%%%%%%
node(node100_5).
a_afun(node100_5, auxv).         const(auxv).
m_form(node100_5, byl).         const(byl).
m_lemma(node100_5, byt).         const(byt).
m_tag(node100_5, vpys___xr_aa___).         const(vpys___xr_aa___).
m_tag0(node100_5,'v'). const('v'). m_tag1(node100_5,'p'). const('p'). m_tag2(node100_5,'y'). const('y'). m_tag3(node100_5,'s'). const('s'). m_tag7(node100_5,'x'). const('x'). m_tag8(node100_5,'r'). const('r'). m_tag10(node100_5,'a'). const('a'). m_tag11(node100_5,'a'). const('a'). 
%%%%%%%% node100_6 %%%%%%%%%%%%%%%%%%%
node(node100_6).
a_afun(node100_6, pred).         const(pred).
m_form(node100_6, zakouren).         const(zakouren).
m_lemma(node100_6, zakourit).         const(zakourit).
m_tag(node100_6, vsys___xx_ap___).         const(vsys___xx_ap___).
m_tag0(node100_6,'v'). const('v'). m_tag1(node100_6,'s'). const('s'). m_tag2(node100_6,'y'). const('y'). m_tag3(node100_6,'s'). const('s'). m_tag7(node100_6,'x'). const('x'). m_tag8(node100_6,'x'). const('x'). m_tag10(node100_6,'a'). const('a'). m_tag11(node100_6,'p'). const('p'). 
edge(node100_0, node100_1).
edge(node100_1, node100_2).
edge(node100_1, node100_3).
edge(node100_3, node100_4).
edge(node100_1, node100_5).
edge(node100_1, node100_6).
