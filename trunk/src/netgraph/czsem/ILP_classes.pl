%%%%%%%%%%%%%%%%%%%%%%%
% Declarations
%:- set(nodes,500000)?
%:- set(r,10000)?
%:- set(inflate,800000)?
%:- set(posonly,1)?

:- set(c,11),set(i,11)?
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



injured(t_plzensky70827_txt_001_p1s3).
injured(t_plzensky72450_txt_001_p3s2).
injured(t_plzensky72450_txt_001_p19s2).
injured(t_plzensky49076_txt_001_p1s3).
injured(t_plzensky63162_txt_001_p1s3).
injured(t_plzensky72795_txt_001_p2s3).
injured(t_plzensky57010_txt_001_p3s3).
injured(t_plzensky60375_txt_001_p1s6).
injured(t_plzensky60375_txt_001_p1s8).
injured(t_plzensky72977_txt_001_p1s2).
injured(t_plzensky57806_txt_001_p2s3).
injured(t_plzensky57806_txt_001_p2s40).
injured(t_plzensky51802_txt_001_p6s2).
injured(t_plzensky69694_txt_001_p3s4).
injured(t_plzensky69694_txt_001_p4s2).
injured(t_plzensky71843_txt_001_p1s7).
injured(t_plzensky58562_txt_001_p3s3).
injured(t_plzensky72261_txt_001_p14s2).
injured(t_plzensky72261_txt_001_p15s5).
injured(t_plzensky71760_txt_001_p2s7).
injured(t_plzensky48663_txt_001_p2s2).
injured(t_plzensky61718_txt_001_p3s3).
injured(t_plzensky56858_txt_001_p3s3).
injured(t_plzensky58020_txt_001_p1s2).
injured(t_plzensky58020_txt_001_p1s4).
injured(t_plzensky72928_txt_001_p1s6).
injured(t_plzensky57870_txt_001_p1s1).
injured(t_plzensky57870_txt_001_p8s2).
injured(t_plzensky62815_txt_001_p1s4).
injured(t_plzensky62815_txt_001_p1s12).
injured(t_plzensky59310_txt_001_p11s2).
injured(t_plzensky69691_txt_001_p2s4).
injured(t_plzensky70461_txt_001_p1s12).
injured(t_plzensky49244_txt_001_p1s2).
injured(t_plzensky49244_txt_001_p1s8).
injured(t_plzensky78857_txt_001_p1s7).
injured(t_plzensky60412_txt_001_p1s2).
injured(t_plzensky60412_txt_001_p4s2).
injured(t_plzensky54670_txt_001_p1s3).
injured(t_plzensky57770_txt_001_p5s2).
injured(t_plzensky69460_txt_001_p1s7).
injured(t_plzensky72675_txt_001_p7s2).
injured(t_plzensky60661_txt_001_p1s2).
injured(t_plzensky58576_txt_001_p4s3).
injured(t_plzensky58576_txt_001_p5s2).
injured(t_plzensky64131_txt_001_p2s2).
injured(t_plzensky69695_txt_001_p1s1).
injured(t_plzensky55831_txt_001_p1s3).
injured(t_plzensky49288_txt_001_p6s6).
injured(t_plzensky59722_txt_001_p2s3).
injured(t_plzensky59722_txt_001_p2s7).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% N E G A T I V E      E X A M P L E S
:- injured(t_plzensky70827_txt_001_p1s1).
:- injured(t_plzensky70827_txt_001_p1s2).
:- injured(t_plzensky70827_txt_001_p1s4).
:- injured(t_plzensky70827_txt_001_p1s5).
:- injured(t_plzensky70827_txt_001_p1s6).
:- injured(t_plzensky70827_txt_001_p1s7).
:- injured(t_plzensky70827_txt_001_p1s8).
:- injured(t_plzensky70827_txt_001_p1s9).
:- injured(t_plzensky70827_txt_001_p1s10).
:- injured(t_plzensky70827_txt_001_p1s11).
:- injured(t_plzensky70827_txt_001_p1s12).
:- injured(t_plzensky51278_txt_001_p1s1).
:- injured(t_plzensky51278_txt_001_p1s2).
:- injured(t_plzensky51278_txt_001_p1s3).
:- injured(t_plzensky51278_txt_001_p1s4).
:- injured(t_plzensky51278_txt_001_p1s5).
:- injured(t_plzensky51278_txt_001_p2s1).
:- injured(t_plzensky51278_txt_001_p2s2).
:- injured(t_plzensky51278_txt_001_p2s3).
:- injured(t_plzensky51278_txt_001_p2s4).
:- injured(t_plzensky51278_txt_001_p2s5).
:- injured(t_plzensky51278_txt_001_p2s6).
:- injured(t_plzensky51278_txt_001_p2s7).
:- injured(t_plzensky51278_txt_001_p2s8).
:- injured(t_plzensky51278_txt_001_p3s1).
:- injured(t_plzensky51278_txt_001_p3s2).
:- injured(t_plzensky51278_txt_001_p3s3).
:- injured(t_plzensky51278_txt_001_p4s1).
:- injured(t_plzensky51278_txt_001_p4s2).
:- injured(t_plzensky51278_txt_001_p4s3).
:- injured(t_plzensky51278_txt_001_p5s1).
:- injured(t_plzensky51278_txt_001_p5s2).
:- injured(t_plzensky51278_txt_001_p5s3).
:- injured(t_plzensky51278_txt_001_p5s4).
:- injured(t_plzensky51278_txt_001_p5s5).
:- injured(t_plzensky51278_txt_001_p5s6).
:- injured(t_plzensky51278_txt_001_p5s7).
:- injured(t_plzensky51278_txt_001_p5s8).
:- injured(t_plzensky51278_txt_001_p5s9).
:- injured(t_plzensky58468_txt_001_p1s1).
:- injured(t_plzensky58468_txt_001_p1s2).
:- injured(t_plzensky58468_txt_001_p1s3).
:- injured(t_plzensky58468_txt_001_p1s4).
:- injured(t_plzensky58468_txt_001_p1s5).
:- injured(t_plzensky58468_txt_001_p1s6).
:- injured(t_plzensky58468_txt_001_p1s7).
:- injured(t_plzensky58468_txt_001_p1s8).
:- injured(t_plzensky81415_txt_001_p1s1).
:- injured(t_plzensky79543_txt_001_p1s1).
:- injured(t_plzensky79543_txt_001_p1s2).
